## Hosting the website using Express JS

In the ```loadbalancing.sh``` script, after moving the website files to the ```/var/www/html``` directory, the script navigates to the website's directory (/var/www/html/website1).

It installs the required Node.js packages using the ```npm install``` command. This ensures that the necessary dependencies are available to run the website.

The script starts the website by running the ```node main.js``` command using ```nohup```. This launches the JavaScript file ```main.js``` as a background process, keeping it running even after the script execution completes.

Inside ```main.js```, the website's logic is implemented using JavaScript. The provided code dynamically generates the content for an anime list based on an array of anime objects. It uses the DOM manipulation methods to create HTML elements for each anime and appends them to the animeListContainer element.

The generated HTML content is then served to clients when they access the website's URL. The Nginx server acts as a reverse proxy, forwarding the incoming requests to the Node.js server running on port ```8000```.

- The websites are accessible via ```http://localhost:8080/``` and ```http://localhost:8000/```

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/4ec015f6-7a68-4444-b23c-cc0ab92cb5e6">

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/f4c7eae4-4f59-461d-8d37-ad42bb57e57f">


## Loadbalancer

The least_conn directive is used to specify the load balancing algorithm for distributing requests among the backend servers. With ```least_conn```, Nginx will distribute the incoming requests to the backend server with the least number of active connections. This helps to evenly distribute the load across the servers and improve performance.

<img width="1568" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/6d1f732f-0742-4e6a-b384-90e474ca7f4b">



*[http://localhost:80/](http://localhost:80)*