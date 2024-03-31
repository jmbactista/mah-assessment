## Assessment
This Repository contains the following:
- Basic setup of automated creation of EKS Cluster
- Automated deployment of NGINX which can be accessible publicly

## Pre-requisite
Before proceeding needed to setup the following Environment Variables for the pipeline and also install the following package for this:
- AWS Credentials on the secrets
  - Access Key and Secret Key
- Installation of eksctl 0.175.0
- Installation of kubectl v1.15.0

## EKS Cluster Creation
Use the `eksctl create` command to create the EKS Cluster. On this demo it will only include the following:
- Cluster
- NodeGroups
- VPC

For the the `Cluster Deployment` run the following command:
```
eksctl create cluster -f cluster/mha-assessment-cluster.yaml
```

## Connect to EKS
Run the following to add the newly created EKS Cluster to your local aws eks config
```
aws eks update-kubeconfig --region ap-southeast-1 --name mha-cluster
```
Test connection
```
kubectl get nodes
kubectl get namespaces
```

## NGINX Deployment
Use the `kubectl apply` command to deploy the yaml for for the Nginx Application. It includes the following to be created:
- Deployment
- Service

For the `NGINX Deployment` run the following command:
```
kubectl apply -f deployment/nginx-deployment.yaml
```

## NGINX Checking
This is to check if NGINX is successfully deployed. 
Run the following command to check the endpoint on the loadbalancer of NGINX then try to hit it on your desired browser.
```
kubectl get svc
```
This is the example output 
Get the `EXTERNAL-IP` for the `nginx-service`. 
NOTE: If not available or still pending, you can check the loadbalancer in AWS Console to get the LoadBalancer Endpoint for you to be able to access the Nginx publicly.
