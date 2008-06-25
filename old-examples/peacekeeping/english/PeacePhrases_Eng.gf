--# -path=.:..:present:prelude

concrete PeacePhrases_Eng of PeacePhrases = 
  PeaceCat_Eng ** open ResEng, PeaceRes in {

lin
    Hello = stop "hello" ;
    GoodMorning = stop ["good morning"];
    GoodEvening = stop ["good evening"] ;
    WhatIsNamePron p = quest (["what is"] ++ p.s!Gen ++ "name") ;

}