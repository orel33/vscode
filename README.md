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

* ajouter une *tâche* de build (menu )


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

* Exemple du langage Python avec notebook Jupyter, ...
* Extension ESLint (Linter pour JavaScript)

---

## Code Runner

Run code snippet or code file for multiple languages...

<center><img src="https://raw.githubusercontent.com/formulahendry/vscode-code-runner/master/images/usage.gif" width=80%></center>

---

## Writing in MarkDown

* Markdown support: highlighting, outline, preview on-the-fly (Ctrl+K V), ...
* Markdown linting and style checking (extension *mardownlint*)
* Show Markdown as Reveal.js presentation (extension *vscode-reveal*)

<center><img src="img/markdownlint.png" width=80%></center>

---

## GIT

* Extension *GitLens* enhances the Git capabilities of VS Code (blame, diff, branch, ...)

<center><img src="https://raw.githubusercontent.com/eamodio/vscode-gitlens/master/images/gitlens-preview.gif" width=80%></center>

note: git config credential.helper store
note: présenter éventuellement gitlab dans le context Inria pour la CI (intégration continue), valeur ajoutée de gitlens

---

## Mes Raccourcis

* Ctrl + P : chercher rapidement un fichier à ouvrir (file palette)
* Ctrl + Shift + P : chercher rapidement une commande à lancer (command palette)
* Ctrl + W : fermer l'éditeur courant
* F7 : compiler le projet (à condition qu'il soit déjà bien configuré)
* ctrl + Shift + I : indentation selon les règles fournies par le fichier .clang-format
* Ctrl + Shift + / : commenter/décommenter la sélection
* Alt + Z : toggle word wrap
* crtl + f : chercher dans le fichier courant ; F3 : next : shift + F3 : previous
* F12 / ctrl + F12 : navigation entre la déclaration et la définition d'une fonction
* Ctrl + J : fermer / ouvrir le panel du bas
* Ctrl + , : édition des user & workspace settings (au format JSON)

---

## My Favorite Extensions

* [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools), [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
* [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake), [CMake Tools](https://marketplace.visualstudio.com/items?itemName=vector-of-bool.cmake-tools)
* [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) (Git supercharged)
* [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) (Run code snippet or code file for multiple language)
* [Spell Right](https://marketplace.visualstudio.com/items?itemName=ban.spellright) (Multilingual, Offline and Lightweight Spellchecker)
* [Path Intellisense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense) (filename auto-completion)
* Misc: VSCode Icons, Dracula Official (theme), Settings Sync, VS Live Share, ...

<!-- 
* Todo Highlighter
* [Et encore...](https://codeburst.io/top-javascript-vscode-extensions-for-faster-development-c687c39596f5)
-->

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

---

## About this Document

This document is written in *Markdown* and converted into slides by the extension *vscode-reveal* (based on [Reval.js](https://revealjs.com)).

This presentation and all demo are available on [GitHub](https://github.com/orel33/vscode):

```bash
git clone https://github.com/orel33/vscode.git
```

Acknowledgment: Pierre Ramet

<!-- 
## Writing in LaTeX

Les autres langages ? LaTeX. Et encore YAML, XML, HTML, CSS, Shell, ...

* compilation on-the-fly, preview pdf synchronisé, navigation TOC, spellright (english)
* Exemple du langage MD & LaTeX

---
-->

