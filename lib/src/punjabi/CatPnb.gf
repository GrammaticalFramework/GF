concrete CatPnb of Cat = CommonX - [Adv] ** open ResPnb, Prelude in {

  flags optimize=all_subs ;

  lincat
------ Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
    SSlash = {s : Str ; c2 : ResPnb.Compl} ;

---- Sentence

    Cl = ResPnb.Clause ;
    ClSlash = {
      s : ResPnb.VPHTense => Polarity => Order => Str ;
      c2 : ResPnb.Compl
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question
    QCl = {s : ResPnb.VPHTense => Polarity => QForm => Str} ;
    IP = {s: Case => Str ; g : Gender ; n : Number};
    IDet = {s :Gender => Str ; n : Number} ;
    IQuant = {s : Number => Gender => Str} ;

---- Relative

    RCl = {
      s : ResPnb.VPHTense => Polarity => Order => Agr => Str ; 
      c : Case
      } ;
    RP = {s: Number => Gender => Case => Str ; a:RAgr};

---- Verb

    VP = ResPnb.VPH ;
    VPSlash = ResPnb.VPHSlash ;
    Comp = {s : Agr => Str} ;
    
---- Adv    
    Adv = {s : Gender => Str} ;
---- Adjective

    AP = ResPnb.Adjective1 ;

---- Noun

    CN = ResPnb.Noun ;
    NP = ResPnb.NP ;
    Pron = {s : Case => Str ; ps : Str ; a : Agr};
    Det = ResPnb.Determiner ;
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
    Prep = ResPnb.Preposition;
---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResPnb.Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = ResPnb.Verb ** {c2 : Compl} ;
    V3 = ResPnb.Verb ** {c2, c3 : Str} ;
    VV = ResPnb.Verb ** { isAux : Bool} ;
    V2V = ResPnb.Verb ** {c1 : Str ; c2 : Str ; isAux : Bool} ;
    A = ResPnb.Adjective1 ; --- {s : Gender => Number => Case => Str} ;
    A2 = ResPnb.Adjective1 ** { c2 : Str} ;
    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str } ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str ; c4 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
