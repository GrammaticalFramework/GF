--# -path=.:alltenses:prelude

resource TryEng = SyntaxEng-[mkAdN], LexiconEng, ParadigmsEng - [mkAdv,mkAdN,mkOrd] ** 
  open (P = ParadigmsEng) in {

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
