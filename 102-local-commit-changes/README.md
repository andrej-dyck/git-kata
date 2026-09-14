# 102 Änderungen committen, nicht Dateien

Git verfolgt Änderungen an einer Datei und nicht die Datei selbst.
Wenn wir eine Änderung stagen, können wir daher jede Änderung innerhalb einer Datei stagen: einen Teilstring, eine Zeile oder einen Textblock (_hunk_).

Dadurch können wir Änderungen innerhalb einer Datei in Patches committen, was zu mehreren Commits führt.

Um Unterschiede innerhalb von Dateien zu stagen, verwende [`git add -p`](https://git-scm.com/docs/git-add#Documentation/git-add.txt-patch), um _Patches_ zu erstellen.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Im Anschluss an [Übung 101](../101-local-amend-commit/README.md) wollen wir nun unsere _Wohnzimmer-Geräte_ installieren.

## Aufgabe: Änderungen committen durch Stagen von Zeilen innerhalb einer Datei

Wir haben das _Wohnzimmer_ in der vorherigen Übung in `rooms.json` registriert.
Nun haben wir das Schema für Geräte in `devices.schema.json` definiert und sind dabei, unser _Wohnzimmer-Licht_ in `devices.json` zu installieren.

Außerdem haben wir festgestellt, dass wir einen Tippfehler in der Eigenschaft `"$schema"` von `devices.json` gemacht haben; diesen haben wir direkt behoben.
Diese Änderung gehört technisch gesehen zum vorherigen Commit `"define devices schema"`.

Hier sind unsere drei Optionen:
1. Den Fix zusammen mit `"define devices schema"` committen (_das ist in dieser Übung nicht das Ziel_)
2. Den Fix separat mit `"fix typo in devices.schema.json"` committen
3. Den vorherigen Commit `"define devices schema"` per Amend mit dem Fix anpassen (_bevorzugter Weg_)

Setze Option _2._ oder _3._ um, indem du Patch-Staging verwendest, um nur den Schema-Fix zu committen, während andere Änderungen in dieser Datei unstaged bleiben.

Installiere danach das _Wohnzimmer-Licht_ mit einem separaten Commit `"install living-room light"`.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 2d1c1ab (HEAD -> main) define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```
_Hinweis_: Die Commit-Hashes unterscheiden sich von der vorherigen `README.md`, da jede Übung generiert wird.
Dies gilt auch für alle nachfolgenden Übungen.

### Ziel-Git-Historie

**… bei Wahl von Option 2.**
```console
$ git log --oneline --graph --decorate --all
* afaef65 install living-room light
* 17adacf fix typo in devices.schema.json
* 2d1c1ab define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```

**… bei Wahl von Option 3.**
```console
$ git log --oneline --graph --decorate --all
* afaef65 (HEAD -> main) install living-room light
* 9e27dca define devices schema
* a4e0e68 register living room
* 8f93767 define rooms schema
* 5907845 write README
* c832a9c configure Git
```
_Hinweis_: In dieser Historie haben wir den letzten Commit `"define devices schema"` mit dem Fix per Amend angepasst; d. h. es gibt keinen separaten _"Fix"_-Commit.

## Reflektieren & Wiederholen

* Wie kann das Stagen einzelner Hunks oder Zeilen zu kohärenten Commits führen?
* Wie hilft Patch-Staging dabei, unabhängige Arbeiten zu trennen, die in derselben Datei stattgefunden haben?
* Wie bestärkt diese Übung das Konzept atomarer Commits?
