# 113 Commits cherry-picken

Das _Cherry-picking_ eines Commits ist nützlich, wenn wir Änderungen aus diesem Commit in einen anderen Branch übernehmen möchten.

Beispielsweise können wir [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick) verwenden, um selektiv eine Änderung, einen Fix oder ein Feature in unseren aktuellen Branch zu integrieren, ohne den gesamten Quell-Branch zu mergen.

Es kann auch nützlich sein, um aus einem unordentlichen oder experimentellen Branch eine saubere, zielgerichtete Historie aufzubauen, indem wir nur die Commits _cherry-picken_, die die tatsächlich gewünschten Änderungen enthalten.

![](../resources/main-cherry-pickable-commit.svg)

Mit [`git cherry-pick`](https://git-scm.com/docs/git-cherry-pick) können wir die Änderungen aus Commit `P` auf unseren aktuellen Branch anwenden.

![](../resources/main-commit-cherry-picked.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben mit der Installation und Automatisierung der Wohnzimmer-Klimaanlage begonnen, während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`).

Um unsere Arbeit fortzusetzen, benötigen wir das _automation-rules Schema_.

## Aufgabe: Einen Commit von einem anderen Branch cherry-picken

Das Schema für Automatisierungsregeln `automation-rules.schema.json` ist noch nicht in `main` integriert und wir möchten es nicht selbst neu definieren.

Um sicherzugehen, dass wir dieselbe Version von `automation-rules.schema.json` wie unser Team verwenden, können wir den Commit `"define automation-rules schema"` vom Branch `living-room-light-automation` auf unseren Branch `living-room-ac-automation` cherry-picken.

Auf diese Weise können wir unsere Arbeit an der Automatisierung der Wohnzimmer-Klimaanlage fortsetzen, ohne auf die Integration von `living-room-light-automation` in `main` warten zu müssen.

Sobald einer der beiden Branches in `main` integriert ist, entfernt ein [Rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) den cherry-gepickten Commit einfach aus dem anderen Branch.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 27932b0 (HEAD -> living-room-ac-automation) install living-room balcony-door sensor
* 4829d15 install living-room thermostat sensor
* 32a150b install living-room AC
| * 0be7489 (living-room-light-automation) automate living-room light
| * 5d5581d define automation-rules schema
| * dba85f9 define living-room-light trait on-off
|/
* 1db2a0d (main) install living-room ambient-light sensor
* b75a4ac install living-room presence sensor
* b394ff8 install living-room light
* 64377f3 define devices schema
* ec4930c register living room
* e932d83 define rooms schema
* 1429929 write README
* b8f3f4b configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 1633f87 (HEAD -> living-room-ac-automation) define automation-rules schema
* 27932b0 install living-room balcony-door sensor
* 4829d15 install living-room thermostat sensor
* 32a150b install living-room AC
| * 0be7489 (living-room-light-automation) automate living-room light
| * 5d5581d define automation-rules schema
| * dba85f9 define living-room-light trait on-off
|/
* 1db2a0d (main) install living-room ambient-light sensor
* b75a4ac install living-room presence sensor
* b394ff8 install living-room light
* 64377f3 define devices schema
* ec4930c register living room
* e932d83 define rooms schema
* 1429929 write README
* b8f3f4b configure Git
```
_Hinweis_: Das Cherry-Picken des Commits `"define automation-rules schema"` vom Branch `living-room-light-automation` führt zu einem anderen Commit-Hash, die Änderungen werden jedoch als Patch auf den Branch `living-room-ac-automation` angewendet.

## Reflektieren & Wiederholen

- Welches Problem löst Cherry-Pick im Vergleich zum Mergen eines gesamten Branches?
- Wie macht das Design atomarer Commits das Cherry-Picken sicherer?
- Warum erhält ein cherry-gepickter Commit einen neuen Commit-Hash, obwohl der Patch identisch ist?
