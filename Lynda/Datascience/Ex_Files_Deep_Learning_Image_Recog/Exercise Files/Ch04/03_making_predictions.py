from keras.models import model_from_json
from pathlib import Path
from keras.preprocessing import image
import numpy as np

# These are the CIFAR10 class labels from the training data (in order from 0 to 9)
class_labels = [
    "Plane",
    "Car",
    "Bird",
    "Cat",
    "Deer",
    "Dog",
    "Frog",
    "Horse",
    "Boat",
    "Truck"
]

# Load the json file that contains the model's structure


# Recreate the Keras model object from the json data


# Re-load the model's trained weights


# Load an image file to test, resizing it to 32x32 pixels (as required by this model)


# Convert the image to a numpy array


# Add a fourth dimension to the image (since Keras expects a list of images, not a single image)


# Make a prediction using the model


# Since we are only testing one image, we only need to check the first result


# We will get a likelihood score for all 10 possible classes. Find out which class had the highest score.



# Get the name of the most likely class


# Print the result
print("This is image is a {} - Likelihood: {:2f}".format(class_label, class_likelihood))