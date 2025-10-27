# My Learning Journey: CI/CD with Jenkins and Docker

Welcome! This directory serves as a comprehensive log of my hands-on journey through the world of Continuous Integration and Continuous Delivery, guided by the excellent Udemy course by **Gourav J. Shah**. I want to extend my sincere gratitude to Gourav for creating such a practical, in-depth, and well-structured course that has been instrumental in solidifying my DevOps skills.

This is more than just a collection of files; it's a testament to a complete learning path, from foundational theories to a fully-realized, automated pipeline.

## About This Directory

This directory contains my personal, detailed notes and workflow summaries for each of the 7 sections of the course. Each section builds upon the last, culminating in a professional-grade CI/CD pipeline that automates the entire process from code commit to a published Docker image.

The notes are written in a "what, why, and how" format to explain not just the steps I took, but the reasoning behind them, making this a valuable personal reference for future projects.

## What I Learned: A Section-by-Section Breakdown

My journey covered a wide array of essential DevOps practices and tools. Here is a summary of what each section in this directory covers:

### [Section 1 & 2: Foundations and Lab Setup](./section-01)
I started with the core concepts of CI/CD, understanding what Jenkins is and its crucial role in the DevOps toolchain. The hands-on work began immediately as I set up my complete lab environment using Docker and Docker Compose, creating an isolated and reproducible Jenkins server with a Docker-in-Docker (DinD) setup for future integrations.

### [Section 3: My First Manual CI Pipeline](./section-03)
With the environment ready, I dove into the classic Jenkins UI. I created my first "manual" pipeline by building three separate jobs: `build`, `test`, and `package`. I learned how to connect them using upstream/downstream configurations and visualize the flow, giving me a fundamental understanding of how CI stages work together.

### [Section 4: Pipeline as Code with Jenkinsfile & Blue Ocean](./section-04)
This was a major leap forward. I transitioned from the manual, UI-driven approach to the modern "Pipeline as Code" philosophy. I wrote my first declarative `Jenkinsfile`, converting my three manual jobs into a single, version-controlled script. I also started using the modern **Blue Ocean UI** to create, visualize, and manage my pipeline, and established a two-way integration with GitHub.

### [Section 5: Jenkinsfile Deep Dive](./section-05)
This was a conceptual deep dive to solidify my understanding of the `Jenkinsfile`. I explored the differences between Declarative and Scripted pipelines, the syntax of core directives (`agent`, `stages`, `post`, `when`), and best practices for writing clean, maintainable, and efficient pipeline code.

### [Section 6: Enforcing Professional Workflows](./section-06)
A pipeline is only effective if it's enforced. In this section, I learned to implement a professional **Trunk-Based Development** model. Using **GitHub's Branch Protection Rules**, I locked down the `main` branch, mandated that all changes go through a Pull Request, and enforced two critical quality gates: a mandatory code review from a peer and a successful Jenkins CI build.

### [Section 7: Integrating Jenkins with Docker](./section-07)
This final section brought everything full circle.
1.  **Docker as an Agent:** I refactored my pipeline to run each stage in a clean, isolated Docker container, ensuring a consistent build environment every time.
2.  **Building & Publishing Images:** I wrote an optimized, multi-stage `Dockerfile` for the application. Then, I added the final stage to my `Jenkinsfile` to automatically build this Docker image and publish it to Docker Hub, tagged with the Git commit hash for perfect traceability.

By the end of this course, I had successfully built a complete, end-to-end automated workflow that takes a simple code change and produces a tested, versioned, and distributable container image. This directory stands as a detailed record of that achievement. Thank you again to Gourav J. Shah and the School of DevOps!
