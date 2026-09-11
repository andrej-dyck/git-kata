# 205 Rewriting History with Teammates (or on another Machine)

When working on different machines or collaborating with teammates on the same branch, _re-writing Git history_ (cf. [exercise 201](../201-remote-amend-commit/README.md) to [204](../204-remote-interactive-rebase/README.md)) brings some challenges.

The most common decision is whether our local copy or `origin` has the most recent history.
If both, the local branch and `origin`, have new changes, we need to decide which one to prioritize and manually _"merge"_ the histories.
Thus, it's recommended to either _"hand off"_ the branch, pair on the same machine, or collaborate on separate short-lived branches.

Assuming we have the simple case that `origin` has the most recent history,

![](../resources/main-feature-out-of-sync-origin-ahead.svg)

we can update our local history by using [`git fetch`](https://git-scm.com/docs/git-fetch) and then [`git reset --hard`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) onto `origin/feature`.

If our local branch has also new changes, we can [interactively rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) onto `origin/feature`, _delete_ obsolete commits, and resolve conflicts with new commits.
[Exercise 301](../301-advanced-interactive-rebase-onto-a-rewritten-branch) addresses this scenario.

_Note_: Don't use [`git pull`](https://git-scm.com/docs/git-pull) when working with _rebase_.
Always use [`git pull --ff-only`](https://git-scm.com/docs/git-fetch); that's shorthand for [`git fetch`](https://git-scm.com/docs/git-fetch) plus [`git merge --no-commit --ff --ff-only`](https://git-scm.com/docs/git-merge).

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We worked on _automating_ the _living-room AC_ and pushed our work-in-progress (_WIP_) changes.
Meanwhile, on a different machine, we (or a teammate) finished the feature, cleaned up the history, and pushed it to `origin`.

## Task: Adopt the Cleaned up History from `origin`

Use `git fetch` and then [`git reset --hard`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) onto `origin/living-room-ac-automation`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* da2218a (origin/living-room-ac-automation) automate living-room AC
* 0a7fdbd install living-room balcony-door sensor
* 3cfe8a0 install living-room thermostat sensor
* ddb7e7d install living-room AC
* a97d339 (origin/main, main) define automation-rules schema
* b2d22bf define traits for devices
| * 88d99ae (HEAD -> living-room-ac-automation) DELETE! thermometer test value 19°C
| * 27cfb03 WIP ac off
| * a782fb3 DELETE! thermometer test value 26°C
| * 4316803 WIP ac on
| * d9704ea define automation-rules schema
| * dccfbb0 install sensors
| * b1ab55b install ac
|/
* d6c3615 install living-room light
* 47d92b6 define devices schema
* 7a0dac6 register living room
* cb7d7d1 define rooms schema
* dd1072a write README
* 375a72b configure Git
```
_Note_: This local copy of the Git repository has still the old branch history of `living-room-ac-automation` checked out, while `origin/living-room-ac-automation` has the new branch history.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* da2218a (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate living-room AC
* 0a7fdbd install living-room balcony-door sensor
* 3cfe8a0 install living-room thermostat sensor
* ddb7e7d install living-room AC
* a97d339 (origin/main, main) define automation-rules schema
* b2d22bf define traits for devices
* d6c3615 install living-room light
* 47d92b6 define devices schema
* 7a0dac6 register living room
* cb7d7d1 define rooms schema
* dd1072a write README
* 375a72b configure Git
```
