# 112 Interactive Rebase auf `main`

In [Übung 104](../104-local-rebase-onto-main/README.md) haben wir gelernt, wie man Änderungen aus `main` durch einen _[Rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)_ eines Branches auf `main` integriert.

![](../resources/main-feature-out-of-sync-more.svg)

Für besser handhabbare Änderungen können wir den _[interaktiven Rebase](https://git-scm.com/book/en/v2/Git-Branching-Rebasing)_ [`git rebase -i`](https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt--i) nutzen (vgl. [Übung 106](../106-local-interactive-rebase-reorder-commits/README.md) bis [111](../111-local-interactive-rebase-delete-commits/README.md)), um einen Rebase auf `main` durchzuführen und unsere Historie in einem einzigen Durchgang aufzuräumen.

![](../resources/main-feature-sync-rebase-i.svg)

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Während unser Team an der _Automatisierung_ des _Wohnzimmer-Lichts_ arbeitet (Übungen `101` bis `104`), haben wir deren _automation-rules Schema_ per _Cherry-Pick_ übernommen und mit der Arbeit an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ begonnen.

In der Zwischenzeit wurde `living-room-light-automation` in `main` integriert.

## Aufgabe: Auf `main` rebasen mittels Interactive Rebase zum Aufräumen der Historie

Während wir an der _Automatisierung_ der _Wohnzimmer-Klimaanlage_ gearbeitet haben, hat unser Team `living-room-light-automation` in `main` integriert.
Unser Branch ist ebenfalls fast bereit für die Integration in `main`.

Um die Integration vorzubereiten und _Konflikte zu lösen_, nutze `git rebase -i main`, um auf `main` zu rebasen und unsere Historie (vgl. _Ziel-Git-Historie_) in einem Schritt aufzuräumen.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* f6110e8 (HEAD -> living-room-ac-automation) ac on/off balcony-door
* dbd492e install balcony-door sensor
* 5ab2c26 ac off temp
* 074d7a7 ac on temp
* f3eb688 install thermometer
* 9ae6ee4 install ac
* 986ef20 define automation-rules schema
| * cc7b2f0 (main) automate living-room light
| * b85a1a9 define automation-rules schema
| * 2ecb46f install living-room ambient-light sensor
| * 25aaa25 install living-room presence sensor
| * 8260331 define living-room-light trait on-off
|/
* b2bd4dc install living-room light
* 4cbcfd5 define devices schema
* 991ec2a register living room
* fe66daa define rooms schema
* 5b8d964 write README
* d1b4b6e configure Git
```

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 9fb56c9 (HEAD -> living-room-ac-automation) automate turning off living-room AC
* 03375f6 install living-room balcony-door sensor
* bcbff7b install living-room thermostat sensor
* f22da0b install living-room AC
* cc7b2f0 (main) automate living-room light
* b85a1a9 define automation-rules schema
* 2ecb46f install living-room ambient-light sensor
* 25aaa25 install living-room presence sensor
* 8260331 define living-room-light trait on-off
* b2bd4dc install living-room light
* 4cbcfd5 define devices schema
* 991ec2a register living room
* fe66daa define rooms schema
* 5b8d964 write README
* d1b4b6e configure Git
```
_Hinweis_: Da wir `living-room-ac-automation` auf `main` gerebased haben, enthalten `devices.json` und `automation-rules.json` nun alle Geräte, Sensoren und Regeln sowohl für das _Wohnzimmer-Licht_ als auch für die _Wohnzimmer-Klimaanlage_.

## Reflektieren & Wiederholen

- Wie hilft der _interaktive Rebase_ bei der Integration von Änderungen aus `main` im Vergleich zu einem einfachen _Rebase_?
- Wann würdest du einen interaktiven Rebase auf `main` einem einfachen Rebase gefolgt von einem separaten Aufräum-Rebase vorziehen?
- Welche Arten von Bereinigungen der Historie lassen sich während eines Rebase auf `main` einfacher durchführen als in einem separaten Schritt danach?
