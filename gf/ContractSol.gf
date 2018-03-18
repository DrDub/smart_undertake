concrete ContractSol of Contract = {

flags lexer=textlit ; unlexer=textlit ;

param Sex = masc | fem ;
param Num = sg | pl ;
param Kas = nom | acc ;
param DepNum = depnum | cnum Num ;

oper
  SS     = {s : Str} ;
  SSRest = {s : Str ; r : Str} ;

oper 
  ss : Str -> SS = \s -> {s = s} ;
  ssr : Str -> Str -> SSRest = \s,r -> {s = s ; r = r} ;
  ssrcheck : Str -> SSRest = \var -> {s = var ;  r = ["require("] ++ var ++ ["!= address(0));"] ++ RET } ;
  ssrconcat : SSRest -> SSRest -> SSRest = \sr1, sr2 -> {s = sr1.s ++ sr2.s ; r = sr1.r ++ sr2.r } ;
  ssr0 : Str -> SSRest = \s ->  { s = s ; r = "" };
  nosr : SSRest = {s = "" ; r="" } ;
  noss : SS = {s = ""} ;
  RET = "\n" ; -- &-

lincat
Contract = SS ;
Heading = SSRest ;
Signers = SS ;
Signer = SS ;
FullName = SS ;
SignerName = SS ;
Accounts = SSRest ;
Account = SSRest ;
AccountName = SSRest ;
Body =  SS ;
Claims = SS ;
Claim = SS ;
Condition = SS ;
Amount = SS ;
Closing = SS ;
Termination = SS ;

lin
MkContract head body close = ss (["pragma solidity ^0.4.18;"] ++ RET ++ 
   ["contract GF_Contract{"] ++ RET ++ ["mapping(address => uint256) balance;"] ++ RET ++  
   ["function execute("] ++ head.s ++ [") public returns (bool) {"] ++ RET ++
   head.r ++ RET ++ RET ++
   body.s ++ RET ++
   close.s ++ RET ++ "}" ++ RET ++ "}") ;
StandardHeading signs = nosr;
AccountsHeading signs accs = accs ;
TwoSigners sign1 sign2 = noss;
NamedSigner full name = ss (full.s ++ ["now identified as"] ++ name.s) ;
Payee = nosr;
Payer = nosr;
Collector = nosr;
SourceAccount = ssrcheck("source") ;
TargetAccount = ssrcheck("target") ;
CollectAccount = ssrcheck("collect") ;
ControlledAccount acc name = acc ;
NamedAccount acc name = name ;
ThreeAccounts acc1 acc2 acc3 = { s = "address" ++ acc1.s ++ [", address"] ++ acc2.s ++ [", address"] ++ acc3.s ;
                                 r = acc1.r ++ acc2.r ++ acc3.r } ;
OnlyClaims cl = cl ;
OneClaim cl1 = cl1 ;
TwoClaims cl1 cl2 = ss (cl1.s ++ RET ++ cl2.s ++ RET) ;
ThreeClaims cl1 cl2 cl3 = ss (cl1.s ++ RET ++ cl2.s ++ RET ++ cl3.s ++ RET) ;
ConditionClaims cond cl = ss(["if("] ++ cond.s ++ ["){"] ++ RET ++ cl.s ++ RET ++ ["}else{ revert(); }"]) ;
TransferClaim src amount tgt = ss (
["balance["] ++ src.s ++ ["] = balance["] ++ src.s ++ ["] -"] ++ amount.s ++ ";" ++ RET ++
["balance["] ++ tgt.s ++ ["] = balance["] ++ tgt.s ++ ["] +"] ++ amount.s ++ ";" ++ RET) ;
Percentage per amount = ss(amount.s ++ "*" ++ per.s ++ ["/100"]) ;
BalanceOverValue acc amount = ss(["balance["] ++ acc.s ++ ["] >"] ++ amount.s) ;
Balance acc = ss(["balance["] ++ acc.s ++ "]") ;
OnlyTermination term = term ;
Forever = ss(["return true;"]) ;
FullNamed str = noss ;
ValueAmount float = ss(float.s);
Address str = ssr0(str.s);
ZeroAddress = ssr0("0");
DavidDennison = noss ;
PeggyPeterson = noss ;
Zero = ss("0") ;
OneThousand = ss("1000") ;
}

