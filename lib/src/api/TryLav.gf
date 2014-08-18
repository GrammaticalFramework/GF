--# -path=.:../latvian:../common:../abstract:../prelude

resource TryLav = SyntaxLav-[mkAdN], LexiconLav, ParadigmsLav-[mkAdv,mkAdN,mkOrd,mkQuant] **
  open (P = ParadigmsLav) in {

oper

  mkAdv = overload SyntaxLav {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxLav.mkAdN ;
    mkAdN : Str -> AdN = P.mkAdN ;
  } ;

  --mkOrd = overload SyntaxLav {
  --  mkOrd : Str -> Ord = P.mkOrd ;
  --} ;


}
