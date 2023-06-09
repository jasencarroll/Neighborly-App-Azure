#! /bin/sh
## ENSURE THAT YOU KNOW YOUR locahost:PORT NUMBER PRIOR TO RUNNING SCRIPT ##
## AND HAVE SAVED ACCORDINGLY IN YOUR settings.py ##

# install dependencies in normal environments if needed. 
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

