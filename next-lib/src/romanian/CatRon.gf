--# -path=.:../Romance:../common:../abstract:../common:prelude

concrete CatRon of Cat =
  CommonX - [Temp,TTAnt,Tense,TPres,TPast,TFut,TCond] 
  ** open Prelude, ResRon, (R = ParamX) in {

  flags optimize=all_subs ;


  
  lincat


-- Verb

 --   VP = ResRon.VP ;
  --  VPSlash = ResRon.VP ** {c2 : Compl} ;
  --  Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN      = {s : Number => Str ; g : Gender} ;
 --   Pron    = Pronoun ;
 --   NP      = NounPhrase ;
  --  Det     = {
  --    s : Gender => Case => Str ; 
  --    n : Number ; 
  --    s2 : Str ;            -- -ci 
  --    sp : Gender => Case => Str    -- substantival: mien, mienne
  --    } ;
  --  Quant = {
  --    s  : Bool => Number => Gender => Case => Str ; 
  --    s2 : Str ; 
  --    sp : Number => Gender => Case => Str 
       Ord = {s : AForm => Str ; isPre : Bool} ;
-- Numeral

    Numeral = {s : ACase => CardOrd => NumF => Str ; size : Size } ;
    Digits  = {s : CardOrd => Str ; n : Size ; isDig : Bool} ;

    

-- Structural
 
    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str ; m : Mood} ;
    Prep = {s : Str ; c : NCase ; isDir : Bool} ;

-- Open lexical classes, e.g. Lexicon
    Verb = {s : VForm => Str } ;
    V ={s : VForm => Str } ;
    VQ, VA = V ;
    V2, VV, V2S, V2Q = V ** {c2 : Compl} ;
    V3, V2A, V2V = V ** {c2,c3 : Compl} ;
    VS = V ** {m : Polarity => Mood} ;

    A  = {s : Degree => AForm => Str ; isPre : Bool} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = Noun ; 
    N2 = Noun  ** {c2 : Compl} ;
    N3 = Noun  ** {c2,c3 : Compl} ;
    PN = {s : ACase => Str ; g : Gender ; n : Number} ;


}
