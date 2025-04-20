# Create resources, in order:
kubectl apply -f auth-DB-mongo-deployment.yaml -n ecommerce
kubectl apply -f auth-DB-mongo-service.yaml -n ecommerce
# Access MongoDB from host machine (locally for testing):
kubectl port-forward service/mongo 27017:27017

echo "All resources applied!"