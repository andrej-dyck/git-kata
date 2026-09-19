# 104 Rebase onto `main`

When working as a team, we want to prefer short-lived branches (i.e., integrated into `main` within hours).
But it's unavoidable that `main` will sometimes have commits that are more recent than those on our `feature` branch.

![](../resources/main-feature-out-of-sync.svg)

There are two ways to integrate the changes from `main`.

One way is to **[merge](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) `main` into `feature`** branch with [`git merge`](https://git-scm.com/docs/git-merge).

![](../resources/main-feature-sync-merge.svg)

This leads to a non-linear, often messy Git history, which can never be linearized again; and in fact, prevents us from cleaning up our history.
With a non-linear, messy history, we might encounter changes in our branch that are not ours (integrated with the _merge commit_), reverting can be less straightforward, and investigating the history (e.g., _"what happened?"_ and debugging with `git bisect`) is more challenging.

The second way is to **[rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) `feature` onto `main`** with [`git rebase`](https://git-scm.com/docs/git-rebase); in other words, re-applying our changes starting with a new _base_ leading to a linear history. Think of it _"as if we started our branch later"_.

![](../resources/main-feature-sync-rebase.svg)

`git merge` and `git rebase` mainly differ in how they incorporate changes and represent history.
_Merge_ preserves the actual branching and integration history (_"how the developers worked"_), while _rebase_ rewrites commits to produce a linear history to focus on the logical changes (_"how the developers want to document it"_).

Many problems often attributed to `git merge` vs. `git rebase` aren't inherent to either approach.
Expensive conflicts, repeated conflict resolution, late integration issues, and changes that merge cleanly but don't work together are usually consequences of late integration and long-lived, diverging branches.
Neither approach solves these underlying coordination and integration problems.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

Following [exercise 101](../101-local-amend-commit/README.md) to [103](../103-local-undo-last-commits/README.md), we successfully installed all of our _living-room devices_ and finished implementing an automation rule for the _living room lights_.

It's time to integrate our feature branch; however, `main` has advanced in the meanwhile.

## Task: Rebase the Feature Branch onto `main`

While we were working on the light automation, our team _cherry-picked_ the _schemas_ and integrated them into `main`.

To ensure our changes work when integrated and that there are no conflicts, it's a good practice to integrate `main` into our branch.
To this end, use [`git rebase`](https://git-scm.com/docs/git-rebase) to rebase our branch `living-room-light-automation` onto `main`.

### Deep Dive
After the rebase onto `main`, investigate what happened to the commits `"define automation-rules schema"` and `"define living-room-light trait on-off"` of the branch `living-room-light-automation`.

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
* a8b86fb (main) define automation-rules schema
* cb7ab96 define traits for devices
| * b3c4ae2 (HEAD -> living-room-light-automation) automate living-room light
| * 86da7e5 define automation-rules schema
| * 452ba87 install living-room ambient-light sensor
| * a548017 install living-room presence sensor
| * 28774ef define living-room-light trait on-off
|/
* c699a3f install living-room light
* bef4d8a define devices schema
* 8a94fa8 register living room
* 545c8f9 define rooms schema
* c18376c write README
* 6d77dca configure Git
```
_Note_: The branch `living-room-light-automation` is checked out, thus the `HEAD` is at `3edb867`.

### Target Git History
```console
$ git log --oneline --graph --decorate --all
* 7e2bcae (HEAD -> living-room-light-automation) automate living-room light
* 10c3f4c install living-room ambient-light sensor
* 163faa5 install living-room presence sensor
* 821b0ab define living-room-light trait on-off
* a8b86fb (main) define automation-rules schema
* cb7ab96 define traits for devices
* c699a3f install living-room light
* bef4d8a define devices schema
* 8a94fa8 register living room
* 545c8f9 define rooms schema
* c18376c write README
* 6d77dca configure Git
```
_Note_: Notice what happened with commits `"define living-room-light trait on-off"` and `"define automation-rules schema"` on branch `living-room-light-automation` after the rebase.
Further, note that all commits on branch `living-room-light-automation` have new commit hashes now.

## Reflect & Review

- What does it mean to rebase a branch onto `main` and how does it differ from merging?
- Why can _rebase_ make reviewing and understanding the history easier?
- How can Git determine that a commit does not need to be replayed?
- How is the story told by a rebased branch different from the story told by a merge commit?
