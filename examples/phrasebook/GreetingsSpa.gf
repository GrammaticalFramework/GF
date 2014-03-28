concrete GreetingsSpa of Greetings = SentencesSpa [Greeting,mkGreeting] ** open Prelude in {

flags coding = utf8 ;

lin 
  GBye = mkGreeting "adiós" ;
  GCheers = mkGreeting "salud" ;
  GDamn = mkGreeting "joder" ;
  GExcuse = mkGreeting "perdón" ;
  GExcusePol = mkGreeting "perdone" ;
  GCongratulations = mkGreeting "felicitaciones" ;
  GGoodLuck = mkGreeting "buena suerte" ;
  GHappyBirthday = mkGreeting "feliz cumpleaños" ;
  GGoodMorning, GGoodDay = mkGreeting "buenos días" ;
  GGoodEvening = mkGreeting "buenas tardes" ;
  GGoodNight = mkGreeting "buenas noches" ;
  GGoodbye = mkGreeting "hasta luego" ;
  GHello = mkGreeting "hola" ;
  GHelp = mkGreeting "socorro" ;
  GHowAreYou = mkGreeting "cómo está¡" ; -- the polite singular "you"
  GLookOut = mkGreeting "atención" ;
  GNiceToMeetYou = mkGreeting "encantado de conocerle" ; -- the polite singular "you"
  GPleaseGive, GPleaseGivePol = mkGreeting "por favor" ;
  GSeeYouSoon = mkGreeting "nos vemos pronto" ; 
  GSorry = mkGreeting "disculpa" ; 
  GSorryPol = mkGreeting "disculpe" ; 
  GThanks = mkGreeting "gracias" ;
  GTheCheck = mkGreeting "la cuenta" ;
  GWhatTime = mkGreeting "qué ora es" ;

}
