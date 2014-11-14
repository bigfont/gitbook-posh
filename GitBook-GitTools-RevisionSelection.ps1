
* SHA-1
** use `git show someLargeSHA`
* Short SHA
** at least four characters
** unambiguous
** use `git show 54T5` for example
** use `git log --abbrev-commit` to see short SHAs
* Branch References
** branch names poin tto specific commits
** use `git show someBranch`
** use `git rev-parse someBranch` to see its SHA
* Reflog Shortnames
** the Reflog is a few month history of where HEAD and each branch has been
** view it via `git reflog`
** use `git show HEAD@{7}
** times work also `git show master{yesterday}`
** use `git log -g` to view the reflog in git log format
** the reflog is entirely local... git never pushes it
* Ancestry References
** HEAD^ means 'the firt parent of HEAD'
** HEAD^2 means 'the second parent of HEAD'
** note: parent does not mean ancetor; it means direct parent
** HEAD~ is equivalent to HEAD^
** HEAD~2 means 'the grandparent of HEAD'
** HEAD^^ is equivalent to HEAD~2
** HEAD~3^2 means 'the grandparent of the third parent of HEAD'
* Commit Ranges
** Double Dot
*** what's in experiment that isn't in master
*** `git log master..experiment`
*** what's in master that isn't in experiment
*** `git log experiment..master`
*** what's in HEAD that isn't in the remote (what am I about to push?)
*** `git log origin/master..HEAD`
*** the head is implied so `git log origin/master..` is the same
** Multiple Points
*** three equivalent commands
*** `git log refA..refB`
*** `git log ^refA refB`
*** `git log refB --not refA
*** what is reachable from refA and refB but not from refC?
*** `git log refA refB ^refC
** Triple Dot
*** What is reachable by either branch but not both? I.e. XOR
*** `git log master...experiment`
*** add the `--left-right` switch for indicators
