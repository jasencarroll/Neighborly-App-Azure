#! /bin/sh
## ENSURE THAT YOU KNOW YOUR locahost:PORT NUMBER PRIOR TO RUNNING SCRIPT ##
## AND HAVE SAVED ACCORDINGLY IN YOUR settings.py ##

# move into the API
cd NeighborlyAPI
# install dependencies
pipenv install
# go into the shell
pipenv shell
#test functionApp locally 
func start -build [-p 7071] --verbose

# move over to the client-side
cd ../NeighborlyFrontEnd

# install frontend dependencies
pipenv install

# go into shell
pipenv shell

# test the webapp locally
python app.py

