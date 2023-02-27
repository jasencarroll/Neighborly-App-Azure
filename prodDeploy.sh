#! /bin/sh
## ENSURE THAT YOU KNOW YOUR WEBAPP SITE PRIOR TO RUNNING SCRIPT ##
## AND HAVE SAVED ACCORDINGLY IN YOUR settings.py ##

# install dependencies
pipenv install
# go into the shell
pipenv shell
# Go into the API
cd NeighborlyAPI
#install dependencies
python3 -m pip install -r requirements.txt
#test functionApp publicly  
func azure functionapp publish $functionApp

# move over to the client-side
cd ../NeighborlyFrontEnd
#install dependencies
python3 -m pip install -r requirements.txt

# FLASK_RUN variable must be exported so that the Azure stack
# know which entry point to start the Flask app. 
export FLASK_RUN=app.py

# deploy the webapp
az webapp up \
  --resource-group "rgjc186148" \
  --name "jc186148-webappsr" \
  --runtime "python:3.7"
  --sku=F1 \
  --location "westus3" \
  --verbose

