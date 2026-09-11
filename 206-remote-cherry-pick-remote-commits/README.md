# 206 Cherry-pick Remote Commits

_Cherry-picking_ a commit is useful when we want to apply changes introduced by that commit in to another branch (cf. [exercise 113](../113-local-cherry-pick-commits/README.md)).

Sometimes, the changes we want to _cherry-pick_ are only available on a remote branch.
This exercise focuses on using [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick) without checking out the remote branch.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We started work on _automating_ the _living-room AC_.
However, we realized that the team working on _automating_ the _living-room light_ needs similar schema changes.

We decided to stop our work and integrate the schema changes to `device.schema.json` and definition of `automation-rules.schema.json` into `main` first.

## Task: Cherry-pick Changes from a Remote Branch

Cherry-pick changes to `device.schema.json` from either `"install ac"` or `"define living-room-light trait on-off"` without checking out the corresponding remote branch.
Commit the changes as `"define traits for devices"`.

Then, cherry-pick and commit `"define automation-rules schema"` from `origin/living-room-light-automation`.

Push the commits on `automation-schema` to `origin` so they can be integrated into `main`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* a5e6ece (origin/living-room-ac-automation) install sensors
* 6918578 install ac
| * 708f97c (origin/living-room-light-automation) automate living-room light
| * bdb73db define automation-rules schema
| * e335f9d define living-room-light trait on-off
| * e7cac78 install living-room ambient-light sensor
| * 40dd17a install living-room presence sensor
|/
* 2efa1cf (HEAD -> automation-schema, origin/main, main) install living-room light
* ec17cd6 define devices schema
* 3a82f0d register living room
* 4b325e8 define rooms schema
* 20f93b1 write README
* 5ccef44 configure Git
```
_Note_: The `HEAD` is on the empty `automation-schema` branch.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 6cf0014 (HEAD -> automation-schema, origin/automation-schema) define automation-rules schema
* 866970e define traits for devices
| * a5e6ece (origin/living-room-ac-automation) install sensors
| * 6918578 install ac
|/
| * 708f97c (origin/living-room-light-automation) automate living-room light
| * bdb73db define automation-rules schema
| * e335f9d define living-room-light trait on-off
| * e7cac78 install living-room ambient-light sensor
| * 40dd17a install living-room presence sensor
|/
* 2efa1cf (origin/main, main) install living-room light
* ec17cd6 define devices schema
* 3a82f0d register living room
* 4b325e8 define rooms schema
* 20f93b1 write README
* 5ccef44 configure Git
```
