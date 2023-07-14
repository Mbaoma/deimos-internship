# Loadbalancing Local Virtual Machines

This project aims to create a robust, reliable, and secure environment for hosting web applications. 

## Objectives
The specific objectives are as follows:

- Install a Linux Virtual Machine (VM) as a sandbox for troubleshooting and application testing.
- Create a bash script for Nginx setup and backup to promote automation.
    - Add an Nginx user and group to reduce the potential impact of security vulnerabilities in the server software.
    - Write a cron job for daily backup to protect against data loss.
- Implement Load Balancing across multiple VMs to distribute incoming network traffic across multiple Linux VMs.

## Tools
- Virtual Box
- Vagrant
- [MkDocs](https://www.mkdocs.org/getting-started/) (documentation)
- [Flowchart Maker](https://app.diagrams.net/) (architectural diagram)
- GitHub (source control)
- Nginx (web server, loadbalancer)

## Setting up
To achieve the outlined goals, first setup the following on your local machine:
-   Virtual box & Vagrant (MacOs)
```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew install --cask virtualbox
$ brew install --cask vagrant
$ brew install --cask vagrant-manager
$ vagrant init ubuntu/xenial64
$ vagrant up
$ vagrant ssh
```

- [Demo Websites](https://github.com/Mbaoma/loadbalancing-local-vms)

- Install MkDocs on your local computer
```bash
$ pip3 install mkdocs
```

- Build the documentation
```bash
$ mkdocs build
```

- Serve the documentation as a website
```bash
$ mkdocs serve -a 127.0.0.1:8000
```

## Architectural diagram

<img width="781" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/72be5c0f-b4f3-42d0-9539-3bcc4ff827a3">

*This architecture diagram represents a load balancing setup using Nginx.*

This setup provides a secure and efficient system that balances load across multiple servers, increasing your application's availability and reliability.

## Running the application
- Enable port forwarding in VagrantBox, by editing the ```Vagrantfile``` located in the directory your box was created. 
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "your_box_name"
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 80, host: 80
end
```

Then run,
```bash
$ vagrant reload
```

- In another VM,
```bash
Vagrant.configure("2") do |config|
  config.vm.box = "your_box_name"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
end
```

Then run,
```bash
$ vagrant reload
```
The snippet specifies forwarding ports 80 and 8081 from the guest machine to ports 80 (loadbalancing), 8080 and 8000 (for the individual websites) on the host machines. This means that any traffic coming to ports 80, 8080 and 8000 on your host machine will be redirected to ports80, 8080 and 8000  respectively on the guest machine.

This enables access to the websites URL from a browser

- Clone the repo to the VM
```bash
$ git clone https://github.com/Mbaoma/loadbalancing-local-vms.git
```

- Run either script on different VMs
```bash
$ cd loadbalancing-local-vms/
$ chmod u+x loadbalancing1.sh
$ ./loadbalancing2.sh
```

```bash
$ cd loadbalancing-local-vms/
$ chmod u+x loadbalancing2.sh
$ ./loadbalancing2.sh
```

### The ```loadbalancer1.sh``` and ```loadbalancer2.sh``` scripts, do the following:
- Install dependencies required for building Nginx from source.
- Download the Nginx source code.
- Extract the downloaded source code and navigates into the extracted directory.
- Configure Nginx with various options.
- Build and install Nginx.
- Set up the Nginx systemd service file.
- Create an Nginx group and user.
- Enable and starts the Nginx service.
- Create necessary directories for website files.
- Move the ```website1``` and ```website2``` folders into the respective ```/var/www/html``` directory.
- Create or edits the default Nginx configuration file in the ```/etc/nginx/sites-available``` directory.
- Create a symbolic link to enable the default configuration.
- Creates a cron job that backs up the files to the home directory at midnight daily.
- Set up load balancing configuration by appending it to the ```/etc/nginx/nginx.conf``` file.
- Verify the Nginx configuration.
- Reload the ```systemd daemon``` and restarts Nginx for the changes to take effect.

In summary, the scripts automate the installation and configuration of Nginx from source, create necessary directories and users, sets up a basic Nginx configuration for a website, and adds load balancing configuration to the Nginx configuration file.

- The websites are accessible via ```http://localhost:8080/``` and ```http://localhost:8000/```

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/4ec015f6-7a68-4444-b23c-cc0ab92cb5e6">

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/f4c7eae4-4f59-461d-8d37-ad42bb57e57f">


## Notes
- To delete a Vaggrant box
```bash
$ vagrant box remove NAME
```
Then delete the Vagrantfile in the directory.

- Logout as user
```bash
$ exit
```

- View Nginx log file
```bash
$ sudo  cat /var/log/nginx/error.log
```

## Loadbalancer
<img width="1572" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/8e75f6b4-8ebd-4fd3-923b-36d338fe0f06">

<img width="1572" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/d392ab67-3198-46e0-bb7f-c5ae8c9f9772">

*[http://192.168.1.152/](http://192.168.1.152/)*

