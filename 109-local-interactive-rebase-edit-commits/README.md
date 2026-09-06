# 109 Interactive Rebase - Edit Commits

[Interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) lets us work on problems naturally, commit changes as we go, and make our Git history more coherent and readable before sharing it with others (cf. [exercise 106](../106-local-interactive-rebase-reorder-commits/README.md)).

We often find that we need to edit commits to _fix mistakes_ or _improve code_ that was introduced with that commit.

While [`git commit --amend`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) allows us to edit the most recent commit (cf. [exercise 101](../101-local-amend-commit/README.md)), [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) lets us edit any commit in a linear history.

![](../resources/main-feature-with-commit-for-modification.svg)

This exercise will help you understand how to use [interactive rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) to _edit_ commits.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

While our team is working on _automating_ the _living-room light_ (exercises `101` to `104`), we _cherry-picked_ their _automation-rules schema_ and started the work on _automating_ the _living-room AC_.

## Task: Edit Commits using Interactive Rebase

In this exercise, we committed our work on `living-room-ac-automation`.

After finishing the automation rules, we realized that we didn't uphold our team's _naming convention_ for _device_ and _rule IDs_.
For example, we used `"ac"` as the _device ID_ and `"ac-on"` as a _rule ID_. However, it should have been `"living-room-ac"` and `"living-room-ac-on"`.

_Edit_ commits `"install living-room AC"` and `"automate living-room AC"` in a single _interactive rebase_ session.
Note that we could make new commits and _squash_ those onto the old commits, but sometimes it's useful to make changes in the context of the old commit; e.g., when using automated refactoring actions.

_Hint_: To edit old commits, use the `edit` option of [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i).
It stops the rebase at that commit and lets us amend it.

- Edit commit `"install living-room AC"` as follows:
  ```diff
  --- a/devices.json
  +++ b/devices.json
  @@ -21,8 +21,8 @@
         "type": "sensor"
       },
       {
  -      "id": "ac",
  -      "name": "AC",
  +      "id": "living-room-ac",
  +      "name": "Living-room AC",
         "roomId": "living-room",
         "type": "ac-unit",
         "traits": [
  ```
- Edit commit `"automate living-room AC"` as follows:
  ```diff
  --- a/automation-rules.json
  +++ b/automation-rules.json
  @@ -3,7 +3,7 @@
     "apiVersion": "1.0",
     "rules": [
       {
  -      "id": "ac-on",
  +      "id": "living-room-ac-on",
         "name": "Turn on living-room AC when its hot",
         "when": [
           {
  @@ -17,7 +17,7 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-on",
             "parameters": {
               "targetTemperatureCelsius": 21.0
  @@ -26,7 +26,7 @@
         ]
       },
       {
  -      "id": "ac-off-temperature",
  +      "id": "living-room-ac-off-temperature",
         "name": "Turn off living-room AC when its cool",
         "when": [
           {
  @@ -36,13 +36,13 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-off"
           }
         ]
       },
       {
  -      "id": "ac-off-balcony",
  +      "id": "living-room-ac-off-balcony",
         "name": "Turn off living-room AC when balcony door open",
         "when": [
           {
  @@ -52,7 +52,7 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-off"
           }
         ]
  ```

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 65d5315 (HEAD -> living-room-ac-automation) automate living-room AC
* 5b7eeba install living-room sensors
* 95621c0 install living-room AC
* 2884e2f define traits for devices
* 6973a59 define automation-rules schema
| * 8e310a3 (living-room-automation) automate turning on/off the living-room light
| * bb583ed define automation-rules schema
| * ad9c8d9 define living-room-light trait on-off
|/
* b19d133 (main) install living-room ambient-light sensor
* d38f3e6 install living-room presence sensor
* 797df09 install living-room light
* 6b0023f define devices schema
* ab49d65 register living room
* 740cb26 define rooms schema
* ce3cbc0 write README
* 229fdbc configure Git
```

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 53dd464 (HEAD -> living-room-ac-automation) automate living-room AC
* b66fa4c install living-room sensors
* 38a7b1e install living-room AC
* 2884e2f define traits for devices
* 6973a59 define automation-rules schema
| * 8e310a3 (living-room-automation) automate turning on/off the living-room light
| * bb583ed define automation-rules schema
| * ad9c8d9 define living-room-light trait on-off
|/
* b19d133 (main) install living-room ambient-light sensor
* d38f3e6 install living-room presence sensor
* 797df09 install living-room light
* 6b0023f define devices schema
* ab49d65 register living room
* 740cb26 define rooms schema
* ce3cbc0 write README
* 229fdbc configure Git
```
_Note_: After editing the commit `"install living-room AC"` all following commits have new commit IDs.
