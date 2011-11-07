--# -path=.:alltenses

resource TryTha = SyntaxTha, LexiconTha, ParadigmsTha -[mkDet,mkQuant]** 
  open (P = ParadigmsTha) in {

-- oper

--  mkAdv = overload SyntaxTha {
--    mkAdv : Str -> Adv = P.mkAdv ;
--  } ;

}
