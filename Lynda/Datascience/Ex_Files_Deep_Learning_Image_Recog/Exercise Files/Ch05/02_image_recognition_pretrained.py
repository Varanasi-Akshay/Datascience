import numpy as np
from keras.preprocessing import image
from keras.applications import vgg16

# Load Keras' VGG16 model that was pre-trained against the ImageNet database
model =

# Load the image file, resizing it to 224x224 pixels (required by this model)
img = image.load_img("bay.jpg", target_size=(224, 224))

# Convert the image to a numpy array
x = image.img_to_array(img)

# Add a fourth dimension (since Keras expects a list of images)
x = np.expand_dims(x, axis=0)

# Normalize the input image's pixel values to the range used when training the neural network
x =

# Run the image through the deep neural network to make a prediction
predictions =

# Look up the names of the predicted classes. Index zero is the results for the first image.
predicted_classes =

print("Top predictions for this image:")

for imagenet_id, name, likelihood in predicted_classes[0]:
    print("Prediction: {} - {:2f}".format(name, likelihood))

