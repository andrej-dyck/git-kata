# Commit changes

Git tracks changes to a file rather than the file itself. So, when we stage a file, we actually stage every change
within a file. Git allows us to stage the differences in the files separately with
[`git add -p`](https://git-scm.com/docs/git-add#Documentation/git-add.txt-patch), and thus, separate the changes into
different commits.

## Exercise

Like in the previous exercise, we forgot to fix some mistakes. This will be our first patch (set of changes) to commit; e.g., `Fix greeting mistake`. 

However, we also went ahead and extracted the main. This should be our second commit

_Bonus_: Amend the "fix" patch to the previous commit.