concrete GreetingsTha of Greetings = 
  SentencesTha [Greeting,mkGreeting] ** 
  open ResTha, Prelude in {

-- สุคสันต์วันเกิด

flags coding = utf8 ;

lin 
  GBye = mkGreeting (thbind "ecO" "kan" "na.") ;
  GCheers = mkGreeting (thbind "a&c2" "o:y") ;
  GDamn = mkGreeting (thbind "a'c2T1g") ; ---- google
  GExcuse, GExcusePol = mkGreeting (thbind "k1O" "o:t5s.") ;
  GGoodDay = mkGreeting (thbind "swas" "di:") ;
  GGoodEvening = mkGreeting (thbind "swas" "di:") ;
  GGoodMorning = mkGreeting (thbind "swas" "di:") ;
  GGoodNight = mkGreeting (thbind "ra:" "tri:" "swas" "diK") ;
  GGoodbye = mkGreeting (thbind "la:" "kT1On") ;
  GHello = mkGreeting (thbind "hwas" "di:") ;
  GHelp = mkGreeting (thbind "c2T1wy" "dT2wy") ;
  GHowAreYou = mkGreeting (thbind "sba:y" "di:" "a&hm") ;
  GLookOut = mkGreeting (thbind "ra." "wag") ; ---- google
  GNiceToMeetYou, GNiceToMeetYouPol = 
    mkGreeting (thbind "yin" "di:" "t2i:T1" "a&dT2" "ru:T2" "cak") ;
  GPleaseGive, GPleaseGivePol = mkGreeting (thbind "c2T1wy") ; ----
  GSeeYouSoon = mkGreeting (thbind "ecO" "kan" "na.") ;
  GSorry, GSorryPol = mkGreeting (thbind "k1O" "o:t5s.") ;
  GThanks = mkGreeting (thbind "k1Ob" "k2un'") ;
  GTheCheck = mkGreeting (thbind "ec2Sk2" "bil") ;
  GCongratulations = mkGreeting (thbind "yin" "di:" "dT2wy") ;
  GHappyBirthday = mkGreeting (thbind "suk2" "santK" "wan" "ekid") ;
  GGoodLuck = mkGreeting (thbind "o:ck2" "di:" "na.") ; 
}

