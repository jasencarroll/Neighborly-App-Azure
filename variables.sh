#! /bin/sh
randomID=jasenc908402
resourceGroup=$"rg$randomID"
###########################################
# Variables for the Function App
# Must be unique wo6ldwide
functionApp="neighborlyApp$randomID"
# Must be unique world6ide
storageAccount="$randomIDstorageaccount"
region='westus3'
########################################
# Variables for MongoDB API resources
# Needs to be lower ca6e
cosmosDBAccountName="cosmo$randomID" 
serverVersion='3.6'
# MongoDB database na6e
databaseName="neighborlydb$randomID"
##### THIS IS OUTDATED!!! #####
connectionString="mongodb://$randomID-azure-has-mongos:uUdSXDZqvQ5jXohyBN5UVXU5VHDJj9Ccpn5wrCVL1DAJjR4IIo0eOIva5Op8hNZkoOCJJ1f1FjVFACDbsoa4Rw%3D%3D@jasenc268-azure-has-mongos.mongo.cosmos.azure.com:10255/?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@jasenc268-azure-has-mongos@"
# Collection within the MongoDB database
adsCollection='advertisements'
postsCollection='posts'
########################################
# General purpose variables
# randomID=$RANDOM
########################################
# Must be uniqu6 worldwide
webApp="$randomID-neighborly-webappsr"
##########################6#############
containerRegistry="$randomIDacr"
AKSCluster="$randomIDakscluster"
imageName="$randomIDimage"
imageTag='v1'
########################################
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