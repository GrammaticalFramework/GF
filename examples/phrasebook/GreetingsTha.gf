concrete GreetingsTha of Greetings = 
  SentencesTha [Greeting,mkGreeting] ** 
  open ResTha, Prelude in {

-- สุคสันต์วันเกิด

flags coding = utf8 ;

lin 
  GBye = mkGreeting (thbind "เจอ" "กัน" "นะ") ;
  GCheers = mkGreeting (thbind "ไช" "โย") ;
  GDamn = mkGreeting (thbind "a'ช่ง") ; ---- google
  GExcuse, GExcusePol = mkGreeting (thbind "ขอ" "โทษ") ;
  GGoodDay = mkGreeting (thbind "สวัส" "ดี") ;
  GGoodEvening = mkGreeting (thbind "สวัส" "ดี") ;
  GGoodMorning = mkGreeting (thbind "สวัส" "ดี") ;
  GGoodNight = mkGreeting (thbind "รา" "ตรี" "สวัส" "ดิ์") ;
  GGoodbye = mkGreeting (thbind "ลา" "ก่อน") ;
  GHello = mkGreeting (thbind "หวัส" "ดี") ;
  GHelp = mkGreeting (thbind "ช่วย" "ด้วย") ;
  GHowAreYou = mkGreeting (thbind "สบาย" "ดี" "ไหม") ;
  GLookOut = mkGreeting (thbind "ระ" "วัง") ; ---- google
  GNiceToMeetYou, GNiceToMeetYouPol = 
    mkGreeting (thbind "ยิน" "ดี" "ฑี่" "ได้" "รู้" "จัก") ;
  GPleaseGive, GPleaseGivePol = mkGreeting (thbind "ช่วย") ; ----
  GSeeYouSoon = mkGreeting (thbind "เจอ" "กัน" "นะ") ;
  GSorry, GSorryPol = mkGreeting (thbind "ขอ" "โทษ") ;
  GThanks = mkGreeting (thbind "ขอบ" "คุณ") ;
  GTheCheck = mkGreeting (thbind "เช็ค" "บิล") ;
  GCongratulations = mkGreeting (thbind "ยิน" "ดี" "ด้วย") ;
  GHappyBirthday = mkGreeting (thbind "สุค" "สันต์" "วัน" "เกิด") ;
  GGoodLuck = mkGreeting (thbind "โจค" "ดี" "นะ") ; 
}

