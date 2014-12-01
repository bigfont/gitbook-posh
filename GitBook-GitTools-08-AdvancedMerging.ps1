
- in git, it's best to merge often to avoid conflicts
- git does not try to auto-merge funky conflicts

# merge conflicts

**To work with the example first turn off autocrlf locally**

git config --local core.autocrlf false

1. create ruby file with initial content
2. commit in master
3. switch to whitespace
4. convert from unix to dos
5. commit
6. change world to mondo
7. commit
8. switch to master
9. document the ruby
0. commit on master
1. try to merge in whitespace to master
