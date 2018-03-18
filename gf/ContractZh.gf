--# -coding=UTF-8
concrete ContractZh of Contract = {

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

  RET = "\n" ; -- &-

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
MkContract head body close = ss (head.s ++ RET ++ ["同意:"] ++ RET ++ body.s ++ RET ++ close.s) ;
StandardHeading signs = ss (["签约者"] ++ signs.s) ;
AccountsHeading signs accs = ss (["签约者"] ++ signs.s ++ ["用这些账户:"] ++ RET ++ accs.s) ;
TwoSigners sign1 sign2 = ss (sign1.s ++ ["和"] ++ sign2.s) ;
NamedSigner full name = ss (full.s ++ ["这里辨认"] ++ name.s) ;
Payee = ss("收放") ;
Payer = ss("付方") ;
Collector = ss("收税员") ;
SourceAccount = ss("来源账户") ;
TargetAccount = ss("终点账户") ;
CollectAccount = ss("收税账户") ;
ControlledAccount acc name = ss (acc.s ++ ["的管制员"] ++ name.s) ;
NamedAccount acc name = ss (acc.s ++ ["辨认"] ++ name.s) ;
ThreeAccounts acc1 acc2 acc3 = ss ("*" ++ acc1.s ++ RET ++ "*" ++ acc2.s ++ RET ++ "*" ++ acc3.s ++ RET) ;
OnlyClaims cl = cl ;
OneClaim cl1 = cl1 ;
TwoClaims cl1 cl2 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ RET) ;
ThreeClaims cl1 cl2 cl3 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ "*" ++ RET ++ "*" ++ cl3.s ++ RET) ;
ConditionClaims cond cl = ss(cond.s ++ "到时候，" ++ RET ++ cl.s) ;
TransferClaim src amount tgt = ss (["把"] ++ amount.s ++ ["的数量从"] ++ src.s ++ ["到"] ++ tgt.s) ;
Percentage per amount = ss(amount.s ++ ["的百分之"] ++ per.s) ;
BalanceOverValue acc amount = ss(acc.s ++ ["的剩余超过"] ++ amount.s) ;
Balance acc = ss(acc.s ++ ["的剩余"]) ;
OnlyTermination term = term ;
Forever = ss("这篇合同没有失效日期") ;
FullNamed str = ss(str.s);
ValueAmount str = ss(str.s);
Address str = ss(str.s);
ZeroAddress = ss("0000000000");
DavidDennison = ss("David Dennison") ;
PeggyPeterson = ss("Peggy Peterson") ;
Zero = ss("零") ;
OneThousand = ss("一千") ;
}

