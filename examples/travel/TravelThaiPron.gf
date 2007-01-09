--# -path=.:prelude

concrete TravelThaiPron of Travel = open Prelude in {

  flags coding=utf8 ;

-- this file is processed by
--  GF.Text.Thai.thaiFile "m^eaeaveaveapltrrlhg-" (Just TGT)
--  GF.Text.Thai.thaiPronFile "m^eaeaveaveapltrrlhg-" (Just TGT)
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

    Male = ss "khr'ap" ;
    Female = ss "kh^a" ;

    Single, Many = ss [] ;

    Hello = ss ["s`awt d-ii"] ;
    Thanks = ss ["kh`Op kh-un"] ;

    IWant = prefixSS "O-eaa" ;
    
    DoYouHave = postfixSS ["m-ii m~ay"] ;
    IsIt x q = ss (x.s ++ q.s ++ "m~ay") ;

    ItIs = cc2 ;
    
    Indef k = ss (k.s ++ k.c ++ "n^vg") ;
    This  k = ss (k.s ++ k.c ++ "n~ii") ;

    NumberObjects n k = ss (k.s ++ n.s ++ k.c) ;

    One  = ss "n^vg" ;
    Two  = ss "s~Og" ;
    Five = ss "h~aa" ;
    Ten  = ss "s`ip" ;

    Mango = cls ["m'a m^owg"] "l^uuk" ;
    Green = ss ["s~ii kh`eiiyw"] ;

  oper
    cls : Str -> Str -> {s,c : Str} = \s,c -> {s = s ; c = c} ;

}
