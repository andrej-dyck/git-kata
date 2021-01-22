# Undo last commit(s)

Sometimes we commit changes that are temporary, e.g., work-in-progress (WIP), or we want to manually re-define what
changes the last commit comprises.
Here, [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) helps us to reset a
previous git-state while not discarding any subsequent changes.

## Exercise

In this exercise, we committed an unfinished implementation of `Greeting`. Undo the `WIP` commit, fix the TODO, and
commit the finished implementation with a good message.

_Bonus_: You might have realized that the `main` was committed before `Greeting`, and thus, the commit can't compile.
Reset also this commit and "fix" it such that the code compiles. The result should be two commits with: First, a simple
greeting in `main`. Second, the `main` using the finished `Greeting`.