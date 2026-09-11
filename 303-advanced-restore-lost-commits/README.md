# 304 Restore Lost Commits with Git-reflog

🚧 WIP (this exercise isn't done yet)

TODO Git command, its purpose, and how we can use it to develop a clean git history.

For example, when you use [rebase](https://git-scm.com/docs/git-rebase) or a hard [reset](https://git-scm.com/docs/git-reset), your local commits are removed from the history.
Fortunately, nothing is ever lost with Git (well, almost nothing).
Git even provides a possibility to restore _lost_ commits[^1].
To this end, [`git reflog`](https://git-scm.com/docs/git-reflog) can show us the scrapped commits, and we can then use tools like [cherry-picking](https://git-scm.com/docs/git-cherry-pick), [branching](https://git-scm.com/docs/git-branch) or [git-reset](https://git-scm.com/docs/git-reset) to restore those.

TODO [Data Recovery with Git-reflog](https://git-scm.com/book/en/v2/Git-Internals-Maintenance-and-Data-Recovery#_data_recovery)

[^1]: Git only knows the scrapped commits within your local repository; it's like a local history.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

TODO current state of the project.

## Task: [TODO Task Title]

TODO this exercise's task

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after `init.sh`
```
_Note_: TODO observations about the initial git history or remove note

### Pre-push Git History [TODO delete for local-only exercises]
```console
$ git log --oneline --graph --decorate --all
TODO git log output of intermediate graph before force push
```
_Note_: TODO observations about the pre-push git history or remove note

### Target Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after exercise is done
```
_Note_: TODO observations about the target git history or remove note
