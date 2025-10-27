# My AWS EC2 Journey & Guide

Hello! This is my personal guide and collection of notes on **Amazon Web Services (AWS) Elastic Compute Cloud (EC2)**. I created this to keep track of everything I've learned about EC2, from the absolute basics to more advanced concepts. My goal is to explain things in a simple, clear way that's easy to follow.

---

## Table of Contents
1.  [What is AWS EC2?](#what-is-aws-ec2)
2.  [Core EC2 Concepts I Needed to Learn](#core-ec2-concepts-i-needed-to-learn)
3.  [My Step-by-Step Guide to Launching an EC2 Instance](#my-step-by-step-guide-to-launching-an-ec2-instance)
4.  [How I Connect to My Instances](#how-i-connect-to-my-instances)
5.  [Managing My Instance's Lifecycle](#managing-my-instances-lifecycle)
6.  [Understanding EC2 Pricing - How I Save Money](#understanding-ec2-pricing---how-i-save-money)
7.  [Best Practices I Always Follow](#best-practices-i-always-follow)
8.  [Next Steps: What I'm Learning Now](#next-steps-what-im-learning-now)
9.  [Scenario-Based MCQs](#scenario-based-mcqs)

---

## What is AWS EC2?

I think of **EC2** as renting a virtual computer in the cloud. Instead of buying and maintaining my own physical servers, I can launch a virtual server (called an "instance") on AWS in just a few minutes.

Here's the simple analogy I use: It's like having a computer that I can access from anywhere in the world. I get to choose its operating system (like Linux or Windows), how much processing power (CPU) it has, how much memory (RAM), and how much storage it needs. The "Elastic" part means I can easily scale it up or down depending on my needs. If I need more power, I can get a bigger instance. If I don't need it anymore, I can just turn it off and stop paying for it.

---

## Core EC2 Concepts I Needed to Learn

When I first started, there were a few key terms I had to get familiar with. Here's my breakdown of the most important ones:

* **Instance:** This is the virtual server itself. It's the core component of EC2. I can have many instances running at the same time.

* **Amazon Machine Image (AMI):** I see this as a template for my instance. It's a pre-configured package that includes the operating system (e.g., Ubuntu, Windows Server) and any additional software I want to start with. I can use public AMIs provided by AWS or create my own custom ones.

* **Instance Types:** This is how I choose the hardware for my instance. AWS offers a huge variety of instance types, each optimized for different tasks (e.g., general purpose, compute-optimized, memory-optimized). I pick one based on the CPU, memory, storage, and networking capacity my application needs. For example, for a small personal website, I'd use a `t2.micro` or `t3.micro` which is part of the Free Tier.

* **Security Groups:** This is a crucial one! A Security Group acts as a virtual firewall for my instance. It controls what traffic is allowed to come in and go out. I have to explicitly open ports for services I want to be accessible. For example, to access a web server, I open port `80` (HTTP) and `443` (HTTPS). For SSH access to a Linux instance, I open port `22`.

* **Key Pair:** This is how I securely connect to my Linux instances. It consists of a **public key** (which AWS stores) and a **private key** (which I download and keep safe). I can't connect to my instance without the private key, so I make sure never to lose it!

* **Elastic Block Store (EBS) Volumes:** I think of EBS as a virtual hard drive for my EC2 instance. It's where the operating system is installed and where I store my files. These volumes are persistent, meaning the data remains even if I stop and start the instance.

* **Elastic IP (EIP):** By default, the public IP address of my instance changes every time I stop and start it. An Elastic IP is a static public IP address that I can associate with my instance. This is useful if I need a fixed address that doesn't change, like for a web server.

---

## My Step-by-Step Guide to Launching an EC2 Instance

Here's the process I follow every time I need to launch a new virtual server.

1.  **Sign in to the AWS Console:** I go to the AWS Management Console and navigate to the EC2 service.

2.  **Choose a Region:** I select the AWS Region where I want my instance to be located. I usually pick the one closest to my users to reduce latency.

3.  **Launch Instance:** I click the "Launch Instances" button.

4.  **Choose an AMI:** I select the Amazon Machine Image. For most of my projects, I start with the latest "Amazon Linux 2" or "Ubuntu Server" AMI.

5.  **Choose an Instance Type:** I select the hardware. The `t2.micro` is my go-to for testing since it's eligible for the AWS Free Tier.

6.  **Configure Key Pair:** This is a critical step. I either choose an existing key pair that I've used before or create a new one. If I create a new one, I immediately download the `.pem` file and save it in a secure location on my computer.

7.  **Network Settings & Security Group:**
    * I usually leave the VPC and Subnet settings as default for simple projects.
    * For the Security Group, I create a new one. I make sure to allow SSH traffic (port 22) from my own IP address for security. If it's a web server, I'll also add rules for HTTP (port 80) and HTTPS (port 443).

8.  **Configure Storage:** I stick with the default EBS volume size (usually 8 GB) for basic setups. I can always increase this later if needed.

9.  **Launch!** I review all the settings on the summary page and then click "Launch Instance". My instance is usually up and running within a minute or two.

---

## How I Connect to My Instances

Connecting to my instance depends on the operating system.

### For Linux Instances (SSH)

1.  **Locate my Private Key:** I find the `.pem` file I downloaded earlier.
2.  **Set Permissions:** On my Mac or Linux terminal, I run `chmod 400 /path/to/my-key.pem`. This is a required step to make the key file not publicly viewable.
3.  **Connect:** I find the Public IPv4 address of my instance from the EC2 console. Then I run the following command in my terminal:
    ```bash
    ssh -i /path/to/my-key.pem ec2-user@<public-ip-address>
    ```
    *(Note: The username might be different depending on the AMI, e.g., `ubuntu` for Ubuntu AMIs).*

### For Windows Instances (RDP)

1.  **Get Password:** In the EC2 console, I select my Windows instance and click "Connect". I choose the RDP client option.
2.  **Decrypt Password:** I'm prompted to upload my private key file (`.pem`). AWS then uses this to decrypt the default Administrator password.
3.  **Connect:** I use a Remote Desktop client (like Microsoft Remote Desktop) and connect using the instance's public IP, the username `Administrator`, and the password I just decrypted.

---

## Managing My Instance's Lifecycle

I can control the state of my instance directly from the EC2 console:

* **Start:** Powers on the instance.
* **Stop:** Shuts down the instance. I'm not charged for instance usage while it's stopped, but I still pay for the attached EBS storage. This is great for instances I don't need running 24/7.
* **Reboot:** Restarts the instance.
* **Terminate:** This is a permanent action! It deletes the instance and its root EBS volume. I make sure to back up any data I need before terminating an instance.

---

## Understanding EC2 Pricing - How I Save Money

AWS pricing can be complex, but for EC2, I focus on these main models:

* **On-Demand:** This is the default. I pay for compute capacity by the hour or second with no long-term commitments. It's flexible but also the most expensive. I use this for applications with unpredictable workloads.

* **Reserved Instances (RIs):** If I know I'll be running an instance for a long period (1 or 3 years), I can reserve it. This gives me a significant discount compared to On-Demand pricing.

* **Savings Plans:** This is similar to RIs but more flexible. I commit to a certain amount of compute usage ($/hour) for a 1 or 3-year term, and I get a discount. This discount applies automatically across different instance types and even regions.

* **Spot Instances:** This is my favorite for non-critical tasks. I can bid on unused EC2 capacity, which can provide massive savings (up to 90% off On-Demand prices). The catch is that AWS can reclaim the instance with a two-minute warning if they need the capacity back. I use this for things like data processing or testing that can be interrupted.

---

## Best Practices I Always Follow

* **Use the Principle of Least Privilege:** I only open the ports I absolutely need in my Security Groups. I also restrict access to specific IP addresses whenever possible.
* **Use IAM Roles:** Instead of storing AWS credentials (access keys) on my EC2 instance, I attach an IAM Role to it. This gives the instance the necessary permissions to access other AWS services (like S3) securely.
* **Regularly Patch and Update:** I make sure the operating system and software on my instances are always up to date to protect against vulnerabilities.
* **Monitor My Instances:** I use Amazon CloudWatch to monitor metrics like CPU utilization. I can set up alarms to notify me if a metric goes above a certain threshold.
* **Tag Everything:** I apply tags (key-value pairs) to all my EC2 instances and resources. This helps me stay organized and track costs. For example, I might use tags like `Project: MyWebApp` or `Environment: Production`.

---

## Next Steps: What I'm Learning Now

EC2 is just the beginning. Now that I'm comfortable with individual instances, I'm focusing on how to use them as part of a larger, more robust architecture. My current learning path includes:

* **Elastic Load Balancing (ELB):** To distribute incoming traffic across multiple EC2 instances.
* **Auto Scaling Groups:** To automatically add or remove instances based on demand, ensuring high availability and performance.

I hope this guide helps you as much as it has helped me!

---

## Scenario-Based MCQs

Test your knowledge with these scenarios. Answers are at the bottom!

**1. I'm launching a web server that needs to be accessible to everyone on the internet. Which inbound rule must I configure in my Security Group?**
-    a) Allow TCP on port 22 from 0.0.0.0/0
-    b) Allow TCP on port 80 from my IP address
-    c) Allow TCP on port 80 and 443 from 0.0.0.0/0
-    d) Allow all traffic from 0.0.0.0/0

**2. I have a critical application that must run for the next 12 months without interruption. To save the most money, which EC2 pricing model should I choose?**
-    a) On-Demand
-    b) Spot Instances
-    c) Reserved Instances
-    d) Savings Plan

**3. I stopped my EC2 instance last night to save costs. This morning, I started it again, but I can't connect using the public IP address I had bookmarked. What is the most likely reason?**
-    a) The instance was terminated by mistake.
-    b) The Security Group rules were reset.
-    c) The instance was assigned a new public IP address upon restart.
-    d) I lost my private key file.

**4. I need to run a batch processing job that can be interrupted. The job takes several hours, and I want to minimize costs as much as possible. What is the best EC2 purchasing option?**
-    a) On-Demand
-    b) Spot Instances
-    c) Reserved Instances
-    d) Dedicated Hosts

**5. I've created a custom application and configured it perfectly on an EC2 instance. Now I need to deploy 10 identical instances. What's the most efficient way to do this?**
-    a) Launch 10 new instances and manually configure each one.
-    b) Create a custom AMI from my configured instance and launch 10 new instances from that AMI.
-    c) Take an EBS snapshot and restore it to 10 new volumes.
-    d) Use an Elastic IP for each new instance.

**6. My EC2 instance needs to securely access files in an S3 bucket. What is the recommended best practice for granting these permissions?**
-    a) Hard-code my AWS access key and secret key into the application code.
-    b) Store my AWS credentials in a text file on the instance.
-    c) Create an IAM Role with S3 access permissions and attach it to the EC2 instance.
-    d) Open all traffic to S3 in the instance's Security Group.

**7. I'm trying to SSH into my new Linux instance, but I'm getting a "permission denied" or "connection timed out" error. I've confirmed the IP is correct. What should I check first?**
-    a) If the instance is running Windows.
-    b) The Security Group to ensure port 22 is open to my IP address.
-    c) If I'm using the correct IAM Role.
-    d) The instance size to see if it has enough memory.

**8. I have an EBS volume with important data. I terminate the EC2 instance it was attached to. What happens to the data on that EBS volume?**
-    a) The EBS volume is automatically terminated with the instance, and the data is lost.
-    b) The EBS volume is detached and persists, but the data is encrypted and inaccessible.
-    c) It depends on the "Delete on Termination" setting for the volume. By default, the root volume is deleted, but non-root volumes persist.
-    d) The data is automatically backed up to S3.

**9. My website is experiencing high traffic, and the CPU utilization on my single EC2 instance is constantly at 100%. What is the best immediate action to handle the load and improve performance?**
-    a) Stop and start the instance.
-    b) Change the instance type to one with more CPU and RAM (scale up).
-    c) Add a new inbound rule to the Security Group.
-    d) Create an AMI of the instance.

**10. I need a static, unchanging public IP address for my DNS records to point to. Which AWS service should I use?**
-    a) Amazon Machine Image (AMI)
-    b) Elastic Block Store (EBS)
-    c) Security Group
-    d) Elastic IP (EIP)

**11. I've downloaded my `.pem` key file. What command do I need to run on my local Linux/macOS machine before I can use it with SSH?**
-    a) `chmod 777 my-key.pem`
-    b) `chmod 400 my-key.pem`
-    c) `chown root my-key.pem`
-    d) `cat my-key.pem`

**12. I want to save money on an instance that I only use during business hours (9 AM to 5 PM, Monday to Friday). What is the most practical approach?**
-    a) Let it run 24/7 because the cost is minimal.
-    b) Terminate it every evening and launch a new one every morning.
-    c) Automate a script to stop the instance every evening and start it every morning.
-    d) Buy a 3-year Reserved Instance for it.

**13. A Security Group is "stateful". What does this mean?**
-    a) It remembers the state of the instance (running or stopped).
-    b) If you allow inbound traffic, the corresponding outbound traffic is automatically allowed, regardless of outbound rules.
-    c) You must define rules for both inbound and outbound traffic separately.
-    d) It can only be attached to one instance at a time.

**14. I'm choosing an Instance Type for a memory-intensive database application. Which instance family should I consider?**
-    a) T-family (e.g., t3.micro)
-    b) C-family (e.g., c5.large)
-    c) R-family (e.g., r5.large)
-    d) G-family (e.g., g4dn.xlarge)

**15. To keep my infrastructure organized, I want to label my instances based on their purpose (e.g., "web-server", "database") and environment (e.g., "prod", "dev"). What EC2 feature should I use?**
-    a) Key Pairs
-    b) AMIs
-    c) Tags
-    d) Instance Types

---

### Answers to MCQs

1.  **c) Allow TCP on port 80 and 443 from 0.0.0.0/0** - This allows HTTP and HTTPS traffic from any IP address.
2.  **c) Reserved Instances** - RIs offer the biggest discount for a committed term like one year. A Savings Plan is also a good option, but RIs are typically the most cost-effective for a specific, unchanging instance.
3.  **c) The instance was assigned a new public IP address upon restart.** - Default public IPs are dynamic and change on stop/start. An Elastic IP is needed for a static address.
4.  **b) Spot Instances** - They offer the largest discounts and are ideal for workloads that can tolerate interruptions.
5.  **b) Create a custom AMI from my configured instance and launch 10 new instances from that AMI.** - This is the most efficient and scalable method for creating identical instances.
6.  **c) Create an IAM Role with S3 access permissions and attach it to the EC2 instance.** - This is the most secure method as it avoids storing long-term credentials on the instance.
7.  **b) The Security Group to ensure port 22 is open to my IP address.** - This is the most common cause of connectivity issues.
8.  **c) It depends on the "Delete on Termination" setting for the volume. By default, the root volume is deleted, but non-root volumes persist.**
9.  **b) Change the instance type to one with more CPU and RAM (scale up).** - This directly addresses the resource bottleneck.
10. **d) Elastic IP (EIP)** - This provides a static public IPv4 address.
11. **b) `chmod 400 my-key.pem`** - This restricts permissions on the key file, which is a requirement for SSH.
12. **c) Automate a script to stop the instance every evening and start it every morning.** - This ensures you only pay for the hours the instance is actually in use.
13. **b) If you allow inbound traffic, the corresponding outbound traffic is automatically allowed, regardless of outbound rules.** - This simplifies firewall management.
14. **c) R-family (e.g., r5.large)** - 'R' stands for RAM, and this family is optimized for memory-intensive workloads.
15. **c) Tags** - Tags are key-value pairs designed specifically for labeling and organizing AWS resources.