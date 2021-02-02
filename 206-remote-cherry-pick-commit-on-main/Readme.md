# Cherry-picking a commit on wrong branch

Sometimes we change tasks often or are eager to start working that we commit changes to the wrong branch. Here, we can use [cherry-pick](https://git-scm.com/docs/git-cherry-pick) to _apply_ the commits changes to the correct branch and [`git reset --hard`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) to remove the commit from the wrong branch.

## Exercise

In this exercise, we changed workstations and unintentionally worked on `main` and committed the changes without realizing it. Change to the `feature` branch and _cherry-pick_ this commit (re-wording the message). Once you pushed the `feature` branch to origin, remove the commit from main.

