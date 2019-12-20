// shape our tenser with 4 rows of 2 columns
const shape = [4,2];
// feed data into the tensor
const data = tf.tensor([4,6,5,9,13,25,1, 57], shape);

// set variables with zeros method
const data2 = tf.variable(tf.zeros([8]));

// print the data
data2.print();

// this is where we assign new values with 1 dimension
data2.assign(tf.tensor1d([4, 12, 5, 6, 56, 3, 45, 3]));
data2.print();

// create 2 new 1 dimensional tensors
const data3 = tf.tensor1d([4, 6, 5, 9]);
const data4 = tf.tensor1d([5, 4, 23, 45]);

// prints
data3.print();
data4.print();

// adds and multiplies and prints
data3.add(data4).print();
data3.mul(data4).print();
