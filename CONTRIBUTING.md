# Developing Exercises for Git Kata

## Use Exercise README Template

````markdown
# [NNN] [Title]

TODO Git command, its purpose, and how we can use it to develop a clean git history.

## Exercise Context

We are working on a _Smart Home_ project, where its configuration is split across three primary data files: `rooms.json`, `devices.json`, and `automation-rules.json`.

TODO current state of the project.

## Task: [Task Title]

TODO this exercise's task

### Initial Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after `init.sh`
```
_Note_: ...

### Target Git History
```console
$ git log --oneline --graph --decorate --all
TODO git log output after exercise is done
```
_Note_: ...
````

## Use Exercise `init.sh` Template

```shell
#!/usr/bin/env bash
source "$(dirname "${BASH_SOURCE[0]}")/../scripts/index.sh"
# source "$REPO_ROOT_DIR/<other-exercise>/init.sh"

init-exercise() {
  local thisDir="$1" exerciseDir="$2"

  init-exercise-repo "$exerciseDir" "$thisDir/README.md" || return
  # OR: init-exercise-repo-with-origin "$exerciseDir" "$thisDir/README.md" || return

  # TODO setup git history for exercise
}

run-init-exercise "$@"
```

## Details to get Right

- Make sure all `.sh` files and `README.md` use Unix line ending LF (`\n`)
- Make sure all `init.sh` files have `+x` permission using `git update-index --chmod=+x init.sh`
- Make sure to run `./scripts/_dev-test-init.sh <exercise> 10` to catch any flaky-ness in Git history creation (since the commits are committed almost at the same time)
- Include the test run for the exercise in `./.github/workflows/ci.yml`
