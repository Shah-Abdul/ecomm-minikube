# ecomm-minikube

Deployment Wrapper for e-comm app using Minikube; contains yaml scripts for initialising and deploying every service in the e-comm app.

## Prerequisites

- Install Docker, minikube and kubectl in your system.

- Clone all the repos for each service present in the system. These are:
  - [auth-service](https://github.com/Shah-Abdul/ecomm-auth-service/)
  - [ui-service](https://github.com/Shah-Abdul/ecomm-ui)
- Build the docker images of each of these services, and push to the local minikube image registry, by running the following steps for each service (example is for auth service):

```
    eval $(minikube docker-env) # To use the local docker env, and not an external registry
    docker build -t auth-service . # To build the docker image (ensure the service name given here is consistent with the image name mentioned in the corresponding deployment yaml)
    minikube image push auth-service # Push the built docker image to the local minikube registry.
```

**Note:** _These above 3 commands have been added as a script in the npm project for convenience, and can be executed by `npm run build:docker`_

## How to run locally

All the yaml files for creating resources of each service, and deploying them, are applied in the right order in this shell script:

```sh

sh  create-resources.sh

```

Verify all the service pods are running locally by checking the status:

```sh

kubectl  get  pods  -n  ecommerce

```

Sometimes some pods can take a bit longer to get up and running. Wait for all the pods to show the status as `Running`, for example:

```

NAME READY STATUS RESTARTS AGE

auth-service-546fd5996c-cgz46 1/1 Running 0 94s

mongo-6878f875b-r9gvd 1/1 Running 0 94s

```

You can expose individual services from the kubernetes cluster to your host machine by running the appropriate command (for the service you want to test) from the below ones:

```sh

# Access UI from host machine:

kubectl  port-forward  service/ui-service  3000:3000  -n  ecommerce



# Access MongoDB (Auth DB) from host machine (locally for testing):

kubectl  port-forward  service/mongo  27017:27017  -n  ecommerce



# Access Auth Service from host machine (locally for testing):

kubectl  port-forward  service/auth-service  5000:5000  -n  ecommerce

```

Access the UI at http://localhost:3000/

## Ports used by each service

Since the application consists of multiple services deployed locally , we need to ensure that no 2 services use the same port. List of ports used and exposed by services is provided below. Please ensure that for any subsequent service/DB, a different port is used than the ones mentioned below:

- DB for Authentication (MongoDB): 27017

- Auth Service (Node): 5000

- UI Service (React): 3000
