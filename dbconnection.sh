#! /bin/sh

# get necessary variables
chmod +x variables.sh
source variables.sh

# finally import data from json files to the MongoDB API Collections
mongoimport --uri $connectionString --collection $adsCollection --file="./sample_data/sampleAds.json" --jsonArray
mongoimport --uri $connectionString --collection $postsCollection --file="./sample_data/samplePosts.json" --jsonArray

#########################################
# Now we need to establish a connection between cosmosDB 
# and the Function App. To that end, get the cosmosDB 
# connection string as follows:
########################################

# Fetch and store the connection string
connectionString=$(az cosmosdb keys list \
--type connection-strings \
--name $cosmosDBAccountName \
--resource-group $resourceGroup \
--query 'connectionStrings[0].connectionString' \
--output tsv) 
echo $connectionString
printf "confirm in local.settings.json or save accordingly"

# save the value in fApps
az functionapp config appsettings set \
--name $functionApp \
--resource-group $resourceGroup \
--setting MyDbConnection=$connectionString

