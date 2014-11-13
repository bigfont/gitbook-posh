git commit --amend
-avoid if you've already pushed
-change the commit message, or
-change the snapshot with `add` or `rm`
-warning: is a mini-rebase, changes the SHA

git rebase -i
-supply the parent of the last commit you want to edit

filter-branch
- changing email globally
-remove file from every commit
-avoid using for pushed files
-`--tree-filter` checks out each commit, changes it, then recommits the results
-`--subdirectory-filter` works on directories and implies remap to ancestor
-`--commit-filter` rewrites commit properties such as GIT_AUTHOR_NAME
-git filter-branch --tree-filter 'some git command' HEAD
-use --all to run on all branches
