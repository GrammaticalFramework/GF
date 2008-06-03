--# -path=.:alltenses-1.4:prelude

resource TryEng = SyntaxEng, LexiconEng, ParadigmsEng - [mkAdv] ** 
  open (P = ParadigmsEng), in {

oper

  mkAdv = overload SyntaxEng {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;


}
