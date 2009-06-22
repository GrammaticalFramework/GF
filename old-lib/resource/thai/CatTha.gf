concrete CatTha of Cat = CommonX ** open ResTha, Prelude in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
--    RS = {s : Agr => Str ; c : Case} ; -- c for it clefts
--
---- Sentence
--
    Cl = {s : Polarity => Str} ;
--    Slash = {
--      s : Tense => Anteriority => CPolarity => Order => Str ;
--      c2 : Str
--      } ;
    Imp = {s : Polarity => Str} ;
--
---- Question
--
    QCl = {s : Polarity => Str} ;
--    IP = {s : Case => Str ; n : Number} ;
--    IComp = {s : Str} ;    
--    IDet = {s : Str ; n : Number} ;
--
---- Relative
--
--    RCl = {s : Tense => Anteriority => CPolarity => Agr => Str ; c : Case} ;
--    RP = {s : RCase => Str ; a : RAgr} ;
--
---- Verb
--
    VP = ResTha.VP ; 
    Comp = ResTha.VP ; 
--
---- Adjective
--
--    AP = {s : Agr => Str ; isPre : Bool} ; 
--
-- Noun
--
    CN = Noun ;
    NP, Pron = SS ;
    Det = Determiner ; 
--    Predet, Ord = {s : Str} ;
    Num, Quant = {s : Str ; hasC : Bool} ;

-- Numeral

    Numeral = {s : Str} ;

---- Structural
--
--    Conj = {s : Str ; n : Number} ;
--    DConj = {s1,s2 : Str ; n : Number} ;
--    Subj = {s : Str} ;
--    Prep = {s : Str} ;
--
-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ; 
    V2, V2A = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2, c3 : Str} ;
    VV = VVerb ;
--
--    A = {s : AForm => Str} ;
--    A2 = {s : AForm => Str ; c2 : Str} ;
--
    N = Noun ;
--    N2 = {s : Number => Case => Str} ** {c2 : Str} ;
--    N3 = {s : Number => Case => Str} ** {c2,c3 : Str} ;
--    PN = {s : Case => Str} ;
--
}
