﻿cd C:\Users\BigFont\Documents\GitHub\practice-repo

# maintenance
# -------------------
cls

# normally auto gc does nothing
# other times, it runs gc
git gc --auto
dir .git/refs -Recurse -File

# after running gc, .git/refs will be empty
# because git will have put the refs into .git/packed-refs
git gc
dir .git/refs -Recurse -File
cat .git/packed-refs 

# data recovery
# --------------------
cls
git log --pretty=oneline -10

# make some changes and commits
# then roll the branch back via a hard reset

git reset --hard 15f57
git log --pretty=oneline -5

# oops, we've lots some commits that we want
# lets find them

git reflog
git log -g -5

# now that we've found them, lets recover
git branch recovery-branch 54e0f30
git log --pretty=oneline recovery-branch -5

# but if we delete the recover-branch
# and we delete reflogs, 
# then the reflog will be empty 
git branch -D recovery-branch
rm -r -force .git/logs

# then we must use a database integrity check
# to recover the lost commits
# because it will display our "dangling commits"
# and we can recover from there
git fsck --full
git branch recovery-branch2 54e0f
git log --pretty=oneline recovery-branch2 -5

# removing objects
# -------------------------

# note: the removing object process is destructive to commit history
# it rewrites every commit object since the earliest tree you have to modify
# and other contributors might have to rebase onto the new commit

# add a massive tarball
curl http://kernel.org/pub/software/scm/git/git-1.8.2.3.tar.gz -OutFile git4.tgz
git add git4.tgz
git commit -m "Added git tarball again.";

# remove the tarbal from the working tree
git rm git.tgz
git commit -m "oops - removed large tarball."

# do garbage collection to see how much space we're using
# the git rm didn't remove the large file from our history
git gc
git count-objects -v

# lets find the large file by first inspecting the pack
dir -Recurse .git/objects/pack

# then sorting the idx to find the large blob
# -------------------------------

# put the idx file into $vp
$idx = ".\.git\objects\pack\pack-e3aa4ad72d76e52dc538d6d8c9e3de95b523957f.idx"
$vp = git verify-pack -v $idx

# remove the summary values that have a colon in their string
$vp = $vp | where { $_ -notlike "*:*" }

# make into 2x tab separated values for consistency and readability
# because its currently space separated with sometimes one and sometimes three spaces
$vp = $vp -replace "\s{1,}", "`t`t" 

# sort and select
$vp = $vp | sort { [int]($_ -split "`t`t")[2] }
$vp | select -Last 3

# then
git rev-list --objects --all | where { $_ -like '438e5*' }


# then
git filter-branch --index-filter 'git rm --cached --ignore-unmatch git.tgz'
rm -Recurse -Force .\.git\refs\original
rm -Recurse -Force .git\logs
git gc
git count-objects -v
git prune --expire '2014-10-30'