# Git Commands Handbook

A comprehensive guide to essential Git commands for version control, complete with descriptions, real-world use cases, and practical examples.

## Table of Contents

- [Basic Git Commands](#basic-git-commands)
  - [git init](#1-git-init)
  - [git clone](#2-git-clone)
  - [git status](#3-git-status)
  - [git add](#4-git-add)
  - [git commit](#5-git-commit)
  - [git config](#6-git-config)
  - [git log](#7-git-log)
  - [git show](#8-git-show)
  - [git diff](#9-git-diff)
  - [git reset](#10-git-reset)
- [Branching and Merging](#branching-and-merging)
  - [git branch](#11-git-branch)
  - [git checkout](#12-git-checkout)
  - [git switch](#13-git-switch)
  - [git merge](#14-git-merge)
  - [git rebase](#15-git-rebase)
  - [git cherry-pick](#16-git-cherry-pick)
- [Remote Repositories](#remote-repositories)
  - [git remote](#17-git-remote)
  - [git push](#18-git-push)
  - [git pull](#19-git-pull)
  - [git fetch](#20-git-fetch)
- [Stashing and Cleaning](#stashing-and-cleaning)
  - [git stash](#21-git-stash)
  - [git stash pop](#22-git-stash-pop)
  - [git stash list](#23-git-stash-list)
  - [git clean](#24-git-clean)
- [Tagging](#tagging)
  - [git tag](#25-git-tag)
- [Advanced Commands](#advanced-commands)
  - [git bisect](#26-git-bisect)
  - [git blame](#27-git-blame)
  - [git reflog](#28-git-reflog)
  - [git submodule](#29-git-submodule)
  - [git archive](#30-git-archive)
  - [git gc](#31-git-gc)
- [GitHub-Specific Commands (using GitHub CLI)](#github-specific-commands-using-github-cli)
  - [gh auth login](#32-gh-auth-login)
  - [gh repo clone](#33-gh-repo-clone)
  - [gh issue list](#34-gh-issue-list)
  - [gh pr create](#35-gh-pr-create)
  - [gh repo create](#36-gh-repo-create)

---

## Basic Git Commands

### 1. `git init`
- **Description**: Initializes a new, empty Git repository in the current directory, creating a hidden `.git` folder to track changes.
- **Real-World Use Case**: This is the very first command you run when starting a new project that you want to put under version control.

**Examples**:
```bash
# Initialize a repository in an existing project folder
cd my-project
git init
# Create and initialize a new project directory at the same time
git init new-app
```

### 2. `git clone`
- **Description**: Creates a local copy of a remote repository that already exists on a server like GitHub.
- **Real-World Use Case**: When you want to contribute to an existing project or just get a copy of it on your machine to work with.

**Examples**:
```bash
# Clone a repository using HTTPS
git clone https://github.com/user/repo.git
# Clone a repository using SSH and give the local folder a custom name
git clone git@github.com:user/repo.git my-awesome-project
```

### 3. `git status`
- **Description**: Shows the current state of your working directory and staging area. It lets you see which files are modified, which are staged, and which are untracked.
- **Real-World Use Case**: You'll run this command constantly to check the status of your changes before adding and committing them.

**Examples**:
```bash
# Get a detailed status of the repository
git status
# Get a shorter, more compact status output
git status -s
```

### 4. `git add`
- **Description**: Adds changes from the working directory to the staging area. This prepares them to be included in the next commit.
- **Real-World Use Case**: After you've modified a file, you use `git add` to select that specific change to be saved in your next commit.

**Examples**:
```bash
# Stage a single file
git add index.html
# Stage all modified and new files in the current directory and subdirectories
git add .
```

### 5. `git commit`
- **Description**: Takes the staged snapshot of changes and permanently saves it to the project's history with a descriptive message.
- **Real-World Use Case**: After completing a logical unit of work (like fixing a bug or adding a feature), you commit the changes to create a save point.

**Examples**:
```bash
# Commit staged changes with a short message
git commit -m "Fix user login bug"
# Stage all tracked files and commit them in one step
git commit -am "Update documentation for new API endpoint"
```

### 6. `git config`
- **Description**: Sets configuration values for your name, email, preferred editor, and other Git settings.
- **Real-World Use Case**: The first thing you should do after installing Git is set your name and email, so your commits are properly attributed to you.

**Examples**:
```bash
# Set your name for all repositories on your machine
git config --global user.name "John Doe"
# Set your email for all repositories on your machine
git config --global user.email "john.doe@example.com"
```

### 7. `git log`
- **Description**: Displays the commit history of the current branch, showing who made changes, when, and with what message.
- **Real-World Use Case**: To review the recent history of a project, find a specific commit, or understand how a file has evolved.

**Examples**:
```bash
# Show the full commit history
git log
# Show a compact, one-line log with a graph of the branch structure
git log --oneline --graph --decorate
```

### 8. `git show`
- **Description**: Displays detailed information about a specific Git object, most commonly a commit.
- **Real-World Use Case**: To inspect the exact changes (the "diff") that were introduced in a single commit.

**Examples**:
```bash
# Show the details and changes of the most recent commit
git show HEAD
# Show the details of a specific commit by its hash
git show a1b2c3d4e5f6
```

### 9. `git diff`
- **Description**: Shows the differences between various states in Git, such as the working directory, staging area, and commits.
- **Real-World Use Case**: To review the line-by-line changes you've made to a file before you stage and commit them.

**Examples**:
```bash
# Show changes in the working directory that are not yet staged
git diff
# Show changes that are staged but not yet committed
git diff --staged
```

### 10. `git reset`
- **Description**: Unstages changes or resets the current branch to a previous commit, effectively undoing changes.
- **Real-World Use Case**: To remove a file from the staging area that you added by mistake, without losing the actual changes in the file.

**Examples**:
```bash
# Unstage a specific file, but keep the changes in your working directory
git reset HEAD README.md
# DANGEROUS: Discard all local changes and commits since the remote main branch
git reset --hard origin/main
```

---

## Branching and Merging

### 11. `git branch`
- **Description**: Lists, creates, or deletes branches. A branch is an independent line of development.
- **Real-World Use Case**: To create a new branch to work on a new feature, ensuring the main codebase remains stable.

**Examples**:
```bash
# List all local branches
git branch
# Create a new branch called "feature/user-profile"
git branch feature/user-profile
```

### 12. `git checkout`
- **Description**: Switches between branches or restores files from a specific commit. (Note: `git switch` and `git restore` are the modern, safer alternatives).
- **Real-World Use Case**: To move to your new feature branch to start working on it, or to switch back to the main branch.

**Examples**:
```bash
# Switch to an existing branch
git checkout feature/user-profile
# Create a new branch and switch to it in one command
git checkout -b hotfix/typo-fix
```

### 13. `git switch`
- **Description**: The modern, dedicated command for switching between branches.
- **Real-World Use Case**: The recommended way to change your active branch, as its purpose is clearer than the overloaded `git checkout`.

**Examples**:
```bash
# Switch to the main branch
git switch main
# Create a new branch and switch to it
git switch -c new-feature
```

### 14. `git merge`
- **Description**: Combines the changes from one branch into another.
- **Real-World Use Case**: After a feature is complete and tested on its branch, you merge it back into the `main` branch to integrate it into the project.

**Examples**:
```bash
# Switch to the main branch and merge the feature branch into it
git switch main
git merge feature/user-profile
# Abort a merge that has conflicts
git merge --abort
```

### 15. `git rebase`
- **Description**: Re-applies commits from one branch on top of another. This rewrites the project history to be more linear.
- **Real-World Use Case**: To update your feature branch with the latest changes from the `main` branch before merging, avoiding a messy merge commit.

**Examples**:
```bash
# Update the current branch with changes from main
git rebase main
# Interactively rebase the last 3 commits to edit, squash, or reorder them
git rebase -i HEAD~3
```

### 16. `git cherry-pick`
- **Description**: Applies a single, specific commit from one branch onto your current branch.
- **Real-World Use Case**: When you need to apply a critical bug fix from a development branch to your main production branch, without merging all the other unfinished features.

**Examples**:
```bash
# Apply a specific commit to your current branch
git cherry-pick a1b2c3d4
# Apply the last two commits from another branch
git cherry-pick other-branch~1..other-branch
```

---

## Remote Repositories

### 17. `git remote`
- **Description**: Manages the set of tracked remote repositories.
- **Real-World Use Case**: To add a connection to your remote repository on GitHub (usually named `origin`) after creating a repository locally.

**Examples**:
```bash
# List the names and URLs of all remote connections
git remote -v
# Add a new remote repository connection
git remote add origin https://github.com/user/repo.git
```

### 18. `git push`
- **Description**: Uploads your local branch commits to the corresponding branch on a remote repository.
- **Real-World Use Case**: After committing your changes locally, you `push` them to GitHub to share them with your team and to back them up.

**Examples**:
```bash
# Push the current branch to its upstream counterpart on the 'origin' remote
git push origin main
# Force a push (DANGEROUS: can overwrite remote history)
git push --force origin feature-branch
```

### 19. `git pull`
- **Description**: Fetches changes from a remote repository and immediately merges them into your current local branch. It's a combination of `git fetch` and `git merge`.
- **Real-World Use Case**: To update your local `main` branch with the latest changes that your teammates have pushed.

**Examples**:
```bash
# Fetch and merge changes from the 'main' branch on 'origin'
git pull origin main
# Fetch and rebase your local changes on top of the remote changes
git pull --rebase origin main
```

### 20. `git fetch`
- **Description**: Downloads commits, files, and refs from a remote repository into your local repo, but does not merge them.
- **Real-World Use Case**: To see what changes have been made on the remote repository without having to merge them into your local work just yet.

**Examples**:
```bash
# Fetch all changes from the 'origin' remote
git fetch origin
# Fetch changes from all of your registered remotes
git fetch --all
```

---

## Stashing and Cleaning

### 21. `git stash`
- **Description**: Temporarily saves your uncommitted local changes (both staged and unstaged) so you can get a clean working directory.
- **Real-World Use Case**: When you're in the middle of a feature but need to switch branches to fix an urgent bug. You can `stash` your work, fix the bug, and then come back.

**Examples**:
```bash
# Stash the current changes
git stash
# Stash the changes with a descriptive message
git stash save "Working on user profile form"
```

### 22. `git stash pop`
- **Description**: Applies the most recently stashed changes to your working directory and removes that stash from the list.
- **Real-World Use Case**: After you've switched back to your feature branch, you use `git stash pop` to get your work-in-progress back.

**Examples**:
```bash
# Apply the most recent stash and remove it from the list
git stash pop
# Apply a specific stash from the list (e.g., the second one)
git stash pop stash@{1}
```

### 23. `git stash list`
- **Description**: Displays a list of all your saved stashes.
- **Real-World Use Case**: When you have multiple stashes saved and need to see which one you want to re-apply.

**Examples**:
```bash
# List all stashes
git stash list
# Show the content summary of the most recent stash
git stash show
```

### 24. `git clean`
- **Description**: Removes untracked files from your working directory. This helps keep your project folder clean.
- **Real-World Use Case**: To get rid of build artifacts, log files, or other generated files that you don't want to commit to the repository.

**Examples**:
```bash
# Do a "dry run" to see which files would be removed
git clean -n
# Forcefully remove all untracked files and directories
git clean -fd
```

---

## Tagging

### 25. `git tag`
- **Description**: Creates a tag to mark a specific point in the repository's history, typically used for releases.
- **Real-World Use Case**: To create a permanent marker for a version release, like `v1.0.0`, so you can easily check out that version of the code later.

**Examples**:
```bash
# Create an annotated tag for a release
git tag -a v1.0 -m "Version 1.0 Release"
# Push all your local tags to the remote repository
git push origin --tags
```

---

## Advanced Commands

### 26. `git bisect`
- **Description**: Uses a binary search algorithm to automatically find the specific commit that introduced a bug.
- **Real-World Use Case**: When you discover a bug that wasn't present in an older version, `git bisect` is the fastest way to hunt down the exact commit that caused it.

**Examples**:
```bash
# Start the bisect process between a known bad commit (HEAD) and a known good one (v1.0)
git bisect start HEAD v1.0
# After starting, you test and mark commits as 'good' or 'bad'
git bisect good
git bisect bad
```

### 27. `git blame`
- **Description**: Examines the content of a file line by line and shows which commit and author last modified each line.
- **Real-World Use Case**: To find out who wrote a specific piece of code so you can ask them about it, or to understand the history of a particular function.

**Examples**:
```bash
# Show who last modified each line of a file
git blame README.md
# Show blame information for a specific range of lines
git blame -L 10,25 script.js
```

### 28. `git reflog`
- **Description**: Shows a log of all recent actions in the repository, including commits, resets, and branch switches. It's a local safety net.
- **Real-World Use Case**: To recover a branch or commit that you accidentally deleted with a command like `git reset --hard`.

**Examples**:
```bash
# Display the reference log
git reflog
# Show the reflog for a specific branch
git reflog show main
```

### 29. `git submodule`
- **Description**: Manages external repositories as subdirectories within your main repository.
- **Real-World Use Case**: When your project depends on another library, you can include it as a submodule to keep its version history separate but linked.

**Examples**:
```bash
# Add an external library as a submodule
git submodule add [https://github.com/user/library.git](https://github.com/user/library.git) external/library
# Initialize and update all submodules after cloning a project
git submodule update --init --recursive
```

### 30. `git archive`
- **Description**: Creates a zip or tar archive of the files in your repository at a specific commit.
- **Real-World Use Case**: To create a clean source code package for a release, without including the entire `.git` history folder.

**Examples**:
```bash
# Create a zip archive of the latest commit
git archive -o latest.zip HEAD
# Create a tar.gz archive from a specific tag
git archive --format=tar.gz -o release.tar.gz v1.0
```

### 31. `git gc`
- **Description**: Performs "garbage collection" on your local repository, cleaning up unnecessary files and optimizing its performance.
- **Real-World Use Case**: Git runs this automatically, but you can run it manually on very large or old repositories to save disk space.

**Examples**:
```bash
# Run garbage collection with default settings
git gc
# Run a more aggressive garbage collection now
git gc --prune=now --aggressive
```

---

## GitHub-Specific Commands (using GitHub CLI)

*Note: These commands require you to have the official [GitHub CLI](https://cli.github.com/) tool installed.*

### 32. `gh auth login`
- **Description**: Authenticates you with your GitHub account from the command line.
- **Real-World Use Case**: The first step to using the GitHub CLI, allowing you to interact with your GitHub account securely.

**Examples**:
```bash
# Start the interactive login process
gh auth login
# Check your authentication status
gh auth status
```

### 33. `gh repo clone`
- **Description**: A `gh` command to clone a repository from GitHub.
- **Real-World Use Case**: A convenient alternative to `git clone` that uses your authenticated `gh` session.

**Examples**:
```bash
# Clone a repository you own or have access to
gh repo clone my-repo
# Clone a repository from another user or organization
gh repo clone user/repo
```

### 34. `gh issue list`
- **Description**: Displays a list of issues for the current GitHub repository.
- **Real-World Use Case**: To quickly check the open issues for a project without having to open your web browser.

**Examples**:
```bash
# List open issues in the current repository
gh issue list
# List issues with a specific label
gh issue list --label "bug"
```

### 35. `gh pr create`
- **Description**: Creates a new pull request on GitHub from your current branch.
- **Real-World Use Case**: The command-line way to propose your changes for review after you've pushed your feature branch to GitHub.

**Examples**:
```bash
# Start an interactive process to create a pull request
gh pr create
# Create a pull request with a title and body directly
gh pr create --title "New Feature" --body "Adds a button to the main page."
```

### 36. `gh repo create`
- **Description**: Creates a new repository on GitHub.
- **Real-World Use Case**: To quickly create a new remote repository on GitHub for a project you've just started locally.

**Examples**:
```bash
# Create a new public repository on your GitHub account
gh repo create my-new-project --public
# Create a private repository and push your existing local code to it
gh repo create my-app --private --source=. --remote=origin
```
