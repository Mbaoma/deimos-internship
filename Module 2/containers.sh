#!/bin/bash
docker run --name my-mysql-2 -v ./main.sql:/docker-entrypoint-initdb.d/main.sql  -e MYSQL_USER=may -e MYSQL_PASSWORD=hoppingtext -e MYSQL_DATABASE=test_db -d mysql:latest 
docker run -d --name my-php --link my-mysql-2:mysql -p 8080:80 -e MYSQL_PASSWORD=hoppingtext -v .:/var/www/html mbaoma/my-php
docker run --name wphpmyadmin  --link my-mysql-2:db -p 80:80 -d phpmyadmin/phpmyadmin