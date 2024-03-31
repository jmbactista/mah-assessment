# mah-assessment
This Repository contains the following:
- Basic setup of automated creation of EKS Cluster
- Automated deployment of NGINX which can be accessible publicly

# Pre-requisite
Before proceeding needed to setup the following Environment Variables for the pipeline and also install the following package for this:
- AWS Credentials on the secrets
  - Access Key and Secret Key
- Installation of eksctl 0.175.0
- Installation of kubectl v1.15.0

#EKS Cluster Creation
Use the `eksctl create` command to create the EKS Cluster. On this demo it will only include the following:
- Cluster
- NodeGroups
