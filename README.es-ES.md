

# Git Kata - Historial Limpio

![Git Logo](./resources/git-logo.png)

Un historial Git limpio es beneficioso para un proyecto de muchas maneras. Similar a cómo el código limpio documenta el estado actual del software, un registro Git bien cuidado documenta qué cambios ocurrieron y por qué. Por ejemplo,
* _¿Cuáles son las decisiones de diseño en un pull request?_
* _¿Qué ha ocurrido desde el último fetch?_
* _¿Por qué cambió la implementación de una función?_
* _¿Fue esto una refactorización o un cambio en la funcionalidad?_
* _¿Cuándo se introdujo el error? (soportado por git-bisect)_

Sin embargo, [mensajes de commit bien redactados](https://chris.beams.io/posts/git-commit/) no son suficientes para un historial Git limpio, y necesitamos cuidar y _refactorizar_ nuestro historial antes de "confirmarlo"; o dicho de otra manera, [reescribir el historial](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History). Para todas las preguntas anteriores, queremos tener commits coherentes, pequeños y funcionales. Además, un historial lineal ayuda a comprender la secuencia de cambios con mayor facilidad.

Para visualizarlo, queremos pasar de este tipo de registro Git (aquí, solo 3 desarrolladores trabajaron en paralelo)

![Git merge](./resources/git-merge-3-devs.svg)

a este tipo de historial lineal (aquí, 5 desarrolladores trabajaron en paralelo)

![Git rebase](./resources/git-rebase-5-devs.svg)

o incluso tan lineal como [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow).

![Git oneflow](./resources/git-one-flow.svg)

**Nota**: Este kata asume que ya tienes conocimientos básicos de Git, como cómo _stage_ archivos, _commit_ cambios, _push_ al origen, _fetch_ y _pull_ desde remoto, _branching_, y trabajar con el _Git log_. 

---

## Inicio Rápido

* Asegúrate de que la última versión de `Git` esté instalada y disponible en la consola
* Navega a la carpeta de un ejercicio; por ejemplo, `<kata-root>/101-local-amend-commit`
* Ejecuta `./init.sh` en esa carpeta
  - En Windows, utiliza _Git BASH_ u otros emuladores de Bash (por ejemplo, [cmder](https://cmder.net/))
  - En Mac OS X, cambia a la rama [`main-osx`](https://github.com/andrej-dyck/git-kata/tree/main-osx)
* Navega a la carpeta creada/actualizada `<kata-root>/exercise` con tu cliente Git favorito
* Consulta el README.md en esa carpeta para conocer la descripción y la tarea

### Con IntelliJ (opcional)

_Esto es opcional_, si deseas tener soporte de compilador de IntelliJ y/o usar su cliente Git integrado.

* Abre este proyecto Gradle con [IntelliJ](https://www.jetbrains.com/idea/)
  - Puedes usar la [Community Edition](https://www.jetbrains.com/idea/) gratuita
  - En Windows, configura `Settings > Tools > Terminal > Shell path` como `"<system-path-to-git>\bin\bash.exe" --login -i` (ver _Nota_)
* En la vista del proyecto, haz clic derecho en el `init.sh` de un ejercicio y _ejecútalo_ con `Run 'init.sh'`
* Selecciona la carpeta creada/actualizada `<kata-root>/exercise` y abre la ventana de herramientas `Git` (`ALT+9`)
  - Si clonaste este repositorio, en la ventana Git Log, elige el filtro `Paths: exercise`
* Consulta el README.md en esa carpeta para conocer la descripción y la tarea

### Nota
Los scripts de inicialización para este kata son scripts _bash_, por el momento. Por lo tanto, necesitas Bash para ejecutarlos.
Afortunadamente para Windows, _Git Bash_ es una consola que puede ejecutar esos scripts.

---

## Enlaces y Recursos

El [sistema de control de versiones Git](https://git-scm.com/)

### Katas inspirados en
* [eficode-academy/git-katas](https://github.com/eficode-academy/git-katas)
* [Git Immersion - A guided tour](https://gitimmersion.com/)

### Convenciones de nomenclatura
* [Git commit message](https://chris.beams.io/posts/git-commit/)
* [Providing context with commit messages](https://testing.googleblog.com/2017/09/code-health-providing-context-with.html)
* [Git branch naming](https://deepsource.io/blog/git-branch-naming-conventions/)

### Flujos de trabajo
* [Comparing workflows](https://www.atlassian.com/git/tutorials/comparing-workflows)
* [OneFlow](https://www.endoflineblog.com/oneflow-a-git-branching-model-and-workflow)
* [GitFlow overview](https://datasift.github.io/gitflow/IntroducingGitFlow.html)
* [Enhanced GitFlow](https://www.toptal.com/gitflow/enhanced-git-flow-explained)
* [Trunk-based Development](https://trunkbaseddevelopment.com/)

### Merge & Rebase
* [Merge vs Rebase](https://www.atlassian.com/git/tutorials/merging-vs-rebasing)
* [Interactive Rebase](https://www.atlassian.com/git/tutorials/rewriting-history)

### Tutoriales y Conferencias
* [Atlassian learn Git](https://www.atlassian.com/git/tutorials/learn-git-with-bitbucket-cloud)
* [Git Happens - Jessica Kerr](https://www.youtube.com/watch?v=yCh6TSLIQBQ)
* [Git Fu Developing - Sebastian Feldmann](https://www.youtube.com/watch?v=FfaGUy-l1rs)
* [How Effective Teams Use Git - Enrico Campidoglio](https://www.youtube.com/watch?v=jw8yK5JV0xw)
* [Learn Git Branching](https://learngitbranching.js.org/)

### Clientes Git Recomendados
* [Git-Plugin of JetBrains IDEs](https://www.jetbrains.com/help/idea/version-control-integration.html) (gratuito con IDEs de la edición Community)
* [SmartGit](https://www.syntevo.com/smartgit/) (gratis/de pago)
* [Fork](https://git-fork.com/) (de pago)
* [GitKraken](https://www.gitkraken.com/git-client) (gratis/de pago)

### Otras Herramientas
* [gitignore.io](https://www.toptal.com/developers/gitignore)
