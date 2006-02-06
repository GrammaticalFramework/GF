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
    RP    = {s : Number => NPForm => Str ; a : RAgr} ;

-- Verb

    VP   = ResFin.VP ;
    Comp = {s : Agr => Str} ; 
    SC   = {s : Str} ;

-- Adjective

-- The $Bool$ tells whether usage is modifying (as opposed to
-- predicative), e.g. "x on suurempi kuin y" vs. "y:tä suurempi luku".

    AP   = {s : Bool => AForm => Str} ; 

-- Noun

-- The $Bool$ tells if a possessive suffix is attached, which affects the case.

    CN   = {s : NForm => Str} ;
    Pron = {s : NPForm => Str ; a : Agr} ;
    NP   = {s : NPForm => Str ; a : Agr ; isPron : Bool} ;
    Det  = {
      s1 : Case => Str ;       -- minun kolme
      s2 : Str ;               -- -ni
      n : Number ;             -- Pl   (agreement feature for verb)
      isNum : Bool ;           -- True (a numeral is present)
      isPoss : Bool            -- True (a possessive suffix is present)
      } ;
    QuantSg, QuantPl = {s1 : Case => Str ; s2 : Str ; isPoss : Bool} ;
    Predet, Ord = {s : Number => Case => Str} ;
    Quant = {s1 : Number => Case => Str ; s2 : Str ; isPoss : Bool} ;
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
