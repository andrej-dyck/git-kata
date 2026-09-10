# 202 Undo Pushed Commits

We want to push work-in-progress (_WIP_) commits to a remote repository because we want a backup our work, continue working from another machine, or share an intermediate state.

Later, once the work is complete, we may want to replace those temporary commits with a smaller, cleaner, more meaningful commit.
Locally, we can do this with [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft), as introduced in [exercise 103](../103-local-undo-last-commits/README.md).

However, when those commits have already been pushed to `origin`, rewriting them locally is not enough.
After the soft-reset and the new commit, the local branch and the remote branch have diverged.

Similar like in [exercise 201](../201-remote-amend-commit/README.md), we can use [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) to overwrite the branch on `origin` with our cleaned-up history.

_Hint_: Prefer `--force-with-lease` over `--force`.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We successfully installed our first _living-room devices_, and worked on _automating the living-room lights_.
Now, the automation rules for the _living-room light_ are complete, but the Git history still contains multiple temporary WIP commits.

Before sharing this branch for review or integrating it, we want to replace those WIP commits with one clean commit that describes the completed feature.

## Task: Undo WIP Commits with Soft Reset and Force Push Changes

On the branch `living-room-light-automation`, replace the three pushed WIP commits with one clean commit.

Use [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) to undo the WIP commits while keeping their changes staged.

Then remove `testMode` property from all rules in `automation-rules.json` and create a single commit named `"automate living-room light"`.

Use `git push --force-with-lease` to overwrite the remote branch with the cleaned-up history.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 7a38b10 (HEAD -> living-room-light-automation, origin/living-room-light-automation) WIP automate living-room light based on ambient light
* 6f188b9 WIP automate turning off the living-room light
* 82de217 WIP automate turning on the living-room light
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* bb82700 (HEAD -> living-room-light-automation) automate living-room light
| * 7a38b10 (origin/living-room-light-automation) WIP automate living-room light based on ambient light
| * 6f188b9 WIP automate turning off the living-room light
| * 82de217 WIP automate turning on the living-room light
|/
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```
_Note_: After the soft-reset and new commit, the local branch contains the clean commit, while `origin/living-room-light-automation` still points to the old WIP history.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* bb82700 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```
_Note_: The old pushed WIP commits are no longer part of the branch history.
