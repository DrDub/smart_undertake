abstract Contract = {

flags startcat=Contract ;

cat 
  Contract ; 
  Heading ;
  Signers ; Signer ; FullName ; SignerName ; 
  Accounts ; Account ; AccountName ;
  Body ; Claims ; Claim ; Condition ; Amount ;
  Closing ; Termination ;

fun
  MkContract : Heading -> Body -> Closing -> Contract ;

  StandardHeading   : Signers -> Heading ;
  AccountsHeading   : Signers -> Accounts -> Heading ;

  TwoSigners : Signer -> Signer -> Signers ;
  NamedSigner : FullName -> SignerName -> Signer ;

  Payee : SignerName ;
  Payer : SignerName ;
  Collector : SignerName ;

  SourceAccount : AccountName ;
  TargetAccount : AccountName ;
  CollectAccount : AccountName ;

  ThreeAccounts : Account -> Account -> Account -> Accounts;
  ControlledAccount : Account -> SignerName -> Account ;
  NamedAccount : Account -> AccountName -> Account ;

  OnlyClaims : Claims -> Body ;

  OneClaim : Claim -> Claims ;
  TwoClaims : Claim -> Claim -> Claims ;
  ThreeClaims : Claim -> Claim -> Claim -> Claims ;
  ConditionClaims : Condition -> Claims -> Claims ;
  TransferClaim : AccountName -> Amount -> AccountName -> Claim ;

  Percentage : Int -> Amount -> Amount ;
  Balance : AccountName -> Amount ;

  BalanceOverValue : AccountName -> Amount -> Condition ;

  OnlyTermination : Termination -> Closing ;
  Forever : Termination ;
  
  FullNamed : String -> FullName ;
  ValueAmount : String -> Amount ;
  Address : String -> Account ;

  ZeroAddress : Account ;
  DavidDennison : FullName ;
  PeggyPeterson : FullName ;
  Zero : Amount ;
  OneThousand : Amount ;

}
