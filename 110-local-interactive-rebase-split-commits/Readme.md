# Interactive rebase - Split commits

Sometimes we committed too many changes in one commit. If that's the last commit, we could undo the last commit. However, if it's any of the earlier commits,

![](../resources/main-feature-before-split.svg)

we can use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) to _split_ those.

![](../resources/main-feature-splitted.svg)

## Exercise

In this exercise, we accidentally committed the _RocketFuel_ readme with the types. Split this commit into two.
