# 104 Rebase auf `main`

Wenn wir im Team arbeiten, wollen wir kurzlebige Branches bevorzugen (d. h. innerhalb von Stunden in `main` integriert).
Es ist jedoch unvermeidlich, dass `main` manchmal Commits enthält, die neuer sind als die auf unserem `feature`-Branch.

![](../resources/main-feature-out-of-sync.svg)

Es gibt zwei Möglichkeiten, die Änderungen aus `main` zu integrieren.

Eine Möglichkeit ist das **[Mergen](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) von `main` in den `feature`-Branch** mit [`git merge`](https://git-scm.com/docs/git-merge).

![](../resources/main-feature-sync-merge.svg)

Dies führt zu einer nicht-linearen, oft unübersichtlichen Git-Historie, die nie wieder linearisiert werden kann – und uns letztlich daran hindert, unsere Historie aufzuräumen.
Mit einer nicht-linearen, unübersichtlichen Historie finden wir möglicherweise Änderungen in unserem Branch, die nicht von uns stammen (integriert durch den _Merge-Commit_), das Rückgängigmachen kann komplizierter sein und das Untersuchen der Historie (z. B. _"Was ist passiert?"_ und Debugging mit `git bisect`) wird schwieriger.

Die zweite Möglichkeit ist das **[Rebasen](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) von `feature` auf `main`** mit [`git rebase`](https://git-scm.com/docs/git-rebase); mit anderen Worten: das erneute Anwenden unserer Änderungen ausgehend von einer neuen _Basis_, was zu einer linearen Historie führt. Du kannst es dir so vorstellen _"als hätten wir unseren Branch später gestartet"_.

![](../resources/main-feature-sync-rebase.svg)

`git merge` und `git rebase` unterscheiden sich hauptsächlich darin, wie sie Änderungen einbinden und die Historie darstellen.
_Merge_ bewahrt die tatsächliche Branching- und Integrationshistorie (_"wie die Entwickler gearbeitet haben“_), während _Rebase_ Commits umschreibt, um eine lineare Historie zu erzeugen, die sich auf die logischen Änderungen konzentriert (_"wie die Entwickler es dokumentieren möchten"_).

Viele Probleme, die oft `git merge` vs. `git rebase` zugeschrieben werden, sind keinem der beiden Ansätze inhärent.
Aufwendige Konflikte, wiederholte Konfliktlösungen, Probleme durch späte Integration und Änderungen, die sich sauber mergen lassen, aber nicht zusammen funktionieren, sind meist Folgen von zu später Integration und langlebigen, auseinanderdriftenden Branches.
Keiner der beiden Ansätze löst diese grundlegenden Koordinations- und Integrationsprobleme.

## Kontext der Übung

Wir arbeiten an einem _Smart Home_-Projekt, dessen Konfiguration auf drei primäre Datendateien aufgeteilt ist: `rooms.json`, `devices.json` und `automation-rules.json`.

Im Anschluss an die Übungen [101](../101-local-amend-commit/README.md) bis [103](../103-local-undo-last-commits/README.md) haben wir alle unsere _Wohnzimmer-Geräte_ erfolgreich installiert und die Implementierung einer Automatisierungsregel für die _Wohnzimmer-Beleuchtung_ abgeschlossen.

Es ist Zeit, unseren Feature-Branch zu integrieren; `main` hat sich in der Zwischenzeit jedoch weiterentwickelt.

## Aufgabe: Den Feature-Branch auf `main` rebasen

Während wir an der Licht-Automatisierung gearbeitet haben, hat unser Team weitere Geräte und Sensoren installiert sowie das _automation-rules Schema_ per _Cherry-Pick_ übernommen.

Bevor wir unseren Feature-Branch abschließen, ist es eine gute Praxis, `main` in unseren Branch zu integrieren und sicherzustellen, dass unsere Änderungen nach der Integration funktionieren.
Nutze zu diesem Zweck [`git rebase`](https://git-scm.com/docs/git-rebase), um unseren Branch `living-room-light-automation` auf `main` zu rebasen.

### Vertiefung
Untersuche nach dem Rebase auf `main`, was mit den Commits `"define automation-rules schema"` und `"define living-room-light trait on-off"` des Branches `living-room-light-automation` passiert ist.

### Initiale Git-Historie
```console
$ git log --oneline --graph --decorate --all
* f30d539 (main) define automation-rules schema
* 97070dc install living-room balcony-door sensor
* 2461e1b install living-room thermostat sensor
* 25dc6e3 install living-room AC
| * 3edb867 (HEAD -> living-room-light-automation) automate living-room light
| * 51f3204 define automation-rules schema
| * 70865e0 define living-room-light trait on-off
|/
* b2a2383 install living-room ambient-light sensor
* 0301603 install living-room presence sensor
* 0e8a75e install living-room light
* 8db8515 define devices schema
* 95060db register living room
* bbcecc8 define rooms schema
* 9315fb1 write README
* dbc3611 configure Git
```
_Hinweis_: Der Branch `living-room-light-automation` ist ausgecheckt, daher befindet sich der `HEAD` bei `3edb867`.

### Ziel-Git-Historie
```console
$ git log --oneline --graph --decorate --all
* 9e28e3b (HEAD -> living-room-light-automation) automate living-room light
* 3c69fc3 define living-room-light trait on-off
* f30d539 (main) define automation-rules schema
* 97070dc install living-room balcony-door sensor
* 2461e1b install living-room thermostat sensor
* 25dc6e3 install living-room AC
* b2a2383 install living-room ambient-light sensor
* 0301603 install living-room presence sensor
* 0e8a75e install living-room light
* 8db8515 define devices schema
* 95060db register living room
* bbcecc8 define rooms schema
* 9315fb1 write README
* dbc3611 configure Git
```
_Hinweis_: Da wir den Branch `living-room-light-automation` auf `main` gerebased haben, haben sich alle Commit-Hashes des Branches geändert.

## Reflektieren & Wiederholen

- Was bedeutet es, einen Branch auf `main` zu rebasen, und wie unterscheidet es sich vom Mergen?
- Warum kann _Rebase_ das Reviewen und Verstehen der Historie erleichtern?
- Wie kann Git feststellen, dass es ein Commit nicht erneut angewendet werden muss?
- Wie unterscheidet sich die Story eines gerebasten Branches von der Story eines Merge-Commits?
