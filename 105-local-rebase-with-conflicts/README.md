# 105 Rebase auf `main` mit Konflikten

Unabhängig davon, ob wir [`git merge`](https://git-scm.com/docs/git-merge) oder [`git rebase`](https://git-scm.com/docs/git-rebase) zum Integrieren von Branches verwenden, müssen wir unter Umständen Merge-Konflikte lösen.

![](../resources/main-feature-out-of-sync-conflict.svg)

Während bei `git merge` der Konflikt im Merge-Commit gelöst wird, stoppt `git rebase` bei jedem problematischen Commit, und wir müssen die Konflikte in der Reihenfolge dieser Commits auflösen.

Das Lösen von Konflikten während eines Rebase kann komplex sein, insbesondere wenn die Konflikte im Code versteckt sind (semantische Konflikte) und mehrere Commits betroffen sind.
Aus diesem Grund bevorzugen viele Entwickler `git merge` gegenüber `git rebase`.

Die allermeisten Merge-Konflikte lassen sich jedoch leicht vermeiden, wenn wir _atomare Commits_ erstellen und Änderungen früh und häufig integriert (_kurzlebige Branches_).
Wenn ein Branch nur wenige (_1–5_) _atomare_ Commits enthält, kontinuierlich mit `main` _integriert_ wird und nur für kurze Zeit existiert, treten Konflikte deutlich seltener auf.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Im Anschluss an die Übungen [101](../101-local-amend-commit/README.md) bis [103](../103-local-undo-last-commits/README.md) haben wir alle unsere _Wohnzimmer-Geräte_ erfolgreich installiert und die Implementierung einer Automatisierungsregel für die _Wohnzimmer-Beleuchtung_ abgeschlossen.

Es ist Zeit, unseren Feature-Branch zu integrieren; `main` hat sich in der Zwischenzeit jedoch weiterentwickelt.

## Aufgabe: Den Feature-Branch auf `main` rebasen

Während wir an der Licht-Automatisierung gearbeitet haben, hat unser Team weitere Geräte und Sensoren installiert sowie das _automation-rules Schema_ per _Cherry-Pick_ übernommen und an der Automatisierung der _Wohnzimmer-Klimaanlage_ gearbeitet.

Wir schließen unseren Feature-Branch ab und möchten ihn integrieren.
Im Gegensatz zu [Übung 104](../104-local-rebase-onto-main/README.md) haben wir jedoch zu lange nicht integriert und stoßen nun auf Merge-Konflikte.
Verwende [`git rebase`](https://git-scm.com/docs/git-rebase), um unseren Branch `living-room-light-automation` auf `main` zu rebasen, und löse die auftretenden Konflikte.

Versuche jedoch vor dem Ausführen des _Rebase_ zu identifizieren, welche Commits Konflikte verursachen werden, und bereite dich entsprechend vor.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* d994035 (main) install living-room balcony-door sensor
* 2000688 install living-room thermostat sensor
* 7e33e41 install living-room AC
* 523a401 define automation-rules schema
* 56c699a define traits for devices
| * dd71c5a (HEAD -> living-room-light-automation) automate living-room light
| * 06f1ae7 define automation-rules schema
| * aabef6d install living-room ambient-light sensor
| * ae93029 install living-room presence sensor
| * 0b9c22e define living-room-light trait on-off
|/
* 9817010 install living-room light
* 24f2db2 define devices schema
* 3d94ca1 register living room
* 4ab80a3 define rooms schema
* 4201555 write README
* 221fce7 configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 3506132 (HEAD -> living-room-light-automation) automate living-room light
* 2ccd6ca install living-room ambient-light sensor
* fc61987 install living-room presence sensor
* 7aa91fc define living-room-light trait on-off
* d994035 (main) install living-room balcony-door sensor
* 2000688 install living-room thermostat sensor
* 7e33e41 install living-room AC
* 523a401 define automation-rules schema
* 56c699a define traits for devices
* 9817010 install living-room light
* 24f2db2 define devices schema
* 3d94ca1 register living room
* 4ab80a3 define rooms schema
* 4201555 write README
* 221fce7 configure Git
```

## Reflektieren & Wiederholen

- Warum können sowohl Merge als auch Rebase zu Konflikten führen?
- Was unterscheidet die Konfliktlösung während eines Rebase von der Lösung desselben Konflikts bei einem Merge? Was macht sie einfacher, was schwieriger?
- Wie können kleine, atomare Commits und ein kurzlebiger Branch die Konfliktlösung erleichtern?
- Warum sind _semantische_ Konflikte schwerer zu erkennen als _textuelle_ Konflikte?
