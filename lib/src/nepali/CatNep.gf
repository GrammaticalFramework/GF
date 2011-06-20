concrete CatNep of Cat = CommonX - [Adv] ** open ResNep, Prelude in {

  flags optimize=all_subs ;

  lincat
----- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
    SSlash = {s : Str ; c2 : ResNep.Compl} ;

---- Sentence

    Cl = ResNep.Clause ;

    ClSlash = {
      s : ResNep.VPHTense => Polarity => Order => Str ;
      c2 : ResNep.Compl
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question

    QCl = {s : ResNep.VPHTense => Polarity => QForm => Str} ;
    IP = {s: Case => Str  ; n : Number} ;
    IDet = {s : Gender => Str ; n : Number} ;
    --IDet = {s : Str ; n : Number} ;
    IQuant = {s : Number => Str} ;

---- Relative

    RCl = {
      s : ResNep.VPHTense => Polarity => Order => Agr => Str ; 
      c : Case
      } ;
    --RP = {s: Number => Case => Str ; a:RAgr};
    RP = {s: Case => Str ; a:RAgr};

---- Verb

    VP = ResNep.VPH ;
    VPSlash = ResNep.VPHSlash ;
    Comp = {s : Agr => Str ; t : NType} ;
    
---- Adv    
    Adv = {s : Str} ;

---- Adjective

    AP = ResNep.npAdjective ;

---- Noun

    CN = ResNep.Noun ;
    NP = ResNep.NP ;
    Pron = {s : Case => Str ; ps : Str ; a : Agr} ; -- ps genetive case
    Det = ResNep.Determiner ;
    Predet = {s : Str} ;
    Num  = {s : Str ; n : Number} ;
    Card = {s : Str; n : Number} ;
    Ord = {s : Str; n : Number} ;
    --Quant = {s : Number => Gender => Case => Str ; a:Agr}; -- ?? Number
    Quant = {s : Number => Gender => Str } ; -- ?? Number
    Art = {s : Str} ;

---- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number } ;

---- Structural

    Conj = {s1,s2 : Str ; n : Number} ;

-----b    Conj = {s : Str ; n : Number} ;
-----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str} ;

---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResNep.Verb ; -- = {s : VForm => Str} ;

    V2, V2A, V2Q, V2S = ResNep.Verb ** {c2 : Compl} ;

    V3 = ResNep.Verb ** {c2, c3 : Str} ;
    VV = ResNep.Verb ** {isAux : Bool} ;
    V2V = ResNep.Verb ** {c1 : Str ; c2 : Str ; isAux : Bool} ;

    A = ResNep.npAdjective ; --- {s : Gender => Number => Str} ;
    A2 = ResNep.npAdjective ** {c2 : Str} ;
    
    N = ResNep.Noun ;--{s : Number => Case => Str ; g : Gender ; t : NType ; h : NPerson} ;

    N2 = ResNep.Noun ** {c2 : Str ; c3 : Str} ;
    N3 = ResNep.Noun ** {c2 : Str ; c3 : Str ; c4 : Str} ;
    PN = {s : Case => Str ; g : Gender ; t : NType ; h : NPerson } ;
}
