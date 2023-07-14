## Hosting the website using Express JS

In the ```loadbalancing.sh``` script, after moving the website files to the ```/var/www/html``` directory, the script navigates to the website's directory (/var/www/html/website1).

It installs the required Node.js packages using the ```npm install``` command. This ensures that the necessary dependencies are available to run the website.

The script starts the website by running the ```node main.js``` command using ```nohup```. This launches the JavaScript file ```main.js``` as a background process, keeping it running even after the script execution completes.

Inside ```main.js```, the website's logic is implemented using JavaScript. The provided code dynamically generates the content for an anime list based on an array of anime objects. It uses the DOM manipulation methods to create HTML elements for each anime and appends them to the animeListContainer element.

The generated HTML content is then served to clients when they access the website's URL. The Nginx server acts as a reverse proxy, forwarding the incoming requests to the Node.js server running on port ```8000```.

- The websites are accessible via ```http://http://192.168.1.120:8080/``` and ```http://192.168.1.152:8000/```

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/4ec015f6-7a68-4444-b23c-cc0ab92cb5e6">

<img width="1572" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/dafb9a27-be5e-481e-bc56-1fcbc944136b">

## Loadbalancer

Round-robin is a load-balancing algorithm used to distribute incoming requests across multiple servers in a sequential manner. It ensures that each server in the pool receives an equal share of the incoming traffic.

<img width="1572" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/8e75f6b4-8ebd-4fd3-923b-36d338fe0f06">

<img width="1572" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/d392ab67-3198-46e0-bb7f-c5ae8c9f9772">

*[http://192.168.1.152/](http://192.168.1.152/)*