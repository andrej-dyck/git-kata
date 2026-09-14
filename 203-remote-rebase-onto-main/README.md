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
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
| * c26c0d5 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
| * 320820f define automation-rules schema
| * 9ac7d52 define living-room-light trait on-off
| * b7fab4d install living-room ambient-light sensor
| * ab6e9f2 install living-room presence sensor
|/
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Hinweis_: Beachte, wie `"install living-room AC"` und `"define living-room-light trait on-off"` beide Änderungen an `devices.schema.json` vornehmen. Außerdem wurde `"define automation-rules schema"` auf `main` aus `living-room-light-automation` _cherry-picked_.

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* f1c0b20 (HEAD -> living-room-light-automation) automate living-room light
* 1b2180b define living-room-light trait on-off
* 1e56542 install living-room ambient-light sensor
* 3a3605f install living-room presence sensor
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
| * c26c0d5 (origin/living-room-light-automation) automate living-room light
| * 320820f define automation-rules schema
| * 9ac7d52 define living-room-light trait on-off
| * b7fab4d install living-room ambient-light sensor
| * ab6e9f2 install living-room presence sensor
|/
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Hinweis_: Ein Git-Client zeigt für diesen Graphen so etwas wie `↓5 ↑8` an.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* f1c0b20 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* 1b2180b define living-room-light trait on-off
* 1e56542 install living-room ambient-light sensor
* 3a3605f install living-room presence sensor
* 00f1515 (origin/main, main) define automation-rules schema
* bc034f3 install living-room balcony-door sensor
* 205e2d4 install living-room thermostat sensor
* 4ca4d1c install living-room AC
* 6f16dfe install living-room light
* d75c547 define devices schema
* 6db1232 register living room
* bcd8abe define rooms schema
* bd3f9de write README
* ec8e764 configure Git
```
_Hinweis_: Beachte, dass `"define living-room-light trait on-off"` keine Änderungen mehr an `devices.schema.json` enthält und dass `"define automation-rules schema"` aus `living-room-light-automation` entfernt wurde.

## Reflektieren & Wiederholen

- Warum erscheint der Remote-Branch nach einem lokalen Rebase als _"nicht synchron"_?
- Welche Risiken birgt das Force-Pushen eines umgeschriebenen Feature-Branches?
- Warum ist das Rebasen von Feature-Branches oft akzeptabel, während das Rebasen von `main` meist vermieden werden sollte?
