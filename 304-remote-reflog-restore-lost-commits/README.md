# 304 Restore Lost Commits with Git-reflog

🚧 WIP (this exercise isn't done yet)

TODO Git command, its purpose, and how we can use it to develop a clean git history.

For example, when you use [rebase](https://git-scm.com/docs/git-rebase) or a hard [reset](https://git-scm.com/docs/git-reset), your local commits are removed from the history.
Fortunately, nothing is ever lost with Git (well, almost nothing).
Git even provides a possibility to restore _lost_ commits[^1].
To this end, [`git reflog`](https://git-scm.com/docs/git-reflog) can show us the scrapped commits, and we can then use tools like [cherry-picking](https://git-scm.com/docs/git-cherry-pick), [branching](https://git-scm.com/docs/git-branch) or [git-reset](https://git-scm.com/docs/git-reset) to restore those.

[^1]: Git only knows the scrapped commits within your local repository; it's like a local history.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

TODO current state of the project.

## Task: [Task Title]

TODO this exercise's task

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after `init.sh`
```
_Note_: ...

### Target Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after exercise is done
```
_Note_: ...
