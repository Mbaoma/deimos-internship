# Efficient Containerization: A Comprehensive Guide to Building and Deploying Secure PHP-MySQL Web Applications with Docker

## Goal 
- Create a Web Server and save form data into MySQL database using PHP (Beginners Guide) - DEV Community
- Web server can be apache2 or nginx,
- Using the above guide dockerize the form application written in PHP and link to a mysql database 
- Application should be accessible on your localhost and form should be able to write to database using containers and relevant networking
- All work to be committed to git repository with corresponding documentation as to how to run application
  
**Bonus Challenges**
- Use docker-compose to create the application and database backend
- Data to persist on container restart

## Running the docker container (using docker-compose)
- Start the container,
```bash
$ docker-compose up --build
```

## Running the docker container (without docker-compose)
**Note**: Ensure the value of ```$host```in ```index.php``` file, tallies with the value of <mysql-container-name> 

- Pull a mysql and phpMyAdmin images
```bash
$ docker pull mysql
$ docker pull phpmyadmin
```

- Start the containers
MySQL
```bash
$ docker run --name <mysql-container-name> -v ./main.sql:/docker-entrypoint-initdb.d/main.sql  -e MYSQL_ROOT_PASSWORD=<value> -e MYSQL_DATABASE=<value> -d mysql:latest
```

- PHP
```bash 
$ docker build -t <docker-hub-repo-name>/<image-name> .
$ docker run -d --name <php-app-container-name> --link <mysql-container-name>:mysql -p 8080:80 -e MYSQL_ROOT_PASSWORD=<value> -v .:/var/www/html <docker-hub-repo-name>/<image-name> 

```
In this command, the ```--link``` option connects the PHP container to the MySQL container. The ```-p``` option maps port ```8080``` on your host to port ```80``` on the container. The 

- PhpMyAdmin
```bash
$ docker run --name <phpMyAdmin-container-name> --link c:db -p 80:80 -d phpmyadmin/phpmyadmin
```
The ```--link`` option here connects the *phpMyAdmin* container to the *MySQL* container.

## The app (in pictures - without docker compose)
<img width="588" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/a7ac4344-a196-4005-93d6-eb56c52f3335">
App - *[http://localhost:8080/index.html](http://localhost:8080/index.html)*

<img width="1521" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/a06a570a-1c36-47b6-ba66-1c2033c289b9">
*redirection*

<img width="1521" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/c20db017-e859-48fc-8b47-5da739e7cc7f">
Database Visualization - *[http://localhost:80](http://localhost:80)*

## The app (in pictures - docker compose)

<img width="1009" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/baa1ca77-eb32-40b5-9a27-ceba38993c6b">

App - *[http://localhost:8080/index.html](http://localhost:8080/index.html)*

<img width="920" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/93b7c82d-1557-4a44-8ef3-ec06bb9ae2ca">

*redirection*

<img width="1150" alt="Screenshot 2023-07-23 at 17 07 08" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/7d8c7aa7-00af-402c-8a69-9576b75ea37c">

<img width="1097" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/0c53c8c7-4239-42ba-bf52-632a4c9b7d15">

Database Visualization - *[http://localhost:80](http://localhost:80)*

## Push Php Image to DockerHub
```bash
$ docker push <docker-hub-repo-name>/<image-name> 
```
<img width="1521" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/3204eb4c-054e-489d-a999-b80e3cecd37e">

[Article](https://omarrrz-lounge.hashnode.dev/efficient-containerization)

