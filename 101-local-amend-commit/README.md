# 101 Ändern des letzten Commits

Das Anpassen von Commits per Amend ist nützlich, wenn wir etwas vergessen haben zu _stagen_, was zum letzten Commit gehört, oder wir in diesem Commit einen Fehler gemacht haben.

Zum Beispiel möchten wir vielleicht einen Tippfehler korrigieren, Code neu formatieren, zugehörige Dateien hinzufügen oder die mit diesem Commit eingeführte Logik verbessern.
Es ist wahrscheinlich der gebräuchlichste Weg, die Git-Historie umzuschreiben.

[`git commit --amend`](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---amend) ermöglicht uns genau das.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Mit dieser Übung beginnen wir damit, die _Räume_ unseres Smart Homes zu registrieren.

## Aufgabe: Commit per Amend anpassen

Wir haben im letzten Commit den `living-room` in `rooms.json` registriert.
In `rooms.schema.json` haben wir jedoch definiert, dass `rooms` ein Array von _Objekten_ ist.
Wir haben also einen Fehler gemacht.

Lass uns diesen Commit per Amend anpassen, um diesen Fehler zu beheben und dem Raum gleichzeitig einen passenden Namen zu geben.

```diff
{
  "$schema": "rooms.schema.json",
  "rooms": [
-   "living-room"
+   { "id": "living-room", "name": "Living room" }
  ]
}
```

Ändere außerdem die Commit-Message zu `"register living room"`.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* f9d96c0 (HEAD -> main) add living room to rooms
* 7e82648 define rooms schema
* 8765181 write README
* 17adacf configure Git
```
_Hinweis_: Die Commit-Hashes sind Beispiele und weichen in deinem generierten Übungs-Repository ab.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 291145d (HEAD -> main) register living room
* 7e82648 define rooms schema
* 8765181 write README
* 17adacf configure Git
```
_Hinweis_: Da wir den letzten Commit (`HEAD`) per Amend geändert haben, hat er nun einen anderen Commit-Hash.

## Reflektieren & Wiederholen

* Welche Arten von Änderungen sind gute Kandidaten für `git commit --amend`?
* Wann ist es besser, einen einzelnen _korrekten_ Commit zu erstellen, anstatt eines Commits gefolgt von einem Tippfehler-Korrektur-Commit?
* Wann würdest du einen separaten Korrektur-Commit bevorzugen und wann den vorherigen Commit per Amend anpassen?
