# Test de Mermaid avec Markdown

<https://mermaid-js.github.io/mermaid>

## VS Code

Installer les extensions suivantes :

* <https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one>
* <https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid>

Et hop c'est parti...

## Exemples

```mermaid
flowchart LR
    A-- This is the text! ---B
```

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

## compilation de ce document avec Pandoc

Utilisation d'un filtre dédié.

```bash
$ sudo npm install --global mermaid-filter
$ pandoc -t html -F mermaid-filter test.md -o test.html
```