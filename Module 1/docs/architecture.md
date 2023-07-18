## Architectural diagram

<img width="761" alt="image" src="https://github.com/Mbaoma/loadbalancing-local-vms/assets/49791498/5bfda06a-dd5b-4598-ad26-0985bcfc9102">

This architecture diagram represents a load balancing setup using Nginx. The various components interact as follows:

- **Client**: This represents the users or systems sending requests to your application. In this case, the client is initiating a secure connection using SSL/TLS protocols. SSL (Secure Sockets Layer) and TLS (Transport Layer Security) are cryptographic protocols designed to provide secure communication over a network. 

- **Nginx (Load Balancer)**: This component acts as a reverse proxy that accepts incoming client requests and distributes them across multiple servers to balance the load and ensure high availability and reliability. The Nginx load balancer is also communicating with the clients and the servers via SSL/TLS, ensuring the secure transfer of data in both directions.

- **Servers**: These are the application servers that process the client's requests and send back responses. They maintain secure SSL/TLS communication with the Nginx load balancer, receiving requests from and sending responses to the load balancer.

In this architecture, the client establishes an HTTP connection with the Nginx load balancer. The Nginx load balancer, applies its load balancing algorithm (like round-robin, least connections, or IP hash) to determine the best server to handle this request.

Then, the Nginx load balancer establishes a separate HTTP connection with the chosen server, and forwards the client's request. The server processes the request and sends the response back to the Nginx load balancer over their secure connection. The Nginx load balancer then sends the server's response back to the client over the original secure connection.

This setup provides a secure and efficient system that balances load across multiple servers, increasing your application's availability and reliability.