concrete CatFin of Cat = CommonX - [Adv] ** open ResFin, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : Str} ;
    RS = {s : Agr => Str ; c : NPForm} ;

-- Sentence

    Cl    = {s : Tense => Anteriority => Polarity => SType => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Str ; c2 : Compl} ;
    Imp   = {s : Polarity => Number => Str} ;

-- Question

    QCl   = {s : Tense => Anteriority => Polarity => Str} ;
    IP    = {s : NPForm => Str ; n : Number} ;
    IComp = {s : Agr => Str} ; 
    IDet  = {s : Case => Str ; n : Number} ;

-- Relative

    RCl   = {s : Tense => Anteriority => Polarity => Agr => Str ; c : NPForm} ;
    RP    = {s : Number => NPForm => Str ; a : RAgr} ;

-- Verb

    VP   = ResFin.VP ;
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
    QuantSg, QuantPl = {s1 : Case => Str ; s2 : Str ; isPoss, isDef : Bool} ;
    Ord = {s : Number => Case => Str} ;
    Predet = {s : Number => NPForm => Str} ;
    Quant = {s1 : Number => Case => Str ; s2 : Str ; isPoss, isDef : Bool} ;
    Num = {s : Number => Case => Str ; isNum : Bool} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V = ResFin.V ;
    V2 = ResFin.V2 ;
    VA = ResFin.VA ;
    VS = ResFin.VS ;
    VQ = ResFin.VQ ;
    V2A = ResFin.V2A ;
    VV = ResFin.VV ;
    V3 = ResFin.V3 ;

    A  = ResFin.A ;
    A2 = ResFin.A2 ;

    N  = ResFin.N ;
    N2 = ResFin.N2 ;
    N3 = ResFin.N3 ;
    PN = ResFin.PN ;

    Adv = ResFin.Adv ;
    Prep = ResFin.Prep ;


}
