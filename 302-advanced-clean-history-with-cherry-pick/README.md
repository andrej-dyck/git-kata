# 302 Eine saubere Historie durch Cherry-Picken von Commits aufbauen

Das _Cherry-picking_ eines Commits ist nützlich, wenn wir Änderungen aus diesem Commit in einen anderen Branch übernehmen möchten (vgl. [Übung 113](../113-local-cherry-pick-commits/README.md)).

Es kann auch nützlich sein, um aus einem unordentlichen oder experimentellen Branch eine saubere, zielgerichtete Historie aufzubauen, indem wir nur die Commits _cherry-picken_, die die tatsächlich gewünschten Änderungen darstellen.

Diese Übung zeigt, wie man [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick) verwendet, um eine unordentliche Git-Historie aufzuräumen.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ gearbeitet und unsere Work-in-Progress (_WIP_)-Änderungen gepusht.
Zuvor haben wir `main` über einen _Merge-Commit_ in unseren Branch gemergt.
Als unser Branch voranschritt, entwickelte sich auch `main` weiter, und nun müssen wir beide Branches integrieren und Konflikte lösen.

## Aufgabe: Commits selektiv cherry-picken, um eine saubere Historie zu erstellen

Zu diesem Zeitpunkt ist `living-room-ac-automation` fertig und wir müssen `main` in unseren Branch integrieren.
Wir haben `main` zuvor jedoch mit einem [_Merge-Commit_](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) integriert, was uns nun daran hindert, einen [Git Rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) durchzuführen (vgl. [Übung 104](../104-local-rebase-onto-main/README.md) und [Übung 203](../203-remote-rebase-onto-main/README.md)).

Um eine lineare Historie zu konstruieren, bauen wir das Feature von Grund auf neu auf:

- Brich den laufenden [_Git-Merge_](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) mit [`git merge --abort`](https://git-scm.com/docs/git-merge#Documentation/git-merge.txt---abort) ab
- Setze den lokalen Branch `living-room-ac-automation` per [_Hard-Reset_](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified) mit [`git reset --hard origin/main`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) auf `origin/main` zurück
- Wende selektiv [_Cherry-Pick_](https://git-scm.com/docs/git-cherry-pick) auf Commits von `origin/living-room-ac-automation` auf unseren sauberen `living-room-ac-automation`-Branch an, löse auftretende Konflikte und formuliere Commits _um_
- Denke daran, die Eigenschaft `testMode` aus den AC-Automatisierungsregeln zu entfernen

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 4ec1b9e (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) DELETE! balcony-door test value door-opened
* e78e489 DELETE! thermometer test value 26°C
* e846129 DELETE! balcony-door test value door-closed
* 42d8a6a WIP ac on/off + balcony door
* 2c1860f install balcony door
* 6222725 DELETE! thermometer test value 19°C
* f98abd4 DELETE! thermometer test value 26°C
*   7ff5376 Merge remote-tracking branch 'origin/main' into living-room-ac-automation
|\
* | aa4f9c9 WIP ac off
* | f9d9b06 WIP ac on
* | d8896c9 WIP automation rules schema
* | 1612f14 install thermostat
* | 19804cd install ac
| | * f7987c2 (origin/main, main) automate living-room light
| | * bcf20e3 define living-room-light trait on-off
| | * 4f7edc7 install living-room ambient-light sensor
| | * e36a924 install living-room presence sensor
| |/
| * 8e983c1 define automation-rules schema
| * a522a7d define traits for devices
|/
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Hinweis_: Der Merge-Commit `"Merge remote-tracking branch 'origin/main' into living-room-ac-automation"` hat `main` bereits integriert und einige Konflikte gelöst. `main` hat sich jedoch weiterentwickelt und wir müssen erneut integrieren.

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* aced70a (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 3c7bc8b install living-room balcony-door sensor
* 004c81a automate turning off living-room AC
* 6baa5db automate turning on living-room AC
* 94fd1f5 install living-room thermostat sensor
* 30d81e0 install living-room AC
* f7987c2 (origin/main, main) automate living-room light
* bcf20e3 define living-room-light trait on-off
* 4f7edc7 install living-room ambient-light sensor
* e36a924 install living-room presence sensor
| * 4ec1b9e (origin/living-room-ac-automation) DELETE! balcony-door test value door-opened
| * e78e489 DELETE! thermometer test value 26°C
| * e846129 DELETE! balcony-door test value door-closed
| * 42d8a6a WIP ac on/off + balcony door
| * 2c1860f install balcony door
| * 6222725 DELETE! thermometer test value 19°C
| * f98abd4 DELETE! thermometer test value 26°C
| *   7ff5376 Merge remote-tracking branch 'origin/main' into living-room-ac-automation
| |\
| |/
|/|
* | 8e983c1 define automation-rules schema
* | a522a7d define traits for devices
| * aa4f9c9 WIP ac off
| * f9d9b06 WIP ac on
| * d8896c9 WIP automation rules schema
| * 1612f14 install thermostat
| * 19804cd install ac
|/
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Hinweis_: Zu diesem Zeitpunkt weicht der lokale Branch `living-room-ac-automation` vollständig von `origin` ab und besteht aus neu cherry-gepickten Commits.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* aced70a (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 3c7bc8b install living-room balcony-door sensor
* 004c81a automate turning off living-room AC
* 6baa5db automate turning on living-room AC
* 94fd1f5 install living-room thermostat sensor
* 30d81e0 install living-room AC
* f7987c2 (origin/main, main) automate living-room light
* bcf20e3 define living-room-light trait on-off
* 4f7edc7 install living-room ambient-light sensor
* e36a924 install living-room presence sensor
* 8e983c1 define automation-rules schema
* a522a7d define traits for devices
* 11a4741 install living-room light
* 063a8b4 define devices schema
* 20e9314 register living room
* 91afadf define rooms schema
* f2e38bc write README
* d663a0b configure Git
```
_Hinweis_: Nach dem _Force-Push_ haben wir eine lineare Historie mit guten Commits (atomar, deskriptiv, kohärent), die leicht verständlich ist.

## Reflektieren & Wiederholen

- Warum können Merge-Commits spätere Bereinigungen der Historie erschweren?
- Wie wirken sich kurzlebige im Vergleich zu langlebigen Branches auf Integrations- und Aufräumarbeiten aus?
- Welche Risiken birgt die Verwendung von `git reset --hard` vor dem Neuaufbau des Branches und welche Alternativen gibt es?
