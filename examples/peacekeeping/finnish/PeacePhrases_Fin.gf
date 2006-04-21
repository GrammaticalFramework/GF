--# -path=.:..:present:prelude

concrete PeacePhrases_Fin of PeacePhrases = 
  PeaceCat_Fin ** open LangFin, ParadigmsFin, PeaceRes in {

lin
    Hello = stop "terve" ;
    GoodMorning = stop ["hyv‰‰ huomenta"] ;
    GoodEvening = stop ["hyv‰‰ iltaa"] ;
    WhatIsNamePron p = quest (PhrUtt NoPConj (UttQS (UseQCl TPres ASimul PPos 
      (QuestVP whatSg_IP (UseComp (CompNP (DetCN (DetSg (SgQuant (PossPron p)) NoOrd) 
      (UseN (reg2N "nimi" "nimi‰")))))))) NoVoc).s ;

}