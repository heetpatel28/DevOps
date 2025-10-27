# My DevOps Project: A User-Friendly Bash Task Scheduler

Hey there! I'm excited to walk you through a project I just completed. I built a simple, yet super useful, task scheduler using a Bash script. This little tool makes it easy to manage automated tasks on a Linux system without having to fiddle with complicated commands every time.

This document is a complete guide to my project. I'll explain why I built it, the core concepts I learned and used, and then I'll break down the script line-by-line so you can see exactly how it works.

## Why Did I Build This?

In the world of DevOps, automation is everything. We want computers to do the repetitive work for us so we can focus on bigger problems. The most fundamental way to automate tasks in Linux is by using **cron**. However, the command to manage cron jobs, `crontab`, can be a bit intimidating at first, and it's easy to make a mistake that wipes out all your scheduled tasks.

My script acts as a friendly, menu-driven wrapper around `crontab`. It provides a safe and easy-to-use interface for:
-   **Listing** currently scheduled tasks.
-   **Adding** a new task with a specific schedule.
-   **Removing** an existing task without messing up the others.

Building this was a fantastic way for me to get hands-on experience with Bash scripting, handling user input, and interacting with a core Linux system utility. It’s a practical tool that solves a real-world problem.

---

## Core Concepts I Used

To build this script, I had to understand a few key Linux and programming concepts.

### 1. Bash Scripting
The whole script is written in Bash (`Bourne Again SHell`). It's the default command-line interpreter for most Linux distributions and is perfect for this kind of automation. I used functions, loops, variables, and conditional statements—all fundamental parts of programming in Bash.

### 2. Cron and Crontab
-   **Cron:** Think of `cron` as the heart of Linux scheduling. It's a daemon (a background process) that wakes up every minute to check if there are any jobs to run at that specific time.
-   **Crontab:** This is the file where the list of cron jobs is stored. Each user has their own crontab. The `crontab` command is what we use to edit this file.
-   **Cron Schedule Syntax:** The schedule for a cron job has five fields, which can be a bit cryptic at first:
    ```
    * * * * * <-- command to be executed
    | | | | |
    | | | | +----- Day of week (0 - 7) (Sunday is 0 or 7)
    | | | +------- Month (1 - 12)
    | | +--------- Day of month (1 - 31)
    | +----------- Hour (0 - 23)
    +------------- Minute (0 - 59)
    ```
    For example, `0 5 * * 1` means "run at 5:00 AM every Monday."

### 3. Command-Line Tools
My script orchestrates several powerful Linux commands:
-   `echo`: To print text to the screen.
-   `read`: To capture input from the user.
-   `crontab`: The command-line tool to interact with the cron daemon.
-   `grep`: To filter text. I use it to remove comment lines from the crontab output.
-   `nl`: To add line numbers, making it easy for the user to select a task.
-   `sed`: A "stream editor" used to perform text transformations. I use it to delete a specific line from the crontab file.

---

## My Script Explained, Line-by-Line

Let's dive into the code. I've broken it down by function to explain what each part does.

```bash
#!/bin/bash
```
This very first line is called a **shebang**. It tells the operating system, "Hey, when you run this file, please use the Bash interpreter to execute the commands inside." It's a crucial part of any shell script.

### The `list_tasks` Function
```bash
list_tasks() {
    echo "--- Current Scheduled Tasks ---"
    crontab -l | grep -v '^#' | nl || echo "No tasks scheduled."
    echo "-----------------------------"
}
```
This function shows the user all the tasks they have scheduled.
-   `crontab -l`: This is the command to **list** all the current cron jobs.
-   `|`: This is the "pipe" operator. It sends the output of the command on its left to the input of the command on its right.
-   `grep -v '^#'`: This filters the list. `grep` searches for patterns. The `-v` inverts the search, so it shows lines that *don't* match the pattern. `'^#'` is the pattern, which means "lines that start with the `#` character" (which are comments). So, this command removes all the comment lines.
-   `nl`: This command takes the filtered list and adds **line numbers** to the beginning of each line. This makes it easy for the user to pick a task to remove later.
-   `|| echo "No tasks scheduled."`: This is a bit of error handling. If `crontab -l` fails (which it does if there are no jobs), the part after `||` (OR) is executed, printing a friendly message.

### The `add_task` Function
```bash
add_task() {
    echo "Enter the command to be scheduled:"
    read command
    # ... prompts for schedule ...
    read schedule
    (crontab -l 2>/dev/null; echo "$schedule $command") | crontab -
    echo "Task added successfully!"
}
```
This is where the magic of adding a new task happens.
-   `read command` and `read schedule`: These lines pause the script and wait for me to type something and press Enter. The text is stored in the `command` and `schedule` variables.
-   `(crontab -l 2>/dev/null; echo "$schedule $command") | crontab -`: This is the most important line. Let's break it down from the inside out:
    -   `crontab -l 2>/dev/null`: It first tries to list the existing cron jobs. The `2>/dev/null` part is important; it suppresses the "no crontab for user" error message if the file is empty, keeping the output clean.
    -   `;`: This is a command separator. It says "run the first command, and when it's done, run the next one."
    -   `echo "$schedule $command"`: This prints the new schedule and command that I entered.
    -   `(...)`: The parentheses group these two commands together. So, the output of this whole group is the *entire old crontab* followed by the *new line for the new task*.
    -   `| crontab -`: This pipes the combined output (old jobs + new job) directly into the `crontab` command. The `-` tells `crontab` to read its new contents from the standard input (which is coming from the pipe) instead of from a file. This is a safe way to add a job without accidentally deleting the old ones.

### The `remove_task` Function
```bash
remove_task() {
    list_tasks
    # ... checks if there are tasks and prompts for a number ...
    read task_number
    # ... input validation ...
    crontab -l | grep -v '^#' | sed "${task_number}d" | crontab -
    echo "Task #$task_number removed successfully!"
}
```
This function safely removes a specific task.
-   First, it calls `list_tasks` so I can see a numbered list of what I can remove.
-   It then asks for the number of the task I want to delete.
-   `crontab -l | grep -v '^#' | sed "${task_number}d" | crontab -`: This is another powerful pipeline.
    -   The first two parts are the same as in `list_tasks`, getting a clean list of the jobs.
    -   `sed "${task_number}d"`: This is the core of the removal. `sed` is the stream editor. The `d` command in `sed` means "delete the line." So, `${task_number}d` tells `sed` to delete the line whose number matches the number I entered.
    -   `| crontab -`: Just like in the `add_task` function, the output (which is now the original list *minus* the one line I deleted) is piped back into the `crontab` command to become the new list of jobs.

### The Main Menu Loop
```bash
while true; do
    # ... prints the menu options ...
    read choice

    case $choice in
        1) list_tasks ;;
        2) add_task ;;
        3) remove_task ;;
        4) exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
```
This is what runs the whole script.
-   `while true; do ... done`: This creates an infinite loop, so the menu will keep showing up after each action until I explicitly choose to exit.
-   `case $choice in ... esac`: This is a cleaner way of writing multiple `if/elif/else` statements in Bash. It looks at the value of the `choice` variable and executes the code corresponding to that value (1, 2, 3, or 4).
-   `*)`: This is the "wildcard" or default case. If I enter anything other than 1, 2, 3, or 4, it will print an error message.
-   `exit 0`: This command terminates the script. The `0` is an exit code that signifies success.

I hope this detailed walkthrough was helpful! It was a really fun project to build and a great way to practice my DevOps fundamentals.
