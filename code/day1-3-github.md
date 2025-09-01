# Day 1 Self‑Study: Very Basic Git & GitHub Companion

Imagine your project folder is a time series of states:
- Git lets you save labelled snapshots (commits) you can roll back to.
- GitHub is the online backup + sharing site.
Benefits: (1) Safety (can undo), (2) Transparency (history), (3) Collaboration (share & review), (4) Reproducibility (exact code at each stage).
You will use only a *small* subset of Git.


## 1. One-Time Setup
1. Install Git
   - macOS: Likely already installed. If prompted, allow Xcode Command Line Tools. (Alternative: Homebrew: `brew install git`)
   - Windows: Install Git for Windows: https://git-scm.com/download/win (accept defaults). You get "Git Bash" (a terminal) – use it for these commands.
2. Create a GitHub account: https://github.com
3. Tell Git who you are (do this once):
```
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
(Use the same email you added to GitHub.)
Check it worked:
```
git config --list 
```

## 2. Your First Local Repository 
Pick or create a new practice folder (NOT an existing complicated project):
```
mkdir git-practice
cd git-practice
git init        # turns this folder into a repository
```
You just created a hidden folder `.git` that stores history.

Create a simple file (choose one you relate to):
```
echo "# Research Notes" > NOTES.md   # macOS / Linux / Git Bash
```
(Windows PowerShell alternative: `echo "# Research Notes" | Out-File -Encoding utf8 NOTES.md`)

Check status (what changed since last commit):
```
git status
```
Add the file to the staging area (a waiting room):
```
git add NOTES.md
```
Make (record) your first snapshot with a message:
```
git commit -m "Add initial NOTES file"
```
View history:
```
git log --oneline
```
Edit the file (open in any editor, add a line like "Idea about dataset X"). Then:
```
git status
git diff          # see the exact changes (press q to quit if pager opens)
git add NOTES.md
git commit -m "Add dataset X idea"
```
Repeat this cycle: Edit -> status/diff -> add -> commit.


## 3. Basic Mental Model
- Working Directory: your actual files.
- Staging Area: what you intend to include in the *next* commit (`git add`).
- Commit: a permanent labelled snapshot.
- Remote (origin): the GitHub copy.

Only what you `git add` gets saved in the commit.

## 4. Very Small Branch Example
Why a branch? To try something without touching the main line yet.
Create a branch and switch to it in one step:
```
git switch -c idea/new-section
```
Edit `NOTES.md`, then:
```
git add NOTES.md
git commit -m "Draft new section"
git push -u origin idea/new-section
```
On GitHub you will see a prompt to "Compare & pull request" – click it, review the diff (changed lines), then "Merge". Afterwards locally:
```
git switch main
git pull
```
Delete the old branch (cleanup):
```
git branch -d idea/new-section
```
You can ignore branching until comfortable.

## 5. Ignoring Unwanted Files
Create a `.gitignore` file so you do not accidentally commit large data or temporary stuff:
```
.Rhistory
.Rproj.user/
.DS_Store
*.log
__pycache__/
*.pyc
data/
```
Add & commit it early:
```
git add .gitignore
git commit -m "Add .gitignore"
```
