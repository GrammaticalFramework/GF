--# -path=.:..:present:prelude

concrete PeacePhrases_Fin of PeacePhrases = 
  PeaceCat_Fin ** open LangFin, ParadigmsFin in {

lin
    Hello = { s = "terve" ++ "." } ;
    GoodMorning = { s = ["hyv‰‰ huomenta"] ++ "." } ;
    GoodEvening = { s = ["hyv‰‰ iltaa"] ++ "." } ;
    WhatIsNamePron p = PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos 
      (QuestVP whatSg_IP (UseComp (CompNP (DetCN (DetSg (SgQuant (PossPron p)) NoOrd) 
      (UseN (reg2N "nimi" "nimi‰")))))))) NoVoc ;

}