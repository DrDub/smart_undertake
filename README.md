Smart Undertake
===============

Compilation
-----------

On a working Haskell Platform, install GF using cabal:

```sh
cabal install gf
```

You might want to add ~/.cabal/bin to your PATH to access `gf` directly.

Then compile the grammer to JS:

```sh
gf --make --output-format=js gf/Contract???.gf
cp Contract.js js/editor/
```

Then open js/editor/editor.html on your web-browser.

