
- in git, it's best to merge often to avoid conflicts
- git does not try to auto-merge funky conflicts

# merge conflicts

**To work with the example first turn off autocrlf locally**

git config --local core.autocrlf false

1. create ruby file with content
2. commit in master
3. switch to whitespace
4. convert from dos 2 unix (*)
5. commit
6. change world to mondo
7. commit
8. switch to master
9. document the ruby
0. commit on master
1. try to merge in whitespace to master
2. PROBLEM :-)

## aborting a merge

- `git status -sb` // short, branch
-- inspect, then either

- `git merge --abort` // this is WD safe
-- or

- `git reset --hard HEAD` // this is not WD safe

## ignoring whitespace

- `git merge -Xignore-all-space` // ignore all WS
- `git merge -Xignore-space-change` // [\s] == [\s+]

## manual file re-merging

### conflict stages

- stage1, common ancestor
- stage2, ours
- stage3, theirs

### inspect the indexes

- `git show :1:fileName.ext`
- `git show :2:fileName.ext`
- `git show :3:fileName.ext`

### get the SHAs

- `git ls-files -u` // -u is unmerged

### file merge

- `git merge-file [current] [base] [other] -p`
- the `-p` sends the result to stout

### doing a manual merge

- `git show :1:simple.rb > simple.common.rb`
- `git show :2:simple.rb > simple.ours.rb`
- `git show :3:simple.rb > siple.theirs.rb`
- `unix2dos simple.theirs.rb`
- `git merge-file -p simple.ours.rb simple.common.rb simple.theirs.rb`

## checking out conflicts

## merge log

## combined diff format

# undoing merges

## fix the references

## reverse the commit

# other types of merges

## ours or theirs preference

## subtree merging

## 