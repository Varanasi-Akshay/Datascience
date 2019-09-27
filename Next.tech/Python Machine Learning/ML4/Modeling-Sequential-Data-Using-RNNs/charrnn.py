import tensorflow as tf
import os
import numpy as np


with open('hamlet.txt', 'r', encoding='utf-8') as f:
    text = f.read()
text = text[15858:]
chars = set(text)
char2int = {ch: i for i, ch in enumerate(chars)}
int2char = dict(enumerate(chars))
text_ints = np.array([char2int[ch] for ch in text], dtype=np.int32)


def reshape_data(sequence, batch_size, num_steps):
    mini_batch_length = batch_size * num_steps
    num_batches = int(len(sequence) / mini_batch_length)
    if num_batches * mini_batch_length + 1 > len(sequence):
        num_batches = num_batches - 1
    # Truncate the sequence at the end to get rid of
    # remaining charcaters that do not make a full batch
    x = sequence[0: num_batches * mini_batch_length]
    y = sequence[1: num_batches * mini_batch_length + 1]
    # Split x & y into a list batches of sequences:
    x_batch_splits = np.split(x, batch_size)
    y_batch_splits = np.split(y, batch_size)
    # Stack the batches together
    # batch_size x mini_batch_length
    x = np.stack(x_batch_splits)
    y = np.stack(y_batch_splits)
    
    return x, y

    
def create_batch_generator(data_x, data_y, num_steps):
    batch_size, tot_batch_length = data_x.shape
    num_batches = int(tot_batch_length / num_steps)
    for b in range(num_batches):
        yield (
            data_x[:, b * num_steps: (b+1) * num_steps],
            data_y[:, b * num_steps: (b+1) * num_steps]
        )


def get_top_char(probas, char_size, top_n=5):
    p = np.squeeze(probas)
    p[np.argsort(p)[:-top_n]] = 0.0
    p = p / np.sum(p)
    ch_id = np.random.choice(char_size, 1, p=p)[0]
    return ch_id


class CharRNN(object):
    def __init__(self, num_classes, batch_size=64,
                 num_steps=100, lstm_size=128,
                 num_layers=1, learning_rate=0.001,
                 keep_prob=0.5, grad_clip=5,
                 sampling=False):
        self.num_classes = num_classes
        self.batch_size = batch_size
        self.num_steps = num_steps
        self.lstm_size = lstm_size
        self.num_layers = num_layers
        self.learning_rate = learning_rate
        self.keep_prob = keep_prob
        self.grad_clip = grad_clip
        
        self.g = tf.Graph()
        with self.g.as_default():
            tf.set_random_seed(123)

            self.build(sampling=sampling)
            self.saver = tf.train.Saver()
            self.init_op = tf.global_variables_initializer()

    def build(self, sampling):
        if sampling == True:
            batch_size, num_steps = 1, 1
        else:
            batch_size = self.batch_size
            num_steps = self.num_steps

        tf_x = tf.placeholder(
            tf.int32, shape=[batch_size, num_steps], name='tf_x'
        )
        tf_y = tf.placeholder(
            tf.int32, shape=[batch_size, num_steps], name='tf_y'
        )
        tf_keepprob = tf.placeholder(tf.float32, name='tf_keepprob')

        # One-hot encoding:
        x_onehot = tf.one_hot(tf_x, depth=self.num_classes)
        y_onehot = tf.one_hot(tf_y, depth=self.num_classes)

        # Build the multi-layer RNN cells
        cells = tf.contrib.rnn.MultiRNNCell([tf.contrib.rnn.DropoutWrapper(
            tf.contrib.rnn.BasicLSTMCell(self.lstm_size),
            output_keep_prob=tf_keepprob)
            for _ in range(self.num_layers)]
        )
        
        # Define the initial state
        self.initial_state = cells.zero_state(batch_size, tf.float32)

        # Run each sequence step through the RNN
        lstm_outputs, self.final_state = tf.nn.dynamic_rnn(
            cells, x_onehot,
            initial_state=self.initial_state
        )
        
        print('  << lstm_outputs  >>', lstm_outputs)

        seq_output_reshaped = tf.reshape(
            lstm_outputs,
            shape=[-1, self.lstm_size],
            name='seq_output_reshaped'
        )

        logits = tf.layers.dense(
            inputs=seq_output_reshaped,
            units=self.num_classes,
            activation=None,
            name='logits'
        )

        proba = tf.nn.softmax(
            logits,
            name='probabilities'
        )

        y_reshaped = tf.reshape(
            y_onehot,
            shape=[-1, self.num_classes],
            name='y_reshaped'
        )
        cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(
                logits=logits,
                labels=y_reshaped
        ), name='cost')

        # Gradient clipping to avoid "exploding gradients"
        tvars = tf.trainable_variables()
        grads, _ = tf.clip_by_global_norm(
            tf.gradients(cost, tvars),
            self.grad_clip
        )
        optimizer = tf.train.AdamOptimizer(self.learning_rate)
        train_op = optimizer.apply_gradients(
            zip(grads, tvars),
            name='train_op'
        )

    def train(self, train_x, train_y,
              num_epochs, ckpt_dir='./model/'):
        # Create the checkpoint directory if it does not exists
        if not os.path.exists(ckpt_dir):
            os.mkdir(ckpt_dir)
            
        with tf.Session(graph=self.g) as sess:
            sess.run(self.init_op)

            n_batches = int(train_x.shape[1] / self.num_steps)
            iterations = n_batches * num_epochs
            for epoch in range(num_epochs):

                # Train network
                new_state = sess.run(self.initial_state)
                loss = 0
                # Mini-batch generator:
                bgen = create_batch_generator(train_x, train_y, self.num_steps)
                for b, (batch_x, batch_y) in enumerate(bgen, 1):
                    iteration = epoch * n_batches + b
                    
                    feed = {
                        'tf_x:0': batch_x,
                        'tf_y:0': batch_y,
                        'tf_keepprob:0': self.keep_prob,
                        self.initial_state: new_state
                    }
                    batch_cost, _, new_state = sess.run(
                            ['cost:0', 'train_op', self.final_state],
                            feed_dict=feed
                    )
                    if iteration % 10 == 0:
                        print(
                            f"Epoch: {epoch + 1:3d}/{num_epochs:3d} "
                            f"Iteration: {iteration} "
                            f"| Train loss: {batch_cost:.4f}"
                        )

                # Save the trained model
                self.saver.save(
                        sess, os.path.join(ckpt_dir, 'language_modeling.ckpt')
                )

    def sample(self, output_length,
               ckpt_dir, starter_seq="The "):
        observed_seq = [ch for ch in starter_seq]
        with tf.Session(graph=self.g) as sess:
            self.saver.restore(
                sess, tf.train.latest_checkpoint(ckpt_dir)
            )
            # 1: run the model using the starter sequence
            new_state = sess.run(self.initial_state)
            for ch in starter_seq:
                x = np.zeros((1, 1))
                x[0, 0] = char2int[ch]
                feed = {
                    'tf_x:0': x,
                    'tf_keepprob:0': 1.0,
                    self.initial_state: new_state
                }
                proba, new_state = sess.run(
                    ['probabilities:0', self.final_state],
                    feed_dict=feed
                )

            ch_id = get_top_char(proba, len(chars))
            observed_seq.append(int2char[ch_id])

            # 2: run the model using the updated observed_seq
            for i in range(output_length):
                x[0, 0] = ch_id
                feed = {
                    'tf_x:0': x,
                    'tf_keepprob:0': 1.0,
                    self.initial_state: new_state
                }
                proba, new_state = sess.run(
                    ['probabilities:0', self.final_state],
                    feed_dict=feed
                )

                ch_id = get_top_char(proba, len(chars))
                observed_seq.append(int2char[ch_id])

        return ''.join(observed_seq)
