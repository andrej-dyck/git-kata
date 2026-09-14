# 106 Interactive Rebase - Commits sortieren

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen.

Es ist ganz natürlich, dass wir an Problemen nicht-linear arbeiten:
- Wir haben eine Idee, wie wir anfangen können 💡
- Wir experimentieren und probieren eine Lösung aus 🔦
- Wir stoßen auf ein Problem und beheben es 🐞
- Wir kommen nicht weiter und hinterlassen unfertige Arbeit (_WIP_) ⏸
- Wir überarbeiten Lösungen 🔧
- Wir stellen etwas fertig, das es wert ist, integriert zu werden ↗

Auch wenn eine chronologische Abfolge von Commits technisch gesehen _"zeigt, wie die Arbeit ablief“_, ist es oft schwer, die eigentliche _„Story"_ nachzuvollziehen und zu verstehen.

Die unübersichtliche Abfolge von Commits einfach zu integrieren wäre zwar leicht, aber schwer zu lesen und zu verstehen.
Es wäre so, als würdest du die rohen und unsortierten _Notizen eines Autors zu einem Buch_ lesen.

Wir wollen eine lesbare, besser nachvollziehbare und klarere Git-Historie erreichen. Daher benötigen wir ein mächtigeres Werkzeug als _Amend Commit_ oder _Soft Reset_, um unsere Git-Historie zu _"refaktorisieren"_: [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i).

Diese Übung hilft dir zu verstehen, wie du _Interactive Rebase_ nutzt, um Commits _umzuordnen_.

Die folgende Grafik zeigt die Commits eines `feature`-Branches in chronologischer Reihenfolge:

![](../resources/main-feature-in-order.svg)

Nach dem _Umsortieren_ in eine kohärente Reihenfolge mit _Interactive Rebase_:

![](../resources/main-feature-coherent-order.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet ([Übung 101](../101-local-amend-commit/README.md) bis [104](../104-local-rebase-onto-main/README.md)), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commits mittels Interactive Rebase Sortieren

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` in chronologischer Reihenfolge committet.

Diese Commits sind jedoch in einer ungünstigen Reihenfolge, um zu verstehen, was erreicht wird.
Beispielsweise liegen Commits, die konzeptionell zusammengehören wie `"define automation-rules schema"` und `"automate living-room AC"`, weit auseinander.

Darüber hinaus sind einige Commits technisch fehlerhaft, z. B.:
- `"install living-room AC"` verwendet die Eigenschaft `traits`, aber das Schema wird erst nach diesem Commit mit `"define traits for devices"` angepasst
- `"automate living-room AC"` verwendet eine `sensorDeviceId`, die erst mit dem nächsten Commit `"install living-room balcony-door sensor"` definiert wird

_Ordne_ die Commits auf `living-room-ac-automation` _um_, um eine schlüssige Story zu erzählen.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 01453a4 (HEAD -> living-room-ac-automation) install living-room balcony-door sensor
* c5022d9 automate living-room AC
* d6e2c23 install living-room thermostat sensor
* f047bde define traits for devices
* b53944f install living-room AC
* 46ceb87 define automation-rules schema
| * b37d325 (living-room-light-automation) automate living-room light
| * 9ce53f0 define automation-rules schema
| * 88e0d8e define living-room-light trait on-off
|/
* 6734841 (main) install living-room ambient-light sensor
* 2479fce install living-room presence sensor
* 8d4a469 install living-room light
* 1c53771 define devices schema
* d8f5025 register living room
* 0208f0f define rooms schema
* 9e76d4d write README
* 5bea84e configure Git
```
_Hinweis_: Wir sehen hier auch den Feature-Branch `living-room-light-automation`, dieser ist für diese Übung jedoch nicht relevant.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* bf3e297 (HEAD -> living-room-ac-automation) automate living-room AC
* 45e9569 define automation-rules schema
* 0d2220d install living-room balcony-door sensor
* 336fdf1 install living-room thermostat sensor
* c011f2d install living-room AC
* 74576bd define traits for devices
| * b37d325 (living-room-light-automation) automate living-room light
| * 9ce53f0 define automation-rules schema
| * 88e0d8e define living-room-light trait on-off
|/
* 6734841 (main) install living-room ambient-light sensor
* 2479fce install living-room presence sensor
* 8d4a469 install living-room light
* 1c53771 define devices schema
* d8f5025 register living room
* 0208f0f define rooms schema
* 9e76d4d write README
* 5bea84e configure Git
```
_Hinweis_: Die Commit-Hashes haben sich nach dem Sortieren geändert, da Commits für Git keine isolierten Patches mit einer ID sind, sondern Änderungen in einer hierarchischen Reihenfolge.

## Reflektieren & Wiederholen

- Warum ist die chronologische Reihenfolge der Commits möglicherweise nicht die beste Reihenfolge, um die Historie zu verstehen?
- Was macht eine Commit-Reihenfolge leichter zu verstehen als eine andere?
- Welche Arten von Commits kannst du sicher umsortieren und welche nicht?
- Wie kann das Umordnen von Commits _versteckte Kopplungen_ zwischen Änderungen aufdecken?
