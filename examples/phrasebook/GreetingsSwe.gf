--# -coding=latin1
concrete GreetingsSwe of Greetings = SentencesSwe [Greeting,mkGreeting] ** open Prelude in {

lin 
  GBye = mkGreeting "hej då" ;
  GCheers = mkGreeting "skål" ;
  GDamn = mkGreeting "fan" ;
  GExcuse, GExcusePol = mkGreeting "ursäkta" ;
  GGoodDay = mkGreeting "god dag" ;
  GGoodEvening = mkGreeting "god afton" ;
  GGoodMorning = mkGreeting "god morgon" ;
  GGoodNight = mkGreeting "god natt" ;
  GGoodbye = mkGreeting "hej då" ;
  GHello = mkGreeting "hej" ;
  GHelp = mkGreeting "hjälp" ;
  GHowAreYou = mkGreeting "hur står det till" ;
  GLookOut = mkGreeting "se upp" ;
  GNiceToMeetYou, GNiceToMeetYouPol = mkGreeting "trevligt att träffas" ;
  GPleaseGive, GPleaseGivePol = mkGreeting "var så god" ;
  GSeeYouSoon = mkGreeting "vi ses snart" ;
  GSorry, GSorryPol = mkGreeting "förlåt" ;
  GThanks = mkGreeting "tack" ;
  GTheCheck = mkGreeting "notan" ;
  GCongratulations = mkGreeting "grattis";
  GHappyBirthday = mkGreeting "grattis på födelsedagen" ;
  GGoodLuck = mkGreeting "lycka till" ; 
  GWhatTime = mkGreeting "vad är klockan" | mkGreeting "hur mycket är klockan" ;

}
