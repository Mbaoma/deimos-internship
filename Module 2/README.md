# Efficient Containerization: A Comprehensive Guide to Building and Deploying Secure PHP-MySQL Web Applications with Docker

## Goal 
- Create a Web Server and save form data into MySQL database using PHP 
- Web server can be apache2 or nginx,
- Using the above guide dockerize the form application written in PHP and link to a mysql database 
- Application should be accessible on your localhost and form should be able to write to database using containers and relevant networking
  
**Bonus Challenges**
- Use docker-compose to create the application and database backend
- Data to persist on container restart
- Include monitoring (personal preference)

## Running the website (using docker-compose)
- Create a ```.env``` file, to supply credentials as environemnt variables to the PHP app and database 
```
MYSQL_ROOT_PASSWORD=<value>
MYSQL_PASSWORD=<value>
DB_HOST=<value>
MYSQL_DATABASE=<value>
MYSQL_PORT=<value>
MYSQL_USER=<value>
```

- Create a ```.my.cnf``` file to supply database credentials to the ```mysqld_exporter``` (for Prometheus monitoring)
```
[client]
user = <value>
password = <value>
host = <value>
```

- Start the container,
```docker
$ docker-compose up --build
```

## The app (in pictures - docker compose)

<img width="1009" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/baa1ca77-eb32-40b5-9a27-ceba38993c6b">

App - *[http:ocalhost:8080/index.html](http:ocalhost:8080/index.html)*

<img width="920" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/93b7c82d-1557-4a44-8ef3-ec06bb9ae2ca">

*redirection*

<img width="1150" alt="Screenshot 2023-07-23 at 17 07 08" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/7d8c7aa7-00af-402c-8a69-9576b75ea37c">

<img width="1097" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/0c53c8c7-4239-42ba-bf52-632a4c9b7d15">

Database Visualization - *[http:ocalhost:80](http:ocalhost:80)*

Grafa Dashboard - *[http:ocalhost:3000/](http:ocalhost:3000/)

<img width="1454" alt="Screenshot 2023-08-02 at 10 20 32" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/f934f778-f403-40ed-84c3-3c13ca1595a6">

## Running website (without docker-compose)
**Note**: Ensure the value of ```$host```in ```index.php``` file, tallies with the value of <mysql-container-name> 

- Pull a mysql and phpMyAdmin images
```docker
$ docker pull mysql
$ docker pull phpmyadmin
$ docker pull prom/mysqld-exporter
$ docker pull prom/prometheus
$ docker pull grafana/grafana
```

- Edit the PHP app to be
```php
<?php
without docker-compose   
$host = "<name-of-my-sql-container"; 
$db_name = "<db-name>"; 
$username = "<username";
$password = getenv('MYSQL_PASSWORD');
........
```

- Start the containers
MySQL
```docker
$ docker run -d --network <network-name> --name <mysql-container-name> -v db_data:/var/lib/mysql -v ./main.sql:/docker-entrypoint-initdb.d/main.sql  -e MYSQL_USER=<user-name> -e MYSQL_PASSWORD=<user-password> -e MYSQL_ROOT_PASSWORD=<root-password> -e MYSQL_DATABASE=<database-name> -p 3306:3306 mysql:latest
```

- PHP
```docker
$ docker build -t <docker-hub-repo-name>/<image-name> .
$ docker run -d --network <network-name> --name <php-container-name> -v .:/var/www/html -e MYSQL_USER=<user-name> -e MYSQL_PASSWORD=<user-password>-p 8080:80 <docker-hub-repo-name>/<image-name>

```

- PhpMyAdmin
```docker
$ docker run -d --network <network-name> --name <php-my-admin-container-name>  -p 80:80 -e PMA_HOST=<mysql-container-name> phpmyadmin:latest
```

- mysqld_exporter
```docker
$ docker run -d --network <network-name> --name <mysqld-exporter-container-name> -v ./.my.cnf:/.my.cnf -e DATA_SOURCE_NAME="${MYSQL_USER}:${MYSQL_PASSWORD}@tcp(db:3306)/${MYSQL_DATABASE}" -p 9104:9104 prom/mysqld-exporter
```

- Prometheus
```docker
$ docker run -d --network <network-name> --name <prometheus-container-name> -v ./prometheus.yml:/etc/prometheus/prometheus.yml -p 9090:9090 prom/prometheus
```

- Grafana
```docker
$ docker run -d --network <network-name> --name <grafana-container-name> -p 3000:3000 grafana/grafana
```

## The app (in pictures - without docker compose)
<img width="588" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/a7ac4344-a196-4005-93d6-eb56c52f3335">

App - *[http:ocalhost:8080/index.html](http:ocalhost:8080/index.html)*

<img width="1521" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/a06a570a-1c36-47b6-ba66-1c2033c289b9">

*redirection*

<img width="1521" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/c20db017-e859-48fc-8b47-5da739e7cc7f">

Database Visualization - *[http:ocalhost:80](http:ocalhost:80)*

## Push Php Image to DockerHub
```bash
$ docker push <docker-hub-repo-name>/<image-name> 
```

<img width="1521" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/3204eb4c-054e-489d-a999-b80e3cecd37e">

[Article](https:marrrz-lounge.hashnode.dev/efficient-containerization)