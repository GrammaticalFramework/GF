concrete CatFin of Cat = TenseX ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Phrase

    Text, Phr, Utt, Voc = {s : Str} ;

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : Str} ;
    RS = {s : Agr => Str} ;

-- Sentence

    Cl    = {s : Tense => Anteriority => Polarity => SType => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Str ; c2 : Compl} ;
    Imp   = {s : Polarity => Number => Str} ;

-- Question

    QCl   = {s : Tense => Anteriority => Polarity => Str} ;
    IP    = {s : NPForm => Str ; n : Number} ;
    IAdv  = {s : Str} ;    
    IDet  = {s : Case => Str ; n : Number} ;

-- Relative

    RCl   = {s : Tense => Anteriority => Polarity => Agr => Str} ;
    RP    = {s : Number => Case => Str ; a : RAgr} ;

-- Verb

    VP = {
      s  : Tense => Anteriority => Polarity => Agr => {fin, inf : Str} ; 
      s2 : Agr => Str
      } ;
    Comp = {s : Agr => Str} ; 
    SC   = {s : Str} ;

-- Adjective

    AP   = {s : Bool => AForm => Str} ; 

-- Noun

    CN   = {s : Bool => Number => Case => Str} ;
    Pron = {s : NPForm => Str ; a : Agr} ;
    NP   = {s : NPForm => Str ; a : Agr} ;
    Det  = {s : Case => Str ; n : Number ; isNum : Bool} ;
    QuantSg, QuantPl = {s : Case => Str} ;
    Predet, Quant, Ord = {s : Number => Case => Str} ;
    Num = {s : Number => Case => Str ; isNum : Bool} ;

-- Adverb

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    PConj = {s : Str} ;    
    CAdv = {s : Str} ;    
    Subj = {s : Str} ;
    Prep = Compl ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb1 ; -- = {s : VForm => Str ; sc : Case} ;
    V2 = Verb1 ** {c2 : Compl} ;
    V2A = Verb1 ** {c2, c3 : Compl} ;
    VV = Verb1 ; ---- infinitive form
    V3 = Verb1 ** {c2, c3 : Compl} ;

    A = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = {s : NForm => Str} ;
    N2 = {s : NForm => Str} ** {c2 : Compl} ;
    N3 = {s : NForm => Str} ** {c2,c3 : Compl} ;
    PN = {s : Case  => Str} ;

oper Verb1 = {s : VForm => Str ; sc : NPForm} ;

}
