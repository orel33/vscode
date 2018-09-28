---
theme: black
customTheme : orel
transition: none
center: false
slideNumber: true
---

# Visual Studio Code

<br>
<br>
<center><url>https://github.com/orel33/vscode</url></center>
<center> ~ </center>
<center><url>https://code.visualstudio.com</url></center>
<center> ~ </center>
<center>aurelien.esnard@u-bordeaux.fr</center>
<br>
<br>

<center><img src="img/icon.svg" width="100" align="middle"></center>

---

## Introduction

* Just another IDE & source code editor
* Provided by Microsoft under free & open-source license (MIT)
* Cross-Platform: Linux, Windows, MacOS
* Hundred of languages supported : <https://code.visualstudio.com/docs/languages/overview>
* First release in 2015 (Vi & Emacs in 1976, Vim in 1991, Atom in 2014)
* Survey [Stack Overflow](https://insights.stackoverflow.com/survey/2018/#development-environments-and-tools) : rank #13 en 2016, rank #1 en 2018 (75 000 users)
* Written in TypeScript & JavaScript and based on [Electron](https://github.com/electron/electron) framework
  * the Atom shell provided by GitHub (backend Node.js + frontend Chromium)
* Extensible: many extensions available on <https://marketplace.visualstudio.com>

---

## Overview

* Editors, Side Bar (Explorer, ...), Actvity Bar, Status Bar, Panels, Palettes

<center><img src="https://code.visualstudio.com/assets/docs/getstarted/userinterface/hero.png" width=80%></center>

Note:
* https://code.visualstudio.com/docs/getstarted/userinterface
* présentation de l'IDE (palette, task, ...)
* notion de workspace, configuration JSON, keybinding, installation package en ligne de commande, ...

---

## Installation

Debian Linux:

```bash
URL="https://vscode-update.azurewebsites.net/1.27.2/linux-deb-x64/stable"
sudo apt-get install gdebi
wget $URL -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb
```

Then, run *code* in your working directory as follow:

```bash
code .
```

---

## C/C++ Programming

* Extension C/C++ (provided by Microsoft)
* code navigation, smart completion / hinting ([IntelliSense](https://code.visualstudio.com/docs/editor/intellisense)), code formatting (clang-format), linting, debugging, refactoring

<https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/>

Note:
* Code Formatting (Ctrl + Shift + I)
* Go to Definition (F12), Go to Declaration (Ctrl + F12), Peek Definition (Ctrl + Shift + F10)
* Show Declaration (Hover) / Show Definition (Ctrl + Hover)

---

## C/C++ Building and Running

* configure a build task
* 


Note: 
* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#building

---

## C/C++ Debugging

<center><img src="https://msdnshared.blob.core.windows.net/media/2016/03/debugging-all-up.png" width=80%></center>

Note:
* https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md
* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#debugging

---

## CMake Project

* Extensions: CMake & CMake Tools


Note: 
* CMake / CTest (compilation out-of-source, kit de dev, sélection d'option CMake, ...)
* [Documentation](https://vector-of-bool.github.io/docs/vscode-cmake-tools/getting_started.html)

---

## Python & JavaScript

* Python support with linting, debugging, smart completion, code formatting, refactoring, unit tests, snippets, ... (extension *Python*)
* Run code snippet or code file for multiple languages... (extension *Code Runner*)
* Linter pour JavaScript (extension *ESLint*)

<center><img src="https://raw.githubusercontent.com/formulahendry/vscode-code-runner/master/images/usage.gif" width=80%></center>

Note:
* test notebook Jupyter for Python

---

## Writing in MarkDown

* syntax highlighting, outline, preview on-the-fly (Ctrl+K V), ...
* linting and style checking (extension *mardownlint*)
* Show Markdown as Reveal.js presentation (extension *vscode-reveal*)

<center><img src="img/snap-markdown.png" width=80%></center>

---

## Writing in LaTeX

* highlighting, smart completion, building, view PDF, linting, ... (extension *LaTeX Workshop*)
* multilingual spell checker (extension *Spell Right*)

<center><img src="img/snap-latex.png" width=80%></center>

---

## GIT

* Amazing Git support with *GitLens* & *Git History* extensions: blame, diff, branch, log, ...

<center><img src="https://raw.githubusercontent.com/eamodio/vscode-gitlens/master/images/gitlens-preview.gif" width=80%></center>

Note:
* git config credential.helper store
* Demo CI with Inria Gitlab

---

## Keyboard Shortcuts

| Shortcut        | Description                                 |
|-----------------|---------------------------------------------|
| Ctrl+P          | quick open file palette                     |
| Ctrl+Shift+P    | quick open command palette                  |
| Ctrl+K Ctrl+T   | change theme                                |
| Ctrl+K Z        | zen mode (Esc Esc to escape)                |
| Ctrl+J / Ctrl+B | toggle panel / side bar visibility          |
| Ctrl+,          | edit user & workspace settings              |
| Ctrl+W          | close current editor                        |
| Ctrl+N          | new file                                    |
| Ctrl+O          | open file                                   |
| Ctrl+S          | save / save as file                         |
| Ctrl+/          | comment / uncomment line(s)                 |
| Alt+↑ / Alt+↓   | move line(s) up / down                      |
| Alt+Z           | toggle line wrapping                        |
| Ctrl+Space      | trigger suggestion for completion           |
| Ctrl+Shift+I    | code formatting                             |
| F12 / Ctrl+F12  | go to function definition / declaration     |
| Ctrl+Shift+F10  | peek definition                             |
| Ctrl+Shift+V    | Markdown preview                            |
| Ctrl+⇟ / Ctrl+⇞ | move to next / previous editor              |
| Ctrl+Shift+C    | open external terminal                      |



[Linux Refcard](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)

Note:
* F7 : compiler le projet (à condition qu'il soit déjà bien configuré)
* crtl + f : chercher dans le fichier courant ; F3 : next : shift + F3 : previous

---

## My Favorite Extensions

* [C/C++][ext-cpp], [Python][ext-python]
* [CMake][ext-cmake], [CMake Tools][ext-cmaketools]
* [GitLens][ext-gitlens] (Git supercharged), [Git History][ext-githistory] (View git log, file history, compare branches or commits)
* [Code Runner][ext-coderunner] (Run code snippet or code file for multiple language)
* [Spell Right][ext-spellright] (Multilingual, Offline and Lightweight Spellchecker)
* [Path Intellisense][ext-path] (Filename auto-completion)
* [Latex Workshop][ext-latex] (LaTeX support, preview, compile, autocomplete, colorize, and more...)
* Misc: VSCode Icons, Dracula Theme, Settings Sync, VS Live Share, Todo Highlighter, Rainbow brackets & indent, Insert Unicode ...

Note:
* https://codeburst.io/top-javascript-vscode-extensions-for-faster-development-c687c39596f5
* test: mardown all in one

[ext-cpp]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools "C/C++ extension"
[ext-python]: https://marketplace.visualstudio.com/items?itemName=ms-python.python "Python extension"
[ext-cmake]: https://marketplace.visualstudio.com/items?itemName=twxs.cmake "CMake extension"
[ext-cmaketools]: https://marketplace.visualstudio.com/items?itemName=vector-of-bool.cmake-tools "CMake Tools extension"
[ext-gitlens]: https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens "GitLens extension"
[ext-coderunner]: https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner "Code Runner extension"
[ext-spellright]: https://marketplace.visualstudio.com/items?itemName=ban.spellright "Spell Right extension"
[ext-path]: https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense "Path IntelliSense extension"
[ext-latex]: https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop "Latex Workshop extension"
[ext-githistory]: https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory "Git history extension"
---

## Les Extensions

* Extensions codés en TypeScript & JavaScript
* Distribués sur <https://marketplace.visualstudio.com>
* [Extending Visual Studio Code](https://code.visualstudio.com/docs/extensions/overview)

---

## Pour aller plus loin

Regarder les extensions pour Docker, node.js, Android, ...

---

## Demo

* demo hello.c
* demo hello.cmake
* demo hello.py

TODO: end this

---

## About this Document

This document is written in *Markdown* and converted into slides by the extension *vscode-reveal* (based on [Reval.js](https://revealjs.com)).

This presentation and all demo are available on [GitHub](https://github.com/orel33/vscode):

```bash
git clone https://github.com/orel33/vscode.git
```

Acknowledgment: Pierre Ramet

---
