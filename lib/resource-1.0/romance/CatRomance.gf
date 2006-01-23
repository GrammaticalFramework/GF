incomplete concrete CatRomance of Cat = 
  open Prelude, CommonRomance, ResRomance, (R = ParamX) in {

  flags optimize=all_subs ;

  lincat

-- Phrase

    Text, Phr, Utt, Voc = {s : Str} ;

-- Tensed/Untensed

    S  = {s : Mood => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Mood => Agr => Str} ;

-- Sentence

    Cl    = {s : Tense => Anteriority => Polarity => Mood => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Mood => Str} ** {c2 : Compl} ;
    Imp   = {s : Polarity => AAgr => Str} ;

-- Question

    QCl  = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    IP   = {s : Case => Str ; a : AAgr} ;
    IAdv = {s : Str} ;    
    IDet = {s : Gender => Case => Str ; n : Number} ;

-- Relative

    RCl  = {s : Tense => Anteriority => Polarity => Mood => Agr => Str} ;
    RP   = {s : AAgr  => RelForm => Str} ; ----  ; a : RAgr} ;

-- Verb

    VP = CommonRomance.VP ;
    Comp = {s : Agr => Str} ; 
    SC = {s : Str} ;

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN      = {s : Number => Str ; g : Gender} ;
    NP,Pron = Pronoun ;
    Det     = {s : Gender => Case => Str ; n : Number} ;
    QuantSg = {s : Gender => Case => Str} ;
    QuantPl = {s : Gender => Case => Str} ;
    Predet  = {s : AAgr   => Case => Str ; c : Case} ; -- la plupart de...
    Num     = {s : Gender => Str} ;
    Ord     = {s : AAgr   => Str} ;

-- Adverb

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str} ;

-- Structural

    Conj  = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    PConj = {s : Str} ;    
    CAdv  = {s : Str} ;    
    Subj  = {s : Str ; m : Mood} ;
    Prep  = {s : Str ; c : Case} ;

-- Open lexical classes, e.g. Basic

    V, VS, VQ, VA = Verb ;
    V2, VV, V2A = Verb ** {c2 : Compl} ;
    V3 = Verb ** {c2,c3 : Compl} ;

    A  = {s : Degree => AForm => Str ; isPre : Bool} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = Noun ; 
    N2 = Noun  ** {c2 : Compl} ;
    N3 = Noun  ** {c2,c3 : Compl} ;
    PN = {s : Str ; g : Gender} ;

}
