# Section 6: Enforcing Professional Workflows with Branch Protection

Having a working "Pipeline as Code" is great, but it's only half the battle. If developers can bypass the process, its value diminishes. This section was all about closing those gaps by defining and enforcing a professional development workflow. I learned how to protect my most important branch (`main`) and ensure that every code change goes through a rigorous, automated, and peer-reviewed quality gate.

## Table of Contents
- [1. Choosing a Strategy: Branching Models](#1-choosing-a-strategy-branching-models)
- [2. The Goal: Implementing Trunk-Based Development](#2-the-goal-implementing-trunk-based-development)
- [3. The Tool: GitHub Branch Protection Rules](#3-the-tool-github-branch-protection-rules)
- [4. Testing the Rules: The Correct Workflow](#4-testing-the-rules-the-correct-workflow)
- [5. The Human Element: Mandating Code Reviews](#5-the-human-element-mandating-code-reviews)
- [6. Merging with Confidence](#6-merging-with-confidence)

---

### 1. Choosing a Strategy: Branching Models

How a team manages its code branches has a massive impact on its workflow. I explored two common models:

-   **Git Flow:** A very structured but complex model with multiple long-running branches (`master`, `develop`, `release/*`, `hotfix/*`). While it offers a lot of control, it can lead to complicated merges and a slower release cadence.
-   **Trunk-Based Development (TBD):** A simpler, more modern model. It has a single primary branch (the "trunk," e.g., `main`), and all developers work on short-lived feature branches that are merged into the trunk frequently. This model is what I chose to implement because it promotes true continuous integration.

---

### 2. The Goal: Implementing Trunk-Based Development

To properly implement TBD, I needed to enforce a set of policies to protect the trunk (`main` branch). The rules are:

1.  **Lock the Trunk:** No one should be able to push code directly to the `main` branch.
2.  **Use Short-Lived Branches:** All new work (features, bug fixes) must happen on a separate branch.
3.  **Mandate Pull Requests (PRs):** The only way to get code into `main` is through a Pull Request.
4.  **Enforce CI Checks:** The Jenkins pipeline must run and pass successfully for every PR.
5.  **Require Code Reviews:** At least one other team member must review and approve the changes.

Only when all these conditions are met can the code be merged.

---

### 3. The Tool: GitHub Branch Protection Rules

GitHub provides the perfect feature to enforce these policies. I navigated to my repository's `Settings > Branches` and created a new "branch protection rule".

Here’s how I configured it for my `main` branch:

-   **Branch name pattern:** `main` - This tells GitHub which branch to protect.
-   **Require a pull request before merging:** This is the cornerstone of the workflow. It disables direct pushes and forces all changes to go through the PR process.
-   **Require approvals:** I set this to `1`. This means at least one reviewer must formally approve the PR before it can be merged.
-   **Require status checks to pass before merging:** This is the critical integration point with Jenkins. I checked this box and selected my Jenkins pipeline job from the list. Now, GitHub will physically block the merge button until Jenkins reports a "success" status.
-   **Do not allow bypassing the above settings:** I enabled this to ensure the rules apply even to me as the repository administrator. This prevents accidental mistakes.
---

### 4. Testing the Rules: The Correct Workflow

With the rules in place, I tested the new, enforced workflow. The old way of pushing directly to `main` now results in an error: `(protected branch hook declined)`.

This is the new, correct process:

1.  **Create a Branch:** From my local machine, I created a new branch for my change: `git checkout -b readme-update`.
2.  **Make & Commit Changes:** I made my changes, then committed them to my new branch.
3.  **Push the Branch:** I pushed the feature branch to the remote repository: `git push origin readme-update`.
4.  **Open a Pull Request:** On GitHub, a prompt appeared to create a PR from my new branch. I opened the PR, targeting the `main` branch as the base.

Immediately, the PR status showed that merging was **blocked**. It was waiting for two things: the Jenkins status check to complete and a code review to be approved.

---

### 5. The Human Element: Mandating Code Reviews

To satisfy the review requirement, I had to simulate a team environment.

1.  **Add a Collaborator:** First, I needed someone to do the review. In a real team, this would be a coworker. For this lab, I created a second GitHub account. I then went to my main repository's `Settings > Collaborators` and invited my second account.
2.  **Accept the Invitation:** I logged into my second account and accepted the collaborator invitation.
3.  **Request a Review:** Back on my primary account, I went to my open PR and assigned my second account as a "Reviewer".
4.  **Perform the Review:** Finally, I logged in as the reviewer. I navigated to the PR, examined the "Files changed," and submitted an "Approve" review.

---

### 6. Merging with Confidence

Once the reviewer approved the PR, and the Jenkins CI job finished with a green checkmark, the status on the PR changed. All checks had passed, and the "Merge pull request" button turned green and became clickable.

I could now merge the changes, confident that they had been both machine-tested (by Jenkins) and human-reviewed. After merging, I also used the option to delete the now-unnecessary feature branch, keeping the repository clean. This entire process enforces quality and safety, forming the backbone of a professional CI/CD workflow.
 