incomplete concrete CatRomance of Cat = 
  open ResRomance, Prelude, DiffRomance, (R = ParamX) in {

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
    IDet = {s : Gender => Str ; n : Number} ;

-- Relative

    RCl  = {s : Tense => Anteriority => Polarity => Mood => Agr => Str} ;
----    RP   = {s : AAgr  => RelForm => Str ; a : RAgr} ;

-- Verb

    VP = {
      s : Anteriority => VF => {
        fin : Str ;           -- ai  
        inf : Str             -- dit 
        } ;
      a1  : Polarity => Str ; -- ne-pas
      c1  : Str ;             -- le
      c2  : Str ;             -- lui
      n2  : Agr => Str ;      -- content(e) ; à ma mère
      a2  : Str ;             -- hier
      ext : Str ;             -- que je dors
      } ;
    Comp = {s : Agr => Str} ; 
    SC = {s : Str} ;


-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN      = {s : Number => Str ; g : Gender} ;
    NP,Pron = {s : NPForm => Str ; a : Agr ; c : ClitType} ;
    Det     = {s : Gender => Case => Str ; n : Number} ;
    QuantSg = {s : Gender => Case => Str} ;
    QuantPl = {s : Gender => Case => Str} ;
    Predet  = {s : AAgr   => Str} ;
    Num     = {s : Gender => Str} ;
    Ord     = {s : AAgr   => Str} ;

-- Adverb

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;

-- Numeral

----    Numeral = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj  = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    PConj = {s : Str} ;    
    CAdv  = {s : Str} ;    
    Subj  = {s : Str ; m : Mood} ;
    Prep  = {s : Str} ;

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

  oper
    Noun = {s : Number => Str ; g : Gender} ;
    Verb = {s : VF => Str ; aux : VAux ; isRefl : Bool} ;

}
