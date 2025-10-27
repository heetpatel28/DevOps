# Section 7: Full Circle - Integrating Jenkins with Docker for Container-Based Delivery

This final module is where all the concepts I've learned—CI, Pipeline as Code, and now Containerization—converge into a single, powerful, end-to-end workflow. I've moved beyond just testing code to producing a tangible, deployable artifact: a Docker image. This process was split into two major phases: first using Docker to run my build jobs, and second, getting Jenkins to build and publish my application's Docker image.

## Table of Contents
- [1. Phase 1: Docker as a Clean Build Agent](#1-phase-1-docker-as-a-clean-build-agent)
- [2. Optimizing the Build: Creating a Multi-Stage Dockerfile](#2-optimizing-the-build-creating-a-multi-stage-dockerfile)
- [3. Phase 2: Building & Publishing Docker Images from Jenkins](#3-phase-2-building--publishing-docker-images-from-jenkins)
- [4. The Final Automated Workflow](#4-the-final-automated-workflow)
- [5. The Challenge: Conditional Stage Execution](#5-the-challenge-conditional-stage-execution)

---

### 1. Phase 1: Docker as a Clean Build Agent

Until now, my pipeline stages were running directly on the Jenkins server (`agent any`). This works, but it can lead to problems with conflicting dependencies and inconsistencies. The solution is to run each stage inside a clean, temporary Docker container.

-   **Why use Docker agents?**
    -   **Isolation:** Each stage runs in its own isolated environment, preventing tool version conflicts (e.g., different Java or Maven versions).
    -   **Consistency:** The build environment is defined by a Docker image, ensuring it's the same every single time, whether on Jenkins or a developer's local machine.
    -   **Cleanliness:** The container is created at the start of the stage and destroyed at the end, meaning I always start with a fresh, clean slate.

-   **How I implemented it in the `Jenkinsfile`:**
    I used the Blue Ocean visual editor to make these changes easily:
    1.  **Set Global Agent to `none`:** I changed the top-level `agent` in my pipeline from `any` to `none`. This tells Jenkins that the execution environment will be defined on a per-stage basis.
    2.  **Define Per-Stage Docker Agents:** For each of my existing stages (`Build`, `Test`, `Package`), I went into its settings and defined a Docker agent:
        ```groovy
        stage('Build') {
            agent {
                docker { image 'maven:3.9.6-eclipse-temurin-17-alpine' }
            }
            steps {
                // ... build steps
            }
        }
        ```
    This configuration instructs Jenkins to pull the specified Maven image, start a container, and run the `steps` for that stage inside it.

---

### 2. Optimizing the Build: Creating a Multi-Stage Dockerfile

Before I could have Jenkins build an image, I needed a `Dockerfile`. To create an image that is small and secure, I used a **multi-stage build**.

-   **What is a multi-stage build?** It's a `Dockerfile` with multiple `FROM` instructions. Each `FROM` starts a new, temporary build stage. This allows me to use a large image with all my build tools (like Maven and the full JDK) in the first stage, and then copy *only the final compiled artifact* into a much smaller, production-focused base image in the final stage.

-   **My `Dockerfile`:**
    ```dockerfile
    # Stage 1: The Build Environment
    FROM maven:3.9.6-eclipse-temurin-17-alpine AS build
    WORKDIR /app
    COPY . .
    RUN mvn package -DskipTests

    # Stage 2: The Final, Lean Production Image
    FROM eclipse-temurin:17-jre-alpine
    WORKDIR /app
    COPY --from=build /app/target/sysfoo-*.jar ./sysfoo.jar
    EXPOSE 8080
    ENTRYPOINT ["java", "-jar", "sysfoo.jar"]
    ```
This process resulted in a final image that was less than half the size of a single-stage build and didn't contain any unnecessary source code or build tools. 
---

### 3. Phase 2: Building & Publishing Docker Images from Jenkins

This was the final step: adding a new stage to my pipeline that would take the `Dockerfile` and produce a container image.

-   **Adding the "Docker B&P" Stage:** I added a new parallel stage called `Docker B&P` (Build & Publish). This stage needed to run on the Jenkins server itself (`agent any`) because it needs access to the Docker daemon that was set up in the lab environment.

-   **Using a `script` Block:** For the complex logic of building, tagging, and pushing, I used a `script` block inside my declarative pipeline. This allows for more advanced, scripted-style logic where needed.

-   **Connecting to Docker Hub:**
    1.  **Credentials:** I went to the classic Jenkins UI (`Manage Jenkins > Credentials`) and added a new "Username with password" credential. For the username, I used my Docker Hub ID, and for the password, I used a **Docker Hub Access Token** for better security. I gave this credential the ID `dockerlogin`.
    2.  **The Code:** Inside the `script` block, I used the `docker.withRegistry()` helper, which automatically handles logging in and out of Docker Hub using the credential I just created.

-   **The Final Script:**
    ```groovy
    // This script runs inside the 'Docker B&P' stage
    script {
        docker.withRegistry('[https://index.docker.io/v1/](https://index.docker.io/v1/)', 'dockerlogin') {
            def commitHash = env.GIT_COMMIT.take(7)
            def dockerImage = docker.build("your-dockerhub-id/sysfoo:${commitHash}", "./")
            dockerImage.push()
            dockerImage.push("latest") // Also tag and push as 'latest'
        }
    }
    ```
    This script automatically builds the image, tags it with the first 7 characters of the Git commit hash for unique versioning, and pushes it (along with a `latest` tag) to my Docker Hub repository.

---

### 4. The Final Automated Workflow

My journey is complete. The final pipeline now works like this:
1.  A developer pushes a change to a feature branch.
2.  They open a Pull Request against the `main` branch.
3.  Jenkins automatically starts a pipeline for the PR. Each stage (`Build`, `Test`, `Package`) runs in its own clean Docker container.
4.  Jenkins reports the success or failure back to the GitHub PR.
5.  A teammate reviews and approves the code.
6.  Once all checks pass, the PR is merged into `main`.
7.  The merge to `main` triggers a final pipeline run. This time, it also executes the `Docker B&P` stage, which builds and publishes a new, versioned Docker image of the application to Docker Hub.

From a simple code change, I have automatically produced a tested, versioned, and distributable artifact, ready for the next stage: deployment.

### 5. The Challenge: Conditional Stage Execution

The final challenge was to refine the pipeline further. The `Package` and `Docker B&P` stages are only really necessary when merging to the `main` branch. For feature branches, I only need to run `Build` and `Test`. I updated my `Jenkinsfile` to include a `when` condition on these stages so they only execute for the `main` branch, making my feature branch builds faster and more efficient.
  