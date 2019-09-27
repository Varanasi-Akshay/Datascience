import tensorflow as tf
import random
import numpy as np

"""Generating Data."""
num_examples = 1000
num_classes = 50


def input_values():
    """Generate 1000 random input examples with 50 timesteps."""
    # Your code here:

    return final_values


def output_values(inputs):
    """Generate 1000 outputs from generated input examples."""
    # Your code here:

    return final_values


def generate_data():
    """Return randomly generated inputs and outputs."""
    # Your code here:

    return


"""Building the TensorFlow Graph."""
#    Define placeholders for X and Y:
#    X =
#    Y =

num_hidden_units = 12

#    Define variables for weights and biases:
#    weights =
#    biases =

#    Build the RNN Cell:
#    rnn_cell =

outputs_temp, state = tf.nn.dynamic_rnn(rnn_cell, inputs=X, dtype=tf.float32)
outputs = tf.transpose(outputs_temp, [1, 0, 2])
last_output = tf.gather(outputs, int(outputs.get_shape()[0]) - 1)

#    Predict the output of a sequence using weights and biases
#    prediction =

#    Define a softmax cross entropy loss function
#    loss =

total_loss = tf.reduce_mean(loss)

learning_rate = 0.001

#    Define the Adam optimizer to minimize the error of the loss function
#    optimizer =

"""Training the RNN."""
batch_size = 10
number_of_batches = int(num_examples / batch_size)
epoch = 100

with tf.Session() as sess:
    # Your code here:

    """Evaluating the Predictions."""
    #    Generate a test example:
    #    test_example =

    prediction_result = sess.run(prediction, {X: test_example})

largest_number_index = prediction_result[0].argsort()[-1:][::-1]
predicted_parity = largest_number_index % 2
actual_sum = np.sum(test_example)
actual_parity = actual_sum % 2

print(f"Predicted sum: {largest_number_index[0]}. Actual sum: {actual_sum}.")
print(f"Predicted sequence parity: {predicted_parity[0]}. Actual sequence parity: {actual_parity}.")
