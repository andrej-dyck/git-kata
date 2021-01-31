# Interactive rebase - Modify commits

There are situations, where we need to make changes to earlier commits, and it's easier to do so when the previous state is restored. We can use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) to _edit_ commits.

![](../resources/main-feature-modify.svg)

## Exercise

In this exercise, we realize that we need `Double` as type for `Fuel` and `Mass`. Further `inKg` is a better attribute name than `amount`. Modify the commit where those types were introduced using interactive rebase and resolve the resulting conflict in the work-in-progress commit (also resolving its WIP state; thus, reword the commit message).