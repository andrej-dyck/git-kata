# 204 Interactive Rebase - Re-writing Remote History

[Interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) lets us work on problems naturally, commit changes as we go, and make our Git history more coherent and readable before sharing it with others (cf. [exercise 106](../106-local-interactive-rebase-reorder-commits/README.md) to [112](../112-local-interactive-rebase-onto-main/README.md)).

Using _interactive rebase_ re-writes a branch's history locally.
So, to update the remote repository, we have to overwrite its branch version with [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) (cf. [exercise 201](../201-remote-amend-commit/README.md) to [203](../203-remote-rebase-onto-main/README.md)).

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We started work on _automating_ the _living-room AC_. To unblock the team, we realized we should integrate schema changes into `main` before continuing.
Thus, we integrated changes to `device.schema.json` and defined `automation-rules.schema.json`.

After completing work on the _AC automation_, it is time to clean up the history and push our changes.

## Task: Interactively Rebase onto `main` to Clean Up History and Force-Push Changes

We finished our work and tested the _living-room AC automation_.

Clean up the history of `living-room-ac-automation` using _interactive rebase_ and probably some other re-writing tools, rebase onto `main`, and overwrite the remote branch with the new history using `git push --force-with-lease`.

Here are our cleanup tasks:
- [ ] _Rebase_ onto `main`
- [ ] _Remove_ all `DELETE!` commits
- [ ] _Squash_ all `WIP` _AC automation_ related commits into a single one
- [ ] _Edit_ AC automation rules and remove the `testMode` property
- [ ] _Split_ `"install sensors"` into two separate commits
- [ ] _Reword_ all commits to have good commit messages

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* cd1a4fd (HEAD -> living-room-ac-automation) DELETE! balcony-door test value door-opened
* bf9e66c DELETE! thermometer test value 26°C
* d18ddbc WIP ac on/off + balcony-door
* f03749e DELETE! thermometer test value 19°C
* f664475 WIP ac off
* 8f108ea DELETE! balcony-door test value door-closed
* 48e9344 DELETE! thermometer test value 26°C
* ee8ec92 WIP ac on
* 3556472 define automation-rules schema
* bfed9e5 (origin/living-room-ac-automation) install sensors
* 6cda9cf install ac
| * 81d1321 (origin/main, main) define automation-rules schema
| * f6492a3 define traits for devices
|/
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Note_: Our branch `living-room-ac-automation` has local changes that are not yet pushed to `origin`. Also, `main` has newer commits that will make some changes of `living-room-ac-automation` obsolete.

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* c4ee170 (HEAD -> living-room-ac-automation) automate living-room AC
* 587d61f install living-room balcony-door sensor
* c5f2483 install living-room thermostat sensor
* 9e1d7fc install living-room AC
* 81d1321 (origin/main, origin/HEAD, main) define automation-rules schema
* f6492a3 define traits for devices
| * bfed9e5 (origin/living-room-ac-automation) install sensors
| * 6cda9cf install ac
|/
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Note_: `origin/living-room-ac-automation` shows only two commits as our `WIP` and `DELETE` commits were never pushed.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* c4ee170 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate living-room AC
* 587d61f install living-room balcony-door sensor
* c5f2483 install living-room thermostat sensor
* 9e1d7fc install living-room AC
* 81d1321 (origin/main, origin/HEAD, main) define automation-rules schema
* f6492a3 define traits for devices
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Note_: After the rebase onto `main`, commit `"define automation-rules schema"` and the change to `devices.schema.json` in `"install living-room AC"` is now gone from `living-room-ac-automation`.
