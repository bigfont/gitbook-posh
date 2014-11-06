
# Rebasing is one of the two methods
# for integrating changes from one branch into another.
# Merging and rebasing lead to the same snapshot result;
# the only difference being that rebasing leads to a *cleaner history*.


# checkout a new branch
git checkout -b rebase-me

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
git log --oneline --graph --branches master rebase-me -8

# lets rebase master onto rebase-me
git checkout rebase-me
git rebase master 

git log --oneline --graph  -8

# now lets merge rebase-me into master
git checkout master
git merge rebase-me