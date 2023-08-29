This folder contains my configuration for deploying the form in [Module-2](https://github.com/DeimosCloud/mary-sre-internship-2023/tree/main/Module%202), to Kubernetes.

## Deploy on local Kubernetes (Docker Desktop)
- Create secrets (ideally values you would put in a ```.env``` file)
```
kubectl create secret generic mysql-secrets \
--from-literal=MYSQL_ROOT_PASSWORD=<value> \
--from-literal=MYSQL_PASSWORD=<value>\
--from-literal=MYSQL_DATABASE=<value> \
--from-literal=MYSQL_PORT=3306 \
--from-literal=MYSQL_USER=<value>
```

- Setup [Ingress](https://kubernetes.github.io/ingress-nginx/deploy/)

- Apply configuration
```
$ kubectl apply -f mysql-database
$ kubectl apply -f php-my-admin
$ kubectl apply -f web-app
```

<img width="1328" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/f27da203-d4f0-468a-a9de-e4b94146ba91">
*web-app-before-filling-data*

<img width="1328" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/cb2fe35c-1999-453f-8d94-6d0e751397cf">
*web-app-with-duplicate-mails*

<img width="1328" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/bcf66b27-2e9c-4de9-850c-cd6b46d26730">
*web-app-after-filling-data*

<img width="1328" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/01703883-348f-4e8a-a406-179ff633db8e">
*php-my-admin*

## Deploy to Google Kubernetes Engine (GKE)
- Create a Cloud Shell
- Create a project
- Create a cluster
```
$ gcloud container clusters create-auto php-web-app \
    --location=us-west1
```

- Get authentication credentials for the cluster
```
$ gcloud container clusters get-credentials php-web-app \
    --location=us-west1
```

- Create secrets (ideally values you would put in a ```.env``` file)
```
kubectl create secret generic mysql-secrets \
--from-literal=MYSQL_ROOT_PASSWORD=<value> \
--from-literal=MYSQL_PASSWORD=<value>\
--from-literal=MYSQL_DATABASE=<value> \
--from-literal=MYSQL_PORT=3306 \
--from-literal=MYSQL_USER=<value>
```

- Apply configuration
```
$ kubectl apply -f mysql-database
$ kubectl apply -f php-my-admin
$ kubectl apply -f web-app
$ kubectl apply -f ingress.yaml
```
