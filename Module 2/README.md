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
- Pull the MySQL image
- Create the docker image (php)
- Log into the MySQL container and run the migration
  

## The app (in pictures)

<img width="1009" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/baa1ca77-eb32-40b5-9a27-ceba38993c6b">

App - *[http://localhost:8080/index.html](http://localhost:8080/index.html)*

<img width="920" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/93b7c82d-1557-4a44-8ef3-ec06bb9ae2ca">

*redirection*

<img width="1150" alt="Screenshot 2023-07-23 at 17 07 08" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/7d8c7aa7-00af-402c-8a69-9576b75ea37c">

<img width="1097" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/0c53c8c7-4239-42ba-bf52-632a4c9b7d15">

Database Visualization - *[http://localhost:80](http://localhost:80)*

[Article](https://omarrrz-lounge.hashnode.dev/efficient-containerization)

