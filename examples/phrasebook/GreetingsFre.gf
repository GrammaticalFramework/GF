--# -coding=latin1
concrete GreetingsFre of Greetings = SentencesFre [Greeting,mkGreeting] ** open Prelude in {

lin 
  GBye = mkGreeting "au revoir" ;
  GCheers = mkGreeting "santé" ;
  GDamn = mkGreeting "maudit" ;
  GExcuse = mkGreeting "excuse-moi" ;
  GExcusePol = mkGreeting "excusez-moi" ;
  GGoodDay = mkGreeting "bonjour" ;
  GGoodEvening = mkGreeting "bon soir" ;
  GGoodMorning = mkGreeting "bonjour" ;
  GGoodNight = mkGreeting "bonne nuit" ;
  GGoodbye = mkGreeting "au revoir" ;
  GHello = mkGreeting "salut" ;
  GHelp = mkGreeting "au secours" ;
  GHowAreYou = mkGreeting "comment ça va" ;
  GLookOut = mkGreeting "attention" ;
  GNiceToMeetYou = mkGreeting "enchanté" ;
  GPleaseGive = mkGreeting "s'il te plaît" ;
  GPleaseGivePol = mkGreeting "s'il vous plaît" ;
  GSeeYouSoon = mkGreeting "à bientôt" ;
  GSorry, GSorryPol = mkGreeting "pardon" ;
  GThanks = mkGreeting "merci" ;
  GTheCheck = mkGreeting "l'addition" ;
  GCongratulations = mkGreeting "félicitations";
  GHappyBirthday = mkGreeting "joyeux anniversaire" ;
  GGoodLuck = mkGreeting "bonne chance" ; 
  GWhatTime = mkGreeting "quelle heure est-il" ;

}
