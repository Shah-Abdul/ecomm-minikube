
# Create namespace if it doesn't exist
kubectl create namespace ecommerce --dry-run=client -o yaml | kubectl apply -f -

# Set your Docker environment to use the Minikube Docker daemon: In order to use local docker images of various services
eval $(minikube docker-env)

# Ensure that you build the images of the services locally, and then push them to the Minikube docker daemon.

# Create resources, in order:

# Create secrets first
kubectl apply -f ./auth-mongo-db/auth-mongo-secret.yaml -n ecommerce
kubectl apply -f ./auth-service/auth-secrets.yaml -n ecommerce

# Create MongoDB (for Auth) deployment and service:
kubectl apply -f ./auth-mongo-db/auth-DB-mongo-deployment.yaml -n ecommerce
kubectl apply -f ./auth-mongo-db/auth-DB-mongo-service.yaml -n ecommerce

# Create auth service deployment and service
kubectl apply -f ./auth-service/auth-deployment.yaml -n ecommerce
kubectl apply -f ./auth-service/auth-service.yaml -n ecommerce

# Create UI service deployment and service
kubectl apply -f ./ui-service/ui-deployment.yaml -n ecommerce
kubectl apply -f ./ui-service/ui-service.yaml -n ecommerce

echo "All resources applied!"