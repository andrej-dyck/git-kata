# Interactive rebase -  Re-writing history at origin with conflicts

Like in [exercise 205](../205-remote-interactive-rebase/Readme.md), we worked on the feature in a non-linear fashion. To bring our Git history in order, we can use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i). However, sometimes you might have conflicts during your interactive rebase. 

Once we have a clean history, use [`git push --force`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force) to overwrite the branch's history on origin.

## Exercise

In this exercise, we worked on the minimal fuel requirements feature and pushed the changes to origin like in [exercise 205](../205-remote-interactive-rebase/Readme.md). However, in the beginning, we chose `amount` as the attribute name for `Fuel` and `Mass`. We realized during a code review that `inKg` would be a better name. Use interactive rebase to achieve a clean history and make it so that `amount` was never chosen.

_Note_: You'll probably encounter conflicts.

_Hint_: Don't forget to remove the temporary main.

