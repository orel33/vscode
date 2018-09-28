---
theme: black
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
* Survey [Stack Overflow](https://insights.stackoverflow.com/survey/2018/#development-environments-and-tools) : rank #13 en 2016, rank #1 en 2018 (75 000 users)
* Provided by Microsoft under free & open-source license (MIT)
* First release in 2015 (Vi & Emacs in 1976, Vim in 1991, Atom in 2014)
* Cross-Platform: Linux, Windows, MacOS
* Written in TypeScript & JavaScript and based on [Electron](https://github.com/electron/electron) framework
  * (backend Node.js + frontend Chromium), the Atom shell provided by GitHub
* Extensible: a lot of extension available on <https://marketplace.visualstudio.com>

---

## Vue d'Ensemble

* Editors, Side Bar (Explorer, ...), Actvity Bar, Status Bar, Panels

 ![overview](https://code.visualstudio.com/assets/docs/getstarted/userinterface/hero.png)

<https://code.visualstudio.com/docs/getstarted/userinterface>

note:  présentation de l'IDE (palette, task, ...)

---

## Quelques Trucs

* notion de workspace, configuration JSON, keybinding, installation package en ligne de commande, ...

---

## Installation de VS Code

Installation sous Debian Linux:

```bash
sudo apt-get install gdebi
wget "https://vscode-update.azurewebsites.net/1.27.2/linux-deb-x64/stable" -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb
```

Et démarrage depuis le répertoire d'un projet :

```bash
code .
```

---

## Programmer en C/C++

* Extensions : C/C++ et 
* navigation / complétion / indentation / analyse statique (linter) / support documentation (Doxygen) / support des différents compilateurs (gcc, clang)
* intégration de la compilation / exécution / debuggage
* Code formating avec clang-format (Ctrl + Shift + I)
* Exemple du langage C (avec plutôt clang et l'exemple de l'analyse statique sur printf("%d %s", ...))

Raccourcis :
* Go to Definition (F12), Go to Declaration (Ctrl + F12), Peek Definition (Ctrl + Shift + F10)
* Show Declaration (Hover) / Show Definition (Ctrl + Hover)

<https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/>

---

## Compilation, Exécution et Debug

* ajouter une *tâche* de build (menu )
* gdb settings en json

---

## Utilisation de CMake

* Extensions : CMake et CMake Tools
* [Documentation](https://vector-of-bool.github.io/docs/vscode-cmake-tools/getting_started.html)

---

## Programmer en Python / JavaScript

* Exemple du langage Python avec notebook Jupyter, ...
* Extension ESLint (Linter pour JavaScript)

---

## Ecrire en MarkDown

* Markdown support (highlighting, outline, ...)
* *preview* synchronisée (Ctrl + K V)
* Markdown linting and style checking (extension *mardownlint*)
* Show markdown as revealJs presentation (extension *vscode-reveal*)

=> AJOUTER IMAGE

---

## Ecrire encore

Les autres langages ? LaTeX. Et encore YAML, XML, HTML, CSS, Shell, ...

* compilation on-the-fly, preview pdf synchronisé, navigation TOC, spellright (english)
* Exemple du langage MD & LaTeX

---

## GIT

* Extension : GIT Lens

![](https://raw.githubusercontent.com/eamodio/vscode-gitlens/master/images/gitlens-preview.gif)



```bash
git config credential.helper store
```

---

## Et quoi encore

* GIT : éventuellement gitlab dans le context Inria pour la CI (intégration continue), valeur ajoutée de gitlens
* CMake / CTest (compilation out-of-source, kit de dev, sélection d'option CMake, ...)
* Makefile (compilation à la main ?)

---

## Mes Raccourcis

* Ctrl + P : chercher rapidement un fichier à ouvrir (file palette)
* Ctrl + Shift + P : chercher rapidement une commande à lancer (command palette)
* Ctrl + W : fermer l'éditeur courant
* F7 : compiler le projet (à condition qu'il soit déjà bien configuré)
* ctrl + Shift + I : indentation selon les règles fournies par le fichier .clang-format
* Ctrl + Shift + / : commenter/décommenter la sélection
* crtl + f : chercher dans le fichier courant ; F3 : next : shift + F3 : previous
* F12 / ctrl + F12 : navigation entre la déclaration et la définition d'une fonction
* Ctrl + J : fermer / ouvrir le panel du bas
* Ctrl + , : édition des user & workspace settings (au format JSON)

---

## Mes Extensions

Déjà présenté ici :

* C/C++
* CMake & CMake Tools

Et encore :

* VSCode Icons
* Dracula Official


A tester :

* VS Live Share
* Todo Highlighter
* Path Intellisense
* Instant Markdown ?
* Settings Sync
* [Et encore...](https://codeburst.io/top-javascript-vscode-extensions-for-faster-development-c687c39596f5)

--- 

## Les Extensions

* Extensions codés en TypeScript & JavaScript
* Distribués sur <https://marketplace.visualstudio.com>
* [Extending Visual Studio Code](https://code.visualstudio.com/docs/extensions/overview)


---

## Pour aller plus loin

Regarder les extensions pour Docker, node.js, Android, ...

--- 

## A Propos de ce Document

This document is written in *Markdown* and converted into slides by the extension *vscode-reveal* (based on [Reval.js](https://revealjs.com)).

This presentation is available on *github.com*:

```bash
git clone https://github.com/orel33/vscode.git
```

**Aknowledgement**: Pierre Ramet

---


<style>
    /* 1vh = 1% of the height of the viewport */
    .reveal h1 { font-size: 10vh; ; text-align: center; }
    .reveal h2 { font-size: 7vh; text-align: center; }
    .reveal h3 { font-size: 5vh; }
    .reveal .slides { font-size: 3vh; text-align: left; }
    .reveal section img { background:none; border:none; box-shadow:none; }
</style>