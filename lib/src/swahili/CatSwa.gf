--# -path=.:../abstract:../../prelude:../common
concrete CatSwa of Cat = CommonX ** open ResSwa, Prelude in {

  flags optimize=all_subs ;

  lincat

    CN = {s,s1,s2 : Number => Str; g : Gender ; anim : Animacy ; hasAdj : Bool } ;
    N = {s : Number => Str; g : Gender ; anim : Animacy } ;
    N2 = {s : Number => Str; g : Gender ; anim : Animacy } ** {c2 : Str} ;
    N3 = {s : Number => Str; g : Gender ; anim : Animacy } ** {c2,c3 : Str} ;
    Pron = {s :Number => Str ; p : Person};
    V,VA = Verb ; -- = {s : VForm => Str} ;
    V2 = Verb ** {c2 : Str} ;
    NP = {s : Case => Str ; a : Agr} ;
    A  = {s : Degree => AForm => Str} ;
    AP = {s : AForm => Str} ;
    Det   = {s : Gender => Case => Animacy => Str ; n : Number } ;
    Quant   = {s : Number => Gender => Animacy => Case => Str} ;
    Predet,Ord = {s : Str} ;
    
    
        
-- Open lexical classes, e.g. Lexicon 

-- Verb

    VP = ResSwa.VP ;

-- Numeral
   Num     = {s : Gender => Str ; n : Number} ;

{--    
    Num = {s : Gender => Animacy => Str ; n : Number} ;
    Card = {s : Gender => Animacy => Str ; n : Number} ;
    Digits = {s : Str ; n : Number} ; 
--}
--Prepositions
   Prep = {s : Str} ; 

-- Sentence

    Cl    = Clause ;
   
}
