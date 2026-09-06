# Git Kata - Clean History

[![CI](https://github.com/andrej-dyck/endoflife-radar/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/andrej-dyck/git-kata/actions/workflows/ci.yml)

![Git Logo](./resources/git-logo.png)

A _clean Git history_ is linear, coherent, and intentional; and therefore easier to read, navigate, and reason about.

A well-tended Git history tells the story of the project's logical evolution: _which_ changes were made and, more importantly, _why_.
It should help us understand the project, not how the team happened to work.

We should be able to look at the history and answer questions such as: _What changed? Why? What decisions led to this change? How has the project evolved? When did a particular change or problem emerge (supported by [Git bisect](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search))?_

[Good commit messages](https://chris.beams.io/posts/git-commit/) are an important part of a clean Git history, but they are not enough on their own.
To improve the readability of the project's history, we want _atomic commits_ (small, coherent, and working) in a logical, linear sequence.

Working with [Trunk-based Development](https://trunkbaseddevelopment.com/) or [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow) helps us to maintain linear history:

![Git trunk-based linear history](resources/git-trunk-based.svg)

Or this, when working with merge PRs:

![Git oneflow linear history](resources/git-oneflow.svg)

Compare those linear histories to one that a typical [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) produces; and that's only the `develop` branch with three developers committing work:

![typical GitFlow history](./resources/git-merge-3-devs.svg)

But a linear history alone is not necessarily a _clean history_. The commits themselves should still be atomic, coherent, and intentional.
And tending to the Git history requires focus and discipline.

Fortunately, Git allows us to revise the commit history later by [rewriting the history](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
With these tools, we can _"refactor"_ our history before we share it with others.

## About this Git Kata
This kata focuses on creating a clean and linear Git history by using Git's [history rewriting](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History) features.

This kata assumes that you already have basic Git knowledge; e.g., how to _stage_ files, _commit_ changes, _push_ to origin, _fetch_ and _pull_ from remote, _branching_, and work with the _Git log_.

## Doing this Git Kata

**_IMPORTANT_**: 🚧 This Git kata is currently under rework. Checkout tag [`2021-git-kata-kotlin-exercise`](https://github.com/andrej-dyck/git-kata/releases/tag/2021-git-kata-kotlin-exercise) (or [`2021-git-kata-osx-kotlin-exercise`](https://github.com/andrej-dyck/git-kata/releases/tag/2021-git-kata-osx-kotlin-exercise) for Mac OS X) for an earlier version.

Each exercise is self-contained, even when they refer to previous exercise numbers; the task is described in the `README.md` file.

Each exercise is safe to experiment with, as a local-only repository is set up by an `init.sh` _bash script_ and, if stuck, you can always re-run the `init.sh` again.

It is highly recommended to use a graphical (GUI) Git client for the exercises.

Each exercise ends in a clean working tree (i.e., `git status` shows no changes), a clean staging area (i.e., `git diff --staged` shows no changes), and a _clean_ history (i.e., `git log --oneline --graph --decorate --all` shows the target history).

Each exercise is categorized by a number and a name; e.g., `101-local-amend-commit`.
The one-hundreds `1xx` are exercises with just a local repository; i.e., no _origin_/_remote_ repository.
The two-hundreds `2xx` are exercises with a local repository and a local _origin_/_remote_ repository.
The three-hundreds `3xx` are advanced Git exercises.

### Quick Start
* Ensure the latest [Git](https://git-scm.com/) is installed
* Clone this `git-kata` repository
  ```shell
  git clone --depth 1 https://github.com/andrej-dyck/git-kata.git && cd git-kata && rm -rf .git
  ```
* Run a `<NNN-exercise>/init.sh` to initialize the exercise in `<git-kata-root>/exercise`
  * Note that by default, each `init.sh` will use this folder and overwrite any existing content
  * You can use [Docker]([Docker](https://www.docker.com/)) to run the scripts in isolation
* Open the created/updated folder `<git-kata-root>/exercise` with your favorite Git client
* Consult the `README.md` in that folder for the description of the task

_Optional_: Cleanup isn't required, but if you want to, just remove the `exercise` _repository_ folder and its _origin_ folder `exercise-origin`.

#### Custom Exercise Folder
Use `init.sh "path-to-exercise"` to use a different exercise folder; e.g., `init.sh "./exercise-101"`. Note that relative links or images in `README.md` might not work, and you will need to open each custom exercise folder in your Git client.

### Isolated Execution with Docker
Use [Dockerfile](./Dockerfile) and [Docker](https://www.docker.com/) to run this kata's _bash scripts_ isolated from your operating system.

Run the following command in `<git-kata-root>`, after cloning this repository:
```shell
docker build -t git-kata . && docker run --rm -it -v "./:/git-kata" git-kata
```

Within the Docker container, use `<NNN-exercise>/init.sh` to initialize an exercise.
And since `/git-kata` is mounted to your local folder, you can open the `./exercise` folder with your local Git client.

### Local Execution
* On **Windows** with [**Git**]([Git](https://git-scm.com/)) installed, use the _Git Bash_ with `sh init.sh` to execute the script
* On **Linux** / **Mac OS X**, you might need to make the `init.sh` executable with `chmod +x init.sh`

#### `jq` Dependency
[jq](https://jqlang.org/) is a lightweight and flexible command-line JSON processor.
If you have `jq` (or `jaq`) installed and in your `PATH`, the `init.sh` script will automatically use it.
Otherwise, the scripts will try to use the bundled `jq` binary (version `jq-1.8.2`).
Or you can install it from [here](https://jqlang.org/).

## Recommended Way of Working with Git as a Team

### Atomic Commits
An **atomic commit** represents a _single_, _self-contained_, and _coherent unit of change_ that keeps the codebase in a working and testable state.

If you drop, revert, or extract (cherry-pick) this commit, it should only affect that specific change without breaking anything else.

_Rule of thumb_: if you cannot easily summarize the change in a single concise subject line, the commit is likely not atomic.

### Good Commit Messages
Follow the core principles of [good commit messages](https://chris.beams.io/posts/git-commit/) (adapted with lowercase imperative verbs).

The **subject line** is a concise summary of _what_ the commit does starting with a lowercase imperative verb (e.g., `add`, `introduce`, `draft`, `model`, `configure`, `fix`).
* Guideline: _"If applied, this commit will ..."_

The **body** (optional, separated by an empty line from the subject) explains _why_ the change was made and the context behind it.

### One Main Branch
Maintain one `main` branch for all environments, including production.
It is recommended to protect this `main` branch from history rewrites.

Every commit on `main` must be continuously deployed; i.e., it must be releasable and production-ready.

Avoid long-lived branching schemes; e.g., GitFlow's `develop`, `release`, and `support` branches. Read also [GitFlow considered harmful](https://www.endoflineblog.com/gitflow-considered-harmful)

### Short-lived Branches
When using branches, keep them _short-lived_ and integrate them into `main` as soon as possible; ideally within minutes or hours.

Rebase frequently onto `main` to stay in sync and prevent merge conflicts.

### Enforce a Linear Commit History
Keep the commit history linear by using [Git _rebase_](https://git-scm.com/docs/git-rebase).
A linear history is easier to read, navigate, and reason about.
It better represents the logical evolution of the project.

The idea that [Git _merge_](https://git-scm.com/docs/git-merge) preserves the _"true"_ history, and that this therefore has significant value is a straw-man argument.
While _merge commits_ accurately record _when_ branches were integrated, they add noise and make it harder to follow the actual changes.
This is especially true when merge conflict resolutions combine unrelated changes.

Keeping the history clean, focused, and linear improves team collaboration and makes maintenance easier with [Git's rewriting tools](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
It also makes [debugging with Git, e.g., bisecting,](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search) easier because each commit represents a clear step in the development.

The goal is to preserve a history of the project's logical evolution; not the history of branch integration.

## Links and Resources

The [Git version control system](https://git-scm.com/)

### Other Git Katas
* [eficode-academy/git-katas](https://github.com/eficode-academy/git-katas)
* [Git Immersion - A guided tour](https://gitimmersion.com/)

### Naming Conventions
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
* [Atlassian - learn Git](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
* [Git Happens - Jessica Kerr](https://www.youtube.com/watch?v=yCh6TSLIQBQ)
* [Git Fu Developing - Sebastian Feldmann](https://www.youtube.com/watch?v=FfaGUy-l1rs)
* [How Effective Teams Use Git - Enrico Campidoglio](https://www.youtube.com/watch?v=jw8yK5JV0xw)
* [Learn Git Branching](https://learngitbranching.js.org/)

### Recommended Git Clients
* [Git in JetBrains IDEs (e.g., IntelliJ)](https://www.jetbrains.com/help/idea/version-control-integration.html) (free with community edition IDEs)
* [SmartGit](https://www.syntevo.com/smartgit/) (paid, free for personal-use and OSS)
* [Fork](https://git-fork.com/) (paid, free evaluation)
* [GitKraken](https://www.gitkraken.com/git-client) (paid, free for OSS)
* here you can find some other [Git-GUIs](https://git-scm.com/tools/guis)

### Other Useful Tools
* [gitignore.io](https://www.toptal.com/developers/gitignore)
