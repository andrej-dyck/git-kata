# 107 Interactive Rebase - Commits squashen

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md)).

Manchmal stellen wir fest, dass zu kleine Commits fragmentiert und zusammenhangslos wirken.
Manchmal müssen wir etwas in einem Commit korrigieren oder verbessern, das mehrere Commits zurückliegt.

Das Zusammenführen (_Squashen_) von Commits ist ein weiteres wichtiges Werkzeug, um die Historie so umzuschreiben, dass kohärente Commits eine klare _"Story"_ erzählen.
Diese Übung hilft dir zu verstehen, wie du den _interaktiven Rebase_ [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzt, um Commits zu _squashen_.

Die folgende Grafik zeigt die Commits eines `feature`-Branches in chronologischer Reihenfolge:

![](../resources/main-feature-in-order-pre-squash.svg)

Nach dem _Squashen_ dieser Commits zu vollständigen und in sich geschlossenen Einheiten mit _Interactive Rebase_:

![](../resources/main-feature-squashed.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

Die Übungen [106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md) haben denselben Kontext, aber leicht abweichende initiale und Ziel-Git-Historien, um den jeweiligen Schwerpunkt der Übung optimal zu unterstützen.

## Aufgabe: Commits mittels Interactive Rebase squashen

In dieser Übung haben wir unsere Arbeit an `living-room-ac-automation` in vielen kleinen Commits festgehalten.

Die Abfolge der Commits ist jedoch ziemlich fragmentiert.
Beispielsweise machen Commits wie `"fixup! devices schema"` (gehört zu `"install living-room AC"`) und `"amend! install living-room sensors"` (gehört zu `"install living-room sensors"`) das Git-Log unnötig unübersichtlich.

Darüber hinaus lässt sich argumentieren, dass die _Automatisierung_ erst vollständig ist, wenn alle Regeln vorhanden sind, sodass `"turning on living-room AC"`, `"turning off living-room AC"` und `"automate turning on/off living-room AC w/ balcony door"` zu einem einzigen Commit `"automate living-room AC"` zusammengefasst werden können.

_Führe_ die Commits auf `living-room-ac-automation` per _Squash_ zusammen, um eine kohärente Story zu erzählen.

_Tipp_: Du kannst nur Commits squashen, die direkt nebeneinanderliegen; du musst also einige Commits verschieben, um sie squashen zu können.

_Gut zu wissen_: Du kannst [`--autosquash`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---autosquash) nutzen, indem du einer Commit-Message das Präfix `"squash! ..."`, `fixup! ...` oder `amend! ...` voranstellst.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 71f8476 (HEAD -> living-room-ac-automation) automate turning on/off living-room AC w/ balcony door
* 6c0afe8 amend! install living-room sensors
* eb52221 automate turning off living-room AC
* d27d2f8 automate turning on living-room AC
* e1d1ebd install living-room sensors
* 4a9f966 fixup! devices schema
* 97b2679 install living-room AC
* eb47066 define automation-rules schema
| * 135458b (living-room-light-automation) automate living-room light
| * 6bc9c53 define automation-rules schema
| * f0a0682 define living-room-light trait on-off
|/
* 3f39256 (main) install living-room ambient-light sensor
* 83b4ca2 install living-room presence sensor
* 79d6bed install living-room light
* 2efc971 define devices schema
* e63777f register living room
* a0be0a2 define rooms schema
* 18806df write README
* 3e2c173 configure Git
```
_Hinweis_: Die initiale Git-Historie von `living-room-ac-automation` unterscheidet sich bewusst leicht von Übung `106`.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* e99ef08 (HEAD -> living-room-ac-automation) automate living-room AC
* ae8266e install living-room sensors
* 97cc672 install living-room AC
* eb47066 define automation-rules schema
| * 135458b (living-room-light-automation) automate living-room light
| * 6bc9c53 define automation-rules schema
| * f0a0682 define living-room-light trait on-off
|/
* 3f39256 (main) install living-room ambient-light sensor
* 83b4ca2 install living-room presence sensor
* 79d6bed install living-room light
* 2efc971 define devices schema
* e63777f register living room
* a0be0a2 define rooms schema
* 18806df write README
* 3e2c173 configure Git
```
_Hinweis_: Die Commit-Hashes nach dem Squashen sind unterschiedlich, da neue Commits entstanden sind und somit auch deren Child-Commits neue Hashes erhalten.

## Reflektieren & Wiederholen

- Was ist der Unterschied zwischen einem _kleinen_ Commit und einem _atomaren_ Commit?
- Wann machen viele winzige Commits die Historie schwerer verständlich?
- Wann sollten Commits nicht gesquasht werden, selbst wenn sie klein sind?
- Warum können _"Fix"_-Commits während der Entwicklung nützlich, in der finalen Historie jedoch störend sein?
