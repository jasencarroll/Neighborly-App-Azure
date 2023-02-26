# move over to the client-side
cd ../NeighborlyFrontEnd
#install dependencies
python3 -m pip install -r requirements.txt

# move over to the client-side
cd ..
# go into shell
pipenv shell
# move over to the client-side
cd ../NeighborlyFrontEnd
# test the webapp locally
python app.py

