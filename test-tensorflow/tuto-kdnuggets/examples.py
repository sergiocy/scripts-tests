# ...ejemplo 1... constantes y variables...
import tensorflow as tf
x = tf.constant(-2.0, name="x", dtype=tf.float32)
a = tf.constant(5.0, name="a", dtype=tf.float32)
b = tf.constant(13.0, name="b", dtype=tf.float32)
y = tf.Variable(tf.add(tf.multiply(a,x), b))

init = tf.global_variables_initializer()
with tf.Session() as session:
    session.run(init)
    print(session.run(y))

# ...ejemplo 2... placeholders...
import tensorflow as tf
x = tf.placeholder(tf.float32, name="x")
y = tf.placeholder(tf.float32, name="y")
z = tf.multiply(x, y, name="z")
with tf.Session() as session:
    print(session.run(z, feed_dict={x: 2.1, y: 3.0}))

# ...ejemplo 3... tensorboard...
import tensorflow as tf
x = tf.constant(-2.0, name="x", dtype=tf.float32)
a = tf.constant(5.0, name="a", dtype=tf.float32)
b = tf.constant(13.0, name="b", dtype=tf.float32)
y = tf.Variable(tf.add(tf.multiply(a,x), b))

init = tf.global_variables_initializer()
with tf.Session() as session:
    merged = tf.summary.merge_all() 
    writer = tf.summary.FileWriter("logs", session.graph) 
    session.run(init)
    print(session.run(y))

# ...ejemplo 4... incluyendo numpy...
import numpy as np
import tensorflow as tf
tensor_1d = np.array([[1.45, -1, 0.2, 102.1]]).reshape(4,1)
print(tensor_1d)

tensor = tf.convert_to_tensor(tensor_1d, dtype=tf.float64)
print(tensor)