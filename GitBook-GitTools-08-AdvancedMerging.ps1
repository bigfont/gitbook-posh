
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

- `git merge --abort`
- we can only do this w/ a clean working dir

## ignoring whitespace

## manual file re-merging

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