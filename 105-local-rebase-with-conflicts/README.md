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
* 3576afb (main) automate living-room AC
* c2c6516 define automation-rules schema
* 9e9db27 install living-room balcony-door sensor
* 901a8f7 install living-room thermostat sensor
* a4dcc86 install living-room AC
| * 24189cb (HEAD -> living-room-light-automation) automate turning on/off living room wall lamp
| * 9852d2b install living-room wall lamp
| * ff58bf0 automate living-room light
| * 811951b define automation-rules schema
| * c173e66 define living-room-light trait on-off
|/
* 4af729b install living-room ambient-light sensor
* a115cf6 install living-room presence sensor
* db1dab9 install living-room light
* 4016796 define devices schema
* 6082fdf register living room
* 4310a75 define rooms schema
* 6d223d7 write README
* 1ab9aab configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* c2a2bfc (HEAD -> living-room-light-automation) automate turning on/off living room wall lamp
* 4569584 install living-room wall lamp
* 299c6e8 automate living-room light
* ded6133 define living-room-light trait on-off
* 3576afb (main) automate living-room AC
* c2c6516 define automation-rules schema
* 9e9db27 install living-room balcony-door sensor
* 901a8f7 install living-room thermostat sensor
* a4dcc86 install living-room AC
* 4af729b install living-room ambient-light sensor
* a115cf6 install living-room presence sensor
* db1dab9 install living-room light
* 4016796 define devices schema
* 6082fdf register living room
* 4310a75 define rooms schema
* 6d223d7 write README
* 1ab9aab configure Git
```

## Reflektieren & Wiederholen

- Warum können sowohl Merge als auch Rebase zu Konflikten führen?
- Was unterscheidet die Konfliktlösung während eines Rebase von der Lösung desselben Konflikts bei einem Merge? Was macht sie einfacher, was schwieriger?
- Wie können kleine, atomare Commits und ein kurzlebiger Branch die Konfliktlösung erleichtern?
- Warum sind _semantische_ Konflikte schwerer zu erkennen als _textuelle_ Konflikte?
