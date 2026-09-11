# 203 Rebase a Pushed Branch onto `main`

To keep a linear history, we want to [rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) our branch onto `main` before integrating it (cf. [exercise 104](../104-local-rebase-onto-main/README.md)).

Since [`git rebase`](https://git-scm.com/docs/git-rebase) re-writes the Git history, the branch will diverge from `origin` when it has already been pushed to the remote repository.
A Git client typically shows something similar to `↓2 ↑4`.

![](../resources/main-feature-out-of-sync-origin-after-rebase.svg)

A common **mistake** users new to _Git rebase_ make is to use `git pull` or `git merge`.
Both actions result in either overwriting our changes or a messy history with a _merge commit_.

To publish our changes and update the remote repository, we need to use [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) to overwrite the branch on `origin`.

_Note_: Two issues can arise when working with _force pushes_:
1. We may accidentally overwrite a remote branch that we did not intend to overwrite.
   Thus, it's recommended to protect `main` from history rewrites.
2. Other collaborators might have already pulled the remote branch and worked on it.
   We will discuss how to collaborate with others in [exercise 205](../205-remote-rewriting-history-with-teammates/README.md).

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 201](../201-remote-amend-commit/README.md) and [202](../202-remote-undo-last-commits/README.md), we successfully installed all of our _living-room devices_ and finished implementing an automation rule for the _living room lights_.

It's time to integrate our feature branch; however, `main` has advanced in the meanwhile.

## Task: Rebase Branch onto `main` and Force-Push Changes

While we were working on the light automation, our team integrated further changes to `main`.

To finalize our branch, we want to integrate the changes of `main` into our branch `living-room-light-automation` using [`git rebase`](https://git-scm.com/docs/git-rebase).
During the rebase, we probably will encounter conflicts.

Since we already pushed our branch, use `git push --force-with-lease` to overwrite the remote branch with the cleaned-up history.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
| * c26c0d5 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
| * 320820f define automation-rules schema
| * 9ac7d52 define living-room-light trait on-off
| * b7fab4d install living-room ambient-light sensor
| * ab6e9f2 install living-room presence sensor
|/
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Note_: Notice how `"install living-room AC"` and `"define living-room-light trait on-off"` both make changes to `devices.schema.json`. Further, `"define automation-rules schema"` on `main` was _cherry-picked_ from `living-room-light-automation`.

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* f1c0b20 (HEAD -> living-room-light-automation) automate living-room light
* 1b2180b define living-room-light trait on-off
* 1e56542 install living-room ambient-light sensor
* 3a3605f install living-room presence sensor
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
| * c26c0d5 (origin/living-room-light-automation) automate living-room light
| * 320820f define automation-rules schema
| * 9ac7d52 define living-room-light trait on-off
| * b7fab4d install living-room ambient-light sensor
| * ab6e9f2 install living-room presence sensor
|/
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Note_: A Git client typically shows something similar to `↓5 ↑8` for this graph.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* f1c0b20 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* 1b2180b define living-room-light trait on-off
* 1e56542 install living-room ambient-light sensor
* 3a3605f install living-room presence sensor
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Note_: Notice how `"define living-room-light trait on-off"` doesn't have any changes to `devices.schema.json` anymore, and that `"define automation-rules schema"` is removed from `living-room-light-automation`.
