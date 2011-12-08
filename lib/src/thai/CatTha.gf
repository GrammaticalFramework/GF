concrete CatTha of Cat = CommonX ** open ResTha, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Str} ;
    SSlash  = {s : Str ; c2 : Str} ;

-- Sentence

    Cl = ResTha.Clause ; -- {s : Polarity => Str} ;
    ClSlash = {s : Polarity => Str ; c2 : Str} ;
    Imp = {s : Polarity => Str} ;

-- Question

    QCl = {s : Polarity => Str} ;
    IP = {s : Str} ;
    IComp = {s : Str} ;    
    IDet, IQuant = Determiner ;

-- Relative

    RCl = {s : Polarity => Str} ;
    RP = {s : Str} ;

-- Verb

    VP = ResTha.VP ; 
    Comp = {s : Polarity => Str} ;
    VPSlash = ResTha.VP ** {c2 : Str} ;

-- Adjective

    AP = ResTha.Adj ;

-- Noun

    CN = ResTha.Noun ;
    NP, Pron = ResTha.NP ;
    Det, Quant = ResTha.Determiner ; 
    Predet = {s1,s2 : Str} ;
    Ord = {s : Str} ;
    Num = {s : Str ; hasC : Bool} ;

-- Numeral

    Numeral, Card, Digits = {s : Str} ;

-- Structural

    Conj = {s1,s2 : Str} ;
    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; 
    V2, V2Q, V2S = Verb ** {c2 : Str} ;
    V3, V2A, V2V = Verb ** {c2, c3 : Str} ;
    VV = VVerb ;

    A = ResTha.Adj ;
    A2 = ResTha.Adj ** {c2 : Str} ;

    N = ResTha.Noun ;
    N2 = ResTha.Noun ** {c2 : Str} ;
    N3 = ResTha.Noun ** {c2,c3 : Str} ;
    PN = ResTha.NP ;

}
