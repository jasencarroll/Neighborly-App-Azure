import azure.functions as func
import logging
import json
import pymongo
from bson.json_util import dumps
from bson.objectid import ObjectId


def main(req: func.HttpRequest) -> func.HttpResponse:

    id = req.params.get('id')

    if id:
        try:
            url = "mongodb://cosmojc186148:VNTLW4DxnQYmuGrgNxemchah8k8VX2rUffJZqMSKi3N5ZcmYYPlvVI7zKWl5svVmJNeQOOZ2YkcbACDbwQlxew==@cosmojc186148.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@cosmojc186148@"  # TODO: Update with appropriate MongoDB connection information
            client = pymongo.MongoClient(url)
            database = client['dbjc186148']
            collection = database['advertisements']
            
            query = {'_id': ObjectId(id)}
            result = collection.delete_one(query)
            return func.HttpResponse("")

        except:
            print("could not connect to mongodb")
            return func.HttpResponse("could not connect to mongodb", status_code=500)

    else:
        return func.HttpResponse("Please pass an id in the query string",
                                 status_code=400)
