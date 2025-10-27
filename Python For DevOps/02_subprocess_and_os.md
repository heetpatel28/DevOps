# Mastering `os` and `subprocess`: A Comprehensive Guide for DevOps

For any DevOps engineer, the `os` and `subprocess` modules are the foundational tools for Python automation. They provide the essential bridge between a Python script and the underlying operating system, allowing you to manage files, navigate directories, access environment variables, and run any external command-line tool. This guide offers a detailed, step-by-step walkthrough of both modules, designed to take you from fundamentals to mastery.

---

### Table of Contents
1.  [**Part 1: The `os` Module: Interacting with the Operating System**](#part-1-the-os-module-interacting-with-the-operating-system)
    * [What is the `os` Module?](#what-is-the-os-module)
    * [The `os.path` Submodule: Your Tool for Path Manipulation](#the-ospath-submodule-your-tool-for-path-manipulation)
    * [Directory and File Operations](#directory-and-file-operations)
    * [Working with Environment Variables](#working-with-environment-variables)
    * [Practical Recipe: Cleaning Up Old Log Files](#practical-recipe-cleaning-up-old-log-files)
2.  [**Part 2: The `subprocess` Module: Running External Commands**](#part-2-the-subprocess-module-running-external-commands)
    * [Why `subprocess` is the Modern Standard](#why-subprocess-is-the-modern-standard)
    * [The Core of `subprocess`: `subprocess.run()`](#the-core-of-subprocess-subprocessrun)
    * [Real-time Output for Long-Running Commands with `subprocess.Popen`](#real-time-output-for-long-running-commands-with-subprocesspopen)
    * [Practical Recipe: Automating Git Operations](#practical-recipe-automating-git-operations)
3.  [**Part 3: Combining `os` and `subprocess` for Advanced Automation**](#part-3-combining-os-and-subprocess-for-advanced-automation)
    * [Advanced Recipe: Checking Git Status Across Multiple Repositories](#advanced-recipe-checking-git-status-across-multiple-repositories)
4.  [**Conclusion**](#conclusion)

---

## Part 1: The `os` Module: Interacting with the Operating System

<a name="part-1-the-os-module-interacting-with-the-operating-system"></a>
This section covers how to use Python to perform fundamental tasks like reading and writing files, creating directories, and manipulating file paths.

### What is the `os` Module?

<a name="what-is-the-os-module"></a>
The `os` module in Python provides a portable way of using operating system-dependent functionality. In simple terms, it allows your Python script to interact with the host system's file system and environment in a way that works across different operating systems like Linux, macOS, and Windows.

To begin, you must always import the module:
```python
import os
```

### The `os.path` Submodule: Your Tool for Path Manipulation

<a name="the-ospath-submodule-your-tool-for-path-manipulation"></a>
A significant portion of DevOps scripting involves working with file and directory paths. Hardcoding paths with simple string concatenation (e.g., `path = folder + "/" + file`) is unreliable because path separators differ between operating systems (`/` on Linux/macOS, `\` on Windows). The `os.path` submodule solves this problem.

**`os.path.join()`: The Correct Way to Build Paths**
This function intelligently joins path components using the correct separator for the current OS.

```python
# This code works on both Windows and Linux
log_dir = "/var/log"
log_file = "app.log"
full_path = os.path.join(log_dir, log_file)
print(full_path) # Output on Linux: /var/log/app.log
```

**`os.path.exists()`: Checking for Existence**
Before attempting to read a file or create a directory, it's essential to check if it already exists.

```python
config_file = "/etc/myapp/config.yaml"
if os.path.exists(config_file):
    print(f"Config file found at: {config_file}")
else:
    print(f"Config file not found. Using default settings.")
```

**`os.path.isdir()` and `os.path.isfile()`: Differentiating Types**
These functions check if a given path points to a directory or a file, respectively.

```python
path = "/var/log"
if os.path.isdir(path):
    print(f"'{path}' is a directory.")
elif os.path.isfile(path):
    print(f"'{path}' is a file.")
```

### Directory and File Operations

<a name="directory-and-file-operations"></a>
The `os` module provides functions for creating, listing, and deleting files and directories.

**`os.getcwd()`: Getting the Current Working Directory**
This returns the directory from which the script is being executed.

```python
current_dir = os.getcwd()
print(f"The script is running from: {current_dir}")
```

**`os.makedirs()`: Creating Directories**
This function creates a directory. A key feature is that it can create all the intermediate parent directories if they don't exist (similar to `mkdir -p`).

```python
new_dir = "/tmp/my_app/logs"
if not os.path.exists(new_dir):
    os.makedirs(new_dir)
    print(f"Created directory: {new_dir}")
```

**`os.listdir()`: Listing Directory Contents**
This function returns a list of all files and subdirectories within a given path.

```python
target_dir = "/etc"
print(f"Contents of '{target_dir}':")
try:
    for item in os.listdir(target_dir):
        print(f"  - {item}")
except FileNotFoundError:
    print(f"Error: Directory '{target_dir}' not found.")
```

### Working with Environment Variables

<a name="working-with-environment-variables"></a>
Environment variables are a standard way to pass configuration to applications. The `os` module provides a simple way to access them.

**`os.getenv()`: The Safe Way to Read Environment Variables**
This is the recommended method. It returns `None` if the environment variable doesn't exist, preventing your script from crashing. You can also provide a default value.

```python
# Safely get an environment variable
db_user = os.getenv("DB_USER")
if db_user:
    print(f"Database user is: {db_user}")
else:
    print("DB_USER environment variable is not set.")

# Get a variable with a default fallback value
log_level = os.getenv("LOG_LEVEL", "INFO")
print(f"Log level is set to: {log_level}")
```

### Practical Recipe: Cleaning Up Old Log Files

<a name="practical-recipe-cleaning-up-old-log-files"></a>
This script demonstrates combining several `os` module functions to perform a common DevOps task: deleting log files older than a specified number of days.

```python
import os
import time

def cleanup_logs(directory, days_to_keep):
    """
    Deletes files in a directory that are older than `days_to_keep`.
    """
    print(f"Scanning '{directory}' for files older than {days_to_keep} days...")
    
    # Get the current time in seconds since the epoch
    now = time.time()
    
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        
        # Check if it's a file
        if os.path.isfile(file_path):
            # Get the last modification time of the file
            file_mod_time = os.path.getmtime(file_path)
            
            # Calculate the age of the file in days
            age_in_days = (now - file_mod_time) / (24 * 3600)
            
            if age_in_days > days_to_keep:
                print(f"  - Deleting '{filename}' (age: {age_in_days:.1f} days)")
                try:
                    os.remove(file_path)
                except OSError as e:
                    print(f"    Error deleting file: {e}")

# --- Script Execution ---
LOG_DIRECTORY = "/path/to/your/logs"
RETENTION_DAYS = 30

cleanup_logs(LOG_DIRECTORY, RETENTION_DAYS)
```

---

## Part 2: The `subprocess` Module: Running External Commands

<a name="part-2-the-subprocess-module-running-external-commands"></a>
Python is excellent for logic and data handling, but many essential DevOps tools are command-line applications (e.g., `git`, `docker`, `terraform`, `kubectl`). The `subprocess` module is the bridge that allows your Python script to run and interact with these tools.

### Why `subprocess` is the Modern Standard

<a name="why-subprocess-is-the-modern-standard"></a>
Older methods like `os.system()` exist, but they are highly discouraged. `os.system()` simply passes the command to the system's shell, which is a security risk and offers very little control. In contrast, `subprocess`:
* Provides full control over the command's execution.
* Allows you to capture the command's output (`stdout`) and errors (`stderr`).
* Lets you check the command's exit code to see if it was successful.
* Is more secure as it avoids shell injection vulnerabilities when used correctly.

### The Core of `subprocess`: `subprocess.run()`

<a name="the-core-of-subprocess-subprocessrun"></a>
For most use cases, `subprocess.run()` is the function you will use. It runs a command and waits for it to complete.

**The Correct Way to Pass Commands:**
Always pass the command and its arguments as a list of strings. This is safer and avoids issues with spaces or special characters in filenames.

```python
# Correct
subprocess.run(['ls', '-l', '/var/log'])

# Incorrect and insecure
subprocess.run('ls -l /var/log', shell=True) 
```

**Capturing Output and Handling Errors:**
`subprocess.run()` has several key arguments that give you control over its behavior.

```python
import subprocess

def run_command(command_list):
    """
    Runs a command, captures its output, and checks for errors.
    """
    print(f"--- Running command: {' '.join(command_list)} ---")
    try:
        result = subprocess.run(
            command_list,
            capture_output=True, # Capture stdout and stderr
            text=True,           # Decode output as text (string) instead of bytes
            check=True           # Raise an exception if the command fails (returns non-zero exit code)
        )
        print("--- Command successful ---")
        return result.stdout.strip()

    except FileNotFoundError:
        print(f"Error: Command not found: '{command_list[0]}'")
        return None
    except subprocess.CalledProcessError as e:
        # 'check=True' makes it jump here on failure
        print(f"--- Command failed with exit code {e.returncode} ---")
        print("Stderr:\n", e.stderr)
        return None

# --- Script Execution ---
# Example 1: Successful command
output = run_command(['ls', '-l'])
if output:
    print("Stdout:\n", output)

# Example 2: Failing command
run_command(['ls', '/nonexistent-directory'])
```

### Real-time Output for Long-Running Commands with `subprocess.Popen`

<a name="real-time-output-for-long-running-commands-with-subprocesspopen"></a>
`subprocess.run()` waits until the command is finished before returning the output. For long-running processes like a software build, a deployment, or a `terraform apply`, you need to see the output in real-time. `subprocess.Popen` is used for this.

`Popen` starts the process and immediately returns control to your script, allowing you to interact with its output streams while it runs.

```python
import subprocess

def run_long_command(command_list):
    """
    Runs a long-running command and prints its output in real-time.
    """
    print(f"--- Running command: {' '.join(command_list)} ---")
    process = subprocess.Popen(
        command_list,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT, # Redirect stderr to stdout to capture all output
        text=True
    )
    
    # Read the output line by line as it is generated
    for line in iter(process.stdout.readline, ''):
        print(line, end='') # 'end=' prevents extra newlines

    process.stdout.close()
    return_code = process.wait() # Wait for the process to finish
    
    if return_code != 0:
        print(f"\n--- Command failed with exit code {return_code} ---")

# --- Script Execution ---
# Simulates a long command with 'ping'
run_long_command(['ping', '-c', '5', 'google.com'])
```

### Practical Recipe: Automating Git Operations

<a name="practical-recipe-automating-git-operations"></a>
This script uses `subprocess.run()` to automate pulling the latest changes for a Git repository.

```python
import subprocess
import os

def git_pull(repo_path):
    """
    Runs 'git pull' in the specified repository path.
    """
    if not os.path.isdir(os.path.join(repo_path, '.git')):
        print(f"Error: '{repo_path}' is not a Git repository.")
        return

    print(f"--- Pulling latest changes for '{repo_path}' ---")
    try:
        # Use 'cwd' to specify the working directory for the command
        subprocess.run(
            ['git', 'pull'],
            cwd=repo_path,
            check=True,
            capture_output=True,
            text=True
        )
        print("--- Pull successful ---")
    except subprocess.CalledProcessError as e:
        print("--- Git pull failed ---")
        print("Stderr:", e.stderr)

# --- Script Execution ---
REPO_DIRECTORY = "/path/to/your/git/repo"
git_pull(REPO_DIRECTORY)
```

---

## Part 3: Combining `os` and `subprocess` for Advanced Automation

<a name="part-3-combining-os-and-subprocess-for-advanced-automation"></a>
The true power of these modules is realized when they are used together. The `os` module helps you navigate and understand the environment, while the `subprocess` module acts on that environment.

### Advanced Recipe: Checking Git Status Across Multiple Repositories

<a name="advanced-recipe-checking-git-status-across-multiple-repositories"></a>
Imagine you have a directory containing multiple Git projects. This script will iterate through them, identify which ones are Git repositories, and run `git status` to report on any with uncommitted changes.

```python
import os
import subprocess

def check_git_repositories(parent_directory):
    """
    Scans a parent directory, finds all Git repos, and checks their status.
    """
    if not os.path.isdir(parent_directory):
        print(f"Error: Directory '{parent_directory}' not found.")
        return

    print(f"Scanning for Git repositories in '{parent_directory}'...")
    
    for item in os.listdir(parent_directory):
        repo_path = os.path.join(parent_directory, item)
        
        # 1. Use 'os' module to check if it's a directory and a Git repo
        if os.path.isdir(repo_path) and os.path.isdir(os.path.join(repo_path, '.git')):
            print(f"\n--- Checking status for: {item} ---")
            try:
                # 2. Use 'subprocess' to run git status
                result = subprocess.run(
                    ['git', 'status', '--porcelain'],
                    cwd=repo_path,
                    capture_output=True,
                    text=True,
                    check=True
                )
                
                if result.stdout:
                    print("  Status: Uncommitted changes found.")
                    print(result.stdout)
                else:
                    print("  Status: Clean.")
            
            except subprocess.CalledProcessError as e:
                print(f"  Error checking status: {e.stderr}")

# --- Script Execution ---
PROJECTS_HOME = "/path/to/your/projects/folder"
check_git_repositories(PROJECTS_HOME)
```

---

## Conclusion

<a name="conclusion"></a>
The `os` and `subprocess` modules are the workhorses of system automation in Python. The `os` module provides the eyes and hands to interact with the file system, while the `subprocess` module provides the voice to command other tools. By mastering them, a DevOps engineer can write clean, robust, and portable scripts to automate a vast range of tasks, from simple file management to complex orchestrations of tools like Git, Docker, and Terraform. They are indispensable skills for anyone serious about a career in DevOps.
