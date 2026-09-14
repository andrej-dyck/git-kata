# 303 Verlorene Commits mit Git-Reflog wiederherstellen

Bei destruktiven Operationen wie [`git reset --hard origin/main`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) oder [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) kann es passieren, dass man versehentlich wichtige Commits überschreibt und Arbeit verliert.

Glücklicherweise bietet Git mit dem [_Git-Reflog_](https://git-scm.com/book/en/v2/Git-Internals-Maintenance-and-Data-Recovery#_data_recovery) eine Möglichkeit, _verlorene_ Commits[^1] wiederherzustellen.
[`git reflog`](https://git-scm.com/docs/git-reflog) zeigt uns verworfene Commits an, die wir mit Werkzeugen wie [Cherry-Picking](https://git-scm.com/docs/git-cherry-pick), [Branching](https://git-scm.com/docs/git-branch) oder [Git-Reset](https://git-scm.com/docs/git-reset) wiederherstellen können.

[^1]: Git kennt die verworfenen Commits nur innerhalb deines lokalen Repositorys; es ist wie ein lokales Protokoll.
Wenn du jedoch [`git gc`](https://git-scm.com/docs/git-gc) oder `git reflog drop` ausführst oder das gesamte lokale Repository löschst, geht die Möglichkeit zur Wiederherstellung per Reflog verloren.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ gearbeitet, unseren Branch aufgeräumt und möchten nun die neuesten Änderungen von `main` mittels _Rebase_ integrieren.

## Aufgabe: Commits verlieren und anschließend wiederherstellen

Wir haben unser Feature fertiggestellt und unseren Branch aufgeräumt. Doch anstatt den Branch auf `main` zu _rebasen_, haben wir versehentlich einen _Hard-Reset_ ausgeführt.
Dadurch haben wir unabsichtlich einige Commits verloren, und da wir länger nicht gepusht haben, enthält `origin/living-room-ac-automation` nur alte Commits.

Nutze `git reflog`, um die verlorene Commit-Historie zu finden und _wiederherzustellen_.

Sobald wir unsere Historie zurückhaben, nutze `git rebase`, um die aktuellen Änderungen von `main` zu integrieren, und führe einen _Force-Push_ nach `origin` durch.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* ab4b7bc (HEAD -> living-room-ac-automation, origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
| * d5f7c8f (origin/living-room-ac-automation) WIP ac on
| * 7304bc0 define automation-rules schema
| * 4632064 WIP sensors
| * da3763e install ac
|/
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```
_Hinweis_: Unsere _verlorenen_ Änderungen auf `living-room-ac-automation` sind mit `git log` nicht sichtbar.

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* 8e384f9 (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 167e817 install living-room balcony-door sensor
* 273669c automate turning off living-room AC
* 14e4e1c automate turning on living-room AC
* 51db3d2 install living-room thermostat sensor
* c5264e6 install living-room AC
* ab4b7bc (origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
| * d5f7c8f (origin/living-room-ac-automation) WIP ac on
| * 7304bc0 define automation-rules schema
| * 4632064 WIP sensors
| * da3763e install ac
|/
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```
_Hinweis_: Nach der Wiederherstellung unserer verlorenen Änderungen und dem Rebase auf `main` haben wir eine lineare Historie erreicht, ohne die Arbeit doppelt machen zu müssen.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 8e384f9 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 167e817 install living-room balcony-door sensor
* 273669c automate turning off living-room AC
* 14e4e1c automate turning on living-room AC
* 51db3d2 install living-room thermostat sensor
* c5264e6 install living-room AC
* ab4b7bc (origin/main, main) define automation-rules schema
* feb70e5 define traits for devices
* 4eaed49 install living-room light
* 055027d define devices schema
* 62fdd8a register living room
* 6cdb153 define rooms schema
* e95970f write README
* 5b78593 configure Git
```

## Reflektieren & Wiederholen

- Warum können Commits als _"verloren"_ erscheinen, obwohl Git sie möglicherweise noch kennt?
- Wo liegen die Grenzen der Wiederherstellung über das _Reflog_?
- Welche Gewohnheiten verringern die Wahrscheinlichkeit, dass eine Reflog-Wiederherstellung erforderlich wird?
