concrete CatDut of Cat = 
  CommonX **
  open ResDut, Prelude in 
{
  flags optimize=all_subs ;

  lincat
--
---- Tensed/Untensed
--
    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
--    RS = {s : GenNum => Str ; c : Case} ;
--    SSlash = {s : Order => Str} ** {c2 : Preposition} ;
--
---- Sentence
--
    Cl = Clause ; -- {s : Tense => Anteriority => Polarity => Order => Str} ;
--    ClSlash = {
--      s : Mood => ResDut.Tense => Anteriority => Polarity => Order => Str ; 
--      c2 : Preposition
--      } ;
--    Imp = {s : Polarity => ImpForm => Str} ;
--
---- Question
--
    QCl = {s : ResDut.Tense => Anteriority => Polarity => QForm => Str} ;
--    IP = {s : Case => Str ; n : Number} ;
--    IComp = {s : Agr => Str} ; 
--    IDet = {s : Gender => Case => Str ; n : Number} ;
--    IQuant = {s : Number => Gender => Case => Str} ;
--
---- Relative
--
--    RCl = {s : Mood => ResDut.Tense => Anteriority => Polarity => GenNum => Str ; c : Case} ;
--    RP = {s : GenNum => Case => Str ; a : RAgr} ;
--
---- Verb
--
    VP = ResDut.VP ;
    VPSlash = ResDut.VP ** {c2 : Preposition} ;
    Comp = {s : Agr => Str} ; 

-- Adjective

    AP = {s : AForm => Str ; isPre : Bool} ; 

-- Noun

    CN = Noun ;
    NP = {s : NPCase => Str ; a : Agr} ;
    Pron = Pronoun ;

--    Det = {s,sp : Gender => Case => Str ; n : Number ; a : Adjf} ;
--    Quant = {
--      s  : Bool => Number => Gender => Case => Str ; 
--      sp : Number => Gender => Case => Str ; 
--      a  : Adjf
--      } ;
--    Predet = {s : Number => Gender => Case => Str ; c : PredetCase} ;
--    Num = {s : Gender => Case => Str ; n : Number ; isNum : Bool} ;
--    Card = {s : Gender => Case => Str ; n : Number} ;
--    Ord = {s : AForm => Str} ;
--
---- Numeral
--
--    Numeral = {s : CardOrd => Str ; n : Number } ;
--    Digits = {s : CardOrd => Str ; n : Number } ;
--
---- Structural
--
--    Conj = {s1,s2 : Str ; n : Number} ;
--    Subj = {s : Str} ;
--    Prep = {s : Str ; c : Case} ;
--
---- Open lexical classes, e.g. Lexicon
--
    V, VS, VQ, VA = ResDut.Verb ** {aux : VAux} ; -- = {s : VForm => Str} ;
--    VV = Verb ** {isAux : Bool} ;
    V2, V2A, V2S, V2Q = VVerb ** {c2 : Preposition} ;
--    V2V = Verb ** {c2 : Preposition ; isAux : Bool} ;
--    V3 = Verb ** {c2, c3 : Preposition} ;
--
    A  = Adjective ;
--    A2 = {s : Degree => AForm => Str ; c2 : Preposition} ;
--
    N  = Noun ;
--    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Preposition} ;
--    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Preposition} ;
--    PN = {s : Case => Str} ;
--
---- tense with possibility to choose conjunctive forms
--
--    Temp = {s : Str ; t : ResDut.Tense ; a : Anteriority ; m : Mood} ;
--    Tense = {s : Str ; t : ResDut.Tense ; m : Mood} ;
--
--  lin
--    TTAnt t a = {s = t.s ++ a.s ; t = t.t ; a = a.a ; m = t.m} ;
--
--    TPres = {s = [] ; t = Pres ; m = MIndic} ;
--    TPast = {s = [] ; t = Past ; m = MIndic} ;   --# notpresent
--    TFut  = {s = [] ; t = Fut  ; m = MIndic} ;   --# notpresent
--    TCond = {s = [] ; t = Cond ; m = MIndic} ;   --# notpresent
--}

}
