#!/bin/bash
# docker run --name my-mysql-2 -v db_data:/var/lib/mysql -v ./main.sql:/docker-entrypoint-initdb.d/main.sql  -e MYSQL_USER=may -e MYSQL_PASSWORD=hoppingtext -e MYSQL_DATABASE=test_db -d mysql:latest 
# docker run -d --name my-php --link my-mysql-2:mysql -p 8080:80 -e MYSQL_PASSWORD=hoppingtext -v .:/var/www/html mbaoma/my-php
# docker run --name wphpmyadmin  --link my-mysql-2:db -p 80:80 -d phpmyadmin/phpmyadmin
# docker run --name mysqld --link my-mysql-2:db -e MYSQL_USER=may -e MYSQL_PASSWORD -e MYSQL_DATABASE=test_db -v ./.my.cnf:/.my.cnf prom/mysqld-exporter

docker run -d --network phpNetwork --name mysql-c -v db_data:/var/lib/mysql -v ./main.sql:/docker-entrypoint-initdb.d/main.sql -e MYSQL_USER=may -e MYSQL_PASSWORD=hoppingtext -e MYSQL_DATABASE=test_db -p 3306:3306 mysql:latest
