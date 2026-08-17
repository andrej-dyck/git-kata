# Git Kata - Clean History

![Git Logo](./resources/git-logo.png)

A clean Git history is beneficial to a project in many ways. 
Similar to how clean code documents the current state of the software, a well-tended Git log documents what changes happened and why. 
For example,
* _What is the design decision in a pull request?_
* _What has happened since the last fetch?_
* _Why did the implementation of a function change?_
* _Was this a refactoring or a change in functionality?_
* _When did the bug get introduced? (supported by git-bisect)_

However, [good commit messages](https://chris.beams.io/posts/git-commit/) are not enough for a clean Git history, and we need to tend to and "refactor" our history before we "commit" to it; or in other words, [rewrite the history](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History). 
To this end, we want to have coherent, small, and working commits (**atomic commits**). 
Further, a linear history helps to comprehend the sequence of changes more easily.

To visualize this, we want to go from this kind of Git log (here, 3 developers worked in parallel using [GitFlow overview](https://datasift.github.io/gitflow/IntroducingGitFlow.html))

![Git merge](./resources/git-merge-3-devs.svg)

to this kind of linear history (here, 5 developers worked in parallel using [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow))

![Git rebase](./resources/git-rebase-5-devs.svg)

or even as linear as [Trunk-based Development](https://trunkbaseddevelopment.com/).

![Git oneflow](./resources/git-one-flow.svg)

### Note
This kata assumes that you are already have basic Git knowledge; e.g., how to _stage_ files, _commit_ changes, _push_ to origin, _fetch_ and _pull_ from remote, _branching_, and work with the _Git log_.

---

## How To / Quick Start

Each exercise is set up by an `init.sh` _bash_ script. 
When run, it will create/overwrite an `exercise` folder with a local Git repository in a prepared task.

* Ensure the latest `Git` is installed and available in the shell
* Navigate to the folder of an exercise; e.g., `101-local-amend-commit`
* Run `./init.sh` within that folder
  - On Windows, use _Git BASH_ or other Bash emulators
* Open the created/updated folder `../exercise` with your favorite Git client
* Consult the README.md in that folder for the description and task

### Note
On Mac OS X, checkout the branch [`main-osx`](https://github.com/andrej-dyck/git-kata/tree/main-osx)

---

## Links and Resources

The [Git version control system](https://git-scm.com/)

### Katas inspired by
* [eficode-academy/git-katas](https://github.com/eficode-academy/git-katas)
* [Git Immersion - A guided tour](https://gitimmersion.com/)

### Naming conventions
* [Git commit message](https://chris.beams.io/posts/git-commit/)
* [Providing context with commit messages](https://testing.googleblog.com/2017/09/code-health-providing-context-with.html)
* [Git branch naming](https://deepsource.io/blog/git-branch-naming-conventions/)

### Workflows
* [Comparing workflows](https://www.atlassian.com/git/tutorials/comparing-workflows)
* [Trunk-based Development](https://trunkbaseddevelopment.com/)
* [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow)
* [GitFlow overview](https://datasift.github.io/gitflow/IntroducingGitFlow.html)
* [Enhanced GitFlow](https://www.toptal.com/gitflow/enhanced-git-flow-explained)

### Merge & Rebase
* [Merge vs Rebase](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
* [Interactive Rebase](https://www.atlassian.com/git/tutorials/rewriting-history)

### Tutorials & Talks
* [Atlassian learn Git](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
* [Git Happens - Jessica Kerr](https://www.youtube.com/watch?v=yCh6TSLIQBQ)
* [Git Fu Developing - Sebastian Feldmann](https://www.youtube.com/watch?v=FfaGUy-l1rs)
* [How Effective Teams Use Git - Enrico Campidoglio](https://www.youtube.com/watch?v=jw8yK5JV0xw)
* [Learn Git Branching](https://learngitbranching.js.org/)

### Recommended Git Clients
* [Git-Plugin of JetBrains IDEs (e.g., IntelliJ)](https://www.jetbrains.com/help/idea/version-control-integration.html) (free with community edition IDEs)
* [SmartGit](https://www.syntevo.com/smartgit/) (paid)
* [Fork](https://git-fork.com/) (paid, free evaluation)
* [GitKraken](https://www.gitkraken.com/git-client) (paid, free for OSS)
* here you can find some other [Git-GUIs](https://git-scm.com/tools/guis)

### Other Tools
* [gitignore.io](https://www.toptal.com/developers/gitignore)
