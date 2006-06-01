incomplete concrete CatRomance of Cat = 
  CommonX ** open Prelude, CommonRomance, ResRomance, (R = ParamX) in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Mood => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Mood => Agr => Str ; c : Case} ;

-- Sentence

    Cl    = {s : Tense => Anteriority => Polarity => Mood => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Mood => Str} ** {c2 : Compl} ;
    Imp   = {s : Polarity => AAgr => Str} ;

-- Question

    QCl   = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    IP    = {s : Case => Str ; a : AAgr} ;
    IComp = {s : AAgr => Str} ;     
    IDet  = {s : Gender => Case => Str ; n : Number} ;

-- Relative

    RCl  = {
      s : Agr => Tense => Anteriority => Polarity => Mood => Str ; 
      c : Case
      } ;
    RP   = {s : Bool => AAgr => Case => Str ; a : AAgr ; hasAgr : Bool} ;

-- Verb

    VP = CommonRomance.VP ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN      = {s : Number => Str ; g : Gender} ;
    NP,Pron = Pronoun ;
    Det     = {s : Gender => Case => Str ; n : Number} ;
    QuantSg = {s : Gender => Case => Str} ;
    QuantPl = {s : Bool => Gender => Case => Str} ;
    Quant   = {s : Bool => Number => Gender => Case => Str} ;
    Predet  = {s : AAgr   => Case => Str ; c : Case} ; -- la plupart de...
    Num     = {s : Gender => Str ; isNum : Bool} ;
    Ord     = {s : AAgr   => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str} ;

-- Structural

    Conj  = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    Subj  = {s : Str ; m : Mood} ;
    Prep  = {s : Str ; c : Case} ;

-- Open lexical classes, e.g. Lexicon

    V, VQ, VA = Verb ;
    V2, VV = Verb ** {c2 : Compl} ;
    V2A, V3 = Verb ** {c2,c3 : Compl} ;
    VS = Verb ** {m : Polarity => Mood} ;

    A  = {s : Degree => AForm => Str ; isPre : Bool} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = Noun ; 
    N2 = Noun  ** {c2 : Compl} ;
    N3 = Noun  ** {c2,c3 : Compl} ;
    PN = {s : Str ; g : Gender} ;

}
