# 108 Interactive Rebase - Re-word Commit Message

🚧 WIP (this exercise isn't done yet)

[Interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) lets us work on problems naturally, commit changes as we go, and make our Git history more coherent and readable afterward (cf. [exercise 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Focusing on the progress of our work is important, and so, we should avoid context switching.
While committing work often is good, even thinking about how to word commit messages is a cognitive load which might make us lose our focus.
With _interactive rebase_ we can commit changes with a quick message and then reword them later.

This exercise will help you understand how to use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) to _reword_ commits.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

While our team is working on _automating_ the _living-room light_ (exercises `101` to `104`), we _cherry-picked_ their _automation-rules schema_ and started the work on _automating_ the _living-room AC_.

## Task: Re-word Commit Messages using Interactive Rebase

In this exercise, we committed our work on `living-room-ac-automation` in small commits and didn't focus on wording messages too much.

For example, ... TODO

_Re-word_ the commit messages on `living-room-ac-automation` to tell a coherent story.

Make sure to _squash_ related WIP commits and _reword_ the commit message of the squashed commit.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 3ff3e66 (HEAD -> living-room-ac-automation) WIP automation
* 77c5301 sensors
* b213a87 fix ac
* 910610c ac
* 0f9b61f define automation-rules schema
| * 087bab5 (living-room-automation) automate turning on/off the living-room light
| * d8a17ab define automation-rules schema
| * 08fb7a0 define living-room-light trait on-off
|/
* 37dac97 (main) install living-room ambient-light sensor
* 54599b6 install living-room presence sensor
* 9d41bc1 install living-room light
* 4a17a48 define devices schema
* a601c18 register living room
* 7624ec7 define rooms schema
* 4c8d1a7 write README
* 3c32c60 configure Git
```
_Note_: ...

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* ebd57ea (HEAD -> living-room-ac-automation) automate living-room AC
* d13e956 install living-room sensors
* 44e95a3 install living-room AC
* 0f9b61f define automation-rules schema
| * 087bab5 (living-room-automation) automate turning on/off the living-room light
| * d8a17ab define automation-rules schema
| * 08fb7a0 define living-room-light trait on-off
|/
* 37dac97 (main) install living-room ambient-light sensor
* 54599b6 install living-room presence sensor
* 9d41bc1 install living-room light
* 4a17a48 define devices schema
* a601c18 register living room
* 7624ec7 define rooms schema
* 4c8d1a7 write README
* 3c32c60 configure Git
```
_Note_: Rewording a commit message also changes the commit's ID.
