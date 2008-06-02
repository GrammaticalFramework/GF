incomplete concrete CatScand of Cat = 
  CommonX ** open ResScand, Prelude, CommonScand, (R = ParamX) in {

  flags optimize=all_subs ;

  lincat

-- Tensed/Untensed

    S  = {s : Order => Str} ;
    QS = {s : QForm => Str} ;
    RS = {s : Agr => Str ; c : NPForm} ;
    SSlash = {s : Order => Str} ** {c2 : Str} ;

-- Sentence

    Cl = {s : R.Tense => Anteriority => Polarity => Order => Str} ;
    ClSlash = {s : R.Tense => Anteriority => Polarity => Order => Str} ** {c2 : Str} ;
    Imp = {s : Polarity => Number => Str} ;

-- Question

    QCl = {s : R.Tense => Anteriority => Polarity => QForm => Str} ;
    IP = {s : NPForm => Str ; gn : GenNum} ;
    IComp = {s : AFormPos => Str} ; 
    IDet = {s : Gender => Str ; n : Number ; det : DetSpecies} ;
    IQuant = {s : Number => Gender => Str ; det : DetSpecies} ;

-- Relative; the case $c$ is for "det" clefts.

    RCl = {s : R.Tense => Anteriority => Polarity => Agr => Str ; c : NPForm} ;
    RP  = {s : GenNum => RCase => Str ; a : RAgr} ;

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
    VPSlash = CommonScand.VP ** {c2 : Str} ;
    Comp = {s : AFormPos => Str} ; 


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
    Quant = {s : Number => Bool => Gender => Str ; det : DetSpecies} ;
    Art = {s : Number => Bool => Gender => Str ; det : DetSpecies} ;
    Predet = {s : GenNum => Str} ;
    Num = {s : Gender => Str ; isDet : Bool ; n : Number} ;
    Card = {s : Gender => Str ; n : Number} ;
    Ord = {s : Str} ;

-- Numeral

    Numeral = {s : CardOrd => Str ; n : Number} ;
    Digits  = {s : CardOrd => Str ; n : Number} ;

-- Structural

    Conj = {s1,s2 : Str ; n : Number} ;
    Subj = {s : Str} ;
    Prep = {s : Str} ;

-- Open lexical classes, e.g. Lexicon

    V, VS, VQ, VA = Verb ;
    V2, VV, V2Q, V2S, V2A = Verb ** {c2 : Str} ;
    V3, V2V = Verb ** {c2,c3 : Str} ;

    A  = Adjective ** {isComp : Bool} ;
       -- {s : AForm => Str} ;
    A2 = Adjective ** {isComp : Bool ; c2 : Str} ;

    N  = Noun ; 
      -- {s : Number => Species => Case => Str ; g : Gender} ;
    N2   = Noun  ** {c2 : Str} ;
    N3   = Noun  ** {c2,c3 : Str} ;
    PN = {s : Case => Str ; g : Gender} ;

}
