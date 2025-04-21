# ecomm-minikube
Deployment Wrapper for e-comm app using Minikube; contains yaml scripts for initialising and deploying every service in the e-comm app.

## Prerequisites
Install Docker, minikube and kubectl in your system.

## How to run locally
All the yaml files for creating resources of each service, and deploying them, are applied in the right order in this shell script: 
```sh
sh create-resources.sh
```

Verify all the service pods are running locally by checking the status:
```sh
kubectl get pods -n ecommerce
```

Sometimes some pods can take a bit longer to get up and running. Wait for all the pods to show the status as `Running`, for example:
```
NAME                            READY   STATUS    RESTARTS   AGE
auth-service-546fd5996c-cgz46   1/1     Running   0          94s
mongo-6878f875b-r9gvd           1/1     Running   0          94s
```

You can expose individual services from the kubernetes cluster to your host machine by running the appropriate command (for the service you want to test) from the below ones:
```sh
# Access MongoDB (Auth DB) from host machine (locally for testing):
kubectl port-forward service/mongo 27017:27017 -n ecommerce

# Access Auth Service from host machine (locally for testing):
kubectl port-forward service/auth-service 5000:5000 -n ecommerce
```

## Ports used by each service
Since the application consists of multiple services deployed locally, we need to ensure that no 2 services use the same port. List of ports used and exposed by services is provided below. Please ensure that for any subsequent service/DB, a different port is used than the ones mentioned below:

- DB for Authentication (MongoDB): 27017
- Auth Service (Node): 5000
- UI Service (React): 3000
