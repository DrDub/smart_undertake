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


Example
-------

Tax example:

```
linearize (MkContract (AccountsHeading  (TwoSigners (NamedSigner DavidDennison Payer) (NamedSigner PeggyPeterson Payee)) (ThreeAccounts (ControlledAccount (NamedAccount (Address "abc1") SourceAccount) Payer) (ControlledAccount (NamedAccount (Address "xyz2") TargetAccount) Payer) (ControlledAccount (NamedAccount (Address "aaabbbccc") CollectAccount) Payee))) (OnlyClaims  (ConditionClaims (BalanceOverValue SourceAccount Zero) (TwoClaims (TransferClaim SourceAccount (Percentage 95 (Balance SourceAccount)) TargetAccount) (TransferClaim SourceAccount (Percentage 5 (Balance SourceAccount)) CollectAccount)))) (OnlyTermination Forever))
```

