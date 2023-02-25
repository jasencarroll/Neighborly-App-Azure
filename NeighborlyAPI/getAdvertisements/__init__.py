import azure.functions as func
import pymongo
import json
from bson.json_util import dumps

def main(req: func.HttpRequest) -> func.HttpResponse:

    try:
            url = "mongodb://cosmojc186148:VNTLW4DxnQYmuGrgNxemchah8k8VX2rUffJZqMSKi3N5ZcmYYPlvVI7zKWl5svVmJNeQOOZ2YkcbACDbwQlxew==@cosmojc186148.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@cosmojc186148@"  # TODO: Update with appropriate MongoDB connection information
            client = pymongo.MongoClient(url)
            database = client['dbjc186148']
            collection = database['posts']


        result = collection.find({})
        result = dumps(result)

        return func.HttpResponse(result, mimetype="application/json", charset='utf-8')
    except:
        print("could not connect to mongodb")
        return func.HttpResponse("could not connect to mongodb",
                                 status_code=400)

