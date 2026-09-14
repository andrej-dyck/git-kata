# 108 Interactive Rebase - Commit-Messages umformulieren

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Es ist wichtig, sich auf den Fortschritt unserer Arbeit zu konzentrieren, weshalb wir Kontextwechsel vermeiden sollten.
Häufiges Committen ist zwar gut, aber schon das Nachdenken über passende Commit-Messages bedeutet kognitive Last, die uns aus dem Fokus bringen kann.
Mit dem _interaktiven Rebase_ können wir Änderungen mit einer schnellen Nachricht committen und sie später umformulieren.

Diese Übung hilft dir zu verstehen, wie du den [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzt, um Commits _umzuformulieren_ (`reword`).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commit-Messages mittels Interactive Rebase umformulieren

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` in kleinen Commits festgehalten und uns nicht allzu viele Gedanken über die Formulierung der Nachrichten gemacht.

Zum Beispiel ist `"ac"` für Work-in-Progress-Commits in Ordnung, sollte jedoch durch eine aussagekräftigere Nachricht wie `"install living-room AC"` ersetzt werden.

_Formuliere_ die Commit-Messages auf `living-room-ac-automation` _um_, um eine schlüssige Story zu erzählen.

Stelle sicher, zusammengehörige WIP-Commits per _Squash_ zu vereinen und die Commit-Message des zusammengeführten Commits _umzuformulieren_.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 3ff3e66 (HEAD -> living-room-ac-automation) WIP automation
* 77c5301 balcony door
* 7fe575b thermometer
* b213a87 fix ac
* 910610c ac
* 0f9b61f define automation-rules schema
| * 087bab5 (living-room-light-automation) automate living-room light
| * d8a17ab define automation-rules schema
| * 08fb7a0 define living-room-light trait on-off
|/
* 37dac97 (main) install living-room ambient-light sensor
* 54599b6 install living-room presence sensor
* 9d41bc1 install living-room light
* 4a17a48 define devices schema
* a601c18 register living room
* 7624ec7 define rooms schema
* 4c8d1a7 write README
* 3c32c60 configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* ebd57ea (HEAD -> living-room-ac-automation) automate living-room AC
* 160300f install living-room balcony-door sensor
* d13e956 install living-room thermostat sensor
* 44e95a3 install living-room AC
* 0f9b61f define automation-rules schema
| * 087bab5 (living-room-light-automation) automate living-room light
| * d8a17ab define automation-rules schema
| * 08fb7a0 define living-room-light trait on-off
|/
* 37dac97 (main) install living-room ambient-light sensor
* 54599b6 install living-room presence sensor
* 9d41bc1 install living-room light
* 4a17a48 define devices schema
* a601c18 register living room
* 7624ec7 define rooms schema
* 4c8d1a7 write README
* 3c32c60 configure Git
```
_Hinweis_: Das Umformulieren einer Commit-Message ändert auch die Commit-ID.

## Reflektieren & Wiederholen

- Was macht eine Commit-Message bei einem Review oder beim Verstehen der Projektentwicklung nützlich? Welche Nachrichten sind nicht hilfreich?
- Wann ist ein Body in einer Commit-Message notwendig?
- Woran machst du fest, ob eine Commit-Message spezifisch genug ist?
