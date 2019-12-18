import face_recognition
from pathlib import Path
from PIL import Image

# Load the image of the person we want to find similar people for
known_image =

# Encode the known image
known_image_encoding =

# Variables to keep track of the most similar face match we've found
best_face_distance = 1.0
best_face_image = None

# Loop over all the images we want to check for similar people
for image_path in Path("people").glob("*.png"):
    # Load an image to check
    unknown_image =

    # Get the location of faces and face encodings for the current image
    face_encodings =

    # Get the face distance between the known person and all the faces in this image
    face_distance =

    # If this face is more similar to our known image than we've seen so far, save it
    if face_distance < best_face_distance:
        # Save the new best face distance
        best_face_distance =
        # Extract a copy of the actual face image itself so we can display it
        best_face_image =

# Display the face image that we found to be the best match!
pil_image = Image.fromarray(best_face_image)
pil_image.show()
