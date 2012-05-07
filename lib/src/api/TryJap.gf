--# -path=.:alltenses:prelude
resource TryJap = 
  SyntaxJap - [mkAdN] , 
  LexiconJap, 
  ParadigmsJap - [mkAdv,mkDet,mkIP,mkAdN,mkQuant] ** 
  open (P = ParadigmsJap) in {

}
{-
oper

  mkAdv = overload SyntaxJap {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxJap.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxJap {
--    mkOrd : A -> Ord = SyntaxJap.OrdSuperl ;
--  } ;


-}
