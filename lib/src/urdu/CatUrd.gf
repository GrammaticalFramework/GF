concrete CatUrd of Cat = CommonX ** open ResUrd, Prelude in {

  flags optimize=all_subs ;

  lincat
------ Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
--      RS = { s: Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
--    SSlash = {s : Str ; c2 : Str} ;

---- Sentence

--      Cl = Str;
    Cl = ResUrd.Clause ;
    ClSlash = {
      s : ResUrd.VPHTense => Polarity => Order => Str ;
--      s : ResUrd.Tense => Anteriority => CPolarity => Order => Str ;
      c2 : ResUrd.Compl
--      c2 : Str
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question
     QCl = {s : ResUrd.VPHTense => Polarity => QForm => Str} ;
--    QCl = {s : ResUrd.Tense => Anteriority => CPolarity => QForm => Str} ;
    IP = {s: Case => Str ; g : Gender ; n : Number};
--    IP = {s : Number => Case => Str} ;
--    IComp = {s : Str} ;    
    IDet = {s :Gender => Str ; n : Number} ;
--    IQuant = {s : Number => Str} ;

---- Relative

    RCl = {
      s : ResUrd.VPHTense => Polarity => Order => Agr => Str ; 
      c : Case
      } ;
    RP = {s: Number => Case => Str ; a:RAgr};
--    RP = {s : RCase => Str ; a : RAgr} ;

---- Verb
--      VP = ResUrd.Verb;
    VP = ResUrd.VPH ;
    VPSlash = ResUrd.VPHSlash ;
    Comp = {s : Agr => Str} ; 

---- Adjective

    AP = ResUrd.Adjective ;
--      AP = {s: Number => Gender => Case = Str}; 
---- Noun

    CN = ResUrd.Noun ;
    NP = ResUrd.NP ;
	Pron = {s : PersPronForm => Str; a : Agr} ;
--    Pron = {s : PronCase => Str ; a : Agr} ;
      Det = {s:Determiner => Str ; n : Number};
--    Det = {s : Gender => Case => Str ; n : Number} ;

    Predet, Ord = {s : Str} ;
      Num = Str;
--    Num  = {s : Str ; n : Number} ;
--    Card = {s : Str; n : Number} ;
    Quant = {s:DemPronForm => Str ; a : Agr};
--    Quant = {s : Number => Gender => Case => Str} ;
    Art = {s : Str} ;

---- Numeral

--    Numeral = {s : CardOrd => Str ; n : Number} ;
--    Digits  = {s : CardOrd => Str ; n : Number ; tail : DTail} ;

---- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
-----b    Conj = {s : Str ; n : Number} ;
-----b    DConj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Proposition => Str ; n : Number} ;

---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = ResUrd.Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = ResUrd.Verb ** {c2 : Compl} ;
--    V2, V2A, V2Q, V2S = ResUrd.Verb; -- ** {c2 : Str} ;
    V3 = ResUrd.Verb ** {c2, c3 : Str} ;
    VV = ResUrd.Verb ** { isAux : Bool} ;
--    VV = {s : VVForm => Str ; isAux : Bool} ;
    V2V = ResUrd.Verb ** {c1 : Str ; c2 : Str ; isAux : Bool} ;

    A = ResUrd.Adjective ; --- {s : Gender => Number => Case => Str} ;
    A2 = {s : Number => Gender => Case => Degree => Str ; c2 : Str} ;

    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Proposition => Str} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2 : Proposition => Str ; c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;
--
}
