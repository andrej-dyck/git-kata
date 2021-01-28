# Undo last pushed commits

Sometimes we need to push changes that are temporary, e.g., work-in-progress (WIP) commits, when we want to "save" our
days work or change workstations. We can
use [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) to undo our last commit
locally, and with
[`git push --force`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force) overwrite the branch on
origin.

## Exercise

In this exercise, we pushed an unfinished implementation of `Greeting` with the commit `WIP`. Undo this commit, finish the TODO, and push the changes to origin.

_Bonus_: Change the commit message to `"Add greeting to Git"`