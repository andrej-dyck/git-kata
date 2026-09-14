# 109 Interactive Rebase - Commits bearbeiten

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Häufig stellen wir fest, dass wir Commits bearbeiten müssen, um _Fehler zu beheben_ oder _Code zu verbessern_, der mit diesem Commit eingeführt wurde.

Während [`git commit --amend`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) es uns erlaubt, den neuesten Commit zu bearbeiten (vgl. [Übung 101](../101-local-amend-commit/README.md)), können wir mit [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) jeden beliebigen Commit in einer linearen Historie bearbeiten.

![](../resources/main-feature-with-commit-for-modification.svg)

Diese Übung hilft dir zu verstehen, wie du den [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzt, um Commits zu _bearbeiten_ (`edit`).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commits mittels Interactive Rebase bearbeiten

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` committet.

Nachdem wir die Automatisierungsregeln fertiggestellt hatten, fiel uns auf, dass wir die _Namenskonvention_ unseres Teams für _Geräte-_ und _Regel-IDs_ nicht eingehalten haben.
Beispielsweise haben wir `"ac"` als _Geräte-ID_ und `"ac-on"` als _Regel-ID_ verwendet. Es hätte jedoch `"living-room-ac"` und `"living-room-ac-on"` heißen sollen.

_Bearbeite_ die Commits `"install living-room AC"` und `"automate living-room AC"` in einer einzigen _Interactive-Rebase_-Session.
Beachte, dass wir auch neue Commits erstellen und diese per _Squash_ mit den alten Commits zusammenführen könnten; manchmal ist es jedoch nützlich, Änderungen direkt im Kontext des alten Commits vorzunehmen, z. B. bei der Verwendung automatisierter Refactoring-Aktionen.

_Tipp_: Um alte Commits zu bearbeiten, verwende die Option `edit` von [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i).
Dadurch stoppt der Rebase bei diesem Commit und lässt uns Änderungen per Amend anbringen.

- Bearbeite den Commit `"install living-room AC"` wie folgt:
  ```diff
  --- a/devices.json
  +++ b/devices.json
  @@ -21,8 +21,8 @@
         "type": "sensor"
       },
       {
  -      "id": "ac",
  -      "name": "AC",
  +      "id": "living-room-ac",
  +      "name": "Living-room AC",
         "roomId": "living-room",
         "type": "ac-unit",
         "traits": [
  ```
- Bearbeite den Commit `"automate living-room AC"` wie folgt:
  ```diff
  --- a/automation-rules.json
  +++ b/automation-rules.json
  @@ -3,7 +3,7 @@
     "apiVersion": "1.0",
     "rules": [
       {
  -      "id": "ac-on",
  +      "id": "living-room-ac-on",
         "name": "Turn on living-room AC when its hot",
         "when": [
           {
  @@ -17,7 +17,7 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-on",
             "parameters": {
               "targetTemperatureCelsius": 21.0
  @@ -26,7 +26,7 @@
         ]
       },
       {
  -      "id": "ac-off-temperature",
  +      "id": "living-room-ac-off-temperature",
         "name": "Turn off living-room AC when its cool",
         "when": [
           {
  @@ -36,13 +36,13 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-off"
           }
         ]
       },
       {
  -      "id": "ac-off-balcony",
  +      "id": "living-room-ac-off-balcony",
         "name": "Turn off living-room AC when balcony door open",
         "when": [
           {
  @@ -52,7 +52,7 @@
         ],
         "then": [
           {
  -          "deviceId": "ac",
  +          "deviceId": "living-room-ac",
             "action": "turn-off"
           }
         ]
  ```

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 65d5315 (HEAD -> living-room-ac-automation) automate living-room AC
* 3b31497 install living-room balcony-door sensor
* 5b7eeba install living-room thermostat sensor
* 95621c0 install living-room AC
* 2884e2f define traits for devices
* 6973a59 define automation-rules schema
| * 8e310a3 (living-room-light-automation) automate living-room light
| * bb583ed define automation-rules schema
| * b19d133 install living-room ambient-light sensor
| * d38f3e6 install living-room presence sensor
| * ad9c8d9 define living-room-light trait on-off
|/
* 797df09 (main) install living-room light
* 6b0023f define devices schema
* ab49d65 register living room
* 740cb26 define rooms schema
* ce3cbc0 write README
* 229fdbc configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 53dd464 (HEAD -> living-room-ac-automation) automate living-room AC
* 99017e2 install living-room balcony-door sensor
* b66fa4c install living-room thermostat sensor
* 38a7b1e install living-room AC
* 2884e2f define traits for devices
* 6973a59 define automation-rules schema
| * 8e310a3 (living-room-light-automation) automate living-room light
| * bb583ed define automation-rules schema
| * b19d133 install living-room ambient-light sensor
| * d38f3e6 install living-room presence sensor
| * ad9c8d9 define living-room-light trait on-off
|/
* 797df09 (main) install living-room light
* 6b0023f define devices schema
* ab49d65 register living room
* 740cb26 define rooms schema
* ce3cbc0 write README
* 229fdbc configure Git
```
_Hinweis_: Nach dem Bearbeiten des Commits `"install living-room AC"` haben alle nachfolgenden Commits neue Commit-Hashes.

## Reflektieren & Wiederholen

- Wann ist das Bearbeiten eines früheren Commits besser als das Hinzufügen eines neuen Korrektur-Commits?
- Warum kann das Modifizieren eines früheren Commits Konflikte in späteren Commits verursachen?
- Wie unterscheidet sich das Bearbeiten eines früheren Commits vom Anpassen des aktuellen HEAD per Amend?
