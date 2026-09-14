# 204 Interactive Rebase - Remote-Historie umschreiben

Der [interaktive Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) ermöglicht es uns, Probleme auf natürliche Weise zu bearbeiten, Änderungen schrittweise zu committen und unsere Git-Historie kohärenter und lesbarer zu gestalten, bevor wir sie mit anderen teilen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md) bis [112](../112-local-interactive-rebase-onto-main/README.md)).

Die Nutzung des _interaktiven Rebase_ schreibt die Historie eines Branches lokal um.
Um das Remote-Repository zu aktualisieren, müssen wir dessen Branch-Version mit [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) überschreiben (vgl. [Übung 201](../201-remote-amend-commit/README.md) bis [203](../203-remote-rebase-onto-main/README.md)).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.
Um das Team nicht zu blockieren, haben wir erkannt, dass wir Schema-Änderungen zuerst in `main` integrieren sollten, bevor wir fortfahren.
Daher haben wir Änderungen an `device.schema.json` integriert und `automation-rules.schema.json` definiert.

Nach Abschluss der Arbeit an der _Klimaanlagen-Automatisierung_ ist es an der Zeit, die Historie aufzuräumen und unsere Änderungen zu pushen.

## Aufgabe: Mittels Interactive Rebase auf `main` rebasen zum Aufräumen der Historie und Änderungen force-pushen

Wir haben unsere Arbeit abgeschlossen und die _Automatisierung der Wohnzimmer-Klimaanlage_ getestet.

Räume die Historie von `living-room-ac-automation` mithilfe des _interaktiven Rebase_ (und ggf. weiteren Werkzeugen zum Umschreiben) auf, führe einen Rebase auf `main` durch und überschreibe den Remote-Branch mit der neuen Historie mittels `git push --force-with-lease`.

Hier sind unsere Aufgaben zum Aufräumen:
- [ ] _Rebase_ auf `main`
- [ ] _Lösche_ alle `DELETE!`-Commits
- [ ] _Squashe_ alle `WIP`-Commits zur _Klimaanlagen-Automatisierung_ in einen einzelnen Commit
- [ ] _Bearbeite_ die Regeln der Klimaanlagen-Automatisierung und entferne die Eigenschaft `testMode`
- [ ] _Teile_ `"install sensors"` in zwei separate Commits auf
- [ ] _Formuliere_ alle Commits so _um_, dass sie gute Commit-Messages haben

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* cd1a4fd (HEAD -> living-room-ac-automation) DELETE! balcony-door test value door-opened
* 8f108ea DELETE! balcony-door test value door-closed
* bf9e66c DELETE! thermometer test value 26°C
* d18ddbc WIP ac on/off + balcony-door
* f03749e DELETE! thermometer test value 19°C
* f664475 WIP ac off
* 48e9344 DELETE! thermometer test value 26°C
* ee8ec92 WIP ac on
* 3556472 define automation-rules schema
* bfed9e5 (origin/living-room-ac-automation) install sensors
* 6cda9cf install ac
| * 81d1321 (origin/main, main) define automation-rules schema
| * f6492a3 define traits for devices
|/
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Hinweis_: Unser Branch `living-room-ac-automation` enthält lokale Änderungen, die noch nicht nach `origin` gepusht wurden. Zudem enthält `main` neuere Commits, die einige Änderungen von `living-room-ac-automation` obsolet machen.

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* c4ee170 (HEAD -> living-room-ac-automation) automate living-room AC
* 587d61f install living-room balcony-door sensor
* c5f2483 install living-room thermostat sensor
* 9e1d7fc install living-room AC
* 81d1321 (origin/main, origin/HEAD, main) define automation-rules schema
* f6492a3 define traits for devices
| * bfed9e5 (origin/living-room-ac-automation) install sensors
| * 6cda9cf install ac
|/
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Hinweis_: `origin/living-room-ac-automation` zeigt nur zwei Commits, da unsere `WIP`- und `DELETE`-Commits nie gepusht wurden.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* c4ee170 (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate living-room AC
* 587d61f install living-room balcony-door sensor
* c5f2483 install living-room thermostat sensor
* 9e1d7fc install living-room AC
* 81d1321 (origin/main, origin/HEAD, main) define automation-rules schema
* f6492a3 define traits for devices
* e8cfa40 install living-room light
* 85092a6 define devices schema
* 28811af register living room
* 4e679ab define rooms schema
* e17ec40 write README
* 07f4fdd configure Git
```
_Hinweis_: Nach dem Rebase auf `main` sind der Commit `"define automation-rules schema"` und die Änderung an `devices.schema.json` in `"install living-room AC"` nun aus `living-room-ac-automation` verschwunden.

## Reflektieren & Wiederholen

- Welche Arten von Bereinigungen lohnen sich, bevor ein Branch gereviewt oder gemergt wird?
- Warum können Review-Kommentare nach dem Umschreiben von Commits veraltet sein?
- Welche Balance sollte ein Team zwischen einer sauberen Historie und der Kontinuität von Reviews finden?
