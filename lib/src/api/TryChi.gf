--# -path=.:alltenses

resource TryChi = SyntaxChi, LexiconChi, ParadigmsChi -[mkAdv, mkDet,mkQuant]** 
  open (P = ParadigmsChi) in {

 oper

  mkAdv = overload SyntaxChi {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

}
