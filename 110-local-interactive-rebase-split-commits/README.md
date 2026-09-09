# 110 Interactive Rebase - Split Commits

[Interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) lets us work on problems naturally, commit changes as we go, and make our Git history more coherent and readable before sharing it with others (cf. [exercise 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Git allows us to make decisions about the commit history later.
One of these decisions might be to _split_ a commit into multiple smaller commits.
Splitting commits is useful when we committed unrelated changes by mistake, the commit isn't atomic, or realize later that we can split off changes to integrate those sooner.

Note that splitting commits is a balancing act between lacking coherence and overly broad.
Each commit should be small enough to be focused but large enough to represent a coherent change.

This exercise will help you understand how to use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) to _split_ commits.

![](../resources/main-feature-before-split.svg)

After splitting the first commit of the `feature` branch into two separate commits:

![](../resources/main-feature-splitted.svg)

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

While our team is working on _automating_ the _living-room light_ (exercises `101` to `104`), we _cherry-picked_ their _automation-rules schema_ and started the work on _automating_ the _living-room AC_.

Exercises [106](../106-local-interactive-rebase-reorder-commits/README.md) to [111](../111-local-interactive-rebase-delete-commits/README.md) have the same context, but with slightly different initial and target Git history to best support the exercise's focus.

## Task: Split Commits using Interactive Rebase

In this exercise, we committed our work on `living-room-ac-automation`.
We achieved a pretty good sequence of commits, but arguably, some commits comprise more than one logical change.

For example, `"install living-room AC"` defines the `traits`-schema for `devices`. This might be a useful commit to integrate early, so our team can start using it sooner.
And we can also split the installation of sensors `"install living-room sensors"` as well as automation `"automate living-room AC"` into two commits, respectively.

_Split_ those three commits mentioned above using _interactive rebase_.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 6075807 (HEAD -> living-room-ac-automation) automate living-room AC
* 33593f8 install living-room sensors
* 4706749 install living-room AC
* b9fb38e define automation-rules schema
| * 3b79ba4 (living-room-lights-automation) automate living-room light
| * 42f707e define automation-rules schema
| * c5669d2 define living-room-light trait on-off
|/
* b1cc447 (main) install living-room ambient-light sensor
* 3e0a64b install living-room presence sensor
* d4a8fa2 install living-room light
* 4fc7c87 define devices schema
* 6ceafa8 register living room
* e770935 define rooms schema
* 598bd6d write README
* 9d1fbb3 configure Git
```

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 7e19fe6 (HEAD -> living-room-ac-automation) turn off/on living-room AC based on open/closed balcony-door
* dd3dbfb install living-room balcony-door sensor
* 3323543 automate living-room AC target-temperature
* 5d26389 install living-room thermostat sensor
* 8fd5280 install living-room AC
* bd2bc53 define traits for devices
* b9fb38e define automation-rules schema
| * 3b79ba4 (living-room-lights-automation) automate living-room light
| * 42f707e define automation-rules schema
| * c5669d2 define living-room-light trait on-off
|/
* b1cc447 (main) install living-room ambient-light sensor
* 3e0a64b install living-room presence sensor
* d4a8fa2 install living-room light
* 4fc7c87 define devices schema
* 6ceafa8 register living room
* e770935 define rooms schema
* 598bd6d write README
* 9d1fbb3 configure Git
```
_Note_: Here, we split `"install living-room sensors"` into two commits, one for thermostat sensor and one for balcony-door sensor, and then _re-ordered_ the commits to intermix with automation. It's fine if you choose not to do this.
