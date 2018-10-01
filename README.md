---
theme: black
customTheme : orel
highlightTheme : zenburn # https://highlightjs.org
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
* Hundred of languages supported : [overview](https://code.visualstudio.com/docs/languages/overview)
* First release in 2015 (Vi & Emacs in 1976, Vim in 1991, Atom in 2014)
* Survey by [Stack Overflow](https://insights.stackoverflow.com/survey/2018/#development-environments-and-tools) : rank #13 en 2016, rank #1 en 2018 (75 000 users)
* Written in TypeScript & JavaScript and based on [Electron](https://github.com/electron/electron) framework
  * the Atom shell provided by GitHub (backend Node.js + frontend Chromium)
* Extensible: many extensions available on <https://marketplace.visualstudio.com>

---

## Editor Overview

* Editors, Side Bar (Explorer, ...), Actvity Bar, Status Bar, Panels

<center><img src="img/snap-overview.png" width=90%></center>

<!-- <center><img src="https://code.visualstudio.com/assets/docs/getstarted/userinterface/hero.png" width=80%></center> -->

Note:
* https://code.visualstudio.com/docs/getstarted/userinterface

--

* File Palette (quick open file, Ctrl+P)

<center><img src="img/snap-palette-file.png" width=60%></center>

--

* Command Palette (access all commands, Ctrl+Shift+P)

<center><img src="img/snap-palette-command.png" width=60%></center>

*type ?: to see all possible actions (> command, :go to line, ...)*

---

## Installation

* Installation on Debian Linux:

```bash
URL="https://vscode-update.azurewebsites.net/1.27.2/linux-deb-x64/stable"
sudo apt-get install gdebi
wget $URL -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb
```

* run VS Code in your *working directory* as follow:

```bash
code .
```

* install extensions using integrated extension manager (side bar) or command line:  

```bash
code --list-extensions
code --install-extension <extension name>
```

* see my [install.sh](install.sh) script 

---

## Settings

All settings in `.vscode/*.json` files (setting button at bottom of the activity bar or Ctrl+,)

* three levels: default / user / workspace settings (settings.json) 

```json
{
    "editor.renderWhitespace": "all",
    "editor.minimap.enabled": true,
    "editor.renderIndentGuides": true,
    "editor.formatOnType": true,
    "git.confirmSync": false,
    "window.zoomLevel": 0,
    "gitlens.gitExplorer.files.layout": "tree",
    "revealjs.center": false,
    "explorer.confirmDragAndDrop": false,
    "editor.wordWrap": "on",
    "workbench.colorTheme": "Dracula",
    "explorer.confirmDelete": false
}
```

* other files for some specific setting (extensions)
* build / run tasks  (tasks.json) + debug settings (launch.json) 

---

## C/C++ Programming

* Extension C/C++ (provided by Microsoft)
* code navigation, smart completion / hinting ([IntelliSense](https://code.visualstudio.com/docs/editor/intellisense)), code formatting (clang-format), linting, debugging, refactoring

* Configure a build task... and run it (Ctrl+Shift+B)
* Run Task
* Menu Debug > Add Configuration... (launch.json)

Note:
* Code Formatting (Ctrl + Shift + I)
* Go to Definition (F12), Go to Declaration (Ctrl + F12), Peek Definition (Ctrl + Shift + F10)
* Show Declaration (Hover) / Show Definition (Ctrl + Hover)
* <https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/>
* <https://code.visualstudio.com/docs/languages/cpp>
* configure debugging: <https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md>
* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#building

---

## C/C++ Debugging

<!-- <center><img src="https://msdnshared.blob.core.windows.net/media/2016/03/debugging-all-up.png" width=80%></center> -->

<center><img src="img/snap-debug.png" width=80%></center>

Note:
* https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md
* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#debugging

---

## Demo Fibonnaci

<https://en.wikipedia.org/wiki/Fibonacci_number>

```c
/* fib.c */
#include <stdio.h>
#include <assert.h>
#include <stdlib.h>

int fib(int n)
{
    if (n <= 1) return 1;
    else return fib(n - 1) + fib(n - 2);
}

int main(int argc, char const *argv[])
{
    int n = 10;
    if (argc == 2) n = atoi(argv[1]);
    assert(n > 0);
    int sum = fib(n);
    printf("%d\n", sum);
    return 0;
}
```

---

## Demo hello.c (2/2)



---

## Demo hello.js (1/2)

Sample [hello.js](demo/js/hello.js) for Node.js

```js
var N = process.argv[2];
var i;
for (i = 0; i < N; i++) {
    console.log("hello world!")
}
```

---

## Demo hello.js (2/2)

Configure a running task (menu Terminal > Configure Tasks) or edit file [tasks.json](https://go.microsoft.com/fwlink/?LinkId=733558)

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "run hello.js",
            "type": "shell",
            "command": "node",
            "args": ["hello.js", "2" ],
            "options": { "cwd": "${workspaceRoot}/demo/js/" }
        }
    ]
}
```

Run task with label "run hello.js" (menu Terminal > Run Task...)

```text
> Executing task: node hello.js 2 <

hello world!
hello world!
```

Note:
* debug: [launch.json](https://go.microsoft.com/fwlink/?linkid=830387)

---

## CMake Project

* Extensions: CMake & CMake Tools


Note: 
* CMake / CTest (compilation out-of-source, kit de dev, sélection d'option CMake, ...)
* [Documentation](https://vector-of-bool.github.io/docs/vscode-cmake-tools/getting_started.html)

---

## Python & JavaScript

* Python support with linting, debugging, code formatting, refactoring, unit tests, ... (extension *Python*)
* Run code snippet or code file for multiple languages... (extension *Code Runner*)
* Linter pour JavaScript (extension *ESLint*)

<center><img src="https://raw.githubusercontent.com/formulahendry/vscode-code-runner/master/images/usage.gif" width=80%></center>

Note:
* What about the Jupyter notebook for Python?

---

## Writing in MarkDown

* syntax highlighting, outline, preview on-the-fly (Ctrl+K V), ...
* formatting, list editing and more (extension *Markdown All in One*) + linting (extension *mardownlint*)
* show Markdown as slides (extension *vscode-reveal*)

<center><img src="img/snap-markdown.png" width=80%></center>


Note:
* <https://ia.net/writer/support/general/markdown-guide>

---

## Writing in LaTeX

* highlighting, smart completion, building, view PDF, linting, ... (extension *LaTeX Workshop*)
* multilingual spell checker (extension *Spell Right*)

<center><img src="img/snap-latex.png" width=80%></center>

---

## GIT

* Amazing Git support with *GitLens* & *Git History* extensions: blame, diff, branch, log, ...

<!-- <center><img src="https://raw.githubusercontent.com/eamodio/vscode-gitlens/master/images/gitlens-preview.gif" width=80%></center> -->

<center><img src="img/snap-git.png" width=80%></center>

Note:
* demo CI with Inria Gitlab (extension *???*)

---

## Keyboard Shortcuts (1/2)

* all keyboard shortcuts (setting button at bottom of activity bar) 

| Shortcut        | Description                        |
| --------------- | ---------------------------------- |
| Ctrl+P          | quick open file palette            |
| Ctrl+Shift+P    | quick open command palette         |
| Ctrl+K Ctrl+T   | change theme                       |
| Ctrl+K Z        | zen mode (Esc Esc to escape)       |
| Ctrl+J / Ctrl+B | toggle panel / side bar visibility |
| Ctrl+,          | edit user & workspace settings     |
| Ctrl+W          | close current editor               |
| Ctrl+N          | new file                           |
| Ctrl+O          | open file                          |
| Ctrl+S          | save / save as file                |

---

## Keyboard Shortcuts (2/2)

| Shortcut        | Description                             |
| --------------- | --------------------------------------- |
| Ctrl+/          | toggle line(s) comment                  |
| Alt+↑ / Alt+↓   | move line(s) up / down                  |
| Alt+Z           | toggle line wrapping                    |
| Ctrl+Space      | trigger suggestion for completion       |
| Ctrl+Shift+I    | code formatting                         |
| F12 / Ctrl+F12  | go to function definition / declaration |
| Ctrl+Shift+F10  | peek definition                         |
| Ctrl+Shift+V    | Markdown preview                        |
| Ctrl+⇟ / Ctrl+⇞ | move to next / previous editor          |
| ???             | ???                                     |

<!-- | Ctrl+Shift+C    | open external terminal                      | -->


Note:
* Start debugging / continue (F5), step over (F10), 
* CMake build (F7)
* find in file (Crtl+F), find in all files (Ctrl+Shift+F), next (F3), previous (Shift+F3)
* copy (Ctrl+C), cut (Ctrl+X), paste (Ctrl+V), ca ctrl + z / y
* [refcard](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)


---

## Demo

Get all demo:

```bash
git clone https://github.com/orel33/vscode.git
```

<!--
For each demo, launch explicitly *Visual Studio Code* in the right sub-directory:

* ```code demo/python```
* ```code demo/js```
* ```code demo/c```
* ```code demo/cmake```
-->

---

## My Favorite Extensions

All extensions are available on [Market Place](https://marketplace.visualstudio.com)

* [C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools), [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
* [CMake](https://marketplace.visualstudio.com/items?itemName=twxs.cmake) + [CMake Tools](https://marketplace.visualstudio.com/items?itemName=vector-of-bool.cmake-tools)
* [GitLens](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) + [Git History](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory) (view git log, file history, compare branches or commits)
* [Doxygen Documentation Generator](https://marketplace.visualstudio.com/items?itemName=cschlosser.doxdocgen)
* [Code Runner](https://marketplace.visualstudio.com/items?itemName=formulahendry.code-runner) (run code snippet or code file for multiple languages)
* [Latex Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop) (LaTeX support, compile, preview, autocomplete, ...)
* [Markdown All In One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one) (toc, preview, lists, ...) + [Markdown Lint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint) (linting)
* [Spell Right](https://marketplace.visualstudio.com/items?itemName=ban.spellright) (multilingual spellchecker)

Some tips \& tricks:

* [Path IntelliSense](https://marketplace.visualstudio.com/items?itemName=christian-kohler.path-intellisense) (filename auto-completion), [Bracket Pair Colorizer](https://marketplace.visualstudio.com/items?itemName=CoenraadS.bracket-pair-colorizer), [Trailing Spaces](https://marketplace.visualstudio.com/items?itemName=shardulm94.trailing-spaces), [Todo Highlight](https://marketplace.visualstudio.com/items?itemName=wayou.vscode-todo-highlight), ...


Note:
* [Extending Visual Studio Code](https://code.visualstudio.com/docs/extensions/overview) (extension written in TypeScript / JavaScript)
* [Settings Sync](https://github.com/shanalikhan/code-settings-sync)
* Other: VSCode Icons, Dracula Theme, VS Live Share, ...
* Useful? [CMake Tools Helper](https://marketplace.visualstudio.com/items?itemName=maddouri.cmake-tools-helper) 

<!-- How about extensions for Docker, Node.js, Android? HTML / CSS format? -->
<!-- https://codeburst.io/top-javascript-vscode-extensions-for-faster-development-c687c39596f5 -->

---

## About this Document

This document is written in *Markdown* and converted into slides by the extension *vscode-reveal* (based on [Reval.js](https://revealjs.com)).

This presentation and all demo are available on [GitHub](https://github.com/orel33/vscode):

```bash
git clone https://github.com/orel33/vscode.git
```

* ___Author___ : Aurélien Esnard (aurelien.esnard@u-bordeaux.fr)
* ___Acknowledgment___: Pierre Ramet

