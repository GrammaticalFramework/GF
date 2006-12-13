concrete CatGer of Cat = CommonX ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : GenNum => Str ; c : Case} ;

-- Sentence

    Cl = {s : Tense => Anteriority => Polarity => Order => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Order => Str} ** 
            {c2 : Preposition} ;
    Imp = {s : Polarity => ImpForm => Str} ;

-- Question

    QCl = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : Case => Str ; n : Number} ;
    IComp = {s : Agr => Str} ; 
    IDet = {s : Gender => Case => Str ; n : Number} ;

-- Relative

    RCl = {s : Tense => Anteriority => Polarity => GenNum => Str ; c : Case} ;
    RP = {s : GenNum => Case => Str ; a : RAgr} ;

-- Verb

    VP = ResGer.VP ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Adjf => Number => Case => Str ; g : Gender} ;
    NP = {s : Case => Str ; a : Agr} ;
    Pron = {s : NPForm => Str ; a : Agr} ;
    Det = {s : Gender => Case => Str ; n : Number ; a : Adjf} ;
    QuantSg, QuantPl = {s : Gender => Case => Str ; a : Adjf} ;
    Quant = {s : Number => Gender => Case => Str ; a : Adjf} ;
    Predet = {s : Number => Gender => Case => Str} ;
    Num = {s : Str} ;
    Ord = {s : AForm => Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str} ;

-- Structural

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str ; c : Case} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResGer.Verb ; -- = {s : VForm => Str} ;
    VV = Verb ** {isAux : Bool} ;
    V2, V2A = Verb ** {c2 : Preposition} ;
    V3 = Verb ** {c2, c3 : Preposition} ;

    A  = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Preposition} ;

    N  = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Preposition} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Preposition} ;
    PN = {s : Case => Str} ;

}
