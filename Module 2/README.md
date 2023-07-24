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
- First, run the migration
```bash

```

- Next, start the container,
```bash
$ docker-compose up --build
```

## Running the docker container (without docker-compose)
- Pull the MySQL image
- Create the docker image (php)
- Log into the MySQL container and run the migration
  

## The app (in pictures)

<img width="751" alt="Screenshot 2023-07-23 at 17 00 36" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/41a0c0f6-4c62-4552-8e37-4265956f5163">

App - *http://localhost:8080/index.html*

<img width="920" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/93b7c82d-1557-4a44-8ef3-ec06bb9ae2ca">

*redirection*

<img width="1150" alt="Screenshot 2023-07-23 at 17 07 08" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/7d8c7aa7-00af-402c-8a69-9576b75ea37c">
Database Visualization - *http://localhost:80*

[Article]()