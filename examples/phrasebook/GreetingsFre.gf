concrete GreetingsFre of Greetings = open Roles,Prelude in {

flags coding = utf8 ;

lincat 
  Greeting = RolePhrase ;

lin 
  GHello = roleNeutral "salut" ;
  GThanks = roleNeutral "merci" ;
  GHowAreYou = roleNeutral "comment ça va" ;
  GPleaseGive = politeDistinct "s'il vous plaît" "s'il te plaît" ;
  GExcuse = politeDistinct "excusez-moi" "excuse-moi" ;
  GSorry = roleNeutral "pardon" ;
  GGoodbye = roleNeutral "au revoir" ;
  GBye = roleNeutral "au revoir" ;
  GWhatsYourName = 
    politeDistinct "comment vous appelez-vous" "comment t'appelles-tu" ;
  GNiceToMeetYou = speakerDistinct "enchanté" "enchantée" ;
  GSeeYouSoon = roleNeutral "à bientôt" ;
  GHelp = roleNeutral "au secours" ;
  GLookOut = roleNeutral "attention" ;
  GGoodMorning = roleNeutral "bonjour" ;
  GGoodDay = roleNeutral "bonjour" ;
  GGoodEvening = roleNeutral "bon soir" ;
  GGoodNight = roleNeutral "bonne nuit" ;
  GImHungry = roleNeutral "j'ai faim" ;
  GImThirsty = roleNeutral "j'ai soif" ;
  GImTired = speakerDistinct "je suis fatigué" "je suis fatiguée" ;
  GImScared = roleNeutral "j'ai peur" ;
  GIdontUnderstand = roleNeutral "je ne comprends pas" ;
  GWheresTheBathroom = roleNeutral "où est la toilette" ;
  GTheCheck = roleNeutral "l'addition" ;

  GYes = roleNeutral "oui" ; ---- si
  GNo = roleNeutral "non" ;


}
