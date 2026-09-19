# 105 Rebase onto `main` with Conflicts

Regardless of whether we use [`git merge`](https://git-scm.com/docs/git-merge) or [`git rebase`](https://git-scm.com/docs/git-rebase) to integrate branches, we potentially need to resolve merge conflicts.

![](../resources/main-feature-out-of-sync-conflict.svg)

While with `git merge` the conflict is resolved in the merge commit, `git rebase` will stop at each problematic commit, and we need to resolve the conflicts in the order of those commits.

Resolving conflicts during a rebase can be complex, especially if the conflicts are hidden within the code (semantic conflicts) and multiple commits are involved.
This is why most developers prefer to use `git merge` over `git rebase`.

However, the vast majority of merge conflicts can be easily avoided by making _atomic commit_ and integrating changes early and often (_short-lived branches_).
When a branch has only a couple (_1-5_) of _atomic_ commits, is _integrated_ with `main` continuously, and exists only for a short period of time, conflicts are less likely to occur.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 101](../101-local-amend-commit/README.md) to [103](../103-local-undo-last-commits/README.md), we successfully installed all of our _living-room devices_ and finished implementing an automation rule for the _living room lights_.

It's time to integrate our feature branch; however, `main` has advanced in the meanwhile.

## Task: Rebase the Feature Branch onto `main`

While we were working on the light automation, our team installed further devices and sensors, as well as, _cherry-picked_ the _automation-rules schema_ and worked on automating the _living-room AC_.

We are finishing our feature branch and want to integrate it.
But in contrast to [exercise 104](../104-local-rebase-onto-main/README.md), we didn't integrate for too long and now encounter merge conflicts.
Use [`git rebase`](https://git-scm.com/docs/git-rebase) to rebase our branch `living-room-light-automation` onto `main`, and resolve the emerging conflicts.

Before executing the _rebase_ though, try to identify which commits will cause conflicts and prepare accordingly.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* d994035 (main) install living-room balcony-door sensor
* 2000688 install living-room thermostat sensor
* 7e33e41 install living-room AC
* 523a401 define automation-rules schema
* 56c699a define traits for devices
| * dd71c5a (HEAD -> living-room-light-automation) automate living-room light
| * 06f1ae7 define automation-rules schema
| * aabef6d install living-room ambient-light sensor
| * ae93029 install living-room presence sensor
| * 0b9c22e define living-room-light trait on-off
|/
* 9817010 install living-room light
* 24f2db2 define devices schema
* 3d94ca1 register living room
* 4ab80a3 define rooms schema
* 4201555 write README
* 221fce7 configure Git
```

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 3506132 (HEAD -> living-room-light-automation) automate living-room light
* 2ccd6ca install living-room ambient-light sensor
* fc61987 install living-room presence sensor
* 7aa91fc define living-room-light trait on-off
* d994035 (main) install living-room balcony-door sensor
* 2000688 install living-room thermostat sensor
* 7e33e41 install living-room AC
* 523a401 define automation-rules schema
* 56c699a define traits for devices
* 9817010 install living-room light
* 24f2db2 define devices schema
* 3d94ca1 register living room
* 4ab80a3 define rooms schema
* 4201555 write README
* 221fce7 configure Git
```

## Reflect & Review

- Why can both merge and rebase lead to conflicts?
- What makes a conflict resolution during rebase different from resolving the same conflict in a merge? What makes it easier, what makes it more difficult?
- How can small, atomic commits and a short-lived branch make conflict resolution easier?
- Why are _semantic_ conflicts harder to detect than _textual_ conflicts?
