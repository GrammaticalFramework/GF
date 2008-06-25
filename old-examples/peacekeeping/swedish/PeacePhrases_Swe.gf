--# -path=.:..:present:prelude

concrete PeacePhrases_Swe of PeacePhrases = 
  PeaceCat_Swe ** open CommonScand, PeaceRes in {

lin
    Hello = stop "hej" ;
    GoodMorning = stop ["god morgon"] ;
    GoodEvening = stop ["god kväll"] ;
    WhatIsNamePron p = stop (["vad heter"] ++ p.s!NPNom) ;

}