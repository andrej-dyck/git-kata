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
And we noticed that we made a typo in the `"$schema"` property of `devices.json`; we fixed this right away.

The fix technically belongs to the previous commit `"define devices schema"`.
Here are our three choices:
1. commit the fix together with `"define devices schema"` (_that is not what we want in this exercise_)
2. commit the fix separately with `"fix typo in devices.schema.json"`
3. amend the previous commit `"define devices schema"` with the fix (_preferred way_)

Separate the two changes by staging the typo fix and commit the fix (option _2._) or amend the previous commit (option _3._).
And then, make a separate commit `"install living-room light"` with the _living-room light_.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* 2d1c1ab (HEAD -> main) define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```
_Note_: The commit hashes are different from the previous `README.md` as each exercise is generated.
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

## Reflect & Review

* How can staging individual hunks or lines lead to more coherent commits?
* How does patch staging help separate unrelated work that happened in the same file?
* How does this exercise reinforce the idea of atomic commits?
