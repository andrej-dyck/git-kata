# Git Kata - Clean History

[![CI](https://github.com/andrej-dyck/endoflife-radar/actions/workflows/ci.yml/badge.svg?branch=main)](https://github.com/andrej-dyck/git-kata/actions/workflows/ci.yml) 
 [![language-en](./resources/lang-en.svg)](https://github.com/andrej-dyck/git-kata/)
 [![language-de](./resources/lang-de.svg)](https://github.com/andrej-dyck/git-kata/tree/language-de)

![Git Logo](./resources/git-logo-clean.svg)

Eine _saubere Git-Historie_ ist linear, schlüssig und bewusst gestaltet; und somit einfacher zu lesen, zu navigieren und nachzuvollziehen.

Eine gepflegte Git-Historie erzählt die Story der logischen Entwicklung des Projekts: _Welche_ Änderungen wurden vorgenommen und, noch wichtiger, _Warum_?
Die Historie soll uns helfen, das Projekt zu verstehen, nicht wie das Team zufällig gearbeitet hat.

Wir sollten in der Lage sein, die Commit-Historie anzuschauen und Fragen zu beantworten wie: _Was hat sich geändert? Warum? Welche Entscheidungen führten zu dieser Änderung? Wie hat sich das Projekt entwickelt? Wann trat eine bestimmte Änderung oder ein bestimmtes Problem auf (unterstützt durch [Git bisect](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search))?_

[Gute Commit-Messages](https://chris.beams.io/posts/git-commit/) sind ein wichtiger Bestandteil einer sauberen Git-Historie, aber für sich allein reichen sie nicht aus.
Um die Lesbarkeit der Projekthistorie zu verbessern, wollen wir _atomare Commits_ (klein, kohärent und funktionsfähig) in einer logischen, linearen Reihenfolge.

Die Arbeit mit [Trunk-based Development](https://trunkbaseddevelopment.com/) oder [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow) hilft uns, eine lineare Historie beizubehalten:

![Git trunk-based linear history](resources/git-trunk-based.svg)

Oder so, bei der Arbeit mit Merge-PRs:

![Git oneflow linear history](resources/git-oneflow.svg)

Vergleiche diese linearen Historien mit dem, was ein typisches [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) erzeugt; und das ist nur der `develop`-Branch mit drei Entwicklern, die Änderungen committen:

![typical GitFlow history](./resources/git-merge-3-devs.svg)

Aber eine lineare Historie allein ist nicht zwangsläufig eine _saubere Historie_. Die Commits selbst sollten dennoch atomar, kohärent und zielgerichtet sein.
Und die Pflege der Git-Historie erfordert Fokus und Disziplin.

Glücklicherweise erlaubt uns Git, die Commit-Historie nachträglich zu überarbeiten, indem wir die [Historie umschreiben](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
Mit diesen Werkzeugen können wir unsere Historie _"refaktorn"_, bevor wir sie mit anderen teilen.

## Über dieses Git Kata
Dieses Kata konzentriert sich auf die Erstellung einer sauberen und linearen Git-Historie unter Verwendung von Gits Funktionen zum [Umschreiben der Historie](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).

Dieses Kata setzt voraus, dass du bereits grundlegende Git-Kenntnisse hast; z. B. wie du Dateien _stagest_, Änderungen _committen_, zu origin _pusht_, von Remote _fetchst_ und _pullst_, _Branching_ nutzt und mit dem _Git log_ arbeitest.

## Durchführung dieses Git Katas

Jede Übung ist in sich geschlossen, selbst wenn sie auf vorherige Übungsnummern verweist; die Aufgabe ist in der Datei `README.md` beschrieben.

Jede Übung ist sicher zum Experimentieren, da ein rein lokales Repository durch ein `init.sh`-_Bash-Skript_ eingerichtet wird. Wenn du nicht weiterkommst, kannst du `init.sh` jederzeit erneut ausführen.

Ich empfehle diese Übungen mit einem grafischen (GUI) Git-Client zu lösen.

Jede Übung endet mit einem sauberen Arbeitsverzeichnis (d. h. `git status` zeigt keine Änderungen), einem sauberen Staging-Bereich (d. h. `git diff --staged` zeigt keine Änderungen) und einer _sauberen_ Historie (d. h. `git log --oneline --graph --decorate --all` zeigt die Ziel-Historie).

Jede Übung ist durch eine Nummer und einen Namen kategorisiert; z. B. `101-local-amend-commit`.
Die Hunderter `1xx` sind Übungen mit einem rein lokalen Repository; d. h. ohne _origin_/_remote_-Repository.
Die Zweihunderter `2xx` sind Übungen mit einem lokalen Repository und einem lokalen _origin_/_remote_-Repository.
Die Dreihunderter `3xx` sind fortgeschrittene Git-Übungen.

### Schnellstart
* Stell sicher, dass die neueste Version von [Git](https://git-scm.com/) installiert ist
* Klone dieses `git-kata`-Repository
  ```shell
  git clone --depth 1 -b language-de https://github.com/andrej-dyck/git-kata.git && cd git-kata && rm -rf .git && rm -rf .github
  ```
* Führe `./init.sh` aus und wähle die zu initialisierende Übung
* Die Übung wird in `<git-kata-root>/exercise` initialisiert
  * Beachte, dass standardmäßig jede Übung diesen Ordner verwendet und vorhandene Inhalte überschreibt
  * Du kannst [Docker](https://www.docker.com/) verwenden, um die Skripte isoliert auszuführen
* Öffne den erstellten/aktualisierten Ordner `<git-kata-root>/exercise` mit deinem bevorzugten Git-Client
* Schlage in der `README.md` in diesem Ordner die Aufgabenbeschreibung nach

_Optional_: Aufräumen ist nicht erforderlich, aber wenn du möchtest, lösche einfach den `exercise`-_Repository_-Ordner und dessen _origin_-Ordner `exercise-origin`.

### Isolierte Ausführung mit Docker
Verwende das [Dockerfile](./Dockerfile) und [Docker](https://www.docker.com/), um die _Bash-Skripte_ dieses Katas isoliert von deinem Betriebssystem auszuführen.

Führe nach dem Klonen dieses Repositorys den folgenden Befehl in `<git-kata-root>` aus:
```shell
docker build -t git-kata . && docker run --rm -it -v "./:/git-kata" git-kata
```

Verwende innerhalb des Docker-Containers `./init.sh`, um eine Übung auszuwählen und zu initialisieren.
Und da `/git-kata` in deinen lokalen Ordner gemountet ist, kannst du den Ordner `./exercise` mit deinem lokalen Git-Client öffnen.

### Lokale Ausführung
* Unter **Windows** mit installiertem [**Git**](https://git-scm.com/) kannst du die _Git Bash_ mit `sh init.sh` verwenden, um das Skript auszuführen
* Unter **Linux** / **macOS** musst du `init.sh` möglicherweise mit `chmod +x init.sh` ausführbar machen

#### `jq`-Abhängigkeit
[jq](https://jqlang.org/) ist ein leichtgewichtiger und flexibler JSON-Prozessor für die Kommandozeile.
Wenn du `jq` (oder `jaq`) installiert und in deinem `PATH` hast, wird das `init.sh`-Skript es automatisch verwenden.
Andernfalls versuchen die Skripte, die mitgelieferte `jq`-Binärdatei (Version `jq-1.8.2`) zu nutzen.
Oder du kannst es von [hier](https://jqlang.org/) installieren.

## Empfohlene Arbeitsweise mit Git im Team

### Atomare Commits
Ein **atomarer Commit** stellt eine _einzelne_, _in sich geschlossene_ und _kohärente Änderungseinheit_ dar, die die Codebasis in einem funktionsfähigen und testbaren Zustand hält.

Wenn du diesen Commit entfernst, rückgängig machst oder extrahierst (cherry-pickst), sollte sich dies nur auf diese spezifische Änderung auswirken, ohne etwas anderes zu beschädigen.

_Faustregel_: Wenn du die Änderung nicht einfach in einer einzelnen prägnanten Betreffzeile zusammenfassen kannst, ist der Commit wahrscheinlich nicht atomar.

### Gute Commit-Messages
Befolge die Kernprinzipien für [gute Commit-Messages](https://chris.beams.io/posts/git-commit/) (angepasst mit kleingeschriebenen Verben im Imperativ).

Die **Betreffzeile** ist eine prägnante Zusammenfassung dessen, _was_ der Commit tut, beginnend mit einem kleingeschriebenen Verb im Imperativ (z. B. `add`, `introduce`, `draft`, `model`, `configure`, `fix`).
* Leitfaden: _"If applied, this commit will ..."_

Der **Body** (optional, durch eine Leerzeile vom Betreff getrennt) erklärt, _warum_ die Änderung vorgenommen wurde und den Kontext dahinter.

### Ein Haupt-Branch
Pflege einen einzelnen `main`-Branch für alle Umgebungen, einschließlich der Produktion.
Ich empfehle den `main`-Branch vor dem Umschreiben der Historie zu schützen.

Jeder Commit auf `main` muss kontinuierlich _"deploybar"_ sein; d. h. er muss releasefähig und produktionsreif sein.

Vermeide langlebige Branching-Modelle wie die `develop`-, `release`- und `support`-Branches von GitFlow. Lies dazu auch [GitFlow considered harmful](https://www.endoflineblog.com/gitflow-considered-harmful).

### Kurzlebige Branches
Wenn du Branches verwendest, halte sie _kurzlebig_ und integriere sie so schnell wie möglich in `main`; idealerweise innerhalb von Minuten oder Stunden.

Führe regelmäßig einen Rebase auf `main` durch, um synchron zu bleiben und Merge-Konflikte zu vermeiden.

### Eine lineare Commit-Historie durchsetzen
Halte die Commit-Historie linear, indem du [Git _rebase_](https://git-scm.com/book/en/v2/Git-Branching-Rebasing) verwendest.
Eine lineare Historie ist einfacher zu lesen, zu navigieren und nachzuvollziehen.
Sie bildet die logische Entwicklung des Projekts besser ab.

Die Vorstellung, dass [Git _merge_](https://git-scm.com/book/en/v2/Git-Branching-Basic-Branching-and-Merging) die _"wahre"_ Historie bewahrt und dies daher einen erheblichen Wert hat, ist ein Scheinargument.
Während _Merge-Commits_ zwar genau aufzeichnen _wann_ Branches integriert wurden, erzeugen sie Störelemente und erschweren so die eigentlichen Änderungen nachzuvollziehen.
Dies gilt insbesondere dann, wenn Merge-Konfliktlösungen unabhängige Änderungen vermischen.

Die Historie sauber, fokussiert und linear zu halten, verbessert die Zusammenarbeit im Team und erleichtert die Wartung mit [Gits Werkzeugen zum Umschreiben der Historie](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History).
Es vereinfacht auch das [Debugging mit Git, z. B. Bisecting](https://git-scm.com/book/en/v2/Git-Tools-Debugging-with-Git#_binary_search), da jeder Commit einen klaren Schritt in der Entwicklung darstellt.

Das Ziel ist es, die Historie der logischen Entwicklung des Projekts zu bewahren; nicht die Historie der Branch-Integrationen.

## Links und Ressourcen

Das [Git-Versionskontrollsystem](https://git-scm.com/)

### Weitere Git-Katas
* [eficode-academy/git-katas](https://github.com/eficode-academy/git-katas)
* [Git Immersion - A guided tour](https://gitimmersion.com/)

### Namenskonventionen
* [Git commit message](https://chris.beams.io/posts/git-commit/)
* [Providing context with commit messages](https://testing.googleblog.com/2017/09/code-health-providing-context-with.html)
* [Git branch naming](https://deepsource.io/blog/git-branch-naming-conventions/)

### Workflows
* [Comparing workflows](https://www.atlassian.com/git/tutorials/comparing-workflows)
* [Trunk-based Development](https://trunkbaseddevelopment.com/)
* [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow)
* [GitFlow overview](https://datasift.github.io/gitflow/IntroducingGitFlow.html)
* [Enhanced GitFlow](https://www.toptal.com/gitflow/enhanced-git-flow-explained)

### Merge & Rebase
* [Merge vs Rebase](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
* [Interactive Rebase](https://www.atlassian.com/git/tutorials/rewriting-history)

### Tutorials & Vorträge
* [Atlassian - learn Git](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
* [Git Happens - Jessica Kerr](https://www.youtube.com/watch?v=yCh6TSLIQBQ)
* [Git Fu Developing - Sebastian Feldmann](https://www.youtube.com/watch?v=FfaGUy-l1rs)
* [How Effective Teams Use Git - Enrico Campidoglio](https://www.youtube.com/watch?v=jw8yK5JV0xw)
* [Learn Git Branching](https://learngitbranching.js.org/)

### Empfohlene Git-Clients
* [Git in JetBrains-IDEs (z. B. IntelliJ)](https://www.jetbrains.com/help/idea/version-control-integration.html) (kostenlos in den Community Editions)
* [SmartGit](https://www.syntevo.com/smartgit/) (kostenpflichtig, kostenlos für persönliche Nutzung und OSS)
* [Fork](https://git-fork.com/) (kostenpflichtig, kostenlose Testversion)
* [GitKraken](https://www.gitkraken.com/git-client) (kostenpflichtig, kostenlos für OSS)
* Hier findest du einige weitere [Git-GUIs](https://git-scm.com/tools/guis)

### Weitere nützliche Werkzeuge
* [gitignore.io](https://www.toptal.com/developers/gitignore)
