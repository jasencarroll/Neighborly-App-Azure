#! /bin/sh
# before we start load variables
chmod +x variables.sh
source variables.sh

# az login

# start with creating a resource group
az group create --name $resourceGroup --location $region

# then create a storage account
az storage account create \
--name $storageAccount \
--location $region \
--resource-group $resourceGroup \
--sku Standard_LRS

# afterwards create a function app
az functionapp create \
--name $functionApp  \
--storage-account $storageAccount \
--consumption-plan-location $region \
--resource-group $resourceGroup \
--functions-version 3 \
--os-type Linux \
--runtime python

# create the cosmosdb for the MongoDB API
az cosmosdb create \
  -n $cosmosDBAccountName \
  -g $resourceGroup \
  --kind MongoDB \
  --server-version $serverVersion \
  --default-consistency-level Eventual \
  --enable-automatic-failover false

# index file in Azure Cosmos DB's API for MongoDB
  printf ' 
[ 
  {
      "key": {"keys": ["_id"]}
  }
]' > idxpolicy-$uniqueId.json

# Create a MongoDB API Ads Collection
az cosmosdb mongodb collection create \
  -a $cosmosDBAccountName \
  -g $resourceGroup \
  -d $databaseName \
  -n $adsCollection \
  --shard '_id' \
  --throughput 400 \
  --idx @idxpolicy-$uniqueId.json

  # Create a MongoDB API Posts Collection
az cosmosdb mongodb collection create \
  -a $cosmosDBAccountName \
  -g $resourceGroup \
  -d $databaseName \
  -n $postsCollection \
  --shard '_id' \
  --throughput 400 \
  --idx @idxpolicy-$uniqueId.json

## if you have to delete something
# az cosmosdb mongodb collection delete \
# -a $cosmosDBAccountName \
# -g $resourceGroup \
# -d $databaseName \
# -n $collectionName

## if you need to view the collection
#az cosmosdb mongodb collection list \
#  --account-name $cosmosDBAccountName \
#  --resource-group $resourceGroup \
#  --database-name $databaseName
