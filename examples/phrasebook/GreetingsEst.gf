--# -coding=latin1
concrete GreetingsEst of Greetings = SentencesEst [Greeting,mkGreeting] ** open Prelude in {

---- TODO: real Estonian

lin 
  GBye = mkGreeting "hei hei" ;
  GCheers = mkGreeting "terveydeksi" ;
  GDamn = mkGreeting "hitto" ;
  GExcuse, GExcusePol = mkGreeting "anteeksi" ;
  GGoodDay = mkGreeting "hyvää päivää" ;
  GGoodEvening = mkGreeting "hyvää iltaa" ;
  GGoodMorning = mkGreeting "hyvää huomenta" ;
  GGoodNight = mkGreeting "hyvää yötä" ;
  GGoodbye = mkGreeting "näkemiin" ;
  GHello = mkGreeting "hei" ;
  GHelp = mkGreeting "apua" ;
  GHowAreYou = mkGreeting "mitä kuuluu" ;
  GLookOut = mkGreeting "varo" ;
  GNiceToMeetYou = mkGreeting "hauska tutustua" ;
  GPleaseGive = mkGreeting "ole hyvä" ;
  GPleaseGivePol = mkGreeting "olkaa hyvä" ;
  GSeeYouSoon = mkGreeting "nähdään pian" ;
  GSorry, GSorryPol = mkGreeting "anteeksi" ;
  GThanks = mkGreeting "kiitos" ;
  GTheCheck = mkGreeting "lasku" ;
  GCongratulations = mkGreeting "onnittelut";
  GHappyBirthday = mkGreeting "hyvää syntymäpäivää" ;
  GGoodLuck = mkGreeting "onnea" ; 
  GWhatTime = mkGreeting "paljonko kello on" | mkGreeting "mitä kello on" ;

}
