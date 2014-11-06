
# Rebasing is one of the two methods
# for integrating changes from one branch into another.
# Merging and rebasing lead to the same snapshot result;
# the only difference being that rebasing leads to a *cleaner history*.

# checkout a new branch
git checkout -b experiment

# do some work on it
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

# lets rebase master onto experiment
git checkout experiment
git rebase master 

git log --oneline --graph  -8

# now lets merge experiment into master
git checkout master
git merge experiment