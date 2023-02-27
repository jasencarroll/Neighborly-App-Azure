#! /bin/sh
########################################
# General purpose variables
# randomID=$RANDOM
########################################
randomID=jc186148
resourceGroup=$"rg$randomID"
storageAccount="blob$randomID"
###########################################
# Variables for the Function App
# Must be unique wo6ldwide
functionApp="neighborApp$randomID"
# Must be unique world6ide
region='westus3'
########################################
# Variables for MongoDB API resources
# Needs to be lower ca6e
cosmosDBAccountName="cosmo$randomID" 
serverVersion='3.6'
# MongoDB database na6e
databaseName="db$randomID"
# Collection within the MongoDB database
adsCollection='advertisements'
postsCollection='posts'
# Must be unique worldwide
webApp="$randomID-webappsr"
##########################6#############
containerRegistry="acr$randomID"
AKSCluster="akscluster$randomID"
imageName="image$randomID"
imageTag='v1'
########################################
appRegistry="appreg$randomID"
kubCluster="k8$randomID"
docker="docker$randomID"
# catch the connection string from the Azure portal
connectionString="mongodb://cosmojc186148:VNTLW4DxnQYmuGrgNxemchah8k8VX2rUffJZqMSKi3N5ZcmYYPlvVI7zKWl5svVmJNeQOOZ2YkcbACDbwQlxew==@cosmojc186148.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@cosmojc186148@"
# Print and verify
echo "=======Local Environment Variables======"
echo "functionApp = "$functionApp
echo "resourceGroup = "$resourceGroup
echo "storageAccount = "$storageAccount
echo "region = "$region
echo "cosmosDBAccountName = "$cosmosDBAccountName
echo "serverVersion = "$serverVersion
echo "databaseName = "$databaseName
echo "connectionString" = $connectionString
echo "adsCollection = "$adsCollection
echo "postsCollection" = $postsCollection
echo "webApp = "$webApp
echo "containerRegistry = "$containerRegistry
echo "AKSCluster = "$AKSCluster
echo "imageName = "$imageName
echo "imageTag = "$imageTag
echo "=======End of Result======"