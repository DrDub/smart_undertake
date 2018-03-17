abstract Contract = {

flags startcat=Contract ;

cat 
  Contract ; 
  Heading ; Signers ; Signer ; Person ; FullName ; Name ; Account ;
  Body ; Claims ; Claim ; Condition ; Amount ;
  Closing ; Termination ;

fun
  MkContract : Heading -> Body -> Closing -> Contract ;

  StandardHeading   : Signers -> Heading ;

  TwoSigners : Signer -> Signer -> Signers ;

  PersonSigns : Person -> Signer ;

  NamedAccount : FullName -> Name -> Account -> Person ;

  Payee : Name ;
  Payer : Name ;
  Collector : Name ;

  OnlyClaims : Claims -> Body ;

  ThreeClaims : Claim -> Claim -> Claim -> Claims ;
  TransferClaim : Condition -> Account -> Amount -> Account -> Claim ;

  BalanceOverValue : Account -> Amount -> Condition ;

  OnlyTermination : Termination -> Closing ;
  Forever : Termination ;
  
  FullNamed : String -> FullName ;
  ValueAmount : String -> Amount ;
  Address : String -> Account ;

  DavidDennison : FullName ;
  PeggyPeterson : FullName ;
  Zero : Amount ;
  OneThousand : Amount ;
}
