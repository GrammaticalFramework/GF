concrete CatChi of Cat = CommonX - [Tense, Temp, Adv] ** open ResChi, Prelude in {

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : Str} ;
    RS = {s : Str} ;
    SSlash = {s : Str ; c2 : Preposition} ; 

-- Sentence

    Cl = Clause ; -- {s : Polarity => Aspect => Str ; np: Str ; vp: Polarity => Aspect => Str} ; 

    ClSlash = Clause ** {c2 : Preposition} ;

    Imp = {s : Polarity => Str} ;

-- Question

    QCl = {s : Polarity => Aspect => Str} ; 
    IP = {s : Str} ;
    IComp = {s : Str} ;    
    IDet, IQuant = {s : Str} ;

-- Relative

    RCl = {s : Polarity => Aspect => Str} ;
    RP = {s : Str} ;

-- Verb

    VP = ResChi.VP ; 
    Comp = ResChi.VP ;
    VPSlash = ResChi.VP ** {c2 : Preposition ; isPre : Bool} ; -- whether the missing arg is before verb

-- Adjective

    AP = ResChi.Adj ;

-- Noun

    CN = ResChi.Noun ;
    NP, Pron = ResChi.NP ;
    Det = Determiner ;
    Quant = Determiner ** {pl : Str} ;
    Predet = {s : Str} ; ----
    Ord = {s : Str} ;
    Num = {s : Str ; numType : NumType} ;

    Adv = {s : Str ; advType : AdvType} ;

-- Numeral

    Numeral = {s,p : Str} ;
    Card, Digits = {s : Str} ;

-- Structural

    Conj = {s : ConjForm => {s1,s2 : Str}} ;    
    Subj = {prePart : Str ; sufPart : Str} ;
    Prep = Preposition ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; 
    V2, V2Q, V2S = Verb ** {c2 : Preposition} ;
    V3, V2A, V2V = Verb ** {c2, c3 : Preposition} ;
    VV = Verb ;

    A = ResChi.Adj ;
    A2 = ResChi.Adj ** {c2 : Preposition} ;

    N = ResChi.Noun ;
    N2 = ResChi.Noun ** {c2 : Preposition} ;
    N3 = ResChi.Noun ** {c2,c3 : Preposition} ;
    PN = ResChi.NP ;

-- overridden

    Temp  = {s : Str ; t : Aspect} ;
    Tense = {s : Str ; t : Aspect} ;


}
