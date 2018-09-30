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

## Overview

* Editors, Side Bar (Explorer, ...), Actvity Bar, Status Bar, Panels, Palettes

<center><img src="img/snap-overview.png" width=90%></center>

<!-- <center><img src="https://code.visualstudio.com/assets/docs/getstarted/userinterface/hero.png" width=80%></center> -->

Note:
* https://code.visualstudio.com/docs/getstarted/userinterface

---

## Installation

Installation on Debian Linux: 

```bash
URL="https://vscode-update.azurewebsites.net/1.27.2/linux-deb-x64/stable"
sudo apt-get install gdebi
wget $URL -O /tmp/vscode.deb
sudo gdebi /tmp/vscode.deb
```

Run *code* in your working directory as follow:

```bash
code .
```

Install extensions using integrated extension manager (side bar) vs command line:

```bash
code --list-extensions
code --install-extension <extension name>
```

All settings in JSON files (setting button at bottom of the activity bar)

* qqq
* 

Note:
* user settings (~/.config/Code/\*.json) 
* workspace settings (./.vscode/\*.json)

---

## C/C++ Programming

* Extension C/C++ (provided by Microsoft)
* code navigation, smart completion / hinting ([IntelliSense](https://code.visualstudio.com/docs/editor/intellisense)), code formatting (clang-format), linting, debugging, refactoring


* <https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/>
* <https://code.visualstudio.com/docs/languages/cpp>
* configure debugging: <https://github.com/Microsoft/vscode-cpptools/blob/master/launch.md>


Menu Debug > Add Configuration... (launch.json)


Note:
* Code Formatting (Ctrl + Shift + I)
* Go to Definition (F12), Go to Declaration (Ctrl + F12), Peek Definition (Ctrl + Shift + F10)
* Show Declaration (Hover) / Show Definition (Ctrl + Hover)

---

## C/C++ Building 

* configure a build task
* 


Note: 
* https://blogs.msdn.microsoft.com/vcblog/2016/03/31/cc-extension-for-visual-studio-code/#building


---

## Building Tasks

Ctrl+Shift+B

---

## Running Custom Tasks (1/2)


Sample [hello.js](demo/js/hello.js) (for Node.js)

```js
var N = process.argv[2];
var i;
for (i = 0; i < N; i++) {
    console.log("hello world!")
}
```

--

## Running Custom Tasks (2/2)

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

```
> Executing task: node hello.js 2 <

hello world!
hello world!
```


Note:
* debug: [launch.json](https://go.microsoft.com/fwlink/?linkid=830387)


---

## C/C++ Debugging

<!-- <center><img src="https://msdnshared.blob.core.windows.net/media/2016/03/debugging-all-up.png" width=80%></center> -->

<center><img src="img/snap-debug.png" width=80%></center>

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


| Shortcut        | Description                             |
| --------------- | --------------------------------------- |
| Ctrl+P          | quick open file palette                 |
| Ctrl+Shift+P    | quick open command palette              |
| Ctrl+K Ctrl+T   | change theme                            |
| Ctrl+K Z        | zen mode (Esc Esc to escape)            |
| Ctrl+J / Ctrl+B | toggle panel / side bar visibility      |
| Ctrl+,          | edit user & workspace settings          |
| Ctrl+W          | close current editor                    |
| Ctrl+N          | new file                                |
| Ctrl+O          | open file                               |
| Ctrl+S          | save / save as file                     |

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
* F7 : compiler le projet (à condition qu'il soit déjà bien configuré)
* crtl + f : chercher dans le fichier courant ; F3 : next : shift + F3 : previous
* ctrl + c, ctrl + x, ctrl + v, + ctrl + z / y
* [refcard](https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf)

---

## My Favorite Extensions

* [C/C++][ext-cpp], [Python][ext-python]
* [CMake][ext-cmake], [CMake Tools][ext-cmaketools]
* [GitLens][ext-gitlens] + [Git History][ext-githistory] (view git log, file history, compare branches or commits)
* [Code Runner][ext-coderunner] (run code snippet or code file for multiple language)
* [Spell Right][ext-spellright] (multilingual spellchecker)
* [Path IntelliSense][ext-path] (filename auto-completion)
* [Latex Workshop][ext-latex] (LaTeX support, preview, compile, autocomplete, colorize, and more...)
* [Markdown All In One][ext-markdown] + [Markdown Lint][ext-markdownlint] (..., linting) 

Note:
* https://codeburst.io/top-javascript-vscode-extensions-for-faster-development-c687c39596f5
* Settings Sync: <https://github.com/shanalikhan/code-settings-sync>
* VSCode Icons, Dracula Theme, VS Live Share, Todo Highlighter, Rainbow brackets & indent, Insert Unicode ...
* How about extensions for Docker, Node.js, Android?
* Extensions written in TypeScript / JavaScript and published on [Market Place](https://marketplace.visualstudio.com)
* [Extending Visual Studio Code](https://code.visualstudio.com/docs/extensions/overview)
* HTML / CSS format ???

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
[ext-markdown]: https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one "Markdown All in One extension"
[ext-markdownlint]: https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one "Markdown All in One extension"

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

<!-- ## Two Cols

<div style="text-align: left; float: left;">
<p data-markdown>| coucou | pouet |</p>
<p data-markdown>|--------|-------|</p>
<p data-markdown>| coucou | pouet |</p>
<p data-markdown>| coucou | pouet |</p>
 </div>

  <div style="text-align: left; float: right;">
    <p data-markdown>- This is my first right element</p>
    <p data-markdown>- This is my second rightelement</p>
  </div> -->


