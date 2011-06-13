concrete CatPes of Cat = CommonX - [Adv] ** open ResPes, Prelude in {

  flags optimize=all_subs ;

  lincat
------ Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : AgrPes => Str } ; -- c for it clefts
    SSlash = {s : Str ; c2 : ResPes.Compl} ;

---- Sentence

    Cl = ResPes.Clause ;
    ClSlash = {
      s : ResPes.VPHTense => Polarity => Order => Str ;
      c2 : ResPes.Compl
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question
    QCl = {s : ResPes.VPHTense => Polarity => QForm => Str} ;
    
    IP = {s: Str ; n : Number};
    
--    IDet = {s :Number => Str } ;
      IDet = {s : Str ; n : Number ; isNum : Bool} ;
    IQuant = {s : Str ; n : Number } ;

---- Relative

    RCl = {
      s : ResPes.VPHTense => Polarity => Order => AgrPes => Str ; 
    --  c : Case
      } ;
    RP = {s: Str ; a:RAgr};

---- Verb

    VP = ResPes.VPH ;

    VPSlash = ResPes.VPHSlash ;
    Comp = {s : AgrPes => Str} ;
  
---- Adv    
    Adv = {s : Str} ;

---- Adjective

    AP = ResPes.Adjective ;

---- Noun

    CN = ResPes.Noun ;

    NP = ResPes.NP ;
    Pron = {s : Str ; ps : Str ; a : AgrPes};
    Det = ResPes.Determiner ;
    Predet = {s : Str} ;
    Num  = {s : Str ; n : Number} ;
    Card = {s : Str; n : Number} ;
    Ord = {s : Str; n : Number} ;
    Quant = {s: Number => Str ; a:AgrPes ; fromPron : Bool};
    Art = {s : Str} ;

---- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number } ;

---- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
-----b    Conj = {s : Str ; n : Number} ;
-----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str };
---- Open lexical classes, e.g. Lexicon
    V, VS, VQ, VA = ResPes.Verb ; -- = {s : VForm => Str} ;

    V2, V2A, V2Q, V2S = ResPes.Verb ** {c2 : Compl} ;
    V3 = ResPes.Verb ** {c2, c3 : Str} ;
    VV = ResPes.Verb ** { isAux : Bool} ;
    V2V = ResPes.Verb ** {c1 : Str ; c2 : Str  ; isAux : Bool} ;
    A = ResPes.Adjective ; --- {s : Gender => Number => Case => Str} ;
    A2 = ResPes.Adjective ** { c2 : Str} ;
    
    N = {s : Ezafa => Number => Str ; animacy : Animacy ; definitness : Bool} ;

    N2 = {s : Ezafa => Number  => Str ; animacy : Animacy ; definitness : Bool} ** {c : Str};
    N3 = {s : Ezafa => Number  => Str ; animacy : Animacy ; definitness : Bool} ** {c2 : Str ; c3 : Str } ;
    PN = {s : Str ; animacy : Animacy} ;

}
