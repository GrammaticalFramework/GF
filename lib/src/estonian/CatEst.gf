concrete CatEst of Cat = CommonX ** open HjkEst, ResEst, Prelude in {

  flags optimize=all_subs ; coding=utf8;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ; --TODO {s : Order => Str}, like in German?
    QS = {s : Str} ;
    RS = {s : Agr => Str ; c : NPForm} ;
    SSlash = {s : Str ; c2 : Compl} ;

-- Sentence

    Cl    = {s : ResEst.Tense => Anteriority => Polarity => SType => Str} ;
    ClSlash = {s : ResEst.Tense => Anteriority => Polarity => Str ; c2 : Compl} ;
    Imp   = {s : Polarity => Agr => Str} ;

-- Question

    QCl    = {s : ResEst.Tense => Anteriority => Polarity => Str} ;
    IP     = {s : NPForm => Str ; n : Number} ;
    IComp  = {s : Agr => Str} ; 
    IDet   = {s : Case => Str ; n : Number ; isNum : Bool} ;
    IQuant = {s : Number => Case => Str} ;

-- Relative

    RCl   = {s : ResEst.Tense => Anteriority => Polarity => Agr => Str ; c : NPForm} ;
    RP    = {s : Number => NPForm => Str ; a : RAgr} ;

-- Verb

    VP   = ResEst.VP ;
    VPSlash = ResEst.VP ** {c2 : Compl} ; 
    Comp = {s : Agr => Str} ; 

-- Adjective

-- The $Bool$ in s tells whether usage is modifying (as opposed to
-- predicative), e.g. "x on suurem kui y" vs. "y:st suurem arv".
-- The $Infl$ in infl tells whether the adjective inflects as a 
-- modifier: e.g. "väsinud mehele" vs. "mees muutus väsinuks".

    AP = {s : Bool => NForm => Str ; infl : Infl} ; 

-- Noun

    CN   = {s : NForm => Str} ;
    Pron = {s : NPForm => Str ; a : Agr} ;
    NP   = {s : NPForm => Str ; a : Agr ; isPron : Bool} ;
    Det  = {
      s : Case => Str ;       -- minun kolme
      sp : Case => Str ;       -- se   (substantival form)
      n : Number ;             -- Pl   (agreement feature for verb)
      isNum : Bool ;           -- True (a numeral is present)
      isDef : Bool             -- True (verb agrees in Pl, Nom is not Part) --I: actually, can we get rid of this? 
      } ;
----    QuantSg, QuantPl = {s : Case => Str ;  isDef : Bool} ;
    Ord    = {s : NForm => Str} ;
    Predet = {s : Number => NPForm => Str} ;
    Quant  = {s,sp : Number => Case => Str ; isDef : Bool} ;
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

    V, VS, VQ = Verb1 ; -- = {s : VForm => Str ; sc : Case} ;
    V2, VA, V2Q, V2S = Verb1 ** {c2 : Compl} ;
    V2A = Verb1 ** {c2, c3 : Compl} ;
    VV = Verb1 ** {vi : InfForm} ; ---- infinitive form
    V2V = Verb1 ** {c2 : Compl ; vi : InfForm} ; ---- infinitive form
    V3 = Verb1 ** {c2, c3 : Compl} ;

    A  = Adjective ** {infl : Infl} ;
    A2 = A ** {c2 : Compl} ;

    N  = Noun  ;
    N2 = CommonNoun ** {c2 : Compl ; isPre : Bool ; lock_N2 : {}} ;
    N3 = CommonNoun ** {c2,c3 : Compl ; isPre,isPre2 : Bool ; lock_N3 : {}} ;
    PN = {s : Case  => Str} ;

oper Verb1 = Verb ** { sc : NPForm} ; --what is this for? --subject case, i.e. "ma näen kassi"/"mul on kass"


}
