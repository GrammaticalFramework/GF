concrete GreetingsTha of Greetings = 
  SentencesTha [Greeting,mkGreeting] ** 
  open ResTha, Prelude in {

-- สุขสันต์วันเกิด

flags coding = utf8 ;

lin 
  GBye = mkGreeting (thword "ลา" "ก่อน") ;
  GCheers = mkGreeting (thword "ไช" "โย") ;
  GDamn = mkGreeting (thword "ชิบ" "หาย") ;
  GExcuse, GExcusePol = mkGreeting (thword "ขอ" "โทษ") ;
  GGoodDay = mkGreeting (thword "สวัส" "ดี") ;
  GGoodEvening = mkGreeting (thword "สวัส" "ดี") ;
  GGoodMorning = mkGreeting (thword "สวัส" "ดี") ;
  GGoodNight = mkGreeting (thword "รา" "ตรี" "สวัส" "ดิ์") ;
  GGoodbye = mkGreeting (thword "ลา" "ก่อน") ;
  GHello = mkGreeting (thword "สวัส" "ดี") ;
  GHelp = mkGreeting (thword "ช่วย" "ด้วย") ;
  GHowAreYou = mkGreeting (thword "สบาย" "ดี" "ไหม") ;
  GLookOut = mkGreeting (thword "ระ" "วัง") ; ---- google
  GNiceToMeetYou, GNiceToMeetYouPol = 
    mkGreeting (thword "ยิน" "ดี" "ที่" "ได้" "รู้" "จัก") ;
  GPleaseGive, GPleaseGivePol = mkGreeting "นะ" ;
  GSeeYouSoon = mkGreeting (thword "เจอ" "กัน" "นะ") ;
  GSorry, GSorryPol = mkGreeting (thword "ขอ" "โทษ") ;
  GThanks = mkGreeting (thword "ขอบ" "คุณ") ;
  GTheCheck = mkGreeting (thword "เช็ค" "บิล") ;
  GCongratulations = mkGreeting (thword "ยิน" "ดี" "ด้วย") ;
  GHappyBirthday = mkGreeting (thword "สุข" "สันต์" "วัน" "เกิด") ;
  GGoodLuck = mkGreeting (thword "โชค" "ดี" "นะ") ; 
}


