concrete GreetingsChi of Greetings = 
  SentencesChi [Greeting,mkGreeting] ** 
  open (D = DictEngChi), ResChi, Prelude in {

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
--  GHelp = mkGreeting (thword "ช่วย" "ด้วย") ;
--  GHowAreYou = mkGreeting (thword "สบาย" "ดี" "ไหม") ;
--  GLookOut = mkGreeting (thword "ระ" "วัง") ;  google
--  GNiceToMeetYou, GNiceToMeetYouPol = mkGreeting (thword "ยิน" "ดี" "ที่" "ได้" "รู้" "จัก") ;
--  GPleaseGive, GPleaseGivePol = mkGreeting "นะ" ;
--  GSeeYouSoon = mkGreeting (thword "เจอ" "กัน" "นะ") ;
--  GSorry, GSorryPol = mkGreeting (thword "ขอ" "โทษ") ;
  GThanks = D.thanks_Interj ;
--  GTheCheck = mkGreeting (thword "เช็ค" "บิล") ;
--  GCongratulations = mkGreeting (thword "ยิน" "ดี" "ด้วย") ;
--  GHappyBirthday = mkGreeting (thword "สุข" "สันต์" "วัน" "เกิด") ;
  GGoodLuck = D.good_luck_Interj ;


}
