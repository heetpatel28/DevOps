# Docker Commands Handbook

A comprehensive guide to essential Docker commands for containerization, complete with descriptions, real-world use cases, and practical examples.

## Table of Contents

- [Basic Docker Commands](#basic-docker-commands)
  - [docker --version](#1-docker---version)
  - [docker info](#2-docker-info)
  - [docker pull](#3-docker-pull)
  - [docker images](#4-docker-images)
  - [docker run](#5-docker-run)
  - [docker ps](#6-docker-ps)
  - [docker stop](#7-docker-stop)
  - [docker start](#8-docker-start)
  - [docker rm](#9-docker-rm)
  - [docker rmi](#10-docker-rmi)
  - [docker exec](#11-docker-exec)
- [Intermediate Docker Commands](#intermediate-docker-commands)
  - [docker build](#12-docker-build)
  - [docker commit](#13-docker-commit)
  - [docker logs](#14-docker-logs)
  - [docker inspect](#15-docker-inspect)
  - [docker stats](#16-docker-stats)
  - [docker cp](#17-docker-cp)
  - [docker rename](#18-docker-rename)
  - [docker network](#19-docker-network)
  - [docker volume](#20-docker-volume)
- [Docker Compose Commands](#docker-compose-commands)
  - [docker-compose up](#21-docker-compose-up)
  - [docker-compose down](#22-docker-compose-down)
  - [docker-compose logs](#23-docker-compose-logs)
  - [docker-compose exec](#24-docker-compose-exec)
- [Image & Container Management](#image--container-management)
    - [docker tag](#25-docker-tag)
    - [docker push](#26-docker-push)
    - [docker login / logout](#27-docker-login--logout)
    - [docker save & load](#28-docker-save--load)
    - [docker export & import](#29-docker-export--import)
- [System & Cleanup](#system--cleanup)
  - [docker system df](#30-docker-system-df)
  - [docker system prune](#31-docker-system-prune)
- [Docker Swarm Commands](#docker-swarm-commands)
  - [docker swarm init](#32-docker-swarm-init)
  - [docker service create](#33-docker-service-create)
  - [docker stack deploy](#34-docker-stack-deploy)
  - [docker stack rm](#35-docker-stack-rm)
- [Experimental & Advanced](#experimental--advanced)
    - [docker checkpoint](#36-docker-checkpoint)

---

## Basic Docker Commands

### 1. `docker --version`
- **Description**: Displays the installed version of Docker on your system.
- **Real-World Use Case**: To quickly verify that Docker is installed correctly and to check its version before running scripts that may depend on a specific version.

**Examples**:
```bash
# Display the Docker version information
docker --version
# Get a more detailed breakdown of the client and server versions
docker version
```

### 2. `docker info`
- **Description**: Provides detailed, system-wide information about your Docker installation, including the number of containers and images, storage driver, and kernel version.
- **Real-World Use Case**: For debugging issues or getting a high-level overview of the Docker daemon's state and configuration.

**Examples**:
```bash
# Display system-wide Docker information
docker info
# Format the output to show only the number of running containers
docker info --format '{{.ContainersRunning}}'
```

### 3. `docker pull`
- **Description**: Downloads a Docker image from a container registry (by default, Docker Hub).
- **Real-World Use Case**: Before you can run an application in a container, you first need to pull its image, such as the official images for `nginx`, `ubuntu`, or `postgres`.

**Examples**:
```bash
# Pull the latest version of the official Ubuntu image
docker pull ubuntu
# Pull a specific version of the Redis image
docker pull redis:6.2
```

### 4. `docker images`
- **Description**: Lists all the Docker images that are currently stored on your local machine.
- **Real-World Use Case**: To see what images you have available to create containers from, and to check how much disk space they are using.

**Examples**:
```bash
# List all local images
docker images
# List all images, including intermediate layers that are normally hidden
docker images -a
```

### 5. `docker run`
- **Description**: Creates and starts a new container from a specified image. This is the most feature-rich Docker command.
- **Real-World Use Case**: This is the primary command for starting applications. You use it to launch a web server, a database, or get an interactive shell inside a container.

**Examples**:
```bash
# Run an Nginx web server in the background and map port 8080 on the host to port 80 in the container
docker run -d -p 8080:80 --name my-web-server nginx
# Start an interactive shell in an Ubuntu container, which will be removed automatically on exit
docker run -it --rm ubuntu bash
```

### 6. `docker ps`
- **Description**: Lists containers. By default, it only shows *running* containers. `ps` stands for "process status".
- **Real-World Use Case**: To check which of your application containers are currently active and to see their container IDs and port mappings.

**Examples**:
```bash
# List all running containers
docker ps
# List all containers (running and stopped)
docker ps -a
```

### 7. `docker stop`
- **Description**: Gracefully stops one or more running containers by sending a SIGTERM signal.
- **Real-World Use Case**: To safely shut down a container, for example, before removing it or updating its image.

**Examples**:
```bash
# Stop a container by its name
docker stop my-web-server
# Stop multiple containers by their IDs
docker stop a1b2c3d4 e5f6g7h8
```

### 8. `docker start`
- **Description**: Starts one or more containers that have been stopped.
- **Real-World Use Case**: To restart a container that you previously stopped, without having to create a new one from an image.

**Examples**:
```bash
# Start a stopped container by its name
docker start my-web-server
# Start a container and attach your terminal to its output
docker start -a my-app-container
```

### 9. `docker rm`
- **Description**: Removes one or more stopped containers. You cannot remove a running container unless you force it.
- **Real-World Use Case**: To clean up old containers that you no longer need, freeing up disk space and keeping your container list tidy.

**Examples**:
```bash
# Remove a stopped container by its name
docker rm my-old-container
# Forcefully remove a running container
docker rm -f my-running-app
```

### 10. `docker rmi`
- **Description**: Removes one or more Docker images from your local machine. `rmi` stands for "remove image".
- **Real-World Use Case**: To free up disk space by deleting old or unused images.

**Examples**:
```bash
# Remove an image by its name and tag
docker rmi ubuntu:20.04
# Forcefully remove an image that is being used by a container
docker rmi -f my-custom-image
```

### 11. `docker exec`
- **Description**: Executes a command inside a *running* container.
- **Real-World Use Case**: To get an interactive shell inside a running container for debugging, or to run a maintenance command without stopping the container.

**Examples**:
```bash
# Get an interactive bash shell inside a running container named "my-app"
docker exec -it my-app bash
# List the files in the /app directory of a running container without entering it
docker exec my-app ls /app
```

---

## Intermediate Docker Commands

### 12. `docker build`
- **Description**: Builds a new Docker image from a `Dockerfile` and a "context" (the set of files at a specified path).
- **Real-World Use Case**: The fundamental command for creating your own custom images for your applications.

**Examples**:
```bash
# Build an image from the Dockerfile in the current directory and tag it as "my-app:1.0"
docker build -t my-app:1.0 .
# Build an image using a specific Dockerfile without using the build cache
docker build --no-cache -f Dockerfile.dev -t my-app:dev .
```

### 13. `docker commit`
- **Description**: Creates a new image from a container's current state. (Note: Using a `Dockerfile` is the recommended practice).
- **Real-World Use Case**: For quick debugging or creating a temporary image after manually installing a tool inside a container, but it's generally better to update the `Dockerfile`.

**Examples**:
```bash
# Commit the changes in "my-container" to a new image called "my-app-with-tools"
docker commit my-container my-app-with-tools:latest
# Commit with an author name and a commit message
docker commit -a "John Doe" -m "Installed curl for debugging" my-container my-debug-image
```

### 14. `docker logs`
- **Description**: Fetches the logs (standard output) from a container.
- **Real-World Use Case**: The primary way to see what your application inside a container is doing, check for errors, or view its output.

**Examples**:
```bash
# Display the logs of a container
docker logs my-web-server
# Follow the log output in real-time and show the last 100 lines
docker logs -f --tail 100 my-app-container
```

### 15. `docker inspect`
- **Description**: Returns low-level, detailed information on Docker objects (like containers, images, volumes, or networks) in JSON format.
- **Real-World Use Case**: To find a container's IP address, inspect its volume mounts, or get any other detailed configuration information.

**Examples**:
```bash
# Get all details about a container
docker inspect my-app-container
# Get only the IP address of a container from a custom network
docker inspect -f '{{.NetworkSettings.Networks.my-app-net.IPAddress}}' my-app-container
```

### 16. `docker stats`
- **Description**: Displays a live stream of resource usage statistics (CPU, memory, network I/O) for running containers.
- **Real-World Use Case**: To monitor the performance of your containers and see which ones are consuming the most resources.

**Examples**:
```bash
# Show a live stream of stats for all running containers
docker stats
# Show stats for specific containers by name without streaming
docker stats --no-stream my-app-1 my-db-1
```

### 17. `docker cp`
- **Description**: Copies files or folders between a container and the local filesystem.
- **Real-World Use Case**: To copy log files out of a container for analysis, or to copy a configuration file into a running container.

**Examples**:
```bash
# Copy a file from the host to a container
docker cp config.ini my-app-container:/app/config.ini
# Copy a log file from a container to the host
docker cp my-app-container:/app/logs/error.log ./
```

### 18. `docker rename`
- **Description**: Renames an existing container.
- **Real-World Use Case**: To give a container a more descriptive name after you've created it, perhaps one that was given a random name by Docker.

**Examples**:
```bash
# Rename the container "boring_name" to "web-frontend"
docker rename boring_name web-frontend
# Rename a container using its ID
docker rename a1b2c3d4 database-server
```

### 19. `docker network`
- **Description**: A parent command for managing Docker networks. You can use it to create, list, inspect, connect, and remove networks.
- **Real-World Use Case**: To create a custom network that allows multiple containers (like a web app and a database) to communicate with each other using their container names as hostnames.

**Examples**:
```bash
# Create a new bridge network and then connect a container to it
docker network create my-app-net
docker network connect my-app-net my-container
# List all networks and inspect a specific one
docker network ls
docker network inspect my-app-net
```

### 20. `docker volume`
- **Description**: A parent command for managing Docker volumes. Volumes are used to persist data generated by and used by Docker containers.
- **Real-World Use Case**: To create a volume to store database files, ensuring the data is not lost when the database container is removed or updated.

**Examples**:
```bash
# Create a new volume and then run a postgres container using it
docker volume create my-db-data
docker run -d -v my-db-data:/var/lib/postgresql/data postgres
# List all volumes and remove an unused one
docker volume ls
docker volume rm my-unused-volume
```

---

## Docker Compose Commands

### 21. `docker-compose up`
- **Description**: Builds, (re)creates, starts, and attaches to containers for a multi-container application defined in a `docker-compose.yml` file.
- **Real-World Use Case**: The standard command to launch a complete application stack (e.g., a website, its database, and a caching service) with a single command.

**Examples**:
```bash
# Start all services in the background
docker-compose up -d
# Rebuild the images before starting the services and force container recreation
docker-compose up --build --force-recreate
```

### 22. `docker-compose down`
- **Description**: Stops and removes the containers, networks, and volumes created by `docker-compose up`.
- **Real-World Use Case**: To completely clean up the environment for a multi-container application.

**Examples**:
```bash
# Stop and remove containers and networks
docker-compose down
# Stop and remove containers, networks, AND volumes
docker-compose down -v
```

### 23. `docker-compose logs`
- **Description**: Displays log output from the services defined in your `docker-compose.yml` file.
- **Real-World Use Case**: To view the combined output of all your application's services at once for debugging.

**Examples**:
```bash
# View and follow the logs for all services
docker-compose logs -f
# View the logs for a specific service (e.g., 'web')
docker-compose logs -f web
```

### 24. `docker-compose exec`
- **Description**: Runs a command inside a running service container managed by Docker Compose.
- **Real-World Use Case**: To open a shell in your `web` service container to run database migrations or other administrative tasks.

**Examples**:
```bash
# Get an interactive shell in the 'web' service container
docker-compose exec web bash
# Run a specific command in the 'db' service container as the postgres user
docker-compose exec -u postgres db psql -l
```

---

## Image & Container Management

### 25. `docker tag`
- **Description**: Creates a new tag that refers to an existing image. It's like creating an alias for an image.
- **Real-World Use Case**: Before pushing an image to a registry like Docker Hub, you need to tag it with your username and the repository name (e.g., `username/my-app:1.0`).

**Examples**:
```bash
# Tag a local image with a new version number
docker tag my-app:latest my-app:1.0.0
# Tag an image for pushing to Docker Hub
docker tag my-app:latest myusername/my-app:latest
```

### 26. `docker push`
- **Description**: Uploads a tagged image to a remote Docker registry (like Docker Hub).
- **Real-World Use Case**: After building and tagging your application's image, you push it to a registry to share it with your team or deploy it to a server.

**Examples**:
```bash
# Push an image to Docker Hub
docker push myusername/my-app:latest
# Push all tags of an image
docker push --all-tags myusername/my-app
```

### 27. `docker login / logout`
- **Description**: Logs you into or out of a Docker registry.
- **Real-World Use Case**: You must log in before you can push private images to a registry like Docker Hub or pull images from private repositories.

**Examples**:
```bash
# Log in to Docker Hub (will prompt for username and password)
docker login
# Log out from a specific private registry
docker logout my-private-registry.com
```

### 28. `docker save & load`
- **Description**: `docker save` exports one or more images to a tar archive. `docker load` imports an image from a tar archive.
- **Real-World Use Case**: To manually transfer a Docker image to a machine that does not have internet access to pull from a registry.

**Examples**:
```bash
# Save an image to a tar file
docker save -o my-app.tar my-app:1.0
# Load an image from a tar file
docker load -i my-app.tar
```

### 29. `docker export & import`
- **Description**: `docker export` exports a container's filesystem as a tar archive. `docker import` creates a new image from a tar archive.
- **Real-World Use Case**: To create a "flattened" image from a container's state, without its history or metadata. This is less common than `save` and `load`.

**Examples**:
```bash
# Export a container's filesystem
docker export my-container > my-container.tar
# Import the filesystem as a new image
cat my-container.tar | docker import - my-new-image:latest
```

---

## System & Cleanup

### 30. `docker system df`
- **Description**: Displays a summary of Docker's disk usage, showing how much space is used by images, containers, and volumes.
- **Real-World Use Case**: To quickly see what is taking up the most disk space in your Docker installation.

**Examples**:
```bash
# Show Docker disk usage
docker system df
# Show a more verbose output
docker system df -v
```

### 31. `docker system prune`
- **Description**: A powerful command to clean up unused Docker resources, such as stopped containers, dangling images, and unused networks.
- **Real-World Use Case**: To reclaim a significant amount of disk space by removing all the Docker objects that are no longer in use.

**Examples**:
```bash
# Remove all unused containers, networks, and dangling images
docker system prune
# DANGEROUS: Remove all unused containers, networks, images (not just dangling), and build cache
docker system prune -a --volumes
```

---

## Docker Swarm Commands

### 32. `docker swarm init`
- **Description**: Initializes a new Docker Swarm, turning the current Docker node into a swarm manager. Docker Swarm is a container orchestration tool.
- **Real-World Use Case**: The first step in setting up a cluster of Docker nodes to deploy and manage applications at scale.

**Examples**:
```bash
# Initialize a swarm and advertise the manager on a specific IP
docker swarm init --advertise-addr 192.168.1.100
# Initialize a swarm with default settings
docker swarm init
```

### 33. `docker service create`
- **Description**: Creates a new service in a Docker Swarm. A service is a scalable group of containers running a specific image.
- **Real-World Use Case**: To deploy a scalable web server in your swarm, specifying the number of replica containers you want to run.

**Examples**:
```bash
# Create a service with 3 replicas of an nginx image
docker service create --replicas 3 -p 80:80 --name my-web-service nginx
# Create a service with a specific version of redis
docker service create --name my-redis-cache redis:6.2-alpine
```

### 34. `docker stack deploy`
- **Description**: Deploys a new stack or updates an existing stack from a `docker-compose.yml` file to a Docker Swarm. A stack is a group of interrelated services.
- **Real-World Use Case**: The preferred way to deploy a complete multi-service application to a production Swarm cluster.

**Examples**:
```bash
# Deploy a stack named "my-app" using a compose file
docker stack deploy -c docker-compose.yml my-app
# Deploy a stack and explicitly include a separate network file
docker stack deploy --compose-file docker-compose.yml --compose-file docker-compose.networks.yml my-prod-app
```

### 35. `docker stack rm`
- **Description**: Removes a stack deployed in a Docker Swarm. This will remove all services, networks, and secrets associated with the stack.
- **Real-World Use Case**: To completely tear down an application environment that was deployed to the swarm.

**Examples**:
```bash
# Remove the stack named "my-app"
docker stack rm my-app
# Remove multiple stacks at once
docker stack rm my-app my-other-app
```

---

## Experimental & Advanced

### 36. `docker checkpoint`
- **Description**: A parent command to manage container checkpoints, which allow you to freeze a running container to disk and restore it later.
- **Real-World Use Case**: For migrating a running container from one host to another with minimal downtime, or for faster startup of complex applications.

**Examples**:
```bash
# Create a checkpoint for a running container
docker checkpoint create my-running-container my-checkpoint
# List checkpoints for a container and then remove one
docker checkpoint ls my-running-container
docker checkpoint rm my-running-container my-checkpoint
