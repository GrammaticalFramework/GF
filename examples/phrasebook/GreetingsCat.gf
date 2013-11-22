--# -coding=latin1
concrete GreetingsCat of Greetings = SentencesCat [Greeting,mkGreeting] ** open Prelude in {

lin 
  GBye = mkGreeting "adéu" ;
  GCheers = mkGreeting "salut" ;
  GDamn = mkGreeting "merda" ;
  GExcuse = mkGreeting "perdona" ;
  GExcusePol = mkGreeting ("perdoni" | "disculpi") ;
  GCongratulations = mkGreeting "felicitats" ;
  GHappyBirthday = mkGreeting "feliç aniversari" ;
  GGoodLuck = mkGreeting "sort" ;
  GGoodDay = mkGreeting "bon dia" ;
  GGoodEvening = mkGreeting "bona tarda" ;
  GGoodMorning = mkGreeting "bon dia" ;
  GGoodNight = mkGreeting "bona nit" ;
  GGoodbye = mkGreeting "a reveure" ;
  GHello = mkGreeting "hola" ;
  GHelp = mkGreeting "socors" ;
  GHowAreYou = mkGreeting "què tal" ;
  GLookOut = mkGreeting "compte" ;
  GNiceToMeetYou = mkGreeting "encantat de conèixer-lo" ; -- make distinction Masc/Fem
  GPleaseGive = mkGreeting "si et plau" ;
  GPleaseGivePol = mkGreeting "si us plau" ;
  GSeeYouSoon = mkGreeting "fins aviat" ; 
  GSorry = mkGreeting "perdoni" ;
  GSorryPol = mkGreeting "em sap greu" ; 
  GThanks = mkGreeting "gràcies" ;
  GTheCheck = mkGreeting "el compte" ;

}
