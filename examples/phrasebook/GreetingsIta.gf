concrete GreetingsIta of Greetings = open Roles,Prelude in {

lincat 
  Greeting = RolePhrase ;

lin 
  GHello = roleNeutral "ciao" ;
  GThanks = roleNeutral "grazie" ;
  GHowAreYou = roleNeutral "come sta" ;
  GPleaseGive = roleNeutral "per favore" ;
  GExcuse = politeDistinct "scusi" "scusa" ;
  GSorry = politeDistinct "scusimi" "scusami" ; ----
  GGoodbye = roleNeutral "arrivederci" ;
  GBye = roleNeutral "ciao" ;
  GWhatsYourName = 
    politeDistinct "come si chiama" "come ti chiami" ;
--  GNiceToMeetYou = roleNeutral "piacevole" ; ----
--  GSeeYouSoon = roleNeutral "a poco tempo" ; ----
  GHelp = roleNeutral "aiuto" ;
  GLookOut = roleNeutral "attenzione" ;
  GGoodMorning = roleNeutral "buongiorno" ;
  GGoodDay = roleNeutral "buongiorno" ;
  GGoodEvening = roleNeutral "buona sera" ;
  GGoodNight = roleNeutral "buona notte" ;
  GImHungry = roleNeutral "ho fame" ;
  GImThirsty = roleNeutral "ho sete" ;
  GImTired = speakerDistinct "sono stanco" "sono stanca" ;
  GImScared = roleNeutral "ho paura" ;
  GIdontUnderstand = roleNeutral "non capisco" ;
  GTheCheck = roleNeutral "il conto" ;

  GYes = roleNeutral "sì" ; ---- si
  GNo = roleNeutral "no" ;


}
