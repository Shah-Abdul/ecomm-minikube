
# Create namespace if it doesn't exist
kubectl create namespace ecommerce --dry-run=client -o yaml | kubectl apply -f -

# Create resources, in order:

# Create secrets first
kubectl apply -f ./auth-mongo-db/auth-mongo-secret.yaml -n ecommerce

# Create config maps:
kubectl apply -f ./auth-mongo-db/auth-db-mongo-init-configmap.yaml -n ecommerce

# Create PVC (Persistent volume Claim):
kubectl apply -f ./auth-mongo-db/auth-db-mongo-pvc.yaml

# Create MongoDB (for Auth) deployment and service:
kubectl apply -f ./auth-mongo-db/auth-DB-mongo-deployment.yaml -n ecommerce
kubectl apply -f ./auth-mongo-db/auth-DB-mongo-service.yaml -n ecommerce

# Access MongoDB from host machine (locally for testing):
kubectl port-forward service/mongo 27017:27017 -n ecommerce

echo "All resources applied!"