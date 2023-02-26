# Deploying the Neighborly App with Azure Functions

## Project Overview

For the final project of the updated Udacity Full Stack Nanodegree, an app called "Neighborly" was built and deployed. Neighborly is a Python Flask-powered web application that allows neighbors to post advertisements for services and products they can offer.

The Neighborly project is comprised of a front-end application that is built with the Python Flask micro framework. The application allows the user to view, create, edit, and delete the community advertisements.

The application makes direct requests to the back-end API endpoints. These are endpoints that we will also build for the server-side of the application.

You can see an example of the deployed app below.

![Deployed App](images/final-app.png)

## Ubuntu Environment

To keep this as simple as possible, I would HIGHLY advise building this on Ubuntu. If you need to ssh into a VM or server remember the ssh tunnel so you can check you local build. Azure will default to localhost:7071, making your login:

```bash
ssh -L [portForClient]:localhost:[portFromServer] [user]@[ip address] -p [ssh port]
```

In my case that would be:

```bash
ssh -L 3000:localhost:7071 jasen@XXX.XXX.X.XXX -p XX
```

## Getting Started

On Ubuntu 20.04 LTS, you can do this with:

```bash
# install pipenv
sudo apt install pipenv

# install azure-cli
sudo apt install azure-cli

# install azure function core tools 
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-$(lsb_release -cs)-prod $(lsb_release -cs) main" > /etc/apt/sources.list.d/dotnetdev.list'

sudo apt-get update

sudo apt-get install azure-functions-core-tools-4
        
# get the mongodb library
sudo apt install mongo-tools

# check if mongoimport lib exists
mongoimport --version
```

## Resources

Ensure terminal is running in the project folder

```bash
source variables.sh

bash resource.rh
```

the output should look like resourcesOutput.json

Copy the connection string to local.settings.json if not already there.

## Confirm import of Sample Data Into MongoDB

- Rources should import the data from the `sample_data` directory for Ads and Posts to initially fill your app.

    ```
    # finally import data from json files to the MongoDB API Collections
    mongoimport --uri $connectionString --d $databaseName --collection $adsCollection --file="./sample_data/sampleAds.json" --jsonArray
    mongoimport --uri $connectionString --d $databaseName --collection $postsCollection --file="./sample_data/samplePosts.json" --jsonArray
    ```

- Example successful import:

    ```
    Importing ads data ------------------->
    2020-05-18T23:30:39.018-0400  connected to: mongodb://neighborlyapp.mongo.cosmos.azure.com:10255/
    2020-05-18T23:30:40.344-0400  5 document(s) imported successfully. 0 document(s) failed to import.
    ...
    Importing posts data ------------------->
    2020-05-18T23:30:40.933-0400  connected to: mongodb://neighborlyapp.mongo.cosmos.azure.com:10255/
    2020-05-18T23:30:42.260-0400  4 document(s) imported successfully. 0 document(s) failed to import.
    ```

## Confirm connection strings

```bash
connectionString=$(az cosmosdb keys list \
--type connection-strings \
--name $cosmosDBAccountName \
--resource-group $resourceGroup \
--query 'connectionStrings[0].connectionString' \
--output tsv) 

echo $connectionString
printf "confirm in local.settings.json or save accordingly"
```

Add the connection string to each HTTP Trigger and ensure each trigger is accessing the right data.

## Local Deploy

- Install dependencies in normal environments if needed.
```bash
# move over to the client-side
cd NeighborlyAPI
# install dependencies
python3 -m pip install -r requirements.txt
# create a virtualenv
cd ..
# install dependencies
pipenv install
# go into the shell
pipenv shell
# move into the API
cd NeighborlyAPI
#install dependencies
python3 -m pip install -r requirements.txt
# move over to the client-side
cd ../NeighborlyFrontEnd
#install dependencies
python3 -m pip install -r requirements.txt
```

### Backend/API

```bash
# move into the API
cd NeighborlyAPI
# install dependencies
pipenv install
# go into the shell
pipenv shell
#test functionApp locally 
func start -build [-p 7071] --verbose
```

Expected output if deployed successfully:

```bash
Functions in <APP_NAME>:
    createAdvertisement - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/createadvertisement

    deleteAdvertisement - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/deleteadvertisement

    getAdvertisement - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/getadvertisement

    getAdvertisements - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/getadvertisements

    getPost - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/getpost

    getPosts - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/getposts

    updateAdvertisement - [httpTrigger]
        Invoke url: https://<APP_NAME>.azurewebsites.net/api/updateadvertisement

```

**Note:** It may take a minute or two for the endpoints to get up and running if you visit the URLs.

Save the function app url **<https://<APP_NAME>.azurewebsites.net/api/>** since you will need to update that in the client-side of the application.

### FrontEnd/Client

```bash
# move over to the client-side
cd ..
# go into shell
pipenv shell
# move over to the client-side
cd ../NeighborlyFrontEnd
# test the webapp locally
python app.py
```

Test everything with Postman.

## Live Deploy

### Backend/API
```bash
# Go into the API - assuming already in pipenv shell
cd ../NeighborlyAPI
#install dependencies
python3 -m pip install -r requirements.txt
#test functionApp publicly  
func azure functionapp publish $functionApp
```

### FrontEnd/Client

Use a text editor to update the API_URL to your published url from the last step.

```bash
# Inside file settings.py

# ------- For Local Testing -------
#API_URL = "http://localhost:7071/api"

# ------- For production -------
# where APP_NAME is your Azure Function App name 
API_URL="https://<APP_NAME>.azurewebsites.net/api"
```
```bash
az webapp up \
--resource-group $resourceGroup \
--name $webApp \
--runtime="Python:3.8"
--sku=F1
--location $region
```

Expected output if deployed successfully:

### III. CI/CD Deployment

1. Create an Azure Registry and dockerize your Azure Functions. Then, push the container to the Azure Container Registry.
2. Create a Kubernetes cluster, and verify your connection to it with `kubectl get nodes`.
3. Deploy app to Kubernetes, and check your deployment with `kubectl config get-contexts`.

### IV. Event Hubs and Logic App

1. Create a Logic App that watches for an HTTP trigger. When the HTTP request is triggered, send yourself an email notification.
2. Create a namespace for event hub in the portal. You should be able to obtain the namespace URL.
3. Add the connection string of the event hub to the Azure Function.

### V.  Cleaning Up Your Services

Before completing this step, make sure to have taken all necessary screenshots for the project! Check the rubric in the classroom to confirm.

Clean up and remove all services, or else you will incur charges.

```bash
# replace with your resource group
RESOURCE_GROUP="<YOUR-RESOURCE-GROUP>"
# run this command
az group delete --name $RESOURCE_GROUP
```
