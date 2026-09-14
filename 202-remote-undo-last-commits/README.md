# 202 Gepushte Commits rückgängig machen

Wir möchten Work-in-Progress (_WIP_)-Commits auf ein Remote-Repository pushen, um unsere Arbeit zu sichern, von einem anderen Rechner weiterzuarbeiten oder einen Zwischenstand zu teilen.

Später, sobald die Arbeit abgeschlossen ist, möchten wir diese temporären Commits durch einen kleineren, saubereren und aussagekräftigeren Commit ersetzen.
Lokal können wir dies mit [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft) tun, wie in [Übung 103](../103-local-undo-last-commits/README.md) eingeführt.

Wenn diese Commits jedoch bereits nach `origin` gepusht wurden, reicht das lokale Umschreiben nicht aus.
Nach dem Soft-Reset und dem neuen Commit sind der lokale Branch und der Remote-Branch auseinandergelaufen.

Ähnlich wie in [Übung 201](../201-remote-amend-commit/README.md) können wir [`git push --force-with-lease`](https://git-scm.com/docs/git-push#Documentation/git-push.txt---force-with-lease) verwenden, um den Branch auf `origin` mit unserer aufgeräumten Historie zu überschreiben.

_Tipp_: Bevorzuge `--force-with-lease` gegenüber `--force`.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben unsere ersten _Wohnzimmer-Geräte_ erfolgreich installiert und an der _Automatisierung der Wohnzimmer-Beleuchtung_ gearbeitet.
Nun sind die Automatisierungsregeln für das _Wohnzimmer-Licht_ vollständig, aber die Git-Historie enthält noch mehrere temporäre WIP-Commits.

Bevor wir diesen Branch für ein Review bereitstellen oder integrieren, möchten wir diese WIP-Commits durch einen einzelnen sauberen Commit ersetzen, der das fertige Feature beschreibt.

## Aufgabe: WIP-Commits per Soft-Reset rückgängig machen und Änderungen force-pushen

Ersetze auf dem Branch `living-room-light-automation` die drei gepushten WIP-Commits durch einen einzigen sauberen Commit.

Nutze [`git reset --soft`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---soft), um die WIP-Commits rückgängig zu machen, während ihre Änderungen im Staging-Bereich verbleiben.

Entferne dann die Eigenschaft `testMode` aus allen Regeln in `automation-rules.json` und erstelle einen einzelnen Commit namens `"automate living-room light"`.

Nutze `git push --force-with-lease`, um den Remote-Branch mit der aufgeräumten Historie zu überschreiben.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 7a38b10 (HEAD -> living-room-light-automation, origin/living-room-light-automation) WIP automate living-room light based on ambient light
* 6f188b9 WIP automate turning off the living-room light
* 82de217 WIP automate turning on the living-room light
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```

### Git-Historie vor dem Push
```console
$ git log --oneline --graph --decorate --all
* bb82700 (HEAD -> living-room-light-automation) automate living-room light
| * 7a38b10 (origin/living-room-light-automation) WIP automate living-room light based on ambient light
| * 6f188b9 WIP automate turning off the living-room light
| * 82de217 WIP automate turning on the living-room light
|/
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```
_Hinweis_: Nach dem Soft-Reset und dem neuen Commit enthält der lokale Branch den sauberen Commit, während `origin/living-room-light-automation` noch auf die alte WIP-Historie zeigt. Ein Git-Client zeigt für diesen Graphen so etwas wie `↓3 ↑1` an.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* bb82700 (HEAD -> living-room-light-automation, origin/living-room-light-automation) automate living-room light
* 9aae62c define automation-rules schema
* ad280a9 define living-room-light trait on-off
* 0f2750e (origin/main, main) install living-room ambient-light sensor
* ff61447 install living-room presence sensor
* 633c8c4 install living-room light
* 039a6af define devices schema
* 40e06ce register living room
* 7d2582f define rooms schema
* 2d8e307 write README
* d4e66cb configure Git
```
_Hinweis_: Die alten gepushten _WIP_-Commits sind nicht mehr Teil der Branch-Historie.

## Reflektieren & Wiederholen

- Warum wollen wir überhaupt einen _WIP_-Commit pushen?
- Welchen Einfluss hat das Branch-Ownership darauf, ob _Force-Pushing_ akzeptiert wird?
