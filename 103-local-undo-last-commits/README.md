# 103 Undo Last Commit(s) with Soft-Reset

Sometimes we commit changes that are temporary, e.g., work-in-progress (_WIP_).
Sometimes we want to manually re-stage changes and separate commits.
Sometimes we include unrelated changes to a commit and want to undo this commit.

[`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) helps us to reset to a previous git-state while keeping all changes from those undone commits staged, so they can be recommitted.

So, unlike a _hard reset_, the changes are not lost; with `--soft`, they remain staged.
Read more about _Git reset_ in the article [Reset Demystified](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified).

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 101](../101-local-amend-commit/README.md) and [102](../102-local-commit-changes/README.md), we successfully installed our first _living-room devices_.
Now, it's time for the _automation_.
We are currently working on the `automation-rules.json` file.

## Task: Soft-reset and Replace WIP Commits

We finished installing our _living-room_ devices: _light_, _presence sensor_, and _ambient-light sensor_.

On the branch `living-room-light-automation`, we are currently working on the `automation-rules.json` file.
Here, we find our work in progress (_WIP_) from our previous session; e.g., the previous day, before lunch, from another PC.

Everything works, and it's time to finalize this feature branch.

_Soft-reset_ to before the WIP commits, remove `testMode` from all `rules` in `automation-rules.json`, and make one commit `"automate turning on/off the living room light"`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 42980cf (HEAD -> living-room-light-automation) WIP automate living-room light based on ambient light
* ba68393 WIP automate turning off the living-room light
* fee2a34 WIP automate turning on the living-room light
* a2c97f8 define automation-rules schema
* 13108ca install living-room ambient-light sensor
* 49f4ba2 install living-room presence sensor
* 17d752c define living-room-light trait on-off
* 38a6e17 (main) install living-room light
* 3e58fd0 define devices schema
* 75bb5c6 register living room
* ffc4d23 define rooms schema
* 9b570a5 write README
* 951e3f4 configure Git
```
_Note_: The _WIP_ commits are on the branch `living-room-light-automation` which is currently checked out.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 133124a (HEAD -> living-room-light-automation) automate living-room light
* a2c97f8 define automation-rules schema
* 13108ca install living-room ambient-light sensor
* 49f4ba2 install living-room presence sensor
* 17d752c define living-room-light trait on-off
* 38a6e17 (main) install living-room light
* 3e58fd0 define devices schema
* 75bb5c6 register living room
* ffc4d23 define rooms schema
* 9b570a5 write README
* 951e3f4 configure Git
```

## Reflect & Review

* Why might _WIP_ commits be useful during development but undesirable in final history?
* How is _soft reset_ useful for rewriting history?
* What risks are avoided by using `--soft` instead of `--hard`?
