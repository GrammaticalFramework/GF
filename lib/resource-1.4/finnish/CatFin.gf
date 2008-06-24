concrete CatFin of Cat = CommonX ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : Str} ;
    RS = {s : Agr => Str ; c : NPForm} ;
    SSlash = {s : Str ; c2 : Compl} ;

-- Sentence

    Cl    = {s : ResFin.Tense => Anteriority => Polarity => SType => Str} ;
    ClSlash = {s : ResFin.Tense => Anteriority => Polarity => Str ; c2 : Compl} ;
    Imp   = {s : Polarity => Number => Str} ;

-- Question

    QCl    = {s : ResFin.Tense => Anteriority => Polarity => Str} ;
    IP     = {s : NPForm => Str ; n : Number} ;
    IComp  = {s : Agr => Str} ; 
    IDet   = {s : Case => Str ; n : Number ; isNum : Bool} ;
    IQuant = {s : Number => Case => Str} ;

-- Relative

    RCl   = {s : ResFin.Tense => Anteriority => Polarity => Agr => Str ; c : NPForm} ;
    RP    = {s : Number => NPForm => Str ; a : RAgr} ;

-- Verb

    VP   = ResFin.VP ;
    VPSlash = ResFin.VP ** {c2 : Compl} ; 
    Comp = {s : Agr => Str} ; 

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
      isPoss : Bool ;          -- True (a possessive suffix is present)
      isDef : Bool             -- True (verb agrees in Pl, Nom is not Part)
      } ;
----    QuantSg, QuantPl = {s1 : Case => Str ; s2 : Str ; isPoss, isDef : Bool} ;
    Ord = {s : Number => Case => Str} ;
    Predet = {s : Number => NPForm => Str} ;
    Quant = {s1 : Number => Case => Str ; s2 : Str ; isPoss : Bool} ;
    Art   = {s1 : Number => Case => Str ; isDef : Bool} ;
    Card  = {s : Number => Case => Str ; n : Number} ;
    Num   = {s : Number => Case => Str ; isNum : Bool ; n : Number} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = Compl ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ = Verb1 ; -- = {s : VForm => Str ; sc : Case} ;
    V2, VA, V2Q, V2S = Verb1 ** {c2 : Compl} ;
    V2A = Verb1 ** {c2, c3 : Compl} ;
    VV = Verb1 ** {vi : InfForm} ; ---- infinitive form
    V2V = Verb1 ** {c2 : Compl ; vi : InfForm} ; ---- infinitive form
    V3 = Verb1 ** {c2, c3 : Compl} ;

    A  = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Compl} ;

    N  = {s : NForm => Str} ;
    N2 = {s : NForm => Str} ** {c2 : Compl ; isPre : Bool} ;
    N3 = {s : NForm => Str} ** {c2,c3 : Compl ; isPre,isPre2 : Bool} ;
    PN = {s : Case  => Str} ;

oper Verb1 = {s : VForm => Str ; sc : NPForm ; qp : Str} ;

}
