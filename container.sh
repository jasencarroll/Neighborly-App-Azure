#! /bin/sh
## ENSURE THAT YOU KNOW LOGGED INTO DOCKER APPREG

#! /bin/sh
## ENSURE THAT YOU KNOW YOUR WEBAPP IP ADDRESS PRIOR TO RUNNING SCRIPT ##
## AND HAVE SAVED ACCORDINGLY IN YOUR settings.py ##
## IP_ADDRESS is the dockerized function endpoint

cd NeighborlyFrontEnd

# go into the shell
pipenv shell

#login to azure
az login

# Create a container with Azure
az acr 

# Run from within the existing Function project directory.
# Creates a Dockerfile
func init --docker-only --python

# SYNTAX 
# docker build -t <name:tag> <path>
docker build -t $imageName:$imageTag .

docker run -p 7071:7071 -it $imageName:$imageTag

# Create a repository in ACR service
az acr create \
  --resource-group $resourceGroup \
  --name $appRegistry \
  --sku Basic

# then log in
az acr login --name $appRegistry

# Both these commands will give a same result
az acr show \
  --name $appRegistry 
  --query loginServer 
  --output table

# let the user login to Docker using password from Azure appRegistry
docker login $appRegistry.azurecr.io \

docker push $appRegistry.azurecr.io/$imagename:$imageTag

az acr repository list --name $appRegistry  --output table

# Create an Azure Kubernetes cluster
az aks create \
--name $AKSCluster \
--resource-group $resourceGroup \
--node-count 2 \
--generate-ssh-keys \
--attach-acr $appRegistry \
--location $region

# Get credentials for your container service
az aks get-credentials \
  --name $AKSCluster \
  --resource-group $resourceGroup

# Make sure Docker Desktop is running
kubectl version --client

# verify the connection to the cluster
kubectl get nodes

# build the image and deploy to K8s
func kubernetes deploy \
--name $functionApp \
--registry $appRegistry \
[--dry-run > deploy.yml]

# check deployement
kubectl config get-contexts

kubectl get service --watch
