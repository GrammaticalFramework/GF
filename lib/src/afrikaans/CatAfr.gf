concrete CatAfr of Cat = 
  CommonX **
  open ResAfr, Prelude in {
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

    QCl = {s : ResAfr.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : NPCase => Str ; n : Number} ;
    IComp  = {s : Agr => Str} ; 
    IDet   = {s : Gender => Str ; n : Number} ;
    IQuant = {s : Number => Gender => Str} ;

-- Relative

    RCl = {s : ResAfr.Tense => Anteriority => Polarity => Gender => Number => Str} ;
    RP = {s : Gender => Number => Str ; a : RAgr} ;

-- Verb

    VP = ResAfr.VP ;
    VPSlash = ResAfr.VP ** {c2 : Preposition} ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN = {s : Adjf => NForm => Str ; g : Gender} ;
    NP = {s : NPCase => Str ; a : Agr ; isPron : Bool} ;
    Pron = Pronoun ;

    Det = {s,sp : Gender => Str ; n : Number ; a : Adjf} ;
    Quant = {
      s  : Bool => Number => Gender => Str ; 
      sp : Number => Gender => Str ; 
      a  : Adjf
      } ;
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
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResAfr.VVerb ;
    VV = VVerb ** {isAux : Bool} ;
    V2, V2A, V2S, V2Q = VVerb ** {c2 : Preposition} ;
    V2V = VVerb ** {c2 : Preposition ; isAux : Bool} ;
    V3 = VVerb ** {c2, c3 : Preposition} ;

    A  = Adjective ;
    A2 = Adjective ** {c2 : Preposition} ;

    N  = Noun ;
    N2 = {s : NForm => Str ; g : Gender} ** {c2 : Preposition} ;
    N3 = {s : NForm => Str ; g : Gender} ** {c2,c3 : Preposition} ;
    PN = {s : NPCase => Str} ;

}
