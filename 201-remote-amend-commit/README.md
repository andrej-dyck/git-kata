# 201 Amend Pushed Commit

Amending commits is useful when we want to fix a typo, add forgotten changes, or improve logic in the most recent commit (cf. [exercise 101](../101-local-amend-commit/README.md)).

However, once a commit has been pushed to a remote repository (`origin`), amending it changes it the commit sequence and our local copy diverges from the one on `origin`.
Git will reject a standard `git push` to prevent overwriting history on the remote.

To update the remote branch with our rewritten commit, we need to overwrite the remote branch using [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease).

_Hint_: Using `--force-with-lease` is safer than `--force` because it ensures we only overwrite the remote branch if no one else has pushed new commits to it since we last fetched.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

We successfully installed our first _living-room devices_, and now, work on _automating the living-room lights_.

## Task: Amend Commit and Force-Push

On the branch `living-room-light-automation`, we are working on _automating the living-room lights_.

With the final changes, we are ready to finish the automation and _push the changes_.
However, we already pushed our work-in-progress (_WIP_) to `origin` earlier, so our changes are backed up.

Amend the WIP commit with the following changes and give it a proper name; e.g., `"automate living-room light"`:

```diff
--- a/automation-rules.json
+++ b/automation-rules.json
@@ -5,11 +5,14 @@
     {
       "id": "living-room-lights-on-presence",
       "name": "Turn on living-room lights when presence is detected",
-      "testMode": true,
       "when": [
         {
           "sensorDeviceId": "living-room-presence",
           "event": "presence-detected"
+        },
+        {
+          "sensorDeviceId": "living-room-ambient-light",
+          "sensorValue": "is-dark"
         }
       ],
       "then": [
@@ -22,7 +25,6 @@
     {
       "id": "living-room-lights-off-no-presence",
       "name": "Turn off living room lights when presence is no longer detected",
-      "testMode": true,
       "when": [
         {
           "sensorDeviceId": "living-room-presence",
@@ -35,6 +37,22 @@
           "action": "turn-off"
         }
       ]
+    },
+    {
+      "id": "living-room-lights-off-ambient-bright",
+      "name": "Turn off living room lights when ambient light is bright",
+      "when": [
+        {
+          "sensorDeviceId": "living-room-ambient-light",
+          "sensorValue": "is-bright"
+        }
+      ],
+      "then": [
+        {
+          "deviceId": "living-room-light",
+          "action": "turn-off"
+        }
+      ]
     }
   ]
 }
```

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* e22b66a (HEAD -> living-room-light-automation, origin/living-room-light-automation) WIP automation rules
* dc6f8e2 define automation-rules schema
* 3c557d0 define living-room-light trait on-off
* 06295d8 (origin/main, main) install living-room ambient-light sensor
* b0ecad5 install living-room presence sensor
* 80152be install living-room light
* 40912ed define devices schema
* 2d944e2 register living room
* f07c0e6 define rooms schema
* cd6326c write README
* c58a904 configure Git
```
_Note_: You can see that a branch is in sync with `origin`, when both, your local copy `living-room-light-automation` and remote `origin/living-room-light-automation` point to the same commit.

### Pre-push Git History
```console
$ git log --oneline --graph --decorate --all
* 2339348 (HEAD -> living-room-light-automation) automate living-room light
| * e22b66a (origin/living-room-light-automation) WIP automation rules
|/
* dc6f8e2 define automation-rules schema
* 3c557d0 define living-room-light trait on-off
* 06295d8 (origin/main, main) install living-room ambient-light sensor
* b0ecad5 install living-room presence sensor
* 80152be install living-room light
* 40912ed define devices schema
* 2d944e2 register living room
* f07c0e6 define rooms schema
* cd6326c write README
* c58a904 configure Git
```
_Note_: Since we amended the last commit (`HEAD`), it has a different commit hash and the history diverges from `origin`.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 2339348 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* dc6f8e2 define automation-rules schema
* 3c557d0 define living-room-light trait on-off
* 06295d8 (origin/main, main) install living-room ambient-light sensor
* b0ecad5 install living-room presence sensor
* 80152be install living-room light
* 40912ed define devices schema
* 2d944e2 register living room
* f07c0e6 define rooms schema
* cd6326c write README
* c58a904 configure Git
```
_Note_: After `git push --force-with-lease`, `origin/main` is updated to point to the new amended commit, and the old commit doesn't exist anymore.
