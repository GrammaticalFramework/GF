concrete CatUrd of Cat = CommonX ** open ResUrd, Prelude in {

  flags optimize=all_subs ;

  lincat
------ Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
    SSlash = {s : Str ; c2 : ResUrd.Compl} ;

---- Sentence

    Cl = ResUrd.Clause ;
    ClSlash = {
      s : ResUrd.VPHTense => Polarity => Order => Str ;
      c2 : ResUrd.Compl
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question
    QCl = {s : ResUrd.VPHTense => Polarity => QForm => Str} ;
    IP = {s: Case => Str ; g : Gender ; n : Number};
    IDet = {s :Gender => Str ; n : Number} ;
    IQuant = {s : Number => Str} ;

---- Relative

    RCl = {
      s : ResUrd.VPHTense => Polarity => Order => Agr => Str ; 
      c : Case
      } ;
    RP = {s: Number => Case => Str ; a:RAgr};

---- Verb

    VP = ResUrd.VPH ;
    VPSlash = ResUrd.VPHSlash ;
    Comp = {s : Agr => Str} ; 

---- Adjective

    AP = ResUrd.Adjective ;

---- Noun

    CN = ResUrd.Noun ;
    NP = ResUrd.NP ;
    Pron = {s : Case => Str ; ps : Str ; a : Agr};
    Det = ResUrd.Determiner ;
    Predet = {s : Str} ;
    Num  = {s : Str ; n : Number} ;
    Card = {s : Str; n : Number} ;
    Ord = {s : Str; n : Number} ;
    Quant = {s:Number => Gender => Case => Str ; a:Agr};
    Art = {s : Str} ;

---- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number } ;

---- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
-----b    Conj = {s : Str ; n : Number} ;
-----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = ResUrd.Preposition;
---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResUrd.Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = ResUrd.Verb ** {c2 : Compl} ;
    V3 = ResUrd.Verb ** {c2, c3 : Str} ;
    VV = ResUrd.Verb ** { isAux : Bool} ;
    V2V = ResUrd.Verb ** {c1 : Str ; c2 : Str ; isAux : Bool} ;
    A = ResUrd.Adjective ; --- {s : Gender => Number => Case => Str} ;
    A2 = {s : Number => Gender => Case => Degree => Str ; c2 : Str} ;
    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str } ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str ; c4 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
