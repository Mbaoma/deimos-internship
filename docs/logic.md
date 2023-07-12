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
  config.vm.network "forwarded_port", guest: 80, host: 80
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
$ ./loadbalancer.sh
```

```bash
$ cd loadbalancing-local-vms/
$ chmod u+x loadbalancing2.sh
$ ./loadbalancer.sh
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
- Set up load balancing configuration by appending it to the ```/etc/nginx/nginx.conf``` file.
- Verify the Nginx configuration.
- Reload the ```systemd daemon``` and restarts Nginx for the changes to take effect.

In summary, the scripts automate the installation and configuration of Nginx from source, create necessary directories and users, sets up a basic Nginx configuration for a website, and adds load balancing configuration to the Nginx configuration file.

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

