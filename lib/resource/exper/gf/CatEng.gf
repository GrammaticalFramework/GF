concrete CatEng of Cat = open ResEng in {
  lincat
    S = {s : Str} ;
    Cl = {s : Tense => Anteriority => Ord => Pol => Str} ;
    VP = {
      s  : Tense => Anteriority => Ord => Pol => Agr => {fin, inf : Str} ; 
      s2 : Agr => Str
      } ;
    NP = {s : Case => Str ; a : Agr} ;
    AP = {s : Str} ; 
    Comp = {s : Agr => Str} ; 
    V  = Verb ; -- = {s : VForm => Str} ;
    V2 = Verb ** {s2 : Str} ;
    VV = Verb ** {s2 : Str} ;
    Adv = {s : Str} ;
}