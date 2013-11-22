--# -coding=latin1
concrete GreetingsNor of Greetings = SentencesNor [Greeting,mkGreeting] ** open Prelude in {

lin 
  GBye = mkGreeting "ha det" ;
  GCheers = mkGreeting "skål" ; -- google translate ! 
  GDamn = mkGreeting "faen" ; 
  GExcuse, GExcusePol = mkGreeting "unnskyld" ;
  GGoodDay = mkGreeting "god dag" ;
  GGoodEvening = mkGreeting "god kveld" ;
  GGoodMorning = mkGreeting "god morgen" ;
  GGoodNight = mkGreeting "god natt" ;
  GGoodbye = mkGreeting "ha det bra" ;
  GHello = mkGreeting "hei" ;
  GHelp = mkGreeting "hjelp" ;
  GHowAreYou = mkGreeting "hvordan går det" ;
  GLookOut = mkGreeting "se opp" ; -- google translate !
  GNiceToMeetYou, GNiceToMeetYouPol = mkGreeting "hyggelig å treffe deg" ;
  GPleaseGive, GPleaseGivePol = mkGreeting "vær så snill" ;
  GSeeYouSoon = mkGreeting "se deg snart" ; -- google translate !
  GSorry, GSorryPol = mkGreeting "beklager" ;
  GThanks = mkGreeting "takk" ;
  GTheCheck = mkGreeting "regningen" ;
  GCongratulations = mkGreeting "gratulerer";
  GHappyBirthday = mkGreeting "gratulerer med dagen" ;
  GGoodLuck = mkGreeting "lykke til" ; 

}
