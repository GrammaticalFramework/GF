concrete GreetingsChi of Greetings = 
  SentencesChi [Greeting,mkGreeting] ** 
  open (D = DictEngChi), ParadigmsChi, ResChi, Prelude in {

flags coding = utf8 ;

lin 
  GBye = D.bye_Interj ;
  GCheers = D.cheers_Interj ;
  GDamn = D.damn_Interj ;
  GExcuse, GExcusePol = D.excuse_me_Interj ;
  GGoodDay = D.hi_Interj ;
  GGoodEvening = D.good_evening_Interj ;
  GGoodMorning = D.good_morning_Interj ;
  GGoodNight = D.good_night_Interj ;
  GGoodbye = D.goodbye_Interj ;
  GHello = D.hi_Interj ;
  GHelp = mkInterj "帮助" ;
  GHowAreYou = mkInterj "你好" ;
  GLookOut = mkInterj "留意" ;
  GNiceToMeetYou, GNiceToMeetYouPol = mkInterj "很高兴见到你" ;
  GPleaseGive, GPleaseGivePol = mkInterj "请" ;
  GSeeYouSoon = mkInterj "很快再见" ;
  GSorry, GSorryPol = mkInterj "对不起" ;
  GThanks = D.thanks_Interj ;
  GTheCheck = mkInterj "检查" ;
  GCongratulations = mkInterj "祝贺您" ;
  GHappyBirthday = mkInterj "祝你生日快乐" ;
  GGoodLuck = D.good_luck_Interj ;

}
