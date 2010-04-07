--# -path=.:alltenses:prelude

resource TryBul = SyntaxBul, LexiconBul, ParadigmsBul - [mkAdv,mkIAdv] ** 
  open (P = ParadigmsBul) in {

oper

  mkAdv = overload SyntaxBul {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;


}
