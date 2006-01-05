concrete CatGer of Cat = open ResGer, Prelude in {

  flags optimize=all_subs ;

  lincat
--    Text, Phr, Utt = {s : Str} ;
--
--    Imp = {s : Polarity => Number => Str} ;

    S  = {s : Order => Str} ;
--    QS = {s : QForm => Str} ;
--    RS = {s : Agr => Str} ;

    Cl = {s : Tense => Anteriority => Polarity => Order => Str} ;
--    Slash = {s : Tense => Anteriority => Polarity => Order => Str} ** {c2 : Str} ;
--
--    QCl   = {s : Tense => Anteriority => Polarity => QForm => Str} ;
--    RCl   = {s : Tense => Anteriority => Polarity => Agr => Str} ;

    VP = ResGer.VP ;
    V, VS, VQ, VA = ResGer.Verb ; -- = {s : VForm => Str} ;
    V2, VV, V2A = Verb ** {c2 : Preposition} ;
    V3 = Verb ** {c2, c3 : Preposition} ;

    AP = {s : AForm => Str ; isPre : Bool} ; 
    Comp = {s : Agr => Str} ; 
--
--    SC = {s : Str} ;
--
    A  = {s : Degree => AForm => Str} ;
    A2 = {s : Degree => AForm => Str ; c2 : Preposition} ;

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;
    Prep = {s : Str ; c : Case} ;

    Det, Quant = {s : Gender => Case => Str ; n : Number ; a : Adjf} ;
    Predet = {s : Number => Gender => Case => Str} ;
    Num = {s : Gender => Case => Str} ;
    Ord = {s : Adjf => Gender => Case => Str} ;

    CN = {s : Adjf => Number => Case => Str ; g : Gender} ;
    N  = {s : Number => Case => Str ; g : Gender} ;
    PN = {s : Case => Str} ;
    Pron = {s : NPForm => Str ; a : Agr} ;
    NP = {s : Case => Str ; a : Agr} ;
    N2 = {s : Number => Case => Str ; g : Gender} ** {c2 : Preposition} ;
    N3 = {s : Number => Case => Str ; g : Gender} ** {c2,c3 : Preposition} ;

--    IP = {s : Case => Str ; n : Number} ;
--    IDet = {s : Str ; n : Number} ;
--    IAdv = {s : Str} ;    
--
--    RP = {s : Case => Str ; a : RAgr} ;
--
--    Numeral = {s : CardOrd => Str ; n : Number} ;
--
--    CAdv = {s : Str} ;    
--
--    Conj = {s : Str ; n : Number} ;
--    DConj = {s1,s2 : Str ; n : Number} ;
--
}
