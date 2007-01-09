--# -path=.:prelude

concrete TravelThai of Travel = open Prelude in {

  flags coding=utf8 ;

-- this file is processed by
--  GF.Text.Thai.thaiFile "���เ��ะมปลเ��ตระึเ���ระึเล��หังฝ" (Just TGT)
--  GF.Text.Thai.thaiPronFile "���เ��ะมปลเ��ตระึเ���ระึเล��หังฝ" (Just TGT)
-- to produce target Thai script and pronunciation files.

  lincat
    Phrase,

    Greeting,
    Order,
    Question,
    Sentence,
    Object = SS ;

    Kind = {s,c : Str} ; -- c is classifier

    Quality,
    Number,

    Speaker,
    Hearer,
    Gender,
    Quantity = SS ;

  lin
    PGreeting g s h = ss (g.s ++ s.s ++ h.s) ;
    POrder    g s h = ss (g.s ++ s.s ++ h.s) ;
    PQuestion g s h = ss (g.s ++ s.s ++ h.s) ;
    PSentence g s h = ss (g.s ++ s.s ++ h.s) ;

    MkSpeaker = cc2 ;
    MkHearer _ _ = ss [] ;

    Male = ss "คระบ" ;
    Female = ss "ค่ะ" ;

    Single, Many = ss [] ;

    Hello = ss ["สวัสดี"] ;
    Thanks = ss ["ขอบคุณ"] ;

    IWant = prefixSS "เอา" ;
    
    DoYouHave = postfixSS ["มีไหม"] ;
    IsIt x q = ss (x.s ++ q.s ++ "ไหม") ;

    ItIs = cc2 ;
    
    Indef k = ss (k.s ++ k.c ++ "นึ่ง") ;
    This  k = ss (k.s ++ k.c ++ "นี้") ;

    NumberObjects n k = ss (k.s ++ n.s ++ k.c) ;

    One  = ss "นึ่ง" ;
    Two  = ss "สอง" ;
    Five = ss "หา" ;
    Ten  = ss "สิบ" ;

    Mango = cls ["มะม่วง"] "ลูก" ;
    Green = ss ["สีเขียว"] ;

  oper
    cls : Str -> Str -> {s,c : Str} = \s,c -> {s = s ; c = c} ;

}
