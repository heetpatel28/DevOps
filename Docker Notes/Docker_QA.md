# Docker Interview Questions & Answers

This document covers common interview questions related to Docker fundamentals and its integration with CI/CD tools like Jenkins.

## Table of Contents

### Part 1: Docker Fundamentals & Core Concepts
1. [Why use Docker containers over traditional Virtual Machines (VMs)?](#1-why-use-docker-containers-over-traditional-virtual-machines-vms)
2. [What is the Docker daemon (dockerd) and what is its role?](#2-what-is-the-docker-daemon-dockerd-and-what-is-its-role)
3. [How does Docker solve the "it works on my machine" problem?](#3-how-does-docker-solve-the-it-works-on-my-machine-problem)
4. [What is the difference between a Docker image and a Docker container?](#4-what-is-the-difference-between-a-docker-image-and-a-docker-container)
5. [What technology allows Linux containers to run on Windows?](#5-what-technology-allows-linux-containers-to-run-on-windows)
6. [What is the difference between a Type 1 and Type 2 hypervisor?](#6-what-is-the-difference-between-a-type-1-and-type-2-hypervisor)
7. [How does containerization (OS-level virtualization) differ from hardware virtualization?](#7-how-does-containerization-os-level-virtualization-differ-from-hardware-virtualization)

### Part 2: Docker & Jenkins Integration
8. [Why don't Jenkins builds trigger automatically from GitHub when Jenkins is on localhost?](#8-why-dont-jenkins-builds-trigger-automatically-from-github-when-jenkins-is-on-localhost)
9. [Why does `docker build` fail inside a Jenkins container with a "docker not found" error?](#9-why-does-docker-build-fail-inside-a-jenkins-container-with-a-docker-not-found-error)
10. [What is the core issue of running Jenkins on localhost versus a server like EC2?](#10-what-is-the-core-issue-of-running-jenkins-on-localhost-versus-a-server-like-ec2)
11. [What is the Docker socket (`/var/run/docker.sock`) and why is it mounted into a Jenkins container?](#11-what-is-the-docker-socket-varrundockersock-and-why-is-it-mounted-into-a-jenkins-container)
12. [What is Poll SCM in Jenkins and when should it be used?](#12-what-is-poll-scm-in-jenkins-and-when-should-it-be-used)

---

## Part 1: Docker Fundamentals & Core Concepts

<a name='q1'></a>

### 1. Why use Docker containers over traditional Virtual Machines (VMs)?
**Answer:**
While both provide isolation, Docker containers are significantly more lightweight. They share the host operating system's kernel, whereas each VM requires a full guest OS.

For a microservices project, this means:
* **Faster Startup Times:** Containers start in seconds, while VMs take minutes.
* **Better Resource Utilization:** We can run many more containers on a single host, saving CPU and memory.
* **Efficiency and Portability:** The deployment process is more efficient, portable, and consistent across development, staging, and production environments.

<a name='q2'></a>
### 2. What is the Docker daemon (dockerd) and what is its role?
**Answer:**
The Docker daemon (`dockerd`) is the persistent background service that manages Docker objects. It is the "brain" of Docker, listening for API requests from the Docker CLI (e.g., `docker run`). It handles all the heavy lifting: building and managing images, running and stopping containers, and configuring networks and volumes.

<a name='q3'></a>
### 3. How does Docker solve the "it works on my machine" problem?
**Answer:**
Docker solves this by packaging an application with all its dependencies—code, runtime, system tools, and libraries—into a single, isolated unit called a container. This containerized application runs the exact same way regardless of the underlying environment (e.g., a developer's laptop, a staging server, or a production server), ensuring consistency and eliminating environment-specific issues.

<a name='q4'></a>
### 4. What is the difference between a Docker image and a Docker container?
**Answer:**
* A **Docker Image** is a read-only template with instructions for creating a container. It's like a blueprint or a class in object-oriented programming.
* A **Docker Container** is a runnable instance of an image. You can have multiple running containers of the same image, just as you can create multiple objects from a single class.

<a name='q5'></a>
### 5. What technology allows Linux containers to run on Windows?
**Answer:**
This is made possible by the **Windows Subsystem for Linux (WSL)**. WSL is a compatibility layer developed by Microsoft that allows a Linux environment, including its command-line tools and applications, to run directly on Windows without the overhead of a traditional virtual machine.

<a name='q6'></a>
### 6. What is the difference between a Type 1 and Type 2 hypervisor?
**Answer:**
* A **Type 1 Hypervisor** (or "bare-metal" hypervisor) runs directly on the host's physical hardware.
* A **Type 2 Hypervisor** (or "hosted" hypervisor) runs as a software application on top of an existing host operating system.

<a name='q7'></a>
### 7. How does containerization (OS-level virtualization) differ from hardware virtualization?
**Answer:**
Containerization (OS-level virtualization) uses a single host OS kernel to create multiple isolated user-space instances called containers. In contrast, traditional hardware virtualization uses a hypervisor to create complete virtual machines, each with its own full guest operating system. This architectural difference makes containers much more lightweight and efficient.

---

## Part 2: Docker & Jenkins Integration

<a name='q8'></a>
### 8. Why don't Jenkins builds trigger automatically from GitHub when Jenkins is on localhost?
**Answer:**
The issue is that webhooks from services like GitHub or GitLab cannot reach a Jenkins instance running on `localhost:8080`. Your local machine isn't publicly accessible on the internet, so the automatic trigger fails.

To work around this on localhost, you can:
1.  Use **Poll SCM** in Jenkins to periodically check for changes.
2.  Use a tunneling tool like **ngrok** to expose your local Jenkins instance to the internet.
3.  Host Jenkins on a public server (like an AWS EC2 instance) where webhooks can reach it directly.

<a name='q9'></a>
### 9. Why does `docker build` fail inside a Jenkins container with a "docker not found" error?
**Answer:**
This happens because the Jenkins container, by default, does not have access to the host machine's Docker engine. When Jenkins tries to execute `docker build`, it can't find the Docker daemon to communicate with.

To solve this, you can mount the Docker socket from the host into the Jenkins container using the `-v` flag:
```docker
docker run -d \
  -p 8080:8080 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v jenkins_home:/var/jenkins_home \
  jenkins/jenkins:lts
```
This allows the Jenkins container to communicate with the host's Docker engine and execute Docker commands.

<a name='q10'></a>
### 10. What is the core issue of running Jenkins on localhost versus a server like EC2?
**Answer:**
The main issue is **accessibility**. When Jenkins is on localhost, external services like GitHub cannot reach it via webhooks for automatic triggers. Furthermore, a Jenkins container needs explicit permission (by mounting the Docker socket) to access the host's Docker engine. On a server like EC2 with a public IP address, webhooks work correctly, and Docker integration is more straightforward.

<a name='q11'></a>
### 11. What is the Docker socket (`/var/run/docker.sock`) and why is it mounted into a Jenkins container?
**Answer:**
The Docker socket (`/var/run/docker.sock`) is a Unix socket file that acts as a communication bridge between the Docker CLI and the Docker Engine (daemon). When you run a command like `docker build`, the CLI uses this socket to send instructions to the daemon.

When Jenkins runs inside a container, it's isolated from the host's Docker Engine. By mounting the socket (`-v /var/run/docker.sock:/var/run/docker.sock`), you give the Jenkins container a "remote control" to the host's Docker Engine. This allows Jenkins to execute `docker` commands on the host system.

> **Important Note:** Even with the socket mounted, automatic triggers from GitHub will not work if Jenkins is on localhost because it is not publicly accessible. You would need to use Poll SCM or trigger builds manually.

<a name='q12'></a>
### 12. What is Poll SCM in Jenkins and when should it be used?
**Answer:**
**Poll SCM** is a Jenkins feature that periodically checks (or "polls") a source code repository (like Git) for new changes, instead of relying on a push notification from a webhook.

This is a practical workaround when Jenkins is running on an environment like localhost that cannot be reached by external webhooks. For example, you can set a schedule like `H/5 * * * *`, which tells Jenkins to check your repository for new commits every five minutes. While not as efficient as webhooks (which are instant), Poll SCM enables "automatic-ish" builds in environments that are not publicly accessible.
