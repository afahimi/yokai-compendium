from google.cloud import firestore
import json

db = firestore.Client()

def read_yokai_json(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

def upload_to_firestore(yokai_data):
    for yokai in yokai_data:
        doc_ref = db.collection('yokai').document(str(yokai['number']))
        doc_ref.set(yokai)

def fetch_all_yokai():
    docs = db.collection('yokai').stream()
    for doc in docs:
        print(f'{doc.id} => {doc.to_dict()}')

def fetch_yokai_by_number(number):
    doc = db.collection('yokai').document(str(number)).get()
    if doc.exists:
        print(f'Yokai {number} => {doc.to_dict()}')
    else:
        print(f'Yokai {number} does not exist')

def update_yokai_attribute(number, attribute, value):
    doc_ref = db.collection('yokai').document(str(number))
    doc_ref.update({attribute: value})

def delete_yokai(number):
    db.collection('yokai').document(str(number)).delete()

if __name__ == '__main__':
    yokai_data = read_yokai_json('yokai.json')
    upload_to_firestore(yokai_data)
    fetch_all_yokai()
    fetch_yokai_by_number(1)
    update_yokai_attribute(1, 'name', 'NewName')
    delete_yokai(1)
