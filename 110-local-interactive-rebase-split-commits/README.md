# 110 Interactive Rebase - Commits aufteilen

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Git erlaubt es uns, Entscheidungen über die Commit-Historie nachträglich zu treffen.
Eine dieser Entscheidungen kann sein, einen Commit in mehrere kleinere Commits _aufzuteilen_ (`split`).
Das Aufteilen von Commits ist nützlich, wenn wir versehentlich unabhängige Änderungen zusammen committet haben, der Commit nicht atomar ist oder wir später feststellen, dass wir Änderungen abspalten können, um sie früher zu integrieren.

Beachte, dass das Aufteilen von Commits eine Gratwanderung zwischen fehlender Kohärenz und zu großer Breite ist.
Jeder Commit sollte klein genug sein, um fokussiert zu sein, aber groß genug, um eine kohärente Änderung darzustellen.

Diese Übung hilft dir zu verstehen, wie du den [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzt, um Commits _aufzuteilen_.

![](../resources/main-feature-before-split.svg)

Nach dem Aufteilen des ersten Commits des `feature`-Branches in zwei separate Commits:

![](../resources/main-feature-splitted.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commits mittels Interactive Rebase aufteilen

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` committet.
Wir haben eine recht gute Abfolge von Commits erreicht, allerdings enthalten einige Commits mehr als eine logische Änderung.

Beispielsweise definiert `"install living-room AC"` das `traits`-Schema für `devices`. Dies könnte ein nützlicher Commit sein, um ihn frühzeitig zu integrieren, damit unser Team ihn früher nutzen kann.
Zudem können wir die Installation der Sensoren `"install living-room sensors"` sowie die Automatisierung `"automate living-room AC"` jeweils in zwei Commits aufteilen.

_Teile_ diese drei oben genannten Commits mittels _interaktivem Rebase_ auf.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 6075807 (HEAD -> living-room-ac-automation) automate living-room AC
* 33593f8 install living-room sensors
* 4706749 install living-room AC
* b9fb38e define automation-rules schema
| * 3b79ba4 (living-room-light-automation) automate living-room light
| * 42f707e define automation-rules schema
| * b1cc447 install living-room ambient-light sensor
| * 3e0a64b install living-room presence sensor
| * c5669d2 define living-room-light trait on-off
|/
* d4a8fa2 (main) install living-room light
* 4fc7c87 define devices schema
* 6ceafa8 register living room
* e770935 define rooms schema
* 598bd6d write README
* 9d1fbb3 configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 7e19fe6 (HEAD -> living-room-ac-automation) turn off/on living-room AC based on open/closed balcony-door
* dd3dbfb install living-room balcony-door sensor
* 3323543 automate living-room AC target-temperature
* 5d26389 install living-room thermostat sensor
* 8fd5280 install living-room AC
* bd2bc53 define traits for devices
* b9fb38e define automation-rules schema
| * 3b79ba4 (living-room-light-automation) automate living-room light
| * 42f707e define automation-rules schema
| * b1cc447 install living-room ambient-light sensor
| * 3e0a64b install living-room presence sensor
| * c5669d2 define living-room-light trait on-off
|/
* d4a8fa2 (main) install living-room light
* 4fc7c87 define devices schema
* 6ceafa8 register living room
* e770935 define rooms schema
* 598bd6d write README
* 9d1fbb3 configure Git
```
_Hinweis_: Hier haben wir `"install living-room sensors"` in zwei Commits aufgeteilt (einen für den Thermostatsensor und einen für den Balkontürsensor) und die Commits anschließend so _umgeordnet_, dass sie sich mit der Automatisierung abwechseln. Es ist völlig in Ordnung, wenn du dies anders machst.

## Reflektieren & Wiederholen

- Was sind Anzeichen dafür, dass ein Commit zu viele unabhängige Änderungen enthält?
- Wie unterstützt das Aufteilen von Commits das Prinzip _atomarer_ Commits?
- Wie würde eine sauberere Aufteilung jemandem helfen, nur einen Teil der Arbeit per _Cherry-Pick_ zu übernehmen oder _rückgängig_ zu machen?
