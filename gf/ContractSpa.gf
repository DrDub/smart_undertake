concrete ContractSpa of Contract = {

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
MkContract head body close = ss (head.s ++ RET ++ ["Se comprometen a:"] ++ RET ++ body.s ++ RET ++ close.s) ;
StandardHeading signs = ss (["Los abajo firmantes"] ++ signs.s) ;
AccountsHeading signs accs = ss (["Los abajo firmantes"] ++ signs.s ++ ["en posesión de las siguientes cuentas:"] ++ RET ++ accs.s) ;
TwoSigners sign1 sign2 = ss (sign1.s ++ "y" ++ sign2.s) ;
NamedSigner full name = ss (full.s ++ (["desde ahora identificado como"] | ["identificado como"] | ["referido como"]) ++ name.s) ;
Payee = ss("PAGADOR") ;
Payer = ss("RECEPTOR") ;
Collector = ss("RECOLECTOR") ;
SourceAccount = ss("FUENTE") ;
TargetAccount = ss("DESTINO") ;
CollectAccount = ss("COLECTORA") ;
ControlledAccount acc name = ss (acc.s ++ (["controlada por"] | ["bajo el control de"]) ++ name.s) ;
NamedAccount acc name = ss (acc.s ++ (["identificada como"] | ["a partir de ahora referida como"]) ++ name.s) ;
ThreeAccounts acc1 acc2 acc3 = ss ("*" ++ acc1.s ++ RET ++ "*" ++ acc2.s ++ RET ++ "*" ++ acc3.s ++ RET) ;
OnlyClaims cl = cl ;
OneClaim cl1 = cl1 ;
TwoClaims cl1 cl2 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ RET) ;
ThreeClaims cl1 cl2 cl3 = ss ("*" ++ cl1.s ++ RET ++ "*" ++ cl2.s ++ "*" ++ RET ++ "*" ++ cl3.s ++ RET) ;
ConditionClaims cond cl = ss("Cuando" ++ cond.s ++ "," ++ RET ++ cl.s) ;
TransferClaim src amount tgt = ss (["transferir desde la cuenta"] ++ src.s ++ "a la cuenta" ++ tgt.s ++ ["en un monto de"] ++ amount.s ++ ".") ;
Percentage per amount = ss(per.s ++ ["puntos porcentuales respecto de"] ++ amount.s) ;
BalanceOverValue acc amount = ss(["el balance en la cuenta"] ++ acc.s ++ ["supera los"] ++ amount.s) ;
Balance acc = ss(["el balance en la cuenta"] ++ acc.s) ;
OnlyTermination term = term ;
Forever = ss(["Este contrato no tiene fecha de expiración."] | ["Este contrato es a perpetuidad."]) ;
FullNamed str = ss(str.s);
ValueAmount str = ss(str.s);
Address str = ss(str.s);
ZeroAddress = ss("0000000000");
DavidDennison = ss("David Dennison") ;
PeggyPeterson = ss("Peggy Peterson") ;
Zero = ss("cero") ;
OneThousand = ss("mil") ;
}

