concrete CatDut of Cat = 
  CommonX **
  open ResDut, Prelude in {
  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Gender => Number => Str} ;
    SSlash = {s : Order => Str} ** {c2 : Preposition} ;

-- Sentence

    Cl = Clause ; -- {s : Tense => Anteriority => Polarity => Order => Str} ;
    ClSlash = Clause ** {c2 : Preposition} ;
    Imp = {s : Polarity => ImpForm => Str} ;

-- Question

    QCl = {s : ResDut.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = MergesWithPrep ** {s : NPCase => Str ; n : Number} ; -- met wat -> waarmee
    IComp  = {s : Agr => Str} ; 
    IDet   = MergesWithPrep ** {s : Gender => Str ; n : Number} ;
    IQuant = MergesWithPrep ** {s : Number => Gender => Str} ;

-- Relative

    RCl = {s : ResDut.Tense => Anteriority => Polarity => Gender => Number => Str} ;
    RP = {s : Gender => Number => Str ; a : RAgr} ;

-- Verb

    VP = ResDut.VP ;
    VPSlash = ResDut.VP ** {c2 : Preposition * Bool} ; -- False = empty prep
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : Agr => AForm => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Adjf => NForm => Str ; g : Gender} ;
    NP = NounPhrase ; 

    Pron = Pronoun ;

    Det = Determiner ;
    Quant = Quantifier ;
    Predet = {s : Number => Gender => Str} ;
    Num = {s : Str ; n : Number ; isNum : Bool} ;
    Card = {s : Gender => Case => Str ; n : Number} ;
    Ord = {s : AForm => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number } ;
    Digits = {s : CardOrd => Str ; n : Number } ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = Preposition ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResDut.VVerb ;
    VV = VVerb ** {isAux : Bool} ;
    V2, V2A, V2S, V2Q = VVerb ** {c2 : Preposition * Bool} ;
    V2V = VVerb ** {c2 : Preposition * Bool ; isAux : Bool} ;
    V3 = VVerb ** {c2, c3 : Preposition * Bool} ;
    -- Preposition * Bool: True if there is a preposition (info needed for word order)

    A  = Adjective ;
    A2 = Adjective ** {c2 : Preposition} ;

    N  = Noun ;
    N2 = {s : NForm => Str ; g : Gender} ** {c2 : Preposition} ;
    N3 = {s : NForm => Str ; g : Gender} ** {c2,c3 : Preposition} ;
    PN = {s : NPCase => Str} ;

}
