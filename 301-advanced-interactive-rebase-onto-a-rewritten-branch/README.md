# 301 Interactive Rebase onto a Re-written Branch

At times, we commit work to a branch that has been re-written at origin.
This can happen when we work on different machines, collaborate with others, or have integrated changes early through other branches.

As alluded to in [exercise 205](../205-remote-rewriting-history-with-teammates/README.md), our branch and `origin` can both have changes that we want to keep.
In this case, we want to decide which changes to keep commit by commit.

To cleanly merge both histories, we can use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) followed by a [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) to publish a clean history.
Here, the general approach is to _delete_ obsolete commits from our branch or resolve the conflicts manually while rebasing onto `origin`.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We worked on _automating_ the _living-room AC_ and pushed our work-in-progress (_WIP_) changes.
Meanwhile, on a different machine, we (or a teammate) cleaned up the history, but before the final changes.
Now, as we finished the feature _balcony-door_ sensor and rules, both our branch and `origin` have changes that we want to keep.

## Task: Re-write the Git History and Craft a Clean History

Merge both histories of `living-room-ac-automation` and it's `origin` counterpart to compose a clean history using _interactive rebase_.

On our local branch, we extended the feature by automating the living-room AC based on the _balcony-door sensor_.

At `origin`, the commits have proper commit messages and remove the `testMode` property from the AC automation rules.
Further, they _squash_ the two automation commits into one.

Also note that `main` has a more complete `automation-rules.schema.json` with `"define automation-rules schema"` than our `"WIP automation rules schema`".

Finally, make a second _interactive rebase_ to remove the `testMode` property, and undo the _squash_ `"automate living-room AC"` back into separate commits.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 3afe36c (HEAD -> living-room-ac-automation) WIP ac on/off + balcony door
* e5a2b2e install balcony door
* 4ac17e9 WIP ac off
* cfc5079 WIP ac on
* 3ee528b WIP automation rules schema
* fe9c73f install thermostat
* bbb4ef4 install ac
| * d649317 (origin/living-room-ac-automation) automate living-room AC
| * 1c91238 install living-room thermostat sensor
| * 5ef35c3 install living-room AC
| * 6eec9c2 (origin/main, main) define automation-rules schema
| * 64f6b9c define traits for devices
|/
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Note_: Both, `living-room-ac-automation` and `origin`, have recent changes that we want to keep.
A Git client shows something similar to `↓5 ↑7` for this graph.

### Git History after the 1st Interactive Rebase
```console
$ git log --oneline --graph --decorate --all
* 5a0e09f (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 53fc8ab install balcony door
* d649317 (origin/living-room-ac-automation) automate living-room AC
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Note_: After the first _interactive rebase_ onto `origin/living-room-ac-automation`, we should have two newer `↑2` commits and a linear history.

### Pre-push Git History (after the 2nd Interactive Rebase)
```console
$ git log --oneline --graph --decorate --all
* 007d041 (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 180e87b install balcony door
* bb786d3 automate turning off living-room AC
* f2a15ed automate turning on living-room AC
| * d649317 (origin/living-room-ac-automation) automate living-room AC
|/
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Note_: After the second _interactive rebase_, we should have no more `testMode` property and have three commits automating the living-room AC.
As we are about to overwrite `origin` dropping one commit, a Git client shows something like `↓1 ↑4`.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 007d041 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 180e87b install balcony door
* bb786d3 automate turning off living-room AC
* f2a15ed automate turning on living-room AC
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Note_: Finally, after the _force push_, we have a linear history with good commits (atomic, descriptive, coherent) that is easy to understand.
