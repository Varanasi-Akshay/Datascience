"""Solution code to `Building Your First RNN with Tensorflow` lesson."""

import random
import tensorflow as tf
import numpy as np

"""Generating Data."""
num_examples = 1000
num_classes = 50

'''
First, we start with initializing the multiple_values variable. It contains a binary representation of the first 220 (1,048,576) numbers, where each binary number is padded with zeros to accommodate the length of 50. Obtaining this many examples minimizes the chance of similarity between any two of them. We use the map function together with int in order to convert the produced string into a number.

Here is a quick example of how this works: Say we want to represent the number i = 2. The binary version of 2 is '10', so the string produced after '{0:050b}'.format(i) is '00000000000000000000000000000000000000000000000010' (48 zeros at the front to accommodate a length of 50). Finally, the map function makes the previous string into a number without removing the zeros at the front.

Then, we shuffle the multiple_values array, assuring difference between neighboring elements. This is important during backpropagation when the network is trained, because we are iteratively looping throughout the array and training the network at each step using a single example. Having similar values next to each other inside the array may produce biased results and incorrect future predictions.

'''

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


'''
X and Y are declared as tf.placeholder, which inserts a placeholder (inside the graph) for a tensor that will be always fed. Placeholders are used for variables that expect data when training the network. They often hold values for the training input and expected output of the network.

The weight and biases are declared as tf.Variable. When a variable is first introduced, one should specify an initial value, type, and shape. The value is modified during training. The type and shape remain constant and cannot be changed.
Next, let's build the RNN cell. An input at time step, t, is plugged into an RNN cell to produce an output, yt, and a hidden state, ht. Then, the hidden state and the new input at time step (t+1) are plugged into a new RNN cell (which shares the same weights and biases as the previous). It produces its own output, yt+1, and hidden state, ht+1. This pattern is repeated for every time step.

Each cell requires an activation function that is applied to the hidden state. By default, TensorFlow chooses tanh (perfect for our use case) but you can specify any that you wish — just add an additional parameter called activation.

Both in weights and in rnn_cell, you can see a parameter called num_hidden_units . This is a direct representation of the learning capacity of a neural network. It determines the dimensionality of both the memory state, ht, and the output, yt.

Since X is a batch of input sequences, then outputs represents a batch of outputs at every time step in all sequences. To evaluate the prediction, we need the value of the last time step for every output in the batch. This happens in three steps, explained in the following example:

    First, we reshape our outputs tensor from (1000, 50, 12) to (50, 1000, 12):
    We do this so that the outputs from the last time step in every sequence are accessible using the following: 
    Let's try to understand how this last_output is obtained.

One input example of 50 time steps is plugged into the network. After iteratively going through each time step, we produce 50 outputs, each one having the dimensions (12, 1). The 12 comes from num_hidden_units.

After all input examples have been plugged in, all of the outputs can be presented in a (1000, 50, 12) matrix. The height of the matrix is 1000 — the number of individual examples. The width of the matrix is 50 — the number of time steps for each example. The depth of the matrix is 12 — the dimension of each element.

To make a prediction, we only care about the last output for each of our 1000 examples. Transposing the outputs matrix from (1000, 50, 12) into (50, 1000, 12) makes it easier to get the last output from each example. Then, we use tf.gather to obtain the last_output tensor, which has size of (1000, 12, 1).

Using the newly obtained tensor, last_output , we can predict the output of the particular sequence using the weights and biases.
Finally, we evaluate the output based on the expected value:
    We can use the popular cross entropy loss function in a combination with softmax. The softmax function transforms a tensor to emphasize the largest values and suppress values that are significantly below the maximum value. This is done by normalizing the values from the initial array to add up to 1. The cross entropy is a loss function that computes the difference between the label (expected values) and logits (predicted values).

    Since tf.nn.softmax_cross_entropy_with_logits_v2 returns a 1-D tensor of a length of batch_size, we use tf.reduce_mean to compute the mean of all elements in that tensor.

As a final step, we will see how TensorFlow makes it easy for us to optimize the weights and biases. Once we have obtained the loss function, we need to perform a backpropagation algorithm, adjusting the weights and biases to minimize the loss. This can be done in the following way:
learning_rate is one of the model's hyperparameters and is used when optimizing the loss function. Tuning this value is essential for better performance, so feel free to adjust it and evaluate the results.

Minimizing the error of the loss function is done using an Adam optimizer. Here is a good explanation of why it is preferred over gradient descent.

We have just built the architecture of our recurrent neural network! The next task is to train the neural network using the TensorFlow graph in combination with the previously generated data.






'''

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


'''
Let’s break this down.

First, we initialize the batch size. At each training step, the network is tuned, based on examples from the chosen batch. Then, we compute the number of batches. We also define the number of epochs — this determines how many times our model should loop through the training set.

tf.Session() encapsulates the code in a TensorFlow Session and sess.run(tf.global_variables_initializer()) makes sure all variables hold their values.

Then, we store an individual batch from the training set in training_x and training_y .

The last (and most important) part of training the network comes with the usage of sess.run(). By calling this function, you can compute the value of any tensor. In addition, you can specify as many arguments as you want by ordering them in a list — in our case, we have specified the optimizer and total_loss function. The placeholders for holding the values of the current batch should be passed to the feed_dict parameter.

Training this network can take a few minutes. You can verify that it is learning by examining the value of the loss function. If its value decreases, then the network is successfully modifying the weights and biases. If the value is not decreasing, you most likely need to make some additional changes to optimize the performance.

    Optimizing this network is beyond the scope of this lesson. If you’d like to try to optimize it on your own, you can try to increase the number of examples in the training data, increase the number of epochs, or change the activation function, learning rate, or the number of hidden units to see if the model performs better.

In our final step, we will learn to evaluate the predictions of our trained RNN!

'''


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



'''
The test_example must be an array of a size of [1, num_classes, 1], for example:
The sum of all elements in the above array is equal to 30, which is an even number. Thus, the parity bit should be 0.

Using prediction_result[0].argsort()[-1:][::-1], we can find the index of the largest number, which will tell us the predicted sum of the sequence. Then, we need to find the remainder when this predicted sum is divided by 2. This is the predicted parity of the sequence.

'''
largest_number_index = prediction_result[0].argsort()[-1:][::-1]
predicted_parity = largest_number_index % 2
actual_sum = np.sum(test_example)
actual_parity = actual_sum % 2

print(f"Predicted sum: {largest_number_index[0]}. Actual sum: {actual_sum}.")
print(f"Predicted sequence parity: {predicted_parity[0]}. Actual sequence parity: {actual_parity}.")
