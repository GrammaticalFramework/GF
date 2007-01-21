--# -path=.:prelude

concrete TravelTha of Travel = open Prelude in {

  flags coding=utf8 ;

-- this file is processed by
--  GF.Text.Thai.thaiFile "../examples/travel/TravelTha.gf" 
      (Just "../examples/travel/TravelThai.gf")
--  GF.Text.Thai.thaiPronFile "../examples/travel/TravelTha.gf" 
      (Just "../examples/travel/TravelThaiPron.gf")
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

    Male = ss "k2ra.b" ;
    Female = ss "k2T1a." ;

    Single, Many = ss [] ;

    Hello = ss ["swas di:"] ;
    Thanks = ss ["k1Ob k2un'"] ;

    IWant = prefixSS "eOa:" ;
    
    DoYouHave = postfixSS ["mi: a&hm"] ;
    IsIt x q = ss (x.s ++ q.s ++ "a&hm") ;

    ItIs = cc2 ;
    
    Indef k = ss (k.s ++ k.c ++ "nvT1g") ;
    This  k = ss (k.s ++ k.c ++ "ni:T2") ;

    NumberObjects n k = ss (k.s ++ n.s ++ k.c) ;

    One  = ss "nvT1g" ;
    Two  = ss "sOg" ;
    Five = ss "ha:" ;
    Ten  = ss "sib" ;

    Mango = cls ["ma. mT1wg"] "lu:k" ;
    Green = ss ["si: ek1i:yw"] ;

  oper
    cls : Str -> Str -> {s,c : Str} = \s,c -> {s = s ; c = c} ;

}
