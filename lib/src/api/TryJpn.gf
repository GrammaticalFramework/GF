--# -path=.:../japanese:../abstract:../prelude
resource TryJpn = 
  SyntaxJpn - [mkAdN] , 
  LexiconJpn, 
  ParadigmsJpn - [mkAdv,mkDet,mkIP,mkAdN,mkQuant] ** 
  open (P = ParadigmsJpn) in {

}
{-
oper

  mkAdv = overload SyntaxJpn {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxJpn.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxJpn {
--    mkOrd : A -> Ord = SyntaxJpn.OrdSuperl ;
--  } ;


-}
