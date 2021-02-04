# Restore lost commits with Git-reflog

For example, when you use [rebase](https://git-scm.com/docs/git-rebase) or a hard [reset](https://git-scm.com/docs/git-reset), your local commits are removed from the history. Fortunately, nothing is ever lost with Git (well, almost nothing). Git even provides a possibility to restore _lost_ commits _^1_. To this end, [`git reflog`](https://git-scm.com/docs/git-reflog) can show us the scrapped commits, and we can then use tools like [cherry-picking](https://git-scm.com/docs/git-cherry-pick), [branching](https://git-scm.com/docs/git-branch) or [git-reset](https://git-scm.com/docs/git-reset) to restore those.

_^1_ Git only knows the scrapped commits within your local repository; it's like a local history.

## Exercise

In this exercise, we already worked on the rocket fuel estimation and committed some code. Like in [exercise 203](../203-remote-rebase-onto-main/Readme.md), we wanted to rebase onto main, but something is wrong and now our commits seem to be lost. Restore your commits with [git-reflog](https://git-scm.com/docs/git-reflog) and [cherry-pick](https://git-scm.com/docs/git-cherry-pick) and push your `feature` branch as intended.

_Bonus_: Use [git-reset](https://git-scm.com/docs/git-reset) to restore the _old_ branch and rebase onto master again.