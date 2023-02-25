#! /bin/sh
## ENSURE THAT YOU KNOW YOUR WEBAPP SITE PRIOR TO RUNNING SCRIPT ##
## AND HAVE SAVED ACCORDINGLY IN YOUR settings.py ##

# move into the API
cd NeighborlyAPI
# install dependencies
pipenv install
# go into the shell
pipenv shell
#test functionApp publicly  
func azure functionapp publish $functionApp

# move over to the client-side
cd ../NeighborlyFrontEnd

# install frontend dependencies
pipenv install

# go into shell
pipenv shell

# FLASK_RUN variable must be exported so that the Azure stack
# know which entry point to start the Flask app. 
export FLASK_RUN=app.py

# deploy the webapp
az webapp up \
  --resource-group "rgjc186148" \
  --name "jc186148-webappsr" \
  --sku F1 \
  --location "westus3"
  --verbose

