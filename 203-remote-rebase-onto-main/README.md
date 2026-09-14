# 203 Einen gepushten Branch auf `main` rebasen

Um eine lineare Historie beizubehalten, möchten wir unseren Branch vor der Integration auf `main` [rebasen](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) (vgl. [Übung 104](../104-local-rebase-onto-main/README.md)).

Da [`git rebase`](https://git-scm.com/docs/git-rebase) die Git-Historie umschreibt, weicht der Branch von `origin` ab, wenn er bereits in das Remote-Repository gepusht wurde.
Ein Git-Client zeigt typischerweise so etwas wie `↓2 ↑4` an.

![](../resources/main-feature-out-of-sync-origin-after-rebase.svg)

Ein häufiger **Fehler**, den Einsteiger bei _Git rebase_ machen, ist die Verwendung von `git pull` oder `git merge`.
Beide Aktionen führen entweder zum Überschreiben unserer Änderungen oder zu einer unordentlichen Historie mit einem _Merge-Commit_.

Um unsere Änderungen zu veröffentlichen und das Remote-Repository zu aktualisieren, müssen wir [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) verwenden, um den Branch auf `origin` zu überschreiben.

_Hinweis_: Bei der Arbeit mit _Force-Pushes_ können zwei Probleme auftreten:
1. Wir überschreiben versehentlich einen Remote-Branch, den wir gar nicht überschreiben wollten.
   Daher empfiehlt sich `main` vor dem Umschreiben der Historie zu schützen.
2. Andere Teammitglieder haben den Remote-Branch möglicherweise bereits gepullt und darauf gearbeitet.
   Wie wir in solchen Fällen mit anderen zusammenarbeiten, behandeln wir in [Übung 205](../205-remote-rewriting-history-with-teammates/README.md).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Im Anschluss an [Übung 201](../201-remote-amend-commit/README.md) und [202](../202-remote-undo-last-commits/README.md) haben wir alle unsere _Wohnzimmer-Geräte_ erfolgreich installiert und die Implementierung einer Automatisierungsregel für die _Wohnzimmer-Beleuchtung_ abgeschlossen.

Es ist Zeit, unseren Feature-Branch zu integrieren; `main` hat sich in der Zwischenzeit jedoch weiterentwickelt.

## Aufgabe: Branch auf `main` rebasen und Änderungen force-pushen

Während wir an der Licht-Automatisierung gearbeitet haben, hat unser Team weitere Änderungen in `main` integriert.

Um unseren Branch abzuschließen, möchten wir die Änderungen aus `main` mittels [`git rebase`](https://git-scm.com/docs/git-rebase) in unseren Branch `living-room-light-automation` integrieren.
Während des Rebase werden wir voraussichtlich auf Konflikte stoßen.

Da wir unseren Branch bereits gepusht haben, nutze `git push --force-with-lease`, um den Remote-Branch mit der aufgeräumten Historie zu überschreiben.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 11d621e (origin/main, main) define automation-rules schema
* 0b6cfd3 define traits for devices
| * 32caf6f (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
| * a9a5d2f define automation-rules schema
| * ac9d0ce install living-room ambient-light sensor
| * a060542 install living-room presence sensor
| * 53f48ef define living-room-light trait on-off
|/
* f715fcd install living-room light
* 296fd9f define devices schema
* f290e3c register living room
* 9ff6aea define rooms schema
* 0c2ca64 write README
* 6b18d94 configure Git
```
_Hinweis_: Beachte, wie `"install living-room AC"` und `"define living-room-light trait on-off"` beide Änderungen an `devices.schema.json` vornehmen. Außerdem wurde `"define automation-rules schema"` auf `main` aus `living-room-light-automation` _cherry-picked_.

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* 2114c97 (HEAD -> living-room-light-automation) automate living-room light
* 22cfb0f install living-room ambient-light sensor
* 570c3ce install living-room presence sensor
* 9545b9b define living-room-light trait on-off
* 11d621e (origin/main, main) define automation-rules schema
* 0b6cfd3 define traits for devices
| * 32caf6f (origin/living-room-light-automation) automate living-room light
| * a9a5d2f define automation-rules schema
| * ac9d0ce install living-room ambient-light sensor
| * a060542 install living-room presence sensor
| * 53f48ef define living-room-light trait on-off
|/
* f715fcd install living-room light
* 296fd9f define devices schema
* f290e3c register living room
* 9ff6aea define rooms schema
* 0c2ca64 write README
* 6b18d94 configure Git
```
_Hinweis_: Ein Git-Client zeigt für diesen Graphen so etwas wie `↓5 ↑8` an.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 2114c97 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* 22cfb0f install living-room ambient-light sensor
* 570c3ce install living-room presence sensor
* 9545b9b define living-room-light trait on-off
* 11d621e (origin/main, main) define automation-rules schema
* 0b6cfd3 define traits for devices
* f715fcd install living-room light
* 296fd9f define devices schema
* f290e3c register living room
* 9ff6aea define rooms schema
* 0c2ca64 write README
* 6b18d94 configure Git
```
_Hinweis_: Beachte, dass `"define living-room-light trait on-off"` keine Änderungen mehr an `devices.schema.json` enthält und dass `"define automation-rules schema"` aus `living-room-light-automation` entfernt wurde.

## Reflektieren & Wiederholen

- Warum erscheint der Remote-Branch nach einem lokalen Rebase als _"nicht synchron"_?
- Welche Risiken birgt das Force-Pushen eines umgeschriebenen Feature-Branches?
- Warum ist das Rebasen von Feature-Branches oft akzeptabel, während das Rebasen von `main` meist vermieden werden sollte?
