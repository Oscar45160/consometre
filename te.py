import pandas as pd
from pymongo import MongoClient

# Connect to the MongoDB database
client = MongoClient('mongodb+srv://csm:admin@cluster0.8u5bitj.mongodb.net/test')
db = client['mydatabase']
collection = db['mycollection']

# Read the CSV file into a pandas dataframe
df = pd.read_csv('/workspaces/consometre/donnees.csv')

# Convert the dataframe to a list of dictionaries
data = df.to_dict(orient='records')

# Insert the data into the MongoDB collection
collection.insert_many(data)

# Close the MongoDB connection
client.close()