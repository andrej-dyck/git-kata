# 111 Interactive Rebase - Commits löschen

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Ein Vorteil von _atomaren Commits_ (klein, kohärent und funktionsfähig) ist, dass sie das [Umschreiben der Historie](https://git-scm.com/docs/git-rebase#_interactive_mode) hervorragend unterstützen.
Anstatt manuell Änderungen vorzunehmen, um Entscheidungen rückgängig zu machen oder Work-in-Progress zu entfernen, können wir die entsprechenden Commits einfach _löschen_.

Diese Übung hilft dir zu verstehen, wie du den [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzt, um Commits zu _löschen_.

![](../resources/main-feature-with-commit-for-removal.svg)

Nach dem Löschen des Commits auf dem `feature`-Branch ist es so, als hätte er nie existiert:

![](../resources/main-feature-with-removed-commit.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commits mittels Interactive Rebase löschen

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` zusammen mit vielen testbezogenen Commits festgehalten.

Um die Automatisierungsregeln zu testen, haben wir einige Testwerte gesetzt.
Anstatt jedoch die testbezogenen Änderungen mit unserer Logik zu vermischen, haben wir sie sorgfältig in eigene Commits aufgeteilt.
Dadurch können wir diese Commits nun einfach entfernen, als hätten sie nie existiert, anstatt jede Datei manuell prüfen und die Änderungen mühsam zurücknehmen zu müssen.

Nutze den _interaktiven Rebase_, um diese Commits zu _löschen_ und unsere Git-Historie vor der Integration aufzuräumen.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 9fae271 (HEAD -> living-room-ac-automation) DELETE! balcony-door test value door-opened
* 98d79cb DELETE! thermometer test value 26°C
* 5eae5d0 DELETE! ac on/off with balcony-door testmode
* c2f63dd automate turning on/off living-room AC w/ balcony door
* 459e1f5 DELETE! balcony-door test value door-closed
* dc9f146 install living-room balcony-door sensor
* 7475fff DELETE! thermometer test value 19°C
* d71bd15 DELETE! ac off testmode
* aa7341a automate turning off living-room AC
* aa78a28 DELETE! thermometer test value 24°C
* e1ae49b DELETE! ac on testmode
* 26a970c automate turning on living-room AC
* 6eb6ff1 DELETE! thermometer test value 26°C
* b34232c install living-room thermostat sensor
* ab77be6 install living-room AC
* 0a8d1bc define automation-rules schema
| * 390de11 (living-room-light-automation) automate living-room light
| * c482c2f define automation-rules schema
| * 683cd7c define living-room-light trait on-off
|/
* b6175ca (main) install living-room ambient-light sensor
* ba422f3 install living-room presence sensor
* 106e3b1 install living-room light
* 5c996c3 define devices schema
* ce99479 register living room
* fa90519 define rooms schema
* 2f675cf write README
* 219782e configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* a78a6be (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 9c7189d install living-room balcony-door sensor
* 95f7bd1 automate turning off living-room AC
* dce12c9 automate turning on living-room AC
* b34232c install living-room thermostat sensor
* ab77be6 install living-room AC
* 0a8d1bc define automation-rules schema
| * 390de11 (living-room-light-automation) automate living-room light
| * c482c2f define automation-rules schema
| * 683cd7c define living-room-light trait on-off
|/
* b6175ca (main) install living-room ambient-light sensor
* ba422f3 install living-room presence sensor
* 106e3b1 install living-room light
* 5c996c3 define devices schema
* ce99479 register living room
* fa90519 define rooms schema
* 2f675cf write README
* 219782e configure Git
```

## Reflektieren & Wiederholen

- Was ist der Unterschied zwischen dem Löschen eines Commits und dem Rückgängigmachen eines Commits?
- Wie erleichtert das Isolieren von temporärer Arbeit das spätere Entfernen?
- Welche Arten von temporären Commits sollten niemals `main` erreichen?
