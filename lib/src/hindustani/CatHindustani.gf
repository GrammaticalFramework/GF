--concrete CatUrd of Cat = CommonX - [Adv,AdN] ** open ResUrd, Prelude in {
incomplete concrete CatHindustani of Cat = 
  CommonX - [Adv,AdN,SC]** open ResHindustani, Prelude, CommonHindustani,  (R = ParamX) in {

  flags optimize=all_subs ;

  lincat
------ Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
    SSlash = {s : Str ; c2 : ResHindustani.Compl} ;
    SC  = {s : Str ; fromVP : Bool} ;

---- Sentence

    Cl = ResHindustani.Clause ;
    ClSlash = {
      s : CommonHindustani.VPHTense => Polarity => Order => Str ;
      c2 : ResHindustani.Compl
      } ;
    Imp = {s : CPolarity => ImpForm => Str} ;

---- Question
    QCl = {s : CommonHindustani.VPHTense => Polarity => QForm => Str} ;
    IP = {s: Case => Str ; g : Gender ; n : Number};
    IDet = {s :Gender => Case => Str ; n : Number} ;
--  IQuant = {s : Number => Str} ;
    IQuant = {s : Number => Gender => Case => Str} ;

---- Relative

    RCl = {
      s : CommonHindustani.VPHTense => Polarity => Order => Agr => Str ; 
      c : Case
      } ;
    RP = {s: Number => Case => Str ; a:RAgr};

---- Verb

    VP = VPH ;
    VPSlash = ResHindustani.VPHSlash ;
    Comp = {s : Agr => Str} ;
---- Adverb
    Adv = {s : Gender => Str } ;
    
----- AdN
    AdN = {s : Str ; p : Bool} ;

---- Adjective

    AP = CommonHindustani.Adjective ;

---- Noun

    CN = ResHindustani.Noun ;
    NP = CommonHindustani.NP ;
 --   Pron = {s : Case => Str ; ps : Str ; gs : Str ; a : Agr};
    Pron = {s : Case => Str ; ps : Number => Gender => Str ; a : Agr};
    Det = ResHindustani.Determiner ;
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
    Prep = ResHindustani.Preposition;
---- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = Verb ** {c2 : Compl} ;
    V3 = Verb ** {c2, c3 : Str} ;
    VV = Verb ** { isAux : Bool} ;
    V2V = Verb ** {c1 : Str ; c2 : Str ; isAux : Bool} ;
    A = CommonHindustani.Adjective ; --- {s : Gender => Number => Case => Str} ;
    A2 = {s : Number => Gender => Case => Degree => Str ; c2 : Str} ;
    N = {s : Number => Case => Str ; g : Gender} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str } ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str ; c3 : Str ; c4 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
