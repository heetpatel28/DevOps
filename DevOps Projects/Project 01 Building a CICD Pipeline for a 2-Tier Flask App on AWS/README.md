# My DevOps Project: Building a CI/CD Pipeline for a 2-Tier Flask App on AWS

**Author:** Prashant Gohel
**Date:** August 23, 2025

---

### **Table of Contents**
1. [My Project's Goal](#1-my-projects-goal)
2. [The Architecture I Designed](#2-the-architecture-i-designed)
3. [Step 1: Preparing My AWS EC2 Server](#3-step-1-preparing-my-aws-ec2-server)
4. [Step 2: Installing the Core Tools](#4-step-2-installing-the-core-tools)
5. [Step 3: Setting Up Jenkins as My Automation Hub](#5-step-3-setting-up-jenkins-as-my-automation-hub)
6. [Step 4: Configuring My GitHub Repository Files](#6-step-4-configuring-my-github-repository-files)
    * [The Dockerfile: A Blueprint for My App](#the-dockerfile-a-blueprint-for-my-app)
    * [The `docker-compose.yml`: Orchestrating My Services](#the-docker-composeyml-orchestrating-my-services)
    * [The Jenkinsfile: My Pipeline as Code](#the-jenkinsfile-my-pipeline-as-code)
7. [Step 5: Bringing It All Together with a Jenkins Pipeline](#7-step-5-bringing-it-all-together-with-a-jenkins-pipeline)
8. [Final Thoughts and Conclusion](#8-final-thoughts-and-conclusion)

---

### **1. My Project's Goal**
<a name="1-my-projects-goal"></a>
For this project, I set out to build a complete, end-to-end CI/CD (Continuous Integration/Continuous Deployment) pipeline. My goal was to take a standard 2-tier web application, which consists of a Flask frontend and a MySQL database backend, and completely automate its deployment process.

The idea was to create a system where, as a developer, all I have to do is push new code to my GitHub repository. From there, an automated process would take over, building and deploying my updated application without any further manual intervention. To achieve this, I decided to use a stack of powerful DevOps tools: AWS for the infrastructure, Docker for containerization, and Jenkins for the automation server.

---

### **2. The Architecture I Designed**
<a name="2-the-architecture-i-designed"></a>
Here is the workflow I designed for my project. It follows a logical flow from code commit to live deployment.


1.  **Code Commit:** The entire process kicks off when I, as the developer, push new code to our GitHub repository.
2.  **Jenkins Trigger:** Jenkins is configured to constantly monitor the GitHub repository. The new push automatically triggers my Jenkins pipeline.
3.  **Pipeline Execution:** Jenkins, running on my AWS EC2 server, begins the pipeline defined in my `Jenkinsfile`.
    * It first clones the latest code from GitHub.
    * Next, it uses the `Dockerfile` to build a fresh, new Docker image of my Flask application.
    * Finally, it uses `docker-compose` to stop the old containers and start new ones with the updated image, seamlessly deploying the new version of the application.
4.  **Live Application:** The Flask application and MySQL database are now running as isolated containers on the same EC2 instance, with the changes live and accessible to users.

---

### **3. Step 1: Preparing My AWS EC2 Server**
<a name="3-step-1-preparing-my-aws-ec2-server"></a>
The foundation of my project is a virtual server in the cloud. I chose AWS EC2 because it's a reliable and widely-used industry standard.

1.  **Why Ubuntu 22.04 on a t2.micro?** I chose the **Ubuntu 22.04 LTS** image because it's a stable, long-term support release with a vast amount of community support and documentation. The **t2.micro** instance type is perfect for a small project like this as it's eligible for the AWS Free Tier, keeping my costs down while I learn and build.

2.  **Why These Security Group Rules?** The security group acts as a virtual firewall for my server. I configured it to only allow the specific traffic I needed:
    * **Port 22 (SSH):** This is essential for me to securely connect to my server's command line to install software and manage it. I restricted this to "My IP" for security.
    * **Port 8080 (Jenkins):** This is the default port for the Jenkins web dashboard, which I needed to access to configure my pipeline.
    * **Port 5000 (Flask):** This is the port my Flask application will be running on, making the website accessible to the public.
    * **Port 80 (HTTP):** While my app runs on port 5000, I also opened port 80, the standard web port. In a production setup, I would configure a web server like Nginx to route traffic from port 80 to my application on port 5000.

---

### **4. Step 2: Installing the Core Tools**
<a name="4-step-2-installing-the-core-tools"></a>
Once connected to my EC2 instance via SSH, I installed the essential software.

1.  **Git:** This was necessary for Jenkins to be able to clone my code from the GitHub repository.
2.  **Docker (`docker.io`):** This is the containerization engine. It allows me to package my application and its dependencies into isolated, lightweight containers.
3.  **Docker Compose (`docker-compose-v2`):** Since my application has two parts (Flask and MySQL), I needed a way to manage them together. Docker Compose lets me define and run multi-container applications with a single, simple YAML file.
4.  **Permissions (`usermod -aG docker`):** By default, you need to use `sudo` to run any Docker command. I added both my user (`ubuntu`) and the `jenkins` user to the `docker` group. This is a crucial step that allows us to run Docker commands without `sudo`, which is necessary for the Jenkins pipeline to work smoothly.

---

### **5. Step 3: Setting Up Jenkins as My Automation Hub**
<a name="5-step-3-setting-up-jenkins-as-my-automation-hub"></a>
Jenkins is the heart of my CI/CD pipeline. It's an open-source automation server that orchestrates the entire build and deployment process.

1.  **Why Java?** Jenkins is a Java-based application, so installing Java (OpenJDK 17) was a mandatory prerequisite.
2.  **Installation:** I followed the standard procedure for Ubuntu to add the official Jenkins repository and key, which ensures I'm installing a stable and legitimate version.
3.  **Initial Setup:** After starting the Jenkins service, I accessed its web UI at `http://<my-ec2-ip>:8080`. The initial password, found in `/var/lib/jenkins/secrets/initialAdminPassword`, provided the first layer of security. I then installed the suggested plugins, which include all the necessary tools for integrating with Git and Docker.

---

### **6. Step 4: Configuring My GitHub Repository Files**
<a name="6-step-4-configuring-my-github-repository-files"></a>
The "brains" of my automation pipeline are three text files that I placed in my GitHub repository.

#### **The Dockerfile: A Blueprint for My App**
<a name="the-dockerfile-a-blueprint-for-my-app"></a>
The `Dockerfile` is a set of instructions for building a Docker image of my Flask application. It's like a recipe that ensures my application environment is identical every single time it's built.
* **`FROM python:3.9-slim`**: I started with an official, lightweight Python image.
* **`WORKDIR /app`**: This sets the working directory inside the container.
* **`RUN apt-get update ...`**: I installed some system libraries needed by the Python MySQL client.
* **`COPY requirements.txt .` & `RUN pip install ...`**: I copied the Python requirements file first and installed the dependencies. This is a clever optimization that uses Docker's caching. If my app code changes but my requirements don't, Docker doesn't need to re-install all the packages, making my builds much faster.
* **`COPY . .`**: This copies the rest of my application code into the image.
* **`CMD ["python", "app.py"]`**: This is the command that runs when the container starts.

#### **The `docker-compose.yml`: Orchestrating My Services**
<a name="the-docker-composeyml-orchestrating-my-services"></a>
This file is where I defined my entire 2-tier application.
* **`services:`**: I defined two services: `mysql` and `flask`.
* **`mysql:`**: This service uses the official `mysql` image from Docker Hub. I set environment variables for the database name and password. The `volumes` section is crucial: `mysql-data:/var/lib/mysql` creates a persistent volume. This means that even if I stop and remove the MySQL container, my data will not be lost.
* **`flask:`**: This service doesn't pull an image; it **builds** one using the `Dockerfile` in the current directory (`build: .`). I passed the database credentials to it as environment variables.
* **`depends_on:`**: This tells Docker to start the `mysql` container before it starts the `flask` container, which is essential since my app needs the database to be ready before it can connect.
* **`networks:`**: I created a custom network named `two-tier`. This allows the Flask and MySQL containers to find each other easily by their service names (`mysql`) instead of having to figure out their internal IP addresses.
* **`healthcheck:`**: This is a vital feature for reliability. Docker will periodically run these commands to ensure the containers are not just running, but are actually healthy and responsive.

#### **The Jenkinsfile: My Pipeline as Code**
<a name="the-jenkinsfile-my-pipeline-as-code"></a>
This file defines my CI/CD pipeline using Jenkins' "pipeline-as-code" syntax. Keeping the pipeline definition in my source code repository means my automation logic is version-controlled, just like my application code.
```groovy
pipeline {
    agent any
    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: '[https://github.com/your-username/your-repo.git](https://github.com/your-username/your-repo.git)'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t flask-app:latest .'
            }
        }
        stage('Deploy with Docker Compose') {
            steps {
                sh 'docker compose down || true'
                sh 'docker compose up -d --build'
            }
        }
    }
}
```
* **`agent any`**: This tells Jenkins it can run this pipeline on any available agent (in my case, the Jenkins server itself).
* **`stages`**: I broke my pipeline into three logical stages:
    1.  **Clone Code:** Jenkins uses its Git plugin to clone my repository.
    2.  **Build Docker Image:** This step isn't strictly necessary since `docker compose` can also build, but I included it as an explicit step to make the process clearer.
    3.  **Deploy:** This is the magic step. `docker compose down || true` stops and removes any old running containers (the `|| true` prevents the pipeline from failing if there are no containers to stop). Then, `docker compose up -d --build` starts the application in the background, rebuilding the `flask` image to include the new code changes.

---

### **7. Step 5: Bringing It All Together with a Jenkins Pipeline**
<a name="7-step-5-bringing-it-all-together-with-a-jenkins-pipeline"></a>
With all the pieces in place, the final step was to create the pipeline job in Jenkins.
1.  I created a new "Pipeline" job in the Jenkins dashboard.
2.  Instead of writing the script in the text box, I configured it to pull the **"Pipeline script from SCM"**.
3.  I pointed it to my GitHub repository and told it the script file was named `Jenkinsfile`.

I then clicked **"Build Now"** to run the pipeline for the first time. I watched the logs in the "Console Output" as Jenkins cloned my code, built the image, and deployed the containers. After it finished, I was able to access my live application at `http://<my-ec2-ip>:5000`.

---

### **8. Final Thoughts and Conclusion**
<a name="8-final-thoughts-and-conclusion"></a>
This project was a fantastic journey through the core components of a modern DevOps workflow. I successfully built a fully automated CI/CD pipeline where a simple `git push` results in a live deployment. By containerizing the application with Docker, I've made it portable and consistent. By automating the process with Jenkins, I've made it fast, reliable, and repeatable. Any future changes to my application will now be deployed seamlessly, showcasing the true power of CI/CD.
  