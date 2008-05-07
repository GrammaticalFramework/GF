concrete CatHin of Cat = CommonX ** open ResHin, Prelude in {

  flags optimize=all_subs ;

  lincat
--
---- Tensed/Untensed
--
--    S  = {s : Str} ;
--    QS = {s : QForm => Str} ;
--    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
--    SSlash = {s : Str ; c2 : Str} ;
--
---- Sentence
--
    Cl = ResHin.Clause ;
--    ClSlash = {
--      s : ResHin.Tense => Anteriority => CPolarity => Order => Str ;
--      c2 : Str
--      } ;
--    Imp = {s : CPolarity => ImpForm => Str} ;
--
---- Question
--
--    QCl = {s : ResHin.Tense => Anteriority => CPolarity => QForm => Str} ;
--    IP = {s : Case => Str ; n : Number} ;
--    IComp = {s : Str} ;    
--    IDet = {s : Str ; n : Number} ;
--    IQuant = {s : Number => Str} ;
--
---- Relative
--
--    RCl = {
--      s : ResHin.Tense => Anteriority => CPolarity => Agr => Str ; 
--      c : Case
--      } ;
--    RP = {s : RCase => Str ; a : RAgr} ;
--
---- Verb
--
    VP = ResHin.VPH ;
    VPSlash = ResHin.VPHSlash ;
--    Comp = {s : Agr => Str} ; 
--
---- Adjective
--
    AP = ResHin.Adjective ;
--
---- Noun
--
    CN = ResHin.Noun ;
    NP, Pron = ResHin.NP ;
--    Det = {s : Str ; n : Number} ;
--    Predet, Ord = {s : Str} ;
--    Num  = {s : Str; n : Number ; hasCard : Bool} ;
--    Card = {s : Str; n : Number} ;
--    Quant = {s : Number => Str} ;
--    Art = {s : Bool => Number => Str} ;
--
---- Numeral
--
--    Numeral = {s : CardOrd => Str ; n : Number} ;
--    Digits  = {s : CardOrd => Str ; n : Number ; tail : DTail} ;
--
---- Structural
--
--    Conj = {s1,s2 : Str ; n : Number} ;
-----b    Conj = {s : Str ; n : Number} ;
-----b    DConj = {s1,s2 : Str ; n : Number} ;
--    Subj = {s : Str} ;
--    Prep = {s : Str} ;
--
---- Open lexical classes, e.g. Lexicon
--
    V, VS, VQ, VA = Verb ; -- = {s : VForm => Str} ;
    V2, V2A, V2Q, V2S = Verb ** {c2 : Compl} ;
--    V3 = Verb ** {c2, c3 : Str} ;
--    VV = {s : VVForm => Str ; isAux : Bool} ;
--    V2V = Verb ** {c2 : Str ; isAux : Bool} ;
--
    A = ResHin.Adjective ; --- {s : Gender => Number => Case => Str} ;
--    A2 = {s : AForm => Str ; c2 : Str} ;
--
    N = {s : Number => Case => Str ; g : Gender} ;
--    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Str} ;
--    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;
--
}
