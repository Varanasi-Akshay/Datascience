from PIL import Image, ImageDraw
import face_recognition

# Load the jpg file into a numpy array
image =

# Find all facial features in all the faces in the image
face_landmarks_list =

# Load the image into a Python Image Library object so that we can draw on top of it and display it
pil_image = Image.fromarray(image)

# Create a PIL drawing object to be able to draw lines later
d = ImageDraw.Draw(pil_image, 'RGBA')

for face_landmarks in face_landmarks_list:
    # The face landmark detection model returns these features:
    #  - chin, left_eyebrow, right_eyebrow, nose_bridge, nose_tip, left_eye, right_eye, top_lip, bottom_lip

    # Draw a line over the eyebrows



    # Draw over the lips




# Show the final image
pil_image.show()
