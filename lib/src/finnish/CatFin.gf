--# -coding=latin1
concrete CatFin of Cat = CommonX ** open ResFin, StemFin, Prelude in {

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
    Imp   = {s : Polarity => Agr => Str} ;

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

    VP   = StemFin.VP ;
    VPSlash = StemFin.VP ** {c2 : Compl} ; 
    Comp = {s : Agr => Str} ; 

-- Adjective

-- The $Bool$ tells whether usage is modifying (as opposed to
-- predicative), e.g. "x on suurempi kuin y" vs. "y:tä suurempi luku".

    AP = {s : Bool => NForm => Str} ; 

-- Noun

-- The $Bool$ tells if a possessive suffix is attached, which affects the case.

    CN   = {s : NForm => Str ; h : Harmony} ;
    Pron = {s : NPForm => Str ; a : Agr ; hasPoss : Bool ; poss : Str} ;
    NP   = {s : NPForm => Str ; a : Agr ; isPron : Bool ; isNeg : Bool} ;
    Det  = {
      s1 : Case => Str ;       -- minun kolme
      s2 : Harmony => Str ;    -- -ni (Front for -nsä, Back for -nsa)
      sp : Case => Str ;       -- se   (substantival form)
      n : Number ;             -- Pl   (agreement feature for verb)
      isNum : Bool ;           -- True (a numeral is present)
      isPoss : Bool ;          -- True (a possessive suffix is present)
      isDef : Bool ;           -- True (verb agrees in Pl, Nom is not Part)
      isNeg : Bool             -- False (only True for "mikään", "kukaan")
      } ;
----    QuantSg, QuantPl = {s1 : Case => Str ; s2 : Str ; isPoss, isDef : Bool} ;
    Ord    = {s : NForm => Str} ;
    Predet = {s : Number => NPForm => Str} ;
    Quant  = {s1,sp : Number => Case => Str ; s2 : Harmony => Str ; isPoss : Bool ; isDef : Bool ; isNeg : Bool} ;
    Card   = {s : Number => Case => Str ; n : Number} ;
    Num    = {s : Number => Case => Str ; isNum : Bool ; n : Number} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = Compl ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ = SVerb1 ; 
    V2, VA, V2Q, V2S = SVerb1 ** {c2 : Compl} ;
    V2A = SVerb1 ** {c2, c3 : Compl} ;
    VV = SVerb1 ** {vi : VVType} ; ---- infinitive form
    V2V = SVerb1 ** {c2 : Compl ; vi : VVType} ; ---- infinitive form
    V3 = SVerb1 ** {c2, c3 : Compl} ;

    A  = {s : Degree => SAForm => Str ; h : Harmony} ;
    A2 = {s : Degree => SAForm => Str ; h : Harmony ; c2 : Compl} ;

    N  = SNoun ;
    N2 = SNoun ** {c2 : Compl ; isPre : Bool} ;
    N3 = SNoun ** {c2,c3 : Compl ; isPre,isPre2 : Bool} ;
    PN = SPN ;

  linref
    SSlash = \ss -> ss.s ++ ss.c2.s.p1  ;
    ClSlash = \cls -> cls.s ! Pres ! Simul ! Pos ++ cls.c2.s.p1 ;
    NP = \np -> np.s ! NPAcc ; ----NPSep ;

    VP = vpRef ;
    VPSlash = \vps -> vpRef vps ++ vps.c2.s.p1 ;

    V, VS, VQ, VA = \v -> vpRef (predV v) ;
    V2, V2A, V2Q, V2S = \v -> vpRef (predV v) ++ v.c2.s.p1 ;
    V3 = \v -> vpRef (predV v) ++ v.c2.s.p1 ++ v.c3.s.p1 ;
    VV = \v -> vpRef (predV v) ;
    V2V = \v -> vpRef (predV v) ++ v.c2.s.p1 ;

    Conj = \c -> c.s1 ++ c.s2 ;

  oper
   vpRef : StemFin.VP -> Str = \vp -> infVP SCNom Pos (agrP3 Sg) vp Inf1 ;

}
