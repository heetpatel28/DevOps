# Terraform Commands Handbook

A comprehensive guide to essential Terraform commands for Infrastructure as Code (IaC), complete with descriptions, real-world use cases, and practical examples.

## Table of Contents

- [Core Workflow Commands](#core-workflow-commands)
  - [terraform init](#1-terraform-init)
  - [terraform validate](#2-terraform-validate)
  - [terraform plan](#3-terraform-plan)
  - [terraform apply](#4-terraform-apply)
  - [terraform destroy](#5-terraform-destroy)
- [Infrastructure Inspection Commands](#infrastructure-inspection-commands)
  - [terraform show](#6-terraform-show)
  - [terraform output](#7-terraform-output)
  - [terraform state list](#8-terraform-state-list)
  - [terraform state show](#9-terraform-state-show)
  - [terraform graph](#10-terraform-graph)
- [State Management Commands](#state-management-commands)
  - [terraform refresh](#11-terraform-refresh)
  - [terraform import](#12-terraform-import)
  - [terraform state mv](#13-terraform-state-mv)
  - [terraform state rm](#14-terraform-state-rm)
  - [terraform taint / untaint](#15-terraform-taint--untaint)
- [Workspace Commands](#workspace-commands)
  - [terraform workspace](#16-terraform-workspace)
- [Code & Module Commands](#code--module-commands)
    - [terraform fmt](#17-terraform-fmt)
    - [terraform providers](#18-terraform-providers)
    - [terraform get](#19-terraform-get)
    - [terraform console](#20-terraform-console)
- [Cloud & Enterprise Commands](#cloud--enterprise-commands)
    - [terraform login](#21-terraform-login)
- [Debugging](#debugging)
    - [TF_LOG](#22-tf_log)

---

## Core Workflow Commands

### 1. `terraform init`
- **Description**: Initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration. It downloads necessary provider plugins and sets up the backend.
- **Real-World Use Case**: When you start a new Terraform project or clone an existing one, `init` prepares your local environment to manage the infrastructure by downloading the code for the cloud providers (like AWS, Azure, GCP) you've specified.

**Examples**:
```bash
# Initialize the current directory
terraform init
# Reconfigure the backend and re-verify plugin versions
terraform init -reconfigure
```

### 2. `terraform validate`
- **Description**: Checks whether a configuration is syntactically valid and internally consistent. It does not check against remote services.
- **Real-World Use Case**: To quickly catch typos, incorrect syntax, or argument errors in your `.tf` files before attempting to create an execution plan. It's great for use in CI/CD pipelines for a quick sanity check.

**Examples**:
```bash
# Validate the configuration files in the current directory
terraform validate
# Get detailed validation output in JSON format
terraform validate -json
```

### 3. `terraform plan`
- **Description**: Creates an execution plan, which lets you preview the changes Terraform plans to make to your infrastructure. It shows what will be created, updated, or destroyed.
- **Real-World Use Case**: This is a critical safety step. Before making any changes, you run `plan` to see exactly what will happen. This allows you to verify the changes are what you expect and prevent accidental deletion or modification of resources.

**Examples**:
```bash
# Create and show an execution plan
terraform plan
# Save the plan to a file to be applied later
terraform plan -out=tfplan
```

### 4. `terraform apply`
- **Description**: Executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.
- **Real-World Use Case**: After reviewing a plan and confirming it's correct, you use `apply` to actually build or modify your cloud resources.

**Examples**:
```bash
# Create a plan and prompt for approval before applying it
terraform apply
# Apply a previously saved plan file without prompting for approval
terraform apply "tfplan"
```

### 5. `terraform destroy`
- **Description**: Destroys all the remote objects managed by a particular Terraform configuration.
- **Real-World Use Case**: To tear down an environment after you're done with it, such as a temporary staging or testing environment, to avoid incurring further cloud costs.

**Examples**:
```bash
# Create a destruction plan and prompt for approval
terraform destroy
# Destroy without an interactive prompt (useful in automation)
terraform destroy -auto-approve
```

---

## Infrastructure Inspection Commands

### 6. `terraform show`
- **Description**: Provides human-readable output from a state or plan file. This is useful for inspecting the current state of your infrastructure.
- **Real-World Use Case**: To see the current values of all the attributes of the resources that Terraform is managing, like the IP address of a server or the ARN of an S3 bucket.

**Examples**:
```bash
# Show the current state of the infrastructure
terraform show
# Show the contents of a saved plan file in a human-readable format
terraform show tfplan
```

### 7. `terraform output`
- **Description**: Reads and displays output values from your Terraform state file. Outputs are defined in your configuration and are a way to expose useful information.
- **Real-World Use Case**: After creating a web server, you might have an output for its public IP address. You can use this command to easily retrieve that IP without parsing the entire state file.

**Examples**:
```bash
# Display all outputs from the root module
terraform output
# Display a specific output value in a raw, unformatted way
terraform output -raw public_ip
```

### 8. `terraform state list`
- **Description**: Lists all the resources that are currently being managed by Terraform in the current state file.
- **Real-World Use Case**: To get a quick list of all resource identifiers, which you can then use in other commands like `terraform state show` or `terraform taint`.

**Examples**:
```bash
# List all resources in the current state
terraform state list
# List resources that match a specific pattern (e.g., all AWS S3 buckets)
terraform state list 'aws_s3_bucket.*'
```

### 9. `terraform state show`
- **Description**: Shows the detailed attributes of a single resource as recorded in the Terraform state file.
- **Real-World Use Case**: To inspect all the details of a specific resource, like a virtual machine, including its ID, IP address, and all other configuration attributes.

**Examples**:
```bash
# Show the details of an AWS instance resource
terraform state show 'aws_instance.web_server'
# Show the details of a resource within a module
terraform state show 'module.my_vpc.aws_vpc.main'
```

### 10. `terraform graph`
- **Description**: Creates a visual representation of the dependency graph of your Terraform resources.
- **Real-World Use Case**: To understand the relationships between your resources and see how Terraform determines the order of operations. The output can be converted into an image.

**Examples**:
```bash
# Output the graph in the DOT language format
terraform graph
# Create a PNG image from the graph output (requires graphviz to be installed)
terraform graph | dot -Tpng > graph.png
```

---

## State Management Commands

### 11. `terraform refresh`
- **Description**: Updates the Terraform state file to match the real-world state of your infrastructure. It does not modify your infrastructure.
- **Real-World Use Case**: If a resource was changed manually in the cloud provider's console, `refresh` will update the state file to reflect that change. (Note: `terraform plan` and `apply` automatically perform a refresh).

**Examples**:
```bash
# Refresh the state file
terraform refresh
# Refresh and target a specific resource
terraform refresh -target=aws_instance.web
```

### 12. `terraform import`
- **Description**: Imports existing, manually-created infrastructure into your Terraform state, allowing it to be managed by Terraform from now on.
- **Real-World Use Case**: When you have existing cloud resources and you want to start managing them with Infrastructure as Code without having to destroy and recreate them.

**Examples**:
```bash
# Import an existing AWS S3 bucket into a Terraform resource
terraform import aws_s3_bucket.my_bucket my-existing-bucket-name
# Import an AWS EC2 instance
terraform import aws_instance.web_server i-0123456789abcdef0
```

### 13. `terraform state mv`
- **Description**: Moves an item within the Terraform state. This is useful for renaming resources or moving them between modules.
- **Real-World Use Case**: When you refactor your Terraform code and rename a resource from `aws_instance.server` to `aws_instance.web_server`, you use `state mv` to tell Terraform they are the same resource, preventing it from being destroyed and recreated.

**Examples**:
```bash
# Rename a resource within the state
terraform state mv aws_instance.old_name aws_instance.new_name
# Move a resource into a module
terraform state mv aws_instance.my_instance module.my_module.aws_instance.my_instance
```

### 14. `terraform state rm`
- **Description**: Removes a resource from being tracked in the Terraform state file. This does *not* destroy the actual infrastructure resource.
- **Real-World Use Case**: When you want to stop managing a resource with Terraform but leave it running in your cloud account.

**Examples**:
```bash
# Remove a resource from the state
terraform state rm aws_instance.web_server
# Remove a resource within a module from the state
terraform state rm 'module.my_vpc.aws_subnet.public[0]'
```

### 15. `terraform taint / untaint`
- **Description**: `taint` marks a resource as "tainted," forcing Terraform to destroy and recreate it on the next `apply`. `untaint` removes this mark.
- **Real-World Use Case**: When a resource has become corrupted or is in a bad state that Terraform can't detect, you can `taint` it to force a fresh replacement.

**Examples**:
```bash
# Mark a resource to be recreated
terraform taint aws_instance.web_server
# Unmark the resource if you change your mind
terraform untaint aws_instance.web_server
```

---

## Workspace Commands

### 16. `terraform workspace`
- **Description**: A parent command for managing workspaces. Workspaces allow you to use the same configuration to manage multiple distinct sets of infrastructure resources (e.g., for different environments like `dev`, `staging`, and `prod`).
- **Real-World Use Case**: To create and switch between different environments, so you can apply the same code to create a staging environment and a production environment, each with its own separate state file.

**Examples**:
```bash
# Create a new workspace and switch to it
terraform workspace new staging
# List all workspaces and select one to switch to
terraform workspace list
terraform workspace select production
```

---

## Code & Module Commands

### 17. `terraform fmt`
- **Description**: Rewrites Terraform configuration files to a canonical format and style.
- **Real-World Use Case**: To automatically clean up your code and ensure consistent formatting across all files and team members, making the code easier to read and maintain.

**Examples**:
```bash
# Format all .tf files in the current directory and subdirectories
terraform fmt -recursive
# Check which files would be reformatted without actually changing them
terraform fmt -check
```

### 18. `terraform providers`
- **Description**: Prints a tree of the providers being used in the configuration and their requirements.
- **Real-World Use Case**: To see which providers and versions your configuration depends on, which is helpful for debugging provider-related issues.

**Examples**:
```bash
# Show the provider dependency tree
terraform providers
# Lock the provider versions based on the current configuration
terraform providers lock -platform=linux_amd64 -platform=darwin_amd64
```

### 19. `terraform get`
- **Description**: Downloads and updates modules for the configuration. (Note: This is largely obsolete as `terraform init` now performs this action).
- **Real-World Use Case**: In older versions of Terraform, this was used to download modules. Now, it's mainly for forcing a re-download of modules if they become corrupted.

**Examples**:
```bash
# Download and update modules for the current configuration
terraform get
# Force a fresh download of modules
terraform get -update
```

### 20. `terraform console`
- **Description**: Provides an interactive console for experimenting with Terraform interpolations and functions.
- **Real-World Use Case**: To test complex expressions, functions, or variable manipulations before putting them into your configuration files.

**Examples**:
```bash
# Start the interactive console
terraform console
# (Inside the console) Test a function
> cidrsubnet("10.0.0.0/16", 8, 1)
"10.0.1.0/24"
```

---

## Cloud & Enterprise Commands

### 21. `terraform login`
- **Description**: Obtains and saves an API token for a remote host, such as Terraform Cloud or a private module registry.
- **Real-World Use Case**: The first step to connect your local Terraform CLI with Terraform Cloud, enabling remote state storage, collaboration, and remote runs.

**Examples**:
```bash
# Log in to the default host (app.terraform.io)
terraform login
# Log in to a self-hosted Terraform Enterprise instance
terraform login my-tfe-host.com
```

---

## Debugging

### 22. `TF_LOG`
- **Description**: An environment variable that controls the level of logging output from Terraform. It is not a command itself.
- **Real-World Use Case**: When a plan or apply is failing with a cryptic error, you can enable detailed logging to see the raw API requests and responses between Terraform and the cloud provider, which is invaluable for debugging.

**Examples**:
```bash
# Run a plan with detailed debug logging
TF_LOG=DEBUG terraform plan
# Run an apply with trace-level logging (most verbose) and save it to a file
TF_LOG=TRACE terraform apply &> apply.log
```