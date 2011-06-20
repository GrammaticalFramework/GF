--# -path=.:alltenses:prelude
resource TryNep = SyntaxNep - [mkAdN] , LexiconNep, ParadigmsNep - [mkAdv,mkDet,mkIP,mkAdN,mkQuant] ** 
  open (P = ParadigmsNep) in {

oper

  mkAdv = overload SyntaxNep {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxNep.mkAdN ;
---   mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxNep {
--    mkOrd : A -> Ord = SyntaxNep.OrdSuperl ;
--  } ;


}
