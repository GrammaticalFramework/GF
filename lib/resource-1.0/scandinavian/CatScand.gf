incomplete concrete CatScand of Cat = 
  open ResScand, Prelude, DiffScand, (R = ParamX) in {

  lincat
    Text, Phr, Utt = {s : Str} ;

    Imp = {s : Polarity => Number => Str} ;

    S   = {s : Order => Str} ;
    QS  = {s : QForm => Str} ;
    RS  = {s : Agr => Str} ;

    Cl    = {s : Tense => Anteriority => Polarity => Order => Str} ;
    Slash = {s : Tense => Anteriority => Polarity => Order => Str} ** {c2 : Str} ;

    QCl   = {s : Tense => Anteriority => Polarity => QForm => Str} ;
    RCl   = {s : Tense => Anteriority => Polarity => Agr   => Str} ;

-- Constructed in $Verb$.

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

    V, VS, VQ, VA = Verb ;
    V2, VV, V2A = Verb ** {c2 : Str} ;
    V3 = Verb ** {c2,c3 : Str} ;

    AP   = {s : AFormPos => Str ; isPre : Bool} ; 
    Comp = {s : AFormPos => Str} ; 

    SC   = {s : Str} ; -- always Sub

    A  = {s : AForm => Str} ;
    A2 = {s : AForm => Str} ** {c2 : Str} ;

    Adv, AdV, AdA, AdS, AdN = {s : Str} ;
    Prep = {s : Str} ;

-- Constructed in $Noun$.

    Det, Quant = {s : Gender => Str ; n : Number ; det : DetSpecies} ;
    Predet = {s : GenNum => Str} ;
    Num    = {s : Gender => Str} ;
    Ord    = {s : Str} ;

    N  = Noun ; 
      -- {s : Number => Species => Case => Str ; g : Gender} ;
    CN = {s : Number => DetSpecies => Case => Str ; g : Gender} ;
    PN = {s : Case => Str ; g : Gender} ;
    Pron, NP = {s : NPForm => Str ; a : Agr} ;
    N2   = Noun  ** {c2 : Str} ;
    N3   = Noun  ** {c2,c3 : Str} ;

    IP   = {s : NPForm => Str ; gn : GenNum} ;
    IDet = {s : Gender => Str ; n : Number ; det : DetSpecies} ;
    IAdv = {s : Str} ;    

    RP = {s : GenNum => RCase => Str ; a : RAgr} ;

    Numeral = {s : CardOrd => Str ; n : Number} ;

    CAdv = {s : Str} ;    

    Conj = {s : Str ; n : Number} ;
    DConj = {s1,s2 : Str ; n : Number} ;

  oper
    Noun = {s : Number => Species => Case => Str ; g : Gender} ;
}
