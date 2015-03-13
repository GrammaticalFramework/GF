--# -path=.:../mongolian:../common:../abstract

resource TryMon = SyntaxMon, LexiconMon, ParadigmsMon -[mkAdv, mkDet,mkQuant,mkAdA,mkAdN,mkIDet,mkDet,mkNP,mkNum,mkPConj,mkRP,mkOrd]** 
  open (P = ParadigmsMon) in {

 oper

  mkAdv = overload SyntaxMon {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

}
