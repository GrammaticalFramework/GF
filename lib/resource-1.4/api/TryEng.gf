--# -path=.:alltenses-1.4:prelude

resource TryEng = SyntaxEng - [mkAdv], LexiconEng, ParadigmsEng - [mkAdv] ** 
  open (P = ParadigmsEng), (S = SyntaxEng) in {

oper
  mkAdv = overload SyntaxEng {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;


}
