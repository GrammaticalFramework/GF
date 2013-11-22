--# -coding=latin1
concrete GreetingsDan of Greetings = SentencesDan [Greeting,mkGreeting] ** open Prelude in {

lin 
  GBye = mkGreeting "hej hej" ; -- not google translate
  GCheers = mkGreeting "skål" ;
  GDamn = mkGreeting "satans" ; -- X  
  GExcuse, GExcusePol = mkGreeting "undskyld mig" ;
  GGoodDay = mkGreeting "god dag" ;
  GGoodEvening = mkGreeting "god aften" ;
  GGoodMorning = mkGreeting "god morgen" ;
  GGoodNight = mkGreeting "godnat" ;
  GGoodbye = mkGreeting "farvel" ;
  GHello = mkGreeting "hej" ;
  GHelp = mkGreeting "hjælp" ;
  GHowAreYou = mkGreeting "hvordan har du det" ;
  GLookOut = mkGreeting "pas på" ;
  GNiceToMeetYou, GNiceToMeetYouPol = mkGreeting "hyggeligt at møde dig" ; -- more common than rart (google translate) 
  GPleaseGive = mkGreeting "vær så sød" ; -- can also have flink instead of sod
  GPleaseGivePol = mkGreeting "venligst" ; -- X not behage 
  GSeeYouSoon = mkGreeting "vi ses snart" ; -- X se dig snart
  GSorry, GSorryPol = mkGreeting "undskyld" ;
  GThanks = mkGreeting "tak" ;
  GTheCheck = mkGreeting "regningen" ;
  GCongratulations = mkGreeting "tillykke";
  GHappyBirthday = mkGreeting "tillykke med fødselsdagen" ;
  GGoodLuck = mkGreeting "held og lykke" ; 

}
