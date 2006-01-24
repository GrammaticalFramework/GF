incomplete concrete CatScand of Cat = 
  open ResScand, Prelude, CommonScand, (R = ParamX) in {

  flags optimize=all_subs ;

  lincat

-- Phrase

    Text, Phr, Utt, Voc = {s : Str} ;

-- Tensed/Untensed

    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str} ;

-- Sentence

    Cl = {s : Tense => Anteriority => Polarity => Order => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Order => Str} ** {c2 : Str} ;
    Imp = {s : Polarity => Number => Str} ;

-- Question

    QCl = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : NPForm => Str ; gn : GenNum} ;
    IAdv = {s : Str} ;    
    IDet = {s : Gender => Str ; n : Number ; det : DetSpecies} ;

-- Relative

    RCl = {s : Tense => Anteriority => Polarity => Agr => Str} ;
    RP = {s : GenNum => RCase => Str ; a : RAgr} ;

-- Verb

    VP = {
      s : VPForm => {
        fin : Str ;          -- V1 har  ---s1
        inf : Str            -- V2 sagt ---s4
        } ;
      a1 : Polarity => Str ; -- A1 inte ---s3
      n2 : Agr => Str ;      -- N2 dig  ---s5  
      a2 : Str ;             -- A2 idag ---s6
      ext : Str ;            -- S-Ext att hon går   ---s7
      en2,ea2,eext : Bool    -- indicate if the field exists
      } ;
    Comp = {s : AFormPos => Str} ; 
    SC = {s : Str} ; -- always Sub


-- Adjective

    AP = {s : AFormPos => Str ; isPre : Bool} ; 

-- Noun

-- The fields $isMod$ and $isDet$, and the boolean parameter of
-- determiners, are a hack (the simples possible we found) that
-- permits treating definite articles "huset - de fem husen - det gamla huset"
-- as $Quant$.

    CN = {s : Number => DetSpecies => Case => Str ; g : Gender ; isMod : Bool} ;
    NP,Pron = {s : NPForm => Str ; a : Agr} ;
    Det = {s : Bool => Gender => Str ; n : Number ; det : DetSpecies} ;
    QuantSg = {s : Bool => Gender => Str ; det : DetSpecies} ;
    QuantPl = {s : Bool => Gender => Str ; det : DetSpecies} ;
    Predet = {s : GenNum => Str} ;
    Num = {s : Gender => Str ; isDet : Bool} ;
    Ord = {s : Str ; isDet : Bool} ;

-- Adverb

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;
    PConj = {s : Str} ;    
    CAdv = {s : Str} ;    
    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Basic

    V, VS, VQ, VA = Verb ;
    V2, VV, V2A = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2,c3 : Str} ;

    A  = Adjective ;
       -- {s : AForm => Str} ;
    A2 = Adjective ** {c2 : Str} ;

    N  = Noun ; 
      -- {s : Number => Species => Case => Str ; g : Gender} ;
    N2   = Noun  ** {c2 : Str} ;
    N3   = Noun  ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
