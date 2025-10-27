# Section 3: Building My First Manual CI Pipeline

This is where the real work begins! After setting up my Jenkins lab, I'm now applying that knowledge to a real-world use case: creating a Continuous Integration workflow for a Java application. This section is my deep dive into creating jobs, configuring them, connecting them into a logical sequence, and automating the process from a code change all the way to a packaged artifact.

## Table of Contents
- [1. Getting Started: UI Tour and Pre-flight Checks](#1-getting-started-ui-tour-and-pre-flight-checks)
- [2. The Use Case: Forking the "Sysfoo" Java App](#2-the-use-case-forking-the-sysfoo-java-app)
- [3. Stage 1: The 'Build' Job (Compile)](#3-stage-1-the-build-job-compile)
- [4. Stage 2 & 3: The 'Test' and 'Package' Jobs](#4-stage-2--3-the-test-and-package-jobs)
- [5. Artifact Management: Archiving and Smart Versioning](#5-artifact-management-archiving-and-smart-versioning)
- [6. Creating a Pipeline: Upstream & Downstream Jobs](#6-creating-a-pipeline-upstream--downstream-jobs)
- [7. Visualization and Automation](#7-visualization-and-automation)

---

### 1. Getting Started: UI Tour and Pre-flight Checks

Before creating jobs, I first needed to configure Jenkins to handle my project's technology stack (Java and Maven).

-   **Jenkins UI Tour:** I started by familiarizing myself with the key areas of the Jenkins UI: the main dashboard, the "Manage Jenkins" section for administration, and the build executor status.
-   **Maven Plugin:** My target application uses Maven. To get the best integration, I navigated to `Manage Jenkins > Manage Plugins > Available` and installed the **Maven Integration** plugin. This adds a specialized "Maven project" job type.
-   **Global Tool Configuration:** Jenkins needs to know where to find the build tools. In `Manage Jenkins > Global Tool Configuration`, I added a Maven installation, gave it a memorable name (`Maven 3.9.6`), and set it to install automatically. Jenkins will now download and use this version whenever a job requests it.

---

### 2. The Use Case: Forking the "Sysfoo" Java App

To simulate a real development workflow, I can't work directly on the original source code. The first crucial step was to create my own copy.

-   **What is Forking?** Forking creates a personal copy of a repository under my own GitHub account. This allows me to make changes, push code, and trigger builds without affecting the original project.
-   **How I did it:** I navigated to the upstream repository (`udbc/sysfoo`) on GitHub and clicked the "Fork" button. This gave me my own version to which I have full push access. All my Jenkins jobs will point to *my* forked repository URL.

---

### 3. Stage 1: The 'Build' Job (Compile)

My first goal is to ensure the code compiles successfully. A broken build can halt the entire team, so this is the most fundamental check.

1.  **Organization with Folders:** To keep my project jobs tidy, I first created a `New Item` and chose the **Folder** type, naming it `sysfoo`. All my jobs for this app will live inside this folder.
2.  **Creating the Job:** Inside the folder, I created a `New Item`, named it `build`, and selected the **Maven project** type.
3.  **Source Code Management:** I configured the job to pull from my forked Git repository. I made sure to change the "Branch Specifier" from the default `*/master` to `*/main`, as that's the primary branch in this repository.
4.  **Build Step:** For a Maven project, this is simple. I just needed to specify the "Goals and options." For this job, the goal is simply `compile`.
5.  **First Run:** I saved the job and manually clicked **"Build Now"**. I watched the "Console Output" to see Jenkins clone my repo, install Maven, and successfully compile the code. A green checkmark meant success!

---

### 4. Stage 2 & 3: The 'Test' and 'Package' Jobs

With the build job as a template, creating the next two jobs was fast and efficient.

-   **Using "Copy from":** For the `test` job, I created a `New Item` but instead of configuring it from scratch, I used the **"Copy from"** field and pointed it to my existing `build` job.
-   **The 'Test' Job:** I opened the configuration for the new `test` job, updated the description, and changed the Maven goal to `clean test`. This tells Maven to first clean the workspace and then run all the unit tests found in the source code.
-   **The 'Package' Job:** I repeated the copy process, this time copying the `test` job to create a `package` job. I changed the goal to `package -DskipTests`.
    -   **Why skip tests?** This is an important optimization. The tests were already run in the dedicated `test` stage. There's no need to run them again. This ensures each stage has a single, clear responsibility.

---

### 5. Artifact Management: Archiving and Smart Versioning

The `package` job creates a `.jar` file, which is the application artifact. I needed to save this file and give it a unique version.

1.  **Archiving:** In the `package` job's configuration, I went to **"Post-build Actions"** and selected **"Archive the artifacts"**. I told it to save files matching the pattern `**/target/*.jar`. After the next run, the generated `.jar` file appeared directly on the job's main page, ready for download.
2.  **Versioning:** A static version like `SNAPSHOT` isn't useful for tracking. I wanted to version my artifact with the unique Git commit ID that triggered the build. I did this by adding a **"Pre Step"** to the `package` job:
    -   **Type:** `Execute shell`.
    -   **Command:** A shell script that gets the `GIT_COMMIT` environment variable, truncates it to 7 characters, and uses a Maven command (`mvn versions:set`) to update the project's version in the `pom.xml` *before* the main `package` goal runs.
    -   The result? An artifact named something like `sysfoo-77a0877.jar`, which is directly traceable to a specific code change.

---

### 6. Creating a Pipeline: Upstream & Downstream Jobs

My three jobs were still independent. I needed to connect them so they run in sequence: `build` → `test` → `package`. I did this by defining upstream and downstream relationships.

-   **Build → Test:** In the `build` job's configuration, under **"Post-build Actions"**, I added **"Build other projects"** and entered `test` as the "Projects to build". This makes `test` a *downstream* job of `build`.
-   **Test → Package:** In the `package` job's configuration, under **"Build Triggers"**, I checked **"Build after other projects are built"** and entered `test` as the "Projects to watch". This makes `test` an *upstream* job of `package`.

With these settings, triggering the `build` job now automatically kicks off the entire chain.

---

### 7. Visualization and Automation

The final steps were to visualize this new pipeline and have it run automatically.

-   **Visualization:** I installed the **Build Pipeline** plugin. Then, inside my `sysfoo` folder, I clicked the `+` tab to create a new **View**. I chose the "Build Pipeline View" type, gave it a name, and configured it to start with my `build` job. This gave me a beautiful, color-coded dashboard showing the status of each stage in the sequence. -   **Automation:** To make this a true CI system, I configured the pipeline to trigger automatically on a code change. In the `build` job's configuration, under **"Build Triggers"**, I enabled **"Poll SCM"**.
    -   **What is it?** This tells Jenkins to periodically check my Git repository for new commits.
    -   **Schedule:** I set the schedule to `* * * * *`, which means "poll every minute."
Now, whenever I push a new commit to my forked repository, Jenkins detects it within a minute and automatically runs the entire build, test, and package pipeline, giving me immediate feedback on my changes.
