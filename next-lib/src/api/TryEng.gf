--# -path=.:alltenses:prelude

resource TryEng = SyntaxEng-[mkAdN], LexiconEng, ParadigmsEng - [mkAdv,mkAdN] ** 
  open (P = ParadigmsEng), in {

oper

  mkAdv = overload SyntaxEng {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxEng.mkAdN ;
    mkAdN : Str -> AdN = P.mkAdN ;
  } ;


}
