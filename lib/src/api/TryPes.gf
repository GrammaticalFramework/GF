--# -path=.:../persian:../common:../abstract:../prelude

resource TryPes = SyntaxPes, LexiconPes, ParadigmsPes -[mkDet,mkQuant,mkAdv]** 
  open (P = ParadigmsPes) in {

-- oper

--  mkAdv = overload SyntaxPes {
--    mkAdv : Str -> Adv = P.mkAdv ;
--  } ;

}
