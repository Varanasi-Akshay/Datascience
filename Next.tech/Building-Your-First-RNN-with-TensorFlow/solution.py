"""Solution code to `Building Your First RNN with Tensorflow` lesson."""

import random
import tensorflow as tf
import numpy as np

"""Generating Data."""
num_examples = 1000
num_classes = 50


def input_values():
    """Generate 1000 random input examples with 50 timesteps."""
    multiple_values = [map(int, '{0:050b}'.format(i)) for i in range(2**20)]
    random.shuffle(multiple_values)
    final_values = []
    for value in multiple_values[:num_examples]:
        temp = []
        for number in value:
            temp.append([number])
        final_values.append(temp)
    return final_values


def output_values(inputs):
    """Generate 1000 outputs from generated input examples."""
    final_values = []
    for value in inputs:
        count_of_ones = 0
        for i in value:
            count_of_ones += i[0]
        output_values = [0 for _ in range(num_classes)]
        if count_of_ones < num_classes:
            output_values[count_of_ones] = 1
        final_values.append(output_values)
    return final_values


def generate_data():
    """Return randomly generated inputs and outputs."""
    inputs = input_values()
    return inputs, output_values(inputs)


"""Building the TensorFlow Graph."""
X = tf.placeholder(tf.float32, shape=[None, num_classes, 1])
Y = tf.placeholder(tf.float32, shape=[None, num_classes])

num_hidden_units = 12

weights = tf.Variable(tf.truncated_normal([num_hidden_units, num_classes]))
biases = tf.Variable(tf.truncated_normal([num_classes]))

rnn_cell = tf.contrib.rnn.BasicRNNCell(num_units=num_hidden_units)

outputs_temp, state = tf.nn.dynamic_rnn(rnn_cell, inputs=X, dtype=tf.float32)
outputs = tf.transpose(outputs_temp, [1, 0, 2])
last_output = tf.gather(outputs, int(outputs.get_shape()[0]) - 1)

prediction = tf.matmul(last_output, weights) + biases

loss = tf.nn.softmax_cross_entropy_with_logits_v2(labels=Y, logits=prediction)
total_loss = tf.reduce_mean(loss)

learning_rate = 0.001
optimizer = tf.train.AdamOptimizer(learning_rate=learning_rate).minimize(loss=total_loss)

"""Training the RNN."""
batch_size = 10
number_of_batches = int(num_examples / batch_size)
epochs = 100

with tf.Session() as sess:
    sess.run(tf.global_variables_initializer())
    X_train, y_train = generate_data()
    for epoch in range(epochs):
        iter = 0
        for _ in range(number_of_batches):
            training_x = X_train[iter:iter + batch_size]
            training_y = y_train[iter:iter + batch_size]
            iter += batch_size
            _, current_total_loss = sess.run([optimizer, total_loss],
                                             feed_dict={X: training_x, Y: training_y})
            print("Epoch", epoch, "Iteration", iter, "loss", current_total_loss)
            print("__________________")

    """Evaluating the Predictions."""
    # Generate a test example
    test_example = [[[1], [0], [0], [1], [1], [0], [1], [1], [1], [0], [1], [0],
                     [0], [1], [1], [0], [1], [1], [1], [0], [1], [0], [0], [1],
                     [1], [0], [1], [1], [1], [0], [1], [0], [0], [1], [1], [0],
                     [1], [1], [1], [0], [1], [0], [0], [1], [1], [0], [1], [1],
                     [1], [0]]]

    prediction_result = sess.run(prediction, {X: test_example})

largest_number_index = prediction_result[0].argsort()[-1:][::-1]
predicted_parity = largest_number_index % 2
actual_sum = np.sum(test_example)
actual_parity = actual_sum % 2

print(f"Predicted sum: {largest_number_index[0]}. Actual sum: {actual_sum}.")
print(f"Predicted sequence parity: {predicted_parity[0]}. Actual sequence parity: {actual_parity}.")
