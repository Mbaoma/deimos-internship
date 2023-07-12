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
$ mkdocs serve
```