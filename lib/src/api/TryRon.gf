--# -path=.:alltenses:prelude

resource TryRon = SyntaxRon-[mkAdN], LexiconRon, ParadigmsRon - [mkAdv,mkAdN,mkOrd,mkDet,mkNP] ** 
  open (P = ParadigmsRon) in {

oper

  mkAdv = overload SyntaxRon {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxRon.mkAdN ;
--    mkAdN : Str -> AdN = P.mkAdN ;
  } ;

--  mkOrd = overload SyntaxRon {
--    mkOrd : Str -> Ord = P.mkOrd ;
--  } ;


}
