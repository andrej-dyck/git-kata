# Amending pushed commits

We just forget something that belongs to the last commit we made like in [exercise 101](../101-local-amend-commit/Readme.md). Unfortunately, we already pushed
the commit. We can still
use [`git commit --amend`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) to fix our mistakes
and with
[`git push --force`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force) overwrite the branch on origin.

## Exercise

Fix the mistakes that made into the pushed commit by amending the local last commit and force pushing to origin.

_Bonus_: Change the commit message to `"Add greeting to Git"`