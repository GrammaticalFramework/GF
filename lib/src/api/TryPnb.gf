--# -path=.:alltenses:prelude

resource TryPnb = SyntaxPnb - [mkAdN] , LexiconPnb, ParadigmsPnb - [mkAdv,mkDet,mkIP,mkAdN] ** 
  open (P = ParadigmsPnb) in {

oper

  mkAdv = overload SyntaxPnb {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxPnb.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxPnb {
--    mkOrd : A -> Ord = SyntaxPnb.OrdSuperl ;
--  } ;


}
