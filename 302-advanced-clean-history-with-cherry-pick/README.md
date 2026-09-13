# 302 Craft a Clean History by Cherry-picking Commits

_Cherry-picking_ a commit is useful when we want to apply changes introduced by that commit in to another branch (cf. [exercise 113](../113-local-cherry-pick-commits/README.md)).

It can also be useful for building a clean, intentional history from a messy or experimental branch by _cherry-picking_ only the commits that represent the changes we actually want to preserve.

This exercise will demonstrate how to use [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick) to clean up a messy Git history.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We worked on _automating_ the _living-room AC_ and pushed our work-in-progress (_WIP_) changes.
Earlier, we merged `main` into our branch using a _merge commit_.
As our branch advanced, so did `main`, and now, we have to integrate both branches and resolve conflicts.

## Task: Selectively Cherry-pick Commits to Compose a Clean History

At this point, `living-room-ac-automation` is done, and we need to integrate `main` into our branch.
However, we integrated `main` with a [_merge commit_](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) earlier, and this now prevents us from doing a [Git rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) (cf. [exercise 104](../104-local-rebase-onto-main/README.md) and [exercise 203](../203-remote-rebase-onto-main/README.md)).

To construct a linear history, we'll need to build the feature from the ground up.

- Abort the ongoing [_Git merge_](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) with [`git merge --abort`](https://git-scm.com/docs/git-merge#Documentation/git-merge.txt---abort)
- [_Hard reset_](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified) the local branch `living-room-ac-automation` to `origin/main` with [`git reset --hard origin/main`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard)
- Selectively [_cherry-pick_](https://git-scm.com/docs/git-cherry-pick) commits from `origin/living-room-ac-automation` onto our clean `living-room-ac-automation` with [`git cherry-pick origin/main`](https://git-scm.com/docs/git-cherry-pick), resolve occurring conflicts, and _re-word_ commits
- Remember to remove the `testMode` property from the AC automation rules

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 4ec1b9e (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) DELETE! balcony-door test value door-opened
* e78e489 DELETE! thermometer test value 26°C
* e846129 DELETE! balcony-door test value door-closed
* 42d8a6a WIP ac on/off + balcony door
* 2c1860f install balcony door
* 6222725 DELETE! thermometer test value 19°C
* f98abd4 DELETE! thermometer test value 26°C
*   7ff5376 Merge remote-tracking branch 'origin/main' into living-room-ac-automation
|\
* | aa4f9c9 WIP ac off
* | f9d9b06 WIP ac on
* | d8896c9 WIP automation rules schema
* | 1612f14 install thermostat
* | 19804cd install ac
| | * f7987c2 (origin/main, main) automate living-room light
| | * bcf20e3 define living-room-light trait on-off
| | * 4f7edc7 install living-room ambient-light sensor
| | * e36a924 install living-room presence sensor
| |/
| * 8e983c1 define automation-rules schema
| * a522a7d define traits for devices
|/
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Note_: The merge commit `"Merge remote-tracking branch 'origin/main' into living-room-ac-automation"` already integrated `main` and resolved some conflicts. However, `main` advanced further, and we need to integrate it again.

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* aced70a (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 3c7bc8b install living-room balcony-door sensor
* 004c81a automate turning off living-room AC
* 6baa5db automate turning on living-room AC
* 94fd1f5 install living-room thermostat sensor
* 30d81e0 install living-room AC
* f7987c2 (origin/main, main) automate living-room light
* bcf20e3 define living-room-light trait on-off
* 4f7edc7 install living-room ambient-light sensor
* e36a924 install living-room presence sensor
| * 4ec1b9e (origin/living-room-ac-automation) DELETE! balcony-door test value door-opened
| * e78e489 DELETE! thermometer test value 26°C
| * e846129 DELETE! balcony-door test value door-closed
| * 42d8a6a WIP ac on/off + balcony door
| * 2c1860f install balcony door
| * 6222725 DELETE! thermometer test value 19°C
| * f98abd4 DELETE! thermometer test value 26°C
| *   7ff5376 Merge remote-tracking branch 'origin/main' into living-room-ac-automation
| |\
| |/
|/|
* | 8e983c1 define automation-rules schema
* | a522a7d define traits for devices
| * aa4f9c9 WIP ac off
| * f9d9b06 WIP ac on
| * d8896c9 WIP automation rules schema
| * 1612f14 install thermostat
| * 19804cd install ac
|/
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Note_: At this point, the local `living-room-ac-automation` branch completely diverged from `origin` and is made up of cherry-picked commits.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* aced70a (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 3c7bc8b install living-room balcony-door sensor
* 004c81a automate turning off living-room AC
* 6baa5db automate turning on living-room AC
* 94fd1f5 install living-room thermostat sensor
* 30d81e0 install living-room AC
* f7987c2 (origin/main, main) automate living-room light
* bcf20e3 define living-room-light trait on-off
* 4f7edc7 install living-room ambient-light sensor
* e36a924 install living-room presence sensor
* 8e983c1 define automation-rules schema
* a522a7d define traits for devices
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Note_: After the _force push_, we have a linear history with good commits (atomic, descriptive, coherent) that is easy to understand.
