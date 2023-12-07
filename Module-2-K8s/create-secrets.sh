#!/bin/bash
kubectl create secret generic mysql-secrets \
    --from-literal=MYSQL_PASSWORD=hoppingtext \
    --from-literal=MYSQL_ROOT_PASSWORD=hopping \
    --from-literal=MYSQL_DATABASE=test_db \
    --from-literal=MYSQL_USER=may