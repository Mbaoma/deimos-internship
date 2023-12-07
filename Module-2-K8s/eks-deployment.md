# gdg-ikorodu-demo
Deploying applications on Google Kubernetes Engine

# multi-container-deployment-k8s

To build and deploy a multi-tier web application using Kubernetes and Docker. Components include: A single-instance Redis to store guestbook entries, Multiple web frontend instances

## Setting up on GKE
- In your CLI, login and configure your project
```
gcloud auth login
gcloud config set project [PROJECT_ID]
```

- Install [gcloud](https://cloud.google.com/sdk/docs/install) CLI
- Install [Kubectl](https://cloud.google.com/kubernetes-engine/docs/how-to/cluster-access-for-kubectl) and required dependencies
```
sudo apt-get install kubectl 
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
```
OR
```
gcloud components install kubectl
gcloud components install gke-gcloud-auth-plugin
```

- Create cluster
```
gcloud container --project "kubernetes-work-396809" clusters create-auto "gdg-demo" --region "us-east1" --release-channel "regular" --network "projects/kubernetes-work-396809/global/networks/default" --subnetwork "projects/kubernetes-work-396809/regions/us-east1/subnetworks/default" --cluster-ipv4-cidr "/17"
```

- Set up an Ingress controller 
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.0/deploy/static/provider/cloud/deploy.yaml
```

- Create and Push Docker images to Google Image Registry
```
gcloud auth configure-docker
docker build -t gcr.io/[PROJECT-ID]/[IMAGE] .
docker push gcr.io/kubernetes-work-396809/gdg-image [PROJECT-ID]/[IMAGE]
```
- Create database secrets (this will be created by running a script)

```
#!/bin/bash
kubectl create secret generic [secret-name] \
    --from-literal=key1=value1 \
    --from-literal=key2=value2
```
Then run the script
```
./create-secrets.sh
```

- Apply configurations
```
kubectl apply -f mysql-database
kubectl apply -f php-my-admin
kubectl apply -f web-app
```
