# 42inception

## Cuz one container is not enough...

![](media/inception.gif)

This project is a hands-on introduction to system administration, containerization, and virtualization. The goal of this project is to create a fully functional multi-container infrastructure using **Docker Compose** running in a **Virtual Machine** to simulate a real-world development environment.

The **Docker**-based environment hosts these services:
  - ```Nginx```: A web server to handle **HTTP/HTTPS** requests
  - ```MariaDB```: A database to store and manage application data
  - ```WordPress```: A content management system, demonstrating a real-world application setup

Mentioning some key features:
  - **Containerization**: Each service is encapsulated within its own **Docker** container, ensuring portability and consistency across environments
  - **Orchestration**: Use of **Docker Compose** to define and manage multi-container setups
  - **Networking**: Secure communication between services via properly configured networks and ports
  - **Virtualization**: Deployment on a **Virtual Machine** to replicate real-world infrastructure
  - **Persistence**: Ensuring data persistence across container restarts for services like ```MariaDB``` and ```WordPress```

I used ***[VirtualBox](https://en.wikipedia.org/wiki/VirtualBox)*** for the choice of **Virtual Machine** for this project, though I am not running in inside a **VM** in the **GIF**.

This was my third to last project studying in **Hive Helsinki**. On this project, I gained valuable experience in managing **Docker** containers, creating modular, reusable, and scalable **Docker Compose** configurations and understanding container networking and security best practices.
I actually finished this project in mid **2024**, but I wanted to redo the commit history and make some minor changes.

## 📖 Topics
  - Containerization
  - Service orchestration
  - Networking
  - Virtualization
  - Web server configuration
  - Database management
  - Content management systems
  - Data persistence
  - Security
  - Automation
  - System administration

## 🛠️ Langs/Tools
  - Shell
  - YAML
  - Docker Compose
  - Dockerfile
  - Makefile

## 🦉 Getting started

First make sure you have **Docker Compose** installed on your system. You can just install **Docker Desktop**, it should include **Docker Compose**.
Read more about it ***[here](https://docs.docker.com/compose/install/)***.

  1. ```git clone https://github.com/kenlies/42inception```
  2. ```cd 42inception```
  3. ```make```
  4. Use your favourite browser to navigate to ```https://inception.42.fr```

## 🔨 To improve

The code documentation/comments can be improved. Also more useful services like **Redis** could've been added.

