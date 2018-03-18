concrete ContractEng of Contract = {

flags lexer=textlit ; unlexer=textlit ;

param Sex = masc | fem ;
param Num = sg | pl ;
param Kas = nom | acc ;
param DepNum = depnum | cnum Num ;

oper SS     = {s : Str} ;
oper SSDep  = {s : Num => Sex => Str} ;      -- needs Num and Sex
oper SSSrc  = {s : Str ; n : Num ; x : Sex} ; -- gives Num and Sex
oper SSSrc2 = {s : Num => Sex => Str ; n : DepNum ; x : Sex} ; -- gives and needs
oper SSDep2 = {s : DepNum => Sex => Num => Sex => Str} ; -- needs Auth's & Recp's
oper SSSrcNum  = {s : Str ; n : Num} ; -- gives Num only

oper 
  ss : Str -> SS = \s -> {s = s} ;
  constNX : Str -> Num -> Sex -> SSSrc2 = \str,num,sex -> 
    {s =  table {_ => table {_ => str}} ; n = cnum num ; x = sex} ;

  dep2num : DepNum -> Num -> Num = \dn,n -> case dn of {
    depnum  => n ; 
    cnum cn => cn
    } ;

  RET = "" ; -- &-

lincat
Contract = SS ;
Heading = SS ;
Signers = SS ;
Signer = SS ;
FullName = SS ;
SignerName = SS ;
Accounts = SS ;
Account = SS ;
AccountName = SS ;
Body = SS ;
Claims = SS ;
Claim = SS ;
Condition = SS ;
Amount = SS ;
Closing = SS ;
Termination = SS ;

lin
MkContract head body close = ss (head.s ++ ":" ++ RET ++ body.s ++ RET ++ close.s) ;
StandardHeading signs = ss (["The signers"] ++ signs.s) ;
AccountsHeading signs accs = ss (["The signers"] ++ signs.s ++ ["with the following accounts"] ++ accs.s) ;
TwoSigners sign1 sign2 = ss (sign1.s ++ "and" ++ sign2.s) ;
NamedSigner full name = ss (full.s ++ ["now identified as"] ++ name.s) ;
Payee = ss("PAYEE") ;
Payer = ss("PAYER") ;
Collector = ss("COLLECTOR") ;
SourceAccount = ss("SOURCE") ;
TargetAccount = ss("TARGET") ;
CollectAccount = ss("COLLECT") ;
ControlledAccount acc name = ss (acc.s ++ ["controlled by"] ++ name.s) ;
NamedAccount acc name = ss (acc.s ++ ["identified as"] ++ name.s) ;
ThreeAccounts acc1 acc2 acc3 = ss ("*" ++ acc1.s ++ RET ++ "*" ++ acc2.s ++ "*" ++ RET ++ "*" ++ acc3.s ++ RET) ;
OnlyClaims cl = cl ;
OneClaim cl1 = cl1 ;
TwoClaims cl1 cl2 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ "*" ++ RET) ;
ThreeClaims cl1 cl2 cl3 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ "*" ++ RET ++ "*" ++ cl3.s ++ RET) ;
ConditionClaims cond cl = ss("When" ++ cond.s ++ "," ++ cl.s) ;
TransferClaim src amount tgt = ss (["transfer from"] ++ src.s ++ "to" ++ tgt.s ++ ["the amount of"] ++ amount.s ++ ".") ;
Percentage per amount = ss(per.s ++ ["percentage of"] ++ amount.s) ;
BalanceOverValue acc amount = ss(["the balance on account"] ++ acc.s ++ ["goes over"] ++ amount.s) ;
Balance acc = ss(["the balance on account"] ++ acc.s) ;
OnlyTermination term = term ;
Forever = ss("This contract does not expire.") ;
FullNamed str = ss(str.s);
ValueAmount str = ss(str.s);
Address str = ss(str.s);
ZeroAddress = ss("0000000000");
DavidDennison = ss("David Dennison") ;
PeggyPeterson = ss("Peggy Peterson") ;
Zero = ss("zero") ;
OneThousand = ss("one thousand") ;
}

