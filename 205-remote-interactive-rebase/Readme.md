# Interactive rebase - Re-writing history at origin 

Often our workflow is not linear. So we commit changes that we think are worthy of a commit, fix something, or just to
have something to fall back to. Since we want to have a clean history, we can
use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i)
to _refactor_ our history, and then, with
[`git push --force`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force) overwrite the branch's
history at origin.

## Exercise

In this exercise, we worked on the minimal fuel requirements feature and pushed the changes to origin (e.g., because we
went on a break). Now we finished the functionality and added the missing link to the readme (un-committed changes).
Our last step, is to bring our history in order. Use interactive rebase to achieve a clean history.

_Hint_: Don't forget to remove the temporary main.

