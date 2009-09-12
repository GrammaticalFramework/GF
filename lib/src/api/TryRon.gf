--# -path=.:alltenses:prelude

resource TryRon = SyntaxRon-[mkAdN], LexiconRon, ParadigmsRon - [mkAdv,mkAdN,mkOrd] ** 
  open (P = ParadigmsRon) in {

oper

  mkAdv = overload SyntaxEng {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxEng.mkAdN ;
    mkAdN : Str -> AdN = P.mkAdN ;
  } ;

  mkOrd = overload SyntaxEng {
    mkOrd : Str -> Ord = P.mkOrd ;
  } ;


}
