# 103 Letzte(n) Commit(s) mit Soft-Reset rückgängig machen

Manchmal committen wir Änderungen, die nur temporär sind, z. B. Work-in-Progress (_WIP_).
Manchmal möchten wir Änderungen manuell neu stagen und in separate Commits aufteilen.
Manchmal fügen wir einem Commit nicht dazugehörige Änderungen hinzu und möchten diesen Commit rückgängig machen.

[`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) hilft uns, auf einen früheren Git-Zustand zurückzusetzen, während alle Änderungen aus diesen rückgängig gemachten Commits im Staging-Bereich bleiben, sodass sie erneut committet werden können.

Anders als bei einem _Hard-Reset_ gehen die Änderungen also nicht verloren; mit `--soft` bleiben sie gestaget.
Lies mehr über _Git reset_ im Artikel [Reset Demystified](https://git-scm.com/book/en/v2/Git-Tools-Reset-Demystified).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Im Anschluss an [Übung 101](../101-local-amend-commit/README.md) und [102](../102-local-commit-changes/README.md) haben wir unsere ersten _Wohnzimmer-Geräte_ erfolgreich installiert.
Nun ist es Zeit für die _Automatisierung_.
Wir arbeiten derzeit an der Datei `automation-rules.json`.

## Aufgabe: Soft-Reset durchführen und WIP-Commits ersetzen

Wir haben die Installation unserer _Wohnzimmer_-Geräte abgeschlossen: _Licht_, _Präsenzsensor_ und _Umgebungslichtsensor_.

Auf dem Branch `living-room-light-automation` arbeiten wir aktuell an der Datei `automation-rules.json`.
Hier finden wir unseren Zwischenstand (_WIP_) aus unserer vorherigen Session; z. B. vom Vortag, vor dem Mittagessen oder von einem anderen Rechner.

Alles funktioniert und es ist Zeit, diesen Feature-Branch fertigzustellen.

Führe einen _Soft-Reset_ auf den Zustand vor den WIP-Commits durch, entferne `testMode` aus allen `rules` in `automation-rules.json` und erstelle einen einzelnen Commit `"automate turning on/off the living room light"`.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 28fe671 (HEAD -> living-room-light-automation) WIP automate living-room light based on ambient light
* 1d62832 WIP automate turning off the living-room light
* 9709189 WIP automate turning on the living-room light
* da3ea2f define automation-rules schema
* 00d7a16 define living-room-light trait on-off
* ba2f53b (main) install living-room ambient-light sensor
* ab9be2f install living-room presence sensor
* 2fb482d install living-room light
* f04f895 define devices schema
* 86e198f register living room
* 753e83b define rooms schema
* 5ff2789 write README
* 258621a configure Git
```
_Hinweis_: Die _WIP_-Commits befinden sich auf dem Branch `living-room-light-automation`, der aktuell ausgecheckt ist.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* c2cca52 (HEAD -> living-room-light-automation) automate living-room light
* da3ea2f define automation-rules schema
* 00d7a16 define living-room-light trait on-off
* ba2f53b (main) install living-room ambient-light sensor
* ab9be2f install living-room presence sensor
* 2fb482d install living-room light
* f04f895 define devices schema
* 86e198f register living room
* 753e83b define rooms schema
* 5ff2789 write README
* 258621a configure Git
```

## Reflektieren & Wiederholen

* Warum können _WIP_-Commits während der Entwicklung nützlich, in der finalen Historie jedoch unerwünscht sein?
* Wie ist der _Soft-Reset_ beim Umschreiben der Historie hilfreich?
* Welche Risiken werden vermieden, wenn man `--soft` anstelle von `--hard` verwendet?
