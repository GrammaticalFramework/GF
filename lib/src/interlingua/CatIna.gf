concrete CatIna of Cat = CommonX ** open ResIna, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : Order => Str} ; -- order is necessary to embed a "semantical" question into other propositions.
    RS = {s : Agr => Str} ;
    SSlash = SS **  {p2 : Str; c2 : Case} ;

-- Sentence

    Cl = ResIna.Clause;
    ClSlash = ResIna.Clause ** {p2 : Str; c2 : Case} ;
    Imp = {s : Polarity => Number => Str} ;

-- Question

    QCl = ResIna.Clause;
    IP = {s : Case => Str; n : Number} ;
    IComp = {s : Str} ;    
    IQuant = {s : Number => Str} ;
    IDet = {s : Str ; n : Number} ;

-- Relative

    RCl = {s : Bool => ResIna.Tense => Anteriority => Polarity => Agr => Str ; c : Case} ;
    RP = {s : Case => Str; a : Agr} ; -- number for "tal que / tales que"; person for reflexives

-- Verb

    VP = ResIna.VP;
    VPSlash = ResIna.VP ** {p2 : Str; c2 : Case} ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : Agr => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Number => Str} ;
    NP = ResIna.NP;
    Pron = ResIna.NP ** {possForm : Str};
    Det = {s : Case => Str ; n : Number} ;
    Predet, Ord = {s : Str};
    Card = {s : Str; n : Number } ;
    Num = {s : Str; n : Number } ;
    Quant = {s : Number => Case => Str} ;

-- Numeral
    
    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number ; tail : DTail} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {c : Case; s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, V2V, V2S, V2Q = 
      Verb ** {p2 : Str; c2 : Case} ; -- preposition + case of the complement.
    V3, V2A = Verb ** {p2, p3 : Str; c2, c3 : Case} ;
    VV = Verb;

    A  = {s : AForm => Str} ; -- TODO: optional pre-adjectives
    A2 = {s : AForm => Str ; c2 : Str} ;

    N  = {s : Number => Str} ;
    N2 = {s : Number => Str} ** {p2 : Str; c2 : Case} ;
    N3 = {s : Number => Str} ** {p2,p3 : Str; c2,c3 : Case} ;

    PN = {s : Str} ;

}
