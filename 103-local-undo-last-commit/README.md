# 103 Undo Last Commit(s) with Soft-Reset

Sometimes we commit changes that are temporary, e.g., work-in-progress (_WIP_).
Sometimes we want to manually re-stage changes and separate commits.
Sometimes we include unrelated changes to a commit and want to undo this commit.

[`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) helps us to reset to a previous git-state while keeping all changes from those undone commits staged, so they can be recommitted.

So, unlike a _hard reset_, the changes are not lost; with `--soft`, they remain staged.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 101](../101-local-amend-commit/README.md) and [102](../102-local-commit-changes/README.md), we successfully installed all of our _living-room devices_.
Now, it's time for the _automation_.
We are currently working on the `automation-rules.json` file.

## Task: Soft-reset and Replace WIP Commits

We finished installing our _living-room_ devices: _light_, _presence sensor_, and _ambient-light sensor_.

On the branch `living-room-automation`, we are currently working on the `automation-rules.json` file.
Here, we find our work in progress (_WIP_) from our previous session; e.g., the previous day, before lunch, from another PC.

Everything works, and it's time to finalize this feature branch.

_Soft-reset_ to before the WIP commits, remove `testMode` from all `rules` in `automation-rules.json`, and make one commit `"automate turning on/off the living room light"`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 28fe671 (HEAD -> living-room-automation) WIP automate turning on/off the living-room light based on ambient light
* 1d62832 WIP automate turning off the living-room light
* 9709189 WIP automate turning on the living-room light
* da3ea2f define automation-rules schema
* 00d7a16 define living-room-light trait on-off
* ba2f53b (main) install living-room ambient-light sensor
* ab9be2f install living-room presence sensor
* 2fb482d install living-room light
* f04f895 define devices schema
* 86e198f register living room
* 753e83b define rooms schema
* 5ff2789 write README
* 258621a configure Git
```
_Note_: The _WIP_ commits are on the branch `living-room-automation` which is currently checked out.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* c2cca52 (HEAD -> living-room-automation) automate turning on/off the living-room light
* da3ea2f define automation-rules schema
* 00d7a16 define living-room-light trait on-off
* ba2f53b (main) install living-room ambient-light sensor
* ab9be2f install living-room presence sensor
* 2fb482d install living-room light
* f04f895 define devices schema
* 86e198f register living room
* 753e83b define rooms schema
* 5ff2789 write README
* 258621a configure Git
```
