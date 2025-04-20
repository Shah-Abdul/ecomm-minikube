# ecomm-minikube
Deployment Wrapper for e-comm app using Minikube; contains yaml scripts for initialising and deploying every service in the e-comm app.

## Prerequisites
Install Docker, minikube and kubectl in your system.

## How to run locally
All the yaml files for creating resources of each service, and deploying them, are applied in the right order in this shell script: 
```sh
sh create-resources.sh
```