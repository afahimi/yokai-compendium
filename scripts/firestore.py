import json
import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate('./../yo-kai-compendium-firebase-adminsdk-6ie26-0a5b75f248.json')
firebase_admin.initialize_app(cred)

db = firestore.client()

with open('./../app/assets/yokai.json', 'r') as f:
    yokai_data = json.load(f)

yokai_ref = db.collection('yokai')

for record in yokai_data:
    yokai_ref.add(record)

print("Data uploaded successfully!")
