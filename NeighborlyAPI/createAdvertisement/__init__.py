import azure.functions as func
import logging
import json
import pymongo
from bson.json_util import dumps
from bson.objectid import ObjectId

def main(req: func.HttpRequest) -> func.HttpResponse:

    request = req.get_json()

    if request:
        try:
            url = "mongodb://cosmojc186148:VNTLW4DxnQYmuGrgNxemchah8k8VX2rUffJZqMSKi3N5ZcmYYPlvVI7zKWl5svVmJNeQOOZ2YkcbACDbwQlxew==@cosmojc186148.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@cosmojc186148@"  # TODO: Update with appropriate MongoDB connection information
            client = pymongo.MongoClient(url)
            database = client['dbjc186148']
            collection = database['advertisements']
            rec_id1 = collection.insert_one(request)

            return func.HttpResponse(req.get_body())

        except Exception as e:
            logging.error(e)
            return func.HttpResponse('Could not connect to mongodb', status_code=500)

    else:
        return func.HttpResponse(
            "Please pass name in the body",
            status_code=400
        )