concrete CatAra of Cat = CommonX - [Utt]  ** open ResAra, Prelude, ParamX in {

  flags optimize=all_subs ;

  lincat

-- Phrase

    Utt = {s : Gender => Str};

-- Tensed/Untensed

    S  = {s : Str} ;
    QS = {s : QForm => Str} ;
--    RS = {s : Agr => Str} ;

-- Sentence

    Cl = {s : ResAra.Tense => Polarity => Order => Str} ;
--    Slash = {s : Tense => Anteriority => Polarity => Order => Str} ** {c2 : Str} ;
    Imp = {s : Polarity => Gender => ResAra.Number => Str} ;

-- Question

    QCl = {s : ResAra.Tense => Polarity => QForm => Str} ;
    IP = {s : Str ; n : ResAra.Number} ;
--    IAdv = {s : Str} ;    
    IDet = {s : Case => Str ; n : ResAra.Number} ; ---- AR add Case
--
---- Relative
--
--    RCl = {s : Tense => Anteriority => Polarity => Agr => Str} ;
--    RP = {s : Case => Str ; a : RAgr} ;
--
-- Verb

    VP = ResAra.VP ;
    VPSlash = ResAra.VP ** {c2 : Str} ;
    Comp = ResAra.Comp ; --{s : AAgr => Case => Str} ; 
--    SC = {s : Str} ;
--
-- Adjective

    AP = {s : Species => Gender => NTable } ; 

-- Noun

    CN = ResAra.Noun ** {adj : NTable};
    NP, Pron = ResAra.NP; --{s : Case => Str ; a : Agr } ;
    Num, Ord, Card = {s : Gender => State => Case => Str ;
                n : Size };
    Predet = ResAra.Predet ;

-- DEPRECATED
--    QuantSg, QuantPl = 
--      {s : Species => Gender => Case => Str; 
--       n : ResAra.Number; 
--       d : State; 
--       isNum : Bool;
--       isPron : Bool} ;

    Det = ResAra.Det ;
--  {s : Species => Gender => Case => Str ; 
--   d : State; n : Size; isNum : Bool } ;
    Quant = {s : ResAra.Number => Species => Gender => Case => Str; 
             d : State;
             isNum : Bool;
             isPron: Bool} ;
    Art = {s : ResAra.Number => Species => Gender => Case => Str; 
             d : State} ;

-- Numeral

    Numeral = {s : CardOrd => Gender => State => Case => Str ; 
               n : Size } ;
    Digits = {s : Str;
              n : Size};

-- Structural

    Conj = {s : Str ; n : ResAra.Number} ;
--    DConj = {s1,s2 : Str ; n : ResAra.Number} ;
--    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon
    
    V, VS, VQ, VA = ResAra.Verb ; -- = {s : VForm => Str} ;
    V2, V2A = ResAra.Verb ** {c2 : Str} ;
    V2V, V2S, V2Q = ResAra.Verb ** {c2 : Str} ; --- AR
    V3 = ResAra.Verb ** {c2, c3 : Str} ;
--    VV = {s : VVForm => Str ; isAux : Bool} ;

    A = ResAra.Adj ;
    A2 = ResAra.Adj ** {c2 : Str} ;

    N, N2 = ResAra.Noun ; 
--{s : ResAra.Number => State => Case => Str; g : Gender ; h = Species} ;
--    N2 = {s : ResAra.Number => Case => Str} ** {c2 : Str} ;??
    N3 = ResAra.Noun ** {c2,c3 : Str} ;
    PN = {s : Case => Str; g : Gender; h : Species} ;

}
