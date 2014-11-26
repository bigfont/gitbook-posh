# reset and checkout

## the three trees

- tree here is 'collection of files'
- HEAD, Index, Working Directory
- HEAD is the snapshot of your last commit
-- git cat-file -p HEAD
-- git ls-tree -r HEAD
- index is your proposed next commit
-- git ls-files -s
- working directory is your sandbox
-- tree /f /a

# The Workflow

- git init, HEAD points to master, an unborn branch
- git add, git copies working dir contents to index, master is still empty
- git commit, git creates a permanent snapshot, master points to it
- HEAD, index, and working directory are equal
- git status now shows nothing, b/c all three have the same contents!
- 'changes not staged for commit' means a diff b/w working dir and index
- 'changes to be committed' means a diff b/w index and HEAD

# git checkout

1. move HEAD to a new branch/commit (move HEAD)
2. update index with the contents of the new HEAD
3. update working dir with the contents the new HEAD

- so, git status will show nothing after a checkout
- because HEAD, index, and working directory will be the same

- checkout points HEAD at a new ref
- HEAD --> ref (e.g. master) --> commit
- checkout moves HEAD
- reset moves the ref

# git reset

1. move the branch that HEAD points to (move branch) [--soft]
- this undid the git commit
- git status will show 'changes to be committed'

2. update index with the contents of the new HEAD [--mixed | default]
- this undid the git add
- git status will show 'changes not staged for commit' 

3. update working directory with the contents of the new HEAD [--hard]
- this undid our sandbox changes
- if we had previously committed them, we could recover with the reflog

# Reset with a Path

- 