 
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

git checkout master
git merge server
