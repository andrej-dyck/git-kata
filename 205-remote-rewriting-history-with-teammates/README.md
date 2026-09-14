# 205 Historie im Team umschreiben (oder auf einem anderen Rechner)

Wenn wir auf verschiedenen Rechnern arbeiten oder mit Teammitgliedern auf demselben Branch zusammenarbeiten, bringt das _Umschreiben der Git-Historie_ (vgl. [Übung 201](../201-remote-amend-commit/README.md) bis [204](../204-remote-interactive-rebase/README.md)) einige Herausforderungen mit sich.

Die häufigste Entscheidung ist, ob unsere lokale Kopie oder `origin` die aktuellste Historie besitzt.
Wenn sowohl der lokale Branch als auch `origin` neue Änderungen enthalten, müssen wir entscheiden, welche davon priorisiert werden, und die Historien manuell _"zusammenführen"_.
Daher empfiehlt es sich den Branch entweder sauber _"zu übergeben"_ (Hand-off), am selben Rechner im Pair zu arbeiten oder auf getrennten kurzlebigen Branches zusammenzuarbeiten.

Gehen wir vom einfachen Fall aus, dass `origin` die aktuellste Historie hat:

![](../resources/main-feature-out-of-sync-origin-ahead.svg)

In diesem Fall können wir unsere lokale Historie aktualisieren, indem wir [`git fetch`](https://git-scm.com/docs/git-fetch) und anschließend [`git reset --hard`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) auf `origin/feature` ausführen.

Wenn unser lokaler Branch ebenfalls neue Änderungen enthält, können wir einen [interaktiven Rebase](https://git-scm.com/docs/git-rebase#_interactive_mode) auf `origin/feature` durchführen, obsolete Commits _löschen_ und Konflikte mit neuen Commits lösen.
[Übung 301](../301-advanced-interactive-rebase-onto-a-rewritten-branch) widmet sich diesem Szenario.

_Hinweis_: Verwende kein [`git pull`](https://git-scm.com/docs/git-pull), wenn du mit _Rebase_ arbeitest.
Nutze stattdessen immer [`git pull --ff-only`](https://git-scm.com/docs/git-fetch); das ist die Kurzform für [`git fetch`](https://git-scm.com/docs/git-fetch) plus [`git merge --no-commit --ff --ff-only`](https://git-scm.com/docs/git-merge).

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Wir haben an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ gearbeitet und unsere Work-in-Progress (_WIP_)-Änderungen gepusht.
In der Zwischenzeit haben wir (oder ein Teammitglied) auf einem anderen Rechner das Feature fertiggestellt, die Historie aufgeräumt und nach `origin` gepusht.

## Aufgabe: Die aufgeräumte Historie von `origin` übernehmen

Nutze `git fetch` und anschließend [`git reset --hard`](https://git-scm.com/docs/git-reset#Documentation/git-reset.txt---hard) auf `origin/living-room-ac-automation`.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* da2218a (origin/living-room-ac-automation) automate living-room AC
* 0a7fdbd install living-room balcony-door sensor
* 3cfe8a0 install living-room thermostat sensor
* ddb7e7d install living-room AC
* a97d339 (origin/main, main) define automation-rules schema
* b2d22bf define traits for devices
| * 88d99ae (HEAD -> living-room-ac-automation) DELETE! thermometer test value 19°C
| * 27cfb03 WIP ac off
| * a782fb3 DELETE! thermometer test value 26°C
| * 4316803 WIP ac on
| * d9704ea define automation-rules schema
| * dccfbb0 install sensors
| * b1ab55b install ac
|/
* d6c3615 install living-room light
* 47d92b6 define devices schema
* 7a0dac6 register living room
* cb7d7d1 define rooms schema
* dd1072a write README
* 375a72b configure Git
```
_Hinweis_: In dieser lokalen Kopie des Git-Repositorys ist noch die alte Branch-Historie von `living-room-ac-automation` ausgecheckt, während `origin/living-room-ac-automation` die neue Branch-Historie enthält.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* da2218a (HEAD -> living-room-ac-automation, origin/living-room-ac-automation) automate living-room AC
* 0a7fdbd install living-room balcony-door sensor
* 3cfe8a0 install living-room thermostat sensor
* ddb7e7d install living-room AC
* a97d339 (origin/main, main) define automation-rules schema
* b2d22bf define traits for devices
* d6c3615 install living-room light
* 47d92b6 define devices schema
* 7a0dac6 register living room
* cb7d7d1 define rooms schema
* dd1072a write README
* 375a72b configure Git
```

## Reflektieren & Wiederholen

- Wie kann sich das Rebasen eines geteilten Branches auf die lokale Historie anderer Entwickler auswirken?
- Wie können Teams sich abstimmen, wenn Force-Pushing erlaubt ist?
- Welche Alternativen gibt es, wenn das Umschreiben einer geteilten Historie zu riskant ist?
- Was würdest du tun, wenn ein Teammitglied Commits überschrieben hat, die du noch benötigst?
