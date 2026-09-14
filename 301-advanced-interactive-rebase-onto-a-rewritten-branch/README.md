# 301 Interactive Rebase auf einen umgeschriebenen Branch

Gelegentlich committen wir Arbeiten auf einen Branch, der auf origin umgeschrieben wurde.
Dies kann passieren, wenn wir auf verschiedenen Rechnern arbeiten, mit anderen zusammenarbeiten oder Änderungen frühzeitig über andere Branches integriert haben.

Wie in [Übung 205](../205-remote-rewriting-history-with-teammates/README.md) angedeutet, können sowohl unser lokaler Branch als auch `origin` Änderungen enthalten, die wir behalten möchten.
In diesem Fall wollen wir Commit für Commit entscheiden, welche Änderungen beibehalten werden sollen.

Um beide Historien sauber zusammenzuführen, können wir den [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) gefolgt von einem [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) nutzen, um eine saubere Historie zu veröffentlichen.
Hierbei besteht der allgemeine Ansatz darin, obsolete Commits aus unserem Branch zu _löschen_ oder die Konflikte während des Rebase auf `origin` manuell aufzulösen.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ gearbeitet und unsere Work-in-Progress (_WIP_)-Änderungen gepusht.
In der Zwischenzeit haben wir (oder ein Teammitglied) auf einem anderen Rechner die Historie aufgeräumt; allerdings vor den finalen Änderungen.
Nun, da wir das Feature für den _Balkontür_-Sensor und die zugehörigen Regeln fertiggestellt haben, enthalten sowohl unser Branch als auch `origin` Änderungen, die wir behalten möchten.

## Aufgabe: Die Git-Historie umschreiben und eine saubere Historie erstellen

Führe beide Historien von `living-room-ac-automation` und dessen `origin`-Gegenstück zusammen, um mithilfe des _interaktiven Rebase_ eine saubere Historie zu erstellen.

Auf unserem lokalen Branch haben wir das Feature erweitert, indem wir die Wohnzimmer-Klimaanlage basierend auf dem _Balkontürsensor_ automatisieren.

Auf `origin` haben die Commits saubere Commit-Messages und die Eigenschaft `testMode` wurde aus den AC-Automatisierungsregeln entfernt.
Außerdem wurden dort die beiden Automatisierungs-Commits per _Squash_ zu einem zusammengeführt.

Beachte auch, dass `main` mit `"define automation-rules schema"` eine vollständigere Version von `automation-rules.schema.json` besitzt als unser `"WIP automation rules schema"`.

Führe schließlich einen zweiten _interaktiven Rebase_ durch, um die Eigenschaft `testMode` zu entfernen und den per Squash zusammengefassten Commit `"automate living-room AC"` wieder in separate Commits aufzuteilen.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 3afe36c (HEAD -> living-room-ac-automation) WIP ac on/off + balcony door
* e5a2b2e install balcony door
* 4ac17e9 WIP ac off
* cfc5079 WIP ac on
* 3ee528b WIP automation rules schema
* fe9c73f install thermostat
* bbb4ef4 install ac
| * d649317 (origin/living-room-ac-automation) automate living-room AC
| * 1c91238 install living-room thermostat sensor
| * 5ef35c3 install living-room AC
| * 6eec9c2 (origin/main, main) define automation-rules schema
| * 64f6b9c define traits for devices
|/
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Hinweis_: Sowohl `living-room-ac-automation` als auch `origin` enthalten neuere Änderungen, die wir behalten möchten.
Ein Git-Client zeigt für diesen Graphen so etwas wie `↓5 ↑7` an.

### Git-Historie nach dem 1. interaktiven Rebase
```console
$ git log --oneline --graph --decorate --all
* 5a0e09f (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 53fc8ab install living-room balcony-door sensor
* d649317 (origin/living-room-ac-automation) automate living-room AC
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Hinweis_: Nach dem ersten _interaktiven Rebase_ auf `origin/living-room-ac-automation` sollten wir zwei neuere Commits (`↑2`) und eine lineare Historie haben.

### Git-Historie vor dem Push (nach dem 2. interaktiven Rebase)
```console
$ git log --oneline --graph --decorate --all
* 007d041 (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 180e87b install living-room balcony-door sensor
* bb786d3 automate turning off living-room AC
* f2a15ed automate turning on living-room AC
| * d649317 (origin/living-room-ac-automation) automate living-room AC
|/
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Hinweis_: Nach dem zweiten _interaktiven Rebase_ sollten wir keine `testMode`-Eigenschaft mehr haben und drei Commits zur Automatisierung der Wohnzimmer-Klimaanlage vorfinden.
Da wir dabei sind, `origin` zu überschreiben und einen Commit zu verwerfen, zeigt ein Git-Client etwas wie `↓1 ↑4` an.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 007d041 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 180e87b install living-room balcony-door sensor
* bb786d3 automate turning off living-room AC
* f2a15ed automate turning on living-room AC
* 1c91238 install living-room thermostat sensor
* 5ef35c3 install living-room AC
* 6eec9c2 (origin/main, origin/HEAD, main) define automation-rules schema
* 64f6b9c define traits for devices
* 248b2fe install living-room light
* 393d820 define devices schema
* 9ae03e3 register living room
* 049a7c5 define rooms schema
* 1cf3070 write README
* 3c2ac1a configure Git
```
_Hinweis_: Nach dem _Force-Push_ haben wir schließlich eine lineare Historie mit guten Commits (atomar, deskriptiv, kohärent), die leicht verständlich ist.

## Reflektieren & Wiederholen

- Warum ist es schwieriger, Historien abzugleichen, wenn sowohl der lokale Branch als auch `origin` Änderungen enthalten, die wir behalten möchten?
- Was macht einen Commit obsolet?
- Warum ist es nützlich, diese Bereinigung Commit für Commit durchzuführen, anstatt eine Historie pauschal zu übernehmen?
- Wie verbessert sich die finale Historie im Vergleich zu den anfänglich auseinandergelaufenen Historien?
