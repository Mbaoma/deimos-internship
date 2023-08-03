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

## Architectural Diagram
<img width="469" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/a0c7af67-4f97-4890-975d-6cc254840236">

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

<img width="376" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/86e15300-65f6-4d55-ad60-456a548c7158">

App - *[http:localhost:8080/index.html](http:localhost:8080/index.html)*

<img width="650" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/09ba0539-ec38-4b2f-9822-758e86fb5816">

*redirection*

<img width="650" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/fc3a7aa3-0316-4bc1-a484-c4e4006b93ce">

Database Visualization - *[http:localhost:80](http:localhost:80)*

Grafa Dashboard - *[http:localhost:3000/](http:localhost:3000/)

<img width="560" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/65a4b114-83a6-4a23-a341-c5d590e4fcde">

Prometheus Targets - *[http:localhost:9090/](http:localhost:9090/)

<img width="837" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/114ddb06-e5dc-4795-9775-63902d15f70d">

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
App - *[http:localhost:8080/index.html](http:localhost:8080/index.html)*

<img width="650" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/09ba0539-ec38-4b2f-9822-758e86fb5816">

*redirection*

<img width="650" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/fc3a7aa3-0316-4bc1-a484-c4e4006b93ce">

Database Visualization - *[http:localhost:80](http:localhost:80)*

Grafa Dashboard - *[http:localhost:3000/](http:localhost:3000/)

<img width="560" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/65a4b114-83a6-4a23-a341-c5d590e4fcde">

Prometheus Targets - *[http:localhost:9090/](http:localhost:9090/)

<img width="837" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/114ddb06-e5dc-4795-9775-63902d15f70d">

## Push Php Image to DockerHub
```bash
$ docker push <docker-hub-repo-name>/<image-name> 
```

<img width="1521" alt="image" src="https:ithub.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/3204eb4c-054e-489d-a999-b80e3cecd37e">

[Article](https:marrrz-lounge.hashnode.dev/efficient-containerization)