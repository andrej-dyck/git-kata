# 102 Commit Changes, Not Files

Git tracks changes to a file rather than the file itself.
So, when we stage a change, we can stage every change within a file; a substring, a line, or a _hunk_.

This allows us to commit changes within one file in patches resulting in multiple commits.

To stage the differences within files, use [`git add -p`](https://git-scm.com/docs/git-add#Documentation/git-add.txt-patch) to create _patches_.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 101](../101-local-amend-commit/README.md), we now want to install our _living-room devices_.

## Task: Commit Changes by Staging Lines within a File

We registered the _living room_ with `rooms.json` in the previous exercise.
Now, we defined the schema for devices in `devices.schema.json` and are about to install our _living-room light_ in `devices.json`.

Further, we noticed that we made a typo in the `"$schema"` property of `devices.json`; we fixed this right away.
This change technically belongs to the previous commit `"define devices schema"`.

Here are our three choices:
1. commit the fix together with `"define devices schema"` (_that is not what we want in this exercise_)
2. commit the fix separately with `"fix typo in devices.schema.json"`
3. amend the previous commit `"define devices schema"` with the fix (_preferred way_)

Implement option _2._ or _3._ using patch staging to commit only the schema fix, while leaving other changes in that file unstaged.

Then, install the _living-room light_ with a separate commit `"install living-room light"`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 2d1c1ab (HEAD -> main) define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```
_Note_: The commit IDs are different from the previous `README.md` as each exercise is generated.
This will also be true for all subsequent exercises.

### Target Git History

**... when choosing option 2.**
```console
$ git log --oneline --graph --decorate --all
* afaef65 install living-room light
* 17adacf fix typo in devices.schema.json
* 2d1c1ab define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```

**... when choosing option 3.**
```console
$ git log --oneline --graph --decorate --all
* afaef65 (HEAD -> main) install living-room light
* 9e27dca define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```
_Note_: This history is where we amended the last commit `"define devices schema"` with the fix; i.e., no separate _"fix"_ commit.
