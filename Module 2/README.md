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

In order to dockerize a PHP form application and link it to a MySQL database, there are several steps you would need to take. This guide will also include the use of Docker Compose for easier orchestration of multi-container applications, data persistence, and Apache as the web server.

## Step 1: Create the PHP Application with a MySQL backend
[Guide](https://dev.to/satellitebots/create-a-web-server-and-save-form-data-into-mysql-database-using-php-beginners-guide-fah)

- Set up a Linux machine using either a VirtualBox or cloud provider. Using a VirtualBox (MacOs):
```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install --cask virtualbox
$ brew install --cask vagrant
$ brew install --cask vagrant-manager
$ vagrant init ubuntu/xenial64
$ vagrant up
$ vagrant ssh
```

- Enable port forwarding in VagrantBox, by editing the ```Vagrantfile``` located in the directory your box was created. 
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "your_box_name"
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "public_network"
end
```

- Then run,
```bash
$ vagrant reload
```

- When prompted,

<img width="565" alt="image" src="https://github.com/DeimosCloud/mary-sre-internship-2023/assets/49791498/6c590585-6cac-490d-99df-147453baf732">
