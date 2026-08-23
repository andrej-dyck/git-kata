# 101 Amend Commit on a Local Branch

Amending commits is useful when we didn't stage something that belongs to the most recent commit,
or we made a mistake in that commit.

For example, we might want to fix a typo, reformat code, add related files, or improve logic that was introduced with that commit.

[`git commit --amend`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) allows us to do that.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

With this exercise, we start by registering the _rooms_ of our smart home.

## Task: Amend Commit

We registered the `living-room` with `rooms.json` in the most recent commit.
However, in `rooms.schema.json`, we defined that `rooms` is an array of _objects_.
And so, we made a mistake.

Let's amend this commit to fix this mistake and at the same time give the room a proper name.

```diff
{
  "$schema": "rooms.schema.json",
  "rooms": [
-   "living-room"
+   { "id": "living-room", "name": "Living room" }
  ]
}
```

Also, change the commit message to `"register living room"`

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* f9d96c0 (HEAD -> main) add living room to rooms
* 7e82648 define rooms schema
* 8765181 write README
* 17adacf configure Git
```
_Note_: The commit IDs are examples and will differ in your generated exercise repository.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 291145d (HEAD -> main) register living room
* 7e82648 define rooms schema
* 8765181 write README
* 17adacf configure Git
```
_Note_: Since we amended the last commit (`HEAD`), it has a different commit ID now.
