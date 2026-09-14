# 303 Restore Lost Commits with Git-reflog

When working with destructive operations like [`git reset --hard origin/main`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) or [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i), you could unwantingly overwrite important commits and lose work.

Fortunately, Git provides a possibility to recover _lost_ commits[^1] with [_Git reflog_](https://git-scm.com/book/en/v2/Git-Internals-Maintenance-and-Data-Recovery#_data_recovery).
[`git reflog`](https://git-scm.com/docs/git-reflog) shows us scrapped commits, which we can restore using tools like [cherry-picking](https://git-scm.com/docs/git-cherry-pick), [branching](https://git-scm.com/docs/git-branch) or [git-reset](https://git-scm.com/docs/git-reset).

[^1]: Git only knows the scrapped commits within your local repository; it's like a local history.
But, if you run [`git gc`](https://git-scm.com/docs/git-gc), `git reflog drop`, or remove the entire local repository, you will lose the ability to reflog.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We worked on _automating_ the _living-room AC_, cleaned up our branch, and now want to integrate the recent changes of `main` using _rebase_.

## Task: Lose Commits and Then Restore Them

We finished our feature and cleaned up our branch, but instead of _rebasing_ the branch onto `main` we _hard reset_ it.
Thus, we accidentally lost some commits, and since we haven't pushed in a while `origin/living-room-ac-automation` only has some old commits.

Use `git reflog` to find and _restore_ the lost commit history.

Once we have our history back, use `git rebase` to integrate the recent changes of `main` and _force push_ to `origin`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* ab4b7bc (HEAD -> living-room-ac-automation, origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
| * d5f7c8f (origin/living-room-ac-automation) WIP ac on
| * 7304bc0 define automation-rules schema
| * 4632064 WIP sensors
| * da3763e install ac
|/
* 134e91c install living-room ambient-light sensor
* 8e5c7e2 install living-room presence sensor
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```
_Note_: Our _lost_ changes to `living-room-ac-automation` are not visible with `git log`.

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* 8e384f9 (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 167e817 install living-room balcony-door sensor
* 273669c automate turning off living-room AC
* 14e4e1c automate turning on living-room AC
* 51db3d2 install living-room thermostat sensor
* c5264e6 install living-room AC
* ab4b7bc (origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
| * d5f7c8f (origin/living-room-ac-automation) WIP ac on
| * 7304bc0 define automation-rules schema
| * 4632064 WIP sensors
| * da3763e install ac
|/
* 134e91c install living-room ambient-light sensor
* 8e5c7e2 install living-room presence sensor
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```
_Note_: After restoring our lost changes and rebasing onto `main`, we achieved a linear history without doing the work twice.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 8e384f9 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 167e817 install living-room balcony-door sensor
* 273669c automate turning off living-room AC
* 14e4e1c automate turning on living-room AC
* 51db3d2 install living-room thermostat sensor
* c5264e6 install living-room AC
* ab4b7bc (origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
* 134e91c install living-room ambient-light sensor
* 8e5c7e2 install living-room presence sensor
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```
