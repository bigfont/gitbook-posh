 
# Rebasing is one of the two methods
# for integrating changes from one branch into another.
# Merging and rebasing lead to the same snapshot result;
# the advantage to rebasing is a *cleaner history*.

# the basic rebase
# ---------------------------

# checkout a new branch
git checkout -b experiment

# do some work
ni -t f work.txt
ac work.txt "This is some work."
git add work.txt
git commit -m "Do some work."

ac work.txt "This is some more work."
git add work.txt
git commit -m "Do some more work."

# do some parallel work on master
git checkout master

ni -t f bugfix.txt
git add bugfix.txt
git commit -m "Do a quick bugfix."

# the branches have diverged
git log --oneline --graph master experiment -8

# rebase master onto experiment
git checkout experiment
git rebase master 

git log --oneline --graph  -8

# merge experiment into master
git checkout master
git merge experiment

# we're clean
git log --oneline --graph master experiment -8

# more interesting rebases
# ------------------------------

git checkout master

ni -t f master.txt
git add master.txt
git commit -m "C1"

ac master.txt "Some work on master."
git add master.txt
git commit -m "C2"

git checkout -b server

ni -t f server.txt
git add server.txt
git commit -m "C3"

ac server.txt "Some work on server."
git add server.txt
git commit -m "C4"

git checkout master

ac master.txt "Additional work on master."
git add master.txt
git commit -m "C5"

ac master.txt "Further work on master."
git add master.txt
git commit -m "C6"

git branch client e1edfdb # create a new branch from C3
git checkout client

ni -t f client.txt
git add client.txt
git commit -m "C8"

ac client.txt "Some work on client."
git add client.txt
git commit -m "C9"

git checkout server

ac server.txt "Some final work on server."
git add server.txt
git commit -m "C10"

# review the log to see where we are
git log --oneline --graph --all -12

# git rebase --onto <newbase> <upstream> <branch>
git rebase --onto master server client

<# 

 1. checkout <branch>
 2. temp save changes made by commits in <branch> that aren't in <upstream>
 3. reset the current branch to <newbase>
 4. apply the temp saved changes to <newbase> in order, one-by-one
<<<<<<< HEAD

Take the changes on the client branch
that are not on the server branch
and replay them onto master.

#>

# notice that master is now behind HEAD
git log --oneline --graph --all --decorate -12

# so we need to fast forward
git checkout master
git merge client

# git rebase <base> <topic>
git rebase master server

<#

Rebase the topic branch onto the base branch
without having to checkout the topic first.

1. checkout the topic branch
2. play it back onto the base branch

#>

# now fast forward
git checkout master
git merge server

# note the order of the commits on master
git log --oneline --graph --all --decorate -12

# remove the client and server branches
# because all their changes are now in master

git branch -D server
git branch -D client

# --------------------------------------------------------
# AVOID REBASING COMMITS THAT YOU'VE PUSHED (i.e THAT EXIST OUTSIDE YOUR REPOSITORY)
# --------------------------------------------------------

<# 

- Rebase abandons existing commits
- and creates new ones that are similar but different.
- If others have used those existing commits, 
- then merging gets messy and they'll hate you.

#>



# create a file, 
# commit and push
ni rebase-hell.txt -t f
git add rebase-hell.txt; 
git commit -m "RP1"
git push

# to mimic collaborating, 
# clone the current repo into a sibling directory
git clone git@github.com:bigfont/gitbook-posh.git ..\gitbook-posh2

# enter posh2
cd ..\gitbook-posh2

git log --oneline --decorate -1

ac .\rebase-hell.txt "Some work from posh2."
git add -A;
git commit -m "RP2";

ac .\rebase-hell.txt "Some more work from posh2."
git add -A; 
git commit -m "RP3";

git log --oneline --decorate -3

# return to original directory
cd ..\gitbook-posh

# do some more work
git checkout -b someBranch
ac .\rebase-hell.txt "Some work from original dir."
git add rebase-hell.txt
git commit -m "RP5"

git log --oneline -5

git checkout master
ac .\rebase-hell.txt "Some more work from original dir."
git add rebase-hell.txt
git commit -m "RP4"

git log --oneline --decorate -8

git merge someBranch

# fix merge conflicts
ii .\rebase-hell.txt
git add .\rebase-hell.txt
git commit --amend -m "RP6"

git log --oneline --graph --all --decorate -4

# push all branches
git push --all

# return to the other directory
cd ..\gitbook-posh2
git pull
git branch -r
git checkout origin/someBranch

git log --oneline --graph --decorate --all -6

git checkout master
git log --oneline --graph --decorate --all -6
git status
ii rebase-hell.txt
git add rebase-hell.txt
git commit -m "RP7"

<# 

master now looks like this
RP1 < RP2 < RP3 < RP7

origin/master looks like this
RP1 < RP4 < RP6

origin/someBranch looks like this
RP1 < RP5

#>

git log --oneline --graph --decorate -7

# switch back to the original dir to cause hell
# by rebasing instead of merging

cd ..\gitbook-posh
git log --oneline --graph --decorate --all -8

# roll back master
git reset --hard HEAD~1

git rebase someBranch master
git rebase --continue
git log --oneline --graph --decorate --all -8

ii rebase-hell.txt
git add rebase-hell.txt
git commit -m "RP4'"
git log --oneline --graph --decorate --all -6

git checkout master
git merge someBranch

git branch -D someBranch

git push --force

# switch directories
# then fetch and merge by doing a pull

cd ..\gitbook-posh2
git pull
git log --oneline --graph --decorate -10

# a way to work with this
# is to fetch and rebase instead of fetch and merge
# we can do that with `git pull --rebase`
# or with `git fetch; git rebase remote/branch;`
