--# -path=.:../chinese:../common:../abstract:../prelude

resource TryChi = SyntaxChi, LexiconChi, ParadigmsChi -[mkAdv, mkDet,mkQuant,mkAdA,mkAdN,mkIDet,mkDet,mkNP,mkNum,mkPConj,mkRP]** 
  open (P = ParadigmsChi) in {

 oper

  mkAdv = overload SyntaxChi {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

}
