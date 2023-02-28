#! /bin/sh
# before we start load variables
chmod +x variables.sh
source variables.sh

# Pat 1 - Get Azure Ready
# Create a repository in ACR service
az acr create \
  --resource-group $resourceGroup \
  --name $appRegistry \
  --sku Basic
echo "acr created"
# then log in
az acr login --name $appRegistry
echo "logged in"
# Both these commands will give a same result
az acr show \
  --name $appRegistry \
  --query loginServer \
  --output table
echo "list above"

# Part 2 - Docker
func init --docker-only --python

# Build the docker image
docker build -t $imageName .

# Test the image locally
docker run -p 7071:7071 -it $imageName

# Tag your docker image for Azure Container Registry
docker tag $imageName $appRegistry.azurecr.io/$imageName:$imageTag

echo "# Go to Container Registry >> Settings >> Access Keys and enable the Admin user. 
# Use those credentials to login from your terminal."
docker login $appRegistry.azurecr.io \
  --username $username \
  --password-stdin $pass
echo "Docker logged in"

docker push $appRegistry.azurecr.io/$imageName:$imageTag
echo "Docker pushed"
az acr repository list --name $appRegistry  --output table
echo "list shown"

# Create an Azure Kubernetes cluster
az aks create \
--name $kubCluster \
--resource-group $resourceGroup \
--node-count 2 \
--generate-ssh-keys \
--attach-acr $appRegistry \
--location $region
echo "aks created"
# Get credentials for your container service
az aks get-credentials \
  --name $kubCluster \
  --resource-group $resourceGroup
echo 'got credentials'
# Make sure Docker Desktop is running
kubectl version --client
echo 'version'
# verify the connection to the cluster
kubectl get nodes
echo 'nodes'
# build the image and deploy to K8s
func kubernetes deploy \
--name $kubCluster \
--image-name $containerRegistry.azurecr.io/$imageName:$imageTag \
echo 'live'
# check deployement
kubectl config get-contexts

kubectl get service --watch

