Turning Words Into Smart Contracts
==================================

Using Haskell Grammatical Framework to Generate Solidity Code
-------------------------------------------------------------

Pablo Duboue, PhD

[http://duboue.net](http://duboue.net)

---

What
====

* MissionHack project

> * Demo: http://textualization.com/smart_undertake/

* Two smart contract experts (Elaine Feng and Horace Yu)

* Two legal experts (Paul Holden and Stephen Pederson)

* Me: Natural Language Processing/AI expert

---

Why
===

* My vision: enable lawyers to understand and write smart contracts in English or any other human language.

Not unlike COBOL:

<pre>
ADD GIN TO VERMOUTH GIVING MARTINI
</pre>

(martini = gin + vermouth)

---

Who
===

* Lic. en Computacion, UNCordoba-FaMAF

* PhD Columbia University, Computer Science / Natural Language Processing / Natural Language Generation

* IBM Research Scientist 2005-2010 (member of original Jeopardy! Watson team)

* Since 2011: 

> * consulting in ML/IR/NLP
> * FLOSS (http://ie4opendata.org)
> * Teaching (http://aprendizajengrande.net)
> * started a company in NLG: http://textualization.com

---

Historical Note
===============

* NLIDB: Natural Language Interfaces to Databases, from human language to SQL.

* Siri: a mix of machine learning and grammatical approaches.

---

Machine Learning approach
=========================

* Classification to detect the API call

* Slot extraction (e.g., Conditional Random Fields) to identify the API arguments

* Some recent work on program generation, see for example:

http://www.aclweb.org/anthology/P17-1015

Program Induction for Rationale Generation: Learning to Solve and Explain Algebraic Word Problems

Authors: Wang Ling, Dani Yogatama, Chris Dyer and Phil Blunsom (Google)

---

Haskell's GF (Grammatical Framework)
====================================

* http://www.grammaticalframework.org/

* GF is:

> * A grammar formalism

> * A set of grammars for 16 languages

> * A reference compiler and set of interpreters

---

Semantic Grammars
=================

* I have used GF to build a small semantic grammar to handle a particular type of contracts.

> * More contracts could be added

* The difference between a semantic grammar and a syntactic grammar is the difference between translating Java to C versus Haskell to Java

> * When the difference between the languages is too far, translate certain parts that *mean* the same.

---

Abstract Grammar
================

<pre>
cat 
  Contract ; 
  Heading ;
  Signers ; Signer ; FullName ; SignerName ; 
  Accounts ; Account ; AccountName ;
  Body ; Claims ; Claim ; Condition ; Amount ;
  Closing ; Termination ;
</pre>

---

Abstract Grammar (cont)
=======================

<pre>
fun
  MkContract : Heading -> Body -> Closing -> Contract ;
  
  OnlyClaims : Claims -> Body ;
  
  ConditionClaims : Condition -> Claims -> Claims ;
  TransferClaim : AccountName -> Amount -> AccountName -> Claim ;
  
  BalanceOverValue : AccountName -> Amount -> Condition ;
</pre>

---

Concrete Grammar: Eng
=====================

<pre>
lin
MkContract head body close = ss (head.s ++ RET ++ ["Agree to:"] ++ RET ++ body.s ++ RET ++ close.s) ;
Payee = ss("PAYEE") ;
Payer = ss("PAYER") ;
Collector = ss("COLLECTOR") ;
NamedSigner full name = ss (full.s ++ (["now identified as"] | ["identified as"] | ["from now on referred as"]) ++ name.s) ;
ConditionClaims cond cl = ss("When" ++ cond.s ++ "," ++ RET ++ cl.s) ;
TransferClaim src amount tgt = ss (["transfer from"] ++ src.s ++ "to" ++ tgt.s ++ ["the amount of"] ++ amount.s ++ ".") ;
</pre>

---

Concrete Grammar: Spa
=====================

<pre>
lin
MkContract head body close = ss (head.s ++ RET ++ ["Agree to:"] ++ RET ++ body.s ++ RET ++ close.s) ;
Payee = ss("TENEDOR") ;
Payer = ss("PAGADOR") ;
Collector = ss("RECOLECTOR") ;
NamedSigner full name = ss (full.s ++ (["identificado como"] | ["identificada como"] | ["de ahora en mas referido como"]) ++ name.s) ;
ConditionClaims cond cl = ss("Cuando" ++ cond.s ++ "," ++ RET ++ cl.s) ;
TransferClaim src amount tgt = ss (["se transferira"] ++ src.s ++ "a" ++ tgt.s ++ [la suma de"] ++ amount.s ++ ".") ;
</pre>

---

Concrete Grammar: Sol
=====================

<pre>
lin
MkContract head body close = ss (["pragma solidity ^0.4.18;"] ++ RET ++ 
   ["contract GF_Contract{"] ++ RET ++ ["mapping(address => uint256) balance;"] ++ RET ++  
   ["function execute("] ++ head.s ++ [") public returns (bool) {"] ++ RET ++
   head.r ++ RET ++ RET ++
   body.s ++ RET ++
   close.s ++ RET ++ "}" ++ RET ++ "}") ;
ConditionClaims cond cl = ss(["if("] ++ cond.s ++ ["){"] ++ RET ++ cl.s ++ RET ++ ["}else{ revert(); }"]) ;
TransferClaim src amount tgt = ss (
["balance["] ++ src.s ++ ["] = balance["] ++ src.s ++ ["] -"] ++ amount.s ++ ";" ++ RET ++
["balance["] ++ tgt.s ++ ["] = balance["] ++ tgt.s ++ ["] +"] ++ amount.s ++ ";" ++ RET) ;
</pre>

---

Compilation and Usage
=====================

<pre>
cabal install gf

gf --make --output-format=js gf/Contract???.gf
cp Contract.js js/editor/
</pre>

---

Demo 1
======

Demo: http://textualization.com/smart_undertake/

---

Demo 2
======

Demo: http://textualization.com/smart_undertake/

---

Demo 3
======

Demo: http://textualization.com/smart_undertake/

---

Feedback after Blockchain Meetup
================================

* Too much indirection

* Contracts lose money already through bugs, no need for further obscurity

* Value in using this technique for generating *properties to be verified*

---

Turning Smart Contracts into Words
==================================

* http://keywords4bytecodes.org project

* ASAI 2018: Deobfuscating Name Scrambling as a Natural Language Generation Task

* Training a system to go from bytecodes (Java bytecodes, but could be also Ethereum VM bytecodes) to method names

* Useful to decide whether to allow a contract to run

---

Vancouver Blockchain Scene
==========================

* Great jurisdiction for ICOs

* Ethereum Foundation presence

* DCTRL space: http://dctrl.ca

* First BTC ATM in the world

---


Keeping in Touch with Pablo
==================================

* Keybase: DrDub

* Email: pablo.duboue@gmail.com

* Website: http://duboue.net/collaboration.html

* Twitter: @pabloduboue

* LinkedIn: http://linkedin.com/in/pabloduboue








