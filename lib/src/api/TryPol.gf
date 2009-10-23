--# -path=.:alltenses:prelude

resource TryPol = SyntaxPol, LexiconPol, ParadigmsPol - [mkAdv] ** 
  open (P = ParadigmsPol) in {

--oper

--  mkAdv = overload SyntaxPol {
--    mkAdv : Str -> Adv = P.mkAdv ;
--  } ;

}
