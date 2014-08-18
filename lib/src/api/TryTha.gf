--# -path=.:../thai:../common:../abstract:../prelude

resource TryTha = SyntaxTha, LexiconTha, ParadigmsTha -[mkAdv, mkDet,mkQuant]** 
  open (P = ParadigmsTha) in {

-- oper

--  mkAdv = overload SyntaxTha {
--    mkAdv : Str -> Adv = P.mkAdv ;
--  } ;

}
