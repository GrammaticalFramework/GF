--# -path=.:alltenses:prelude:/users/shafqat/www.grammaticalframework.org_0/lib/src/persian

resource TryPes = SyntaxPes, LexiconPes, ParadigmsPes -[mkDet,mkQuant]** 
  open (P = ParadigmsPes) in {

-- oper

--  mkAdv = overload SyntaxPes {
--    mkAdv : Str -> Adv = P.mkAdv ;
--  } ;

}
