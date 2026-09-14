# 206 Remote-Commits cherry-picken

Das _Cherry-picking_ eines Commits ist nützlich, wenn wir Änderungen aus diesem Commit in einen anderen Branch übernehmen möchten (vgl. [Übung 113](../113-local-cherry-pick-commits/README.md)).

Manchmal sind die Änderungen, die wir _cherry-picken_ möchten, nur auf einem Remote-Branch verfügbar.
Diese Übung konzentriert sich auf die Verwendung von [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick), ohne den Remote-Branch auszuchecken.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.
Wir haben jedoch festgestellt, dass das Team, das an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet, ähnliche Schema-Änderungen benötigt.

Wir haben beschlossen, unsere Arbeit zu unterbrechen und zuerst die Schema-Änderungen an `device.schema.json` sowie die Definition von `automation-rules.schema.json` in `main` zu integrieren.

## Aufgabe: Änderungen von einem Remote-Branch cherry-picken

Cherry-picke Änderungen an `device.schema.json` von entweder `"install ac"` oder `"define living-room-light trait on-off"`, ohne den entsprechenden Remote-Branch auszuchecken.
Committe die Änderungen als `"define traits for devices"`.

Cherry-picke und committe dann `"define automation-rules schema"` von `origin/living-room-light-automation`.

Pushe die Commits auf `automation-schema` nach `origin`, damit sie in `main` integriert werden können.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* a5e6ece (origin/living-room-ac-automation) install sensors
* 6918578 install ac
| * 708f97c (origin/living-room-light-automation) automate living-room light
| * bdb73db define automation-rules schema
| * e335f9d define living-room-light trait on-off
| * e7cac78 install living-room ambient-light sensor
| * 40dd17a install living-room presence sensor
|/
* 2efa1cf (HEAD -> automation-schema, origin/main, main) install living-room light
* ec17cd6 define devices schema
* 3a82f0d register living room
* 4b325e8 define rooms schema
* 20f93b1 write README
* 5ccef44 configure Git
```
_Hinweis_: Der `HEAD` befindet sich auf dem leeren `automation-schema`-Branch.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 6cf0014 (HEAD -> automation-schema, origin/automation-schema) define automation-rules schema
* 866970e define traits for devices
| * a5e6ece (origin/living-room-ac-automation) install sensors
| * 6918578 install ac
|/
| * 708f97c (origin/living-room-light-automation) automate living-room light
| * bdb73db define automation-rules schema
| * e335f9d define living-room-light trait on-off
| * e7cac78 install living-room ambient-light sensor
| * 40dd17a install living-room presence sensor
|/
* 2efa1cf (origin/main, main) install living-room light
* ec17cd6 define devices schema
* 3a82f0d register living room
* 4b325e8 define rooms schema
* 20f93b1 write README
* 5ccef44 configure Git
```

## Reflektieren & Wiederholen

- Warum ist es nützlich, von einem Remote-Branch zu cherry-picken, ohne ihn auszuchecken?
- Wenn dieselbe Änderung auf mehreren Remote-Branches existiert (wie in dieser Übung), was sollte deine Wahl leiten, welchen Commit du cherry-pickst?
- In welcher Beziehung stehen der cherry-gepickte und der ursprüngliche Commit? Was passiert mit den Commits, wenn du Branches später mittels _Rebase_ integrierst, und was bei einem _Merge_?
