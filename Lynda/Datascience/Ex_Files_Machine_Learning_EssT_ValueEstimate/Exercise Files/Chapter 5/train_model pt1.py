import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn import ensemble
from sklearn.metrics import mean_absolute_error
from sklearn.externals import joblib

# Load the data set
df = pd.read_csv("ml_house_data_set.csv")

# Remove the fields from the data set that we don't want to include in our model


# Replace categorical data with one-hot encoded data
features_df =

# Remove the sale price from the feature data


# Create the X and y arrays
X =
y =