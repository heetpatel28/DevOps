#!/bin/bash

# A simple task scheduler using cron

# Function to list scheduled tasks
list_tasks() {
    echo "--- Current Scheduled Tasks ---"
    # crontab -l lists the current cron jobs for the user
    # grep -v '^#' filters out lines that start with # (comments)
    # nl adds line numbers for easy selection
    crontab -l | grep -v '^#' | nl || echo "No tasks scheduled."
    echo "-----------------------------"
}

# Function to add a new task
add_task() {
    echo "Enter the command to be scheduled:"
    read command

    echo "Enter the schedule (e.g., '*/1 * * * *' for every minute, '0 0 * * *' for daily at midnight):"
    echo "Common schedules:"
    echo "  - Every minute: */1 * * * *"
    echo "  - Hourly (at minute 0): 0 * * * *"
    echo "  - Daily (at midnight): 0 0 * * *"
    echo "  - Weekly (Sunday at midnight): 0 0 * * 0"
    echo "  - Monthly (1st day at midnight): 0 0 1 * *"
    read schedule

    # (crontab -l ; echo "$schedule $command") pipes the current crontab and the new command
    # into a new crontab.
    # The 2>/dev/null suppresses the "no crontab for user" error if the crontab is empty.
    (crontab -l 2>/dev/null; echo "$schedule $command") | crontab -
    echo "Task added successfully!"
}

# Function to remove a task
remove_task() {
    list_tasks
    if [ "$(crontab -l | grep -v '^#' | wc -l)" -eq 0 ]; then
        return
    fi
    echo "Enter the number of the task to remove (or 0 to cancel):"
    read task_number

    # check if input is a number
    if ! [[ "$task_number" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Please enter a number."
        return
    fi
    
    if [ "$task_number" -eq 0 ]; then
        echo "Removal cancelled."
        return
    fi

    # crontab -l | grep -v '^#' lists non-comment lines
    # sed "${task_number}d" deletes the line specified by the user
    # The result is then loaded as the new crontab
    crontab -l | grep -v '^#' | sed "${task_number}d" | crontab -
    echo "Task #$task_number removed successfully!"
}

# Main menu loop
while true; do
    echo ""
    echo "Task Scheduler Menu"
    echo "1. List Scheduled Tasks"
    echo "2. Add a New Task"
    echo "3. Remove a Task"
    echo "4. Exit"
    echo "Please enter your choice:"
    read choice

    case $choice in
        1)
            list_tasks
            ;;
        2)
            add_task
            ;;
        3)
            remove_task
            ;;
        4)
            echo "Exiting."
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
done
