--# -path=.:..:present:prelude

concrete PeacePhrases_Fin of PeacePhrases = 
  PeaceCat_Fin ** open LangFin, ParadigmsFin, ConstructorsFin, PeaceRes in {

lin
    Hello = stop "terve" ;
    GoodMorning = stop ["hyv‰‰ huomenta"] ;
    GoodEvening = stop ["hyv‰‰ iltaa"] ;
    WhatIsNamePron p = quest (
       mkPhr (mkUtt (mkQS (mkQCl whatSg_IP (mkVP (mkNP (mkDet p) name_N)))))).s ;

}
