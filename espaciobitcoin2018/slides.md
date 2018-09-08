Turning Words Into Smart Contracts
==================================

Using Haskell Grammatical Framework to Generate Solidity Code
-------------------------------------------------------------

Pablo Duboue, PhD

[http://duboue.net](http://duboue.net)

[http://textualization.com](Textualization Software Ltd.)

Slides at: http://duboue.net/papers/espaciobitcoin2018.html

---

This talk
=======

* Exploratory work

> * Inteded to elicit new ideas

* Bringing my expertise (human language technologies) into blockchain/smart contracts

> * Building on a long tradition of research on transforming human language into programs

* Have spent time trying to make it as unabridged as possible

---

Background
==========

* Blockchain

> * a distributed DB

> * a solution to replace trust

* Ethereum

> * the blockchain with data (representing money in "Ether", ETH)

> * distributed computing platform ("smart contracts")

---

Smart Contracts in Ethereum
===========================

* Small programs that live on an address in the Ethereum blockchain

* Can be executed knowing the public address and paying for its execution

* It executes in all nodes in the network

> * The results must agree

> * Ensures trust

---

Motivating Example
==================

* DAO crash

> * https://en.m.wikipedia.org/wiki/The\_DAO\_(organization)

> * A decentralized organization that among other things held US$168m

* A bug caused it to lose one third of that money (US$50m)

> * https://www.coindesk.com/understanding-dao-hack-journalists/

> * Fork on the blockchain (Ethereum and Ethereum Classic)

---

Why this happened?
==================

* The DAO code was vulnerable 

> * It allowed people to spend the money before updating the balance of the account

* These issues also happen in real-life contracts

* Would lawyers have realized of this bug if they would have been involved?

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
======

* My vision: enable lawyers to understand and write smart contracts in English or any other human language.

Not unlike COBOL:

<pre>
ADD GIN TO VERMOUTH GIVING MARTINI
</pre>

(martini = gin + vermouth)

---

Who
=====

* Lic. en Computacion, UNCordoba-FaMAF

* PhD Columbia University, Computer Science / Natural Language Processing / Natural Language Generation

* IBM Research Scientist 2005-2010 (member of original Jeopardy! Watson team)

* Since 2011: 

> * consulting in ML/IR/NLP
> * FLOSS (http://ie4opendata.org)
> * Teaching (http://aprendizajengrande.net)
> * started a company in NLG: http://textualization.com

---

Smart Contracts
===============

* Another term for "program"

> * Run thousands of times at the mining nodes

* Trust through replication and energy consumption

> * Better than the alternative

* Ethereum smart contracts

> * Particular type of smart contract that runs in the Ethereum VM
 
---

Haskell's GF (Grammatical Framework)
====================================

* http://www.grammaticalframework.org/

* GF is:

> * A grammar formalism

> * A set of grammars for 16 languages

> * A reference compiler and set of interpreters

---

Syntatic Grammars
=================

* Usual grammars as taught in the school

<pre>
Sentence = NounPhrase VerbPhrase
NounPhrase = Determiner CommonNoun
NounPhrase = ProperNoun
VerbPhrase = Verb NounPhrase
</pre>

---

Semantic Grammars
=================

* I have used GF to build a small semantic grammar to handle a particular type of contracts.

> * More contracts could be added

* The difference between a semantic grammar and a syntactic grammar is the difference between translating Java to C versus Haskell to Java

> * When the difference between the languages is too far, translate certain parts that *mean* the same.

---

High level view
===============

<table>
<tr><th>Text</th><th>Categories</th></tr>
<tr><td> ? Agree to: ? ?</td><td>Contract (Heading Body Closing)</td></tr>
<tr><td> The signers ?</td><td>Heading (Signers)</td></tr>
<tr><td> ? now identified as ?</td><td>Signer (FullName SignerName)</td></tr>
</table>

---

High level view (cont)
======================

<table>
<tr><th>Text</th><th>Categories</th></tr>
<tr><td> When ?, ? </td><td>Body (Condition Claims)</td></tr>
<tr><td> When the balance on account ? goes over ?</td><td>Condition (AccountName Amount)</td></tr>
<tr><td> transfer from ? to ? the amount of ? </td><td>Condition (AccountName AccountName Amount)</td></tr>
</table>

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
MkContract head body close = 
  head.s ++ RET ++ 
  ["Agree to:"] ++ RET ++ 
  body.s ++ RET ++ 
  close.s ;
Payee = "PAYEE" ;
Payer = "PAYER" ;
NamedSigner full name = full.s ++ 
   (["now identified as"] | 
    ["identified as"] | 
    ["from now on referred as"]) ++ 
   name.s) ;
</pre>

---

Concrete Grammar: Eng (cont.)
=============================

<pre>
ConditionClaims cond cl = 
   "When" ++ cond.s ++ "," ++ RET ++ cl.s ;
TransferClaim src amount tgt = 
   ["transfer from"] ++ src.s ++ 
   "to" ++ tgt.s ++ 
   ["the amount of"] ++ amount.s ++ "." ;
</pre>

---

Concrete Grammar: Spa
=====================

<pre>
lin
MkContract head body close = 
  head.s ++ RET ++ 
  ["Se comprometen a:"] ++ RET ++ 
  body.s ++ RET ++ 
  close.s ;
Payee = ss("TENEDOR") ;
Payer = ss("PAGADOR") ;
NamedSigner full name = 
  full.s ++ 
  (["identificado como"] 
  | ["identificada como"] 
  | ["de ahora en mas referido como"]) ++ 
  name.s ;
</pre>

---

Concrete Grammar: Spa (cont.)
=============================

<pre>
ConditionClaims cond cl = 
  "Cuando" ++ cond.s ++ "," ++ RET ++ 
  cl.s ;
TransferClaim src amount tgt = 
  ["se transferira de"] ++ src.s ++ 
  "a" ++ tgt.s ++ 
  [la suma de"] ++ amount.s ++ ".") ;
</pre>

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

Concrete Grammar: Solidity
========================

<pre>
lin
MkContract head body close = 
   ["pragma solidity ^0.4.18;"] ++ RET ++ 
   ["contract GF_Contract{"] ++ RET ++ 
   ["mapping(address => uint256) balance;"] ++ RET ++  
   ["function execute("] ++ head.s ++ [") public returns (bool) {"] ++ RET ++
   head.r ++ RET ++ RET ++
   body.s ++ RET ++
   close.s ++ RET ++ 
   "}" ++ RET ++ 
   "}"  ;
</pre>


---

Concrete Grammar: Solidity (cont.)
===========================

<pre>
ConditionClaims cond cl = 
  ["if("] ++ cond.s ++ ["){"] ++ RET ++ 
      cl.s ++ RET ++ 
  ["}else{ revert(); }"] ;
TransferClaim src amount tgt =
  ["balance["] ++ src.s ++ 
      ["] = balance["] ++ src.s ++ ["] -"] ++ 
      amount.s ++ ";" ++ RET ++
  ["balance["] ++ tgt.s ++ 
      ["] = balance["] ++ tgt.s ++ ["] +"] ++ 
      amount.s ++ ";" ++ RET) ;
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


The signers Peggy Peterson now identified as COLLECTOR and David Dennison now identified as PAYEE with the following accounts: 

* 0000000001 identified as TARGET controlled by COLLECTOR

* 0000000002 identified as SOURCE controlled by PAYEE 

* 0000000003 identified as COLLECT controlled by COLLECTOR

Agree to: 

* transfer from SOURCE to COLLECT the amount of the balance on account TARGET.

This contract does not expire.


---

Demo 2
======

<pre>
Contract> parse "The signers Peggy Peterson now identified as COLLECTOR and David Dennison now identified as PAYEE with the following accounts: * 0000000001 identified as TARGET controlled by COLLECTOR * 0000000002 identified as SOURCE controlled by PAYEE * 0000000003 identified as COLLECT controlled by COLLECTOR Agree to: transfer from SOURCE to COLLECT the amount of the balance on account TARGET . This contract does not expire."
The parser failed at token 1: "The"
MkContract (AccountsHeading 
  (TwoSigners 
    (NamedSigner PeggyPeterson Collector) 
    (NamedSigner DavidDennison Payee)) 
  (ThreeAccounts 
    (ControlledAccount (NamedAccount (Adress "00000001") TargetAccout) Collector) 
    (ControlledAccount (NamedAccount (Address "0000000000") SourceAccount) Payee) 
    (ControlledAccount (NamedAccount (Address "0000000000") CollectAccount) Collector))) 
  (OnlyClaims (OneClaim 
    (TransferClaim SourceAccount (Balance TargetAccount) CollectAccount))) (OnlyTermination Forever)
</pre>
---

Demo 3
======

<pre>
Contract> linearize MkContract (AccountsHeading  (TwoSigners     (NamedSigner PeggyPeterson Collector)    (NamedSigner DavidDennison Payee)) (ThreeAccounts     (ControlledAccount (NamedAccount (Address "00000001") TargetAccount) Collector)     (ControlledAccount (NamedAccount (Address "00000002") SourceAccount) Payee)  (ControlledAccount (NamedAccount (Address "00000003") CollectAccount) Collector)))  (OnlyClaims (OneClaim     (TransferClaim SourceAccount (Balance TargetAccount) CollectAccount))) (OnlyTermination Forever)
</pre>

Los abajo firmantes Peggy Peterson desde ahora identificado como RECOLECTOR y David Dennison desde ahora identificado como PAGADOR en posesión de las siguientes cuentas:
 
* 00000001 identificada como DESTINO controlada por RECOLECTOR

* 00000002 identificada como FUENTE controlada por PAGADOR

* 00000003 identificada como COLECTORA controlada por RECOLECTOR

Se comprometen a: transferir desde la cuenta FUENTE a la cuenta FUENTE a la cuenta COLECTORA en un monto de el balance en la cuenta DESTINO .

Este contrato no tiene fecha de expiración.

---

Demo 4
======

<pre>
contract GF_Contract{
  mapping(address => uint256) balance;
 function execute( address target , address source , address collect ) public returns (bool) {
 require( target != address(0));
 require( source != address(0));
 require( collect != address(0));

 balance[ source ] = balance[ source ] - balance[ target ] ;
 balance[ collect ] = balance[ collect ] + balance[ target ] ;

 return true;
}
</pre>

---

Demo 5
======

Demo: http://textualization.com/smart_undertake/

---

Feedback after Blockchain Meetup
================================

* Notes at https://community.frontierfoundry.co/t/vancouver-blockchain-for-product-developers-notes-for-april-2018-meetup/60

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








