--# -path=.:..:present:prelude

concrete PeacePhrases_Eng of PeacePhrases = 
  PeaceCat_Eng ** open ResEng in {

lin
    Hello = { s = "hello" ++ "." } ;
    GoodMorning = { s = ["good morning"] ++ "." } ;
    GoodEvening = { s = ["good evening"] ++ "." } ;
    WhatIsNamePron p = { s = ["what is"] ++ p.s!Gen ++ "name" ++ "?"; };

}