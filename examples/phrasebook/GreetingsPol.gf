concrete GreetingsPol of Greetings = SentencesPol [Greeting,mkGreeting] ** open Prelude in {

flags
  optimize =values ; coding =utf8 ; 

lin 
  GBye = mkGreeting "cześć" ;
  GCheers = mkGreeting "na zdrowie" ;
  GDamn = mkGreeting "cholera" ; -- not polite
  GExcuse, GExcusePol, GSorry, GSorryPol = mkGreeting "przepraszam" ;
  GGoodDay, GGoodMorning = mkGreeting "dzień dobry" ;
  GGoodEvening = mkGreeting "dobry wieczór" ;
  GGoodNight = mkGreeting "dobranoc" ;
  GGoodbye = mkGreeting "do widzenia" ;
  GHello = mkGreeting "cześć" ;
  GHelp = mkGreeting "pomocy" ;
  GHowAreYou = mkGreeting "jak się masz" ;
  GLookOut = mkGreeting "uwaga" ;
  GNiceToMeetYou = mkGreeting "miło mi" ; 
  GPleaseGive, GPleaseGivePol = mkGreeting "poproszę" ;
  GSeeYouSoon = mkGreeting "do zobaczenia" ;
  GThanks = mkGreeting "dziękuję" ;
  GTheCheck = mkGreeting "rachunek" ;
  GCongratulations = mkGreeting "gratulacje";
  GHappyBirthday = mkGreeting "wszystkiego najlepszego z okazji urodzin" ;
  GGoodLuck = mkGreeting "powodzenia" ; 
}
