import tensorflow as tf

###########################
##   Helper functions    ##
###########################


def build_classifier(data, labels, n_classes=2):
    data_shape = data.get_shape().as_list()
    weights = tf.get_variable(
        name='weights',
        shape=(data_shape[1], n_classes),
        dtype=tf.float32
    )
    bias = tf.get_variable(
        name='bias',
        initializer=tf.zeros(shape=n_classes)
    )
    logits = tf.add(
        tf.matmul(data, weights),
        bias,
        name='logits'
    )
    return logits, tf.nn.softmax(logits)


def build_generator(data, n_hidden):
    data_shape = data.get_shape().as_list()
    w1 = tf.Variable(
        tf.random_normal(shape=(data_shape[1], n_hidden)),
        name='w1'
    )
    b1 = tf.Variable(
        tf.zeros(shape=n_hidden),
        name='b1'
    )
    hidden = tf.add(
        tf.matmul(data, w1),
        b1,
        name='hidden_pre-activation'
    )
    hidden = tf.nn.relu(hidden, 'hidden_activation')
        
    w2 = tf.Variable(
        tf.random_normal(shape=(n_hidden, data_shape[1])),
        name='w2'
    )
    b2 = tf.Variable(
        tf.zeros(shape=data_shape[1]),
        name='b2'
    )
    output = tf.add(
        tf.matmul(hidden, w2),
        b2,
        name='output'
    )
    return output, tf.nn.sigmoid(output)
