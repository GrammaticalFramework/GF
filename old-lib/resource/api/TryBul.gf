--# -path=.:alltenses:prelude

resource TryBul = SyntaxBul, LexiconBul, ParadigmsBul - [mkAdv] ** 
  open (P = ParadigmsBul) in {

oper

  mkAdv = overload SyntaxBul {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;


}
