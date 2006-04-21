--# -path=.:..:present:prelude

concrete PeacePhrases_Swe of PeacePhrases = 
  PeaceCat_Swe ** open CommonScand in {

lin
    Hello = { s = "hej" ++ "." } ;
    GoodMorning = { s = ["god morgon"] ++ "." } ;
    GoodEvening = { s = ["god kväll"] ++ "." } ;
    WhatIsNamePron p = { s = ["vad heter"] ++ p.s!NPNom ++ "?"; };

}