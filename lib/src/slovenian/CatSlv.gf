concrete CatSlv of Cat = CommonX ** open ResSlv, (P=ParamX), Prelude in {

lincat
  -- Sentence
  Cl = {s : P.Tense => P.Anteriority => P.Polarity => Str} ;
  Imp = {s : P.Polarity => Gender => Number => Str} ;
  ClSlash = {s : P.Tense => P.Anteriority => P.Polarity => Str ; c2 : Prep} ; ----AR

  -- Question
  QCl = {s : P.Tense => P.Anteriority => P.Polarity => Str} ;
  IP =  {s : Case => Str; a : Agr} ; ----AR

  -- Verb
  VP = ResSlv.VP ;
  VPSlash = ResSlv.VP ** {c2 : Prep} ;
  Comp = {s : Agr => Str} ; 

  -- Adjective
  AP = {s : Species => AGender => Case => Number => Str} ;

  -- Noun
  CN = {s : Species => Case => Number => Str; g : AGender} ;
  NP = {s : Case => Str; a : Agr; isPron : Bool} ;

  Pron = {s : Case => Str; poss : Gender => Case => Number => Str; a : Agr} ;

  Det = {s : Gender => Case => Str; spec : Species; n : NumAgr} ;
  Num  = {s : Gender => Case => Str ; n : NumAgr} ;
  Card = {s : Gender => Case => Str ; n : NumAgr} ;
  Quant = {s : Gender => Case => Number => Str; spec : Species} ;

  -- Numeral
  Numeral = {s : Gender => Case => Str ; n : NumAgr} ;

  -- Structural
  Conj = {s : Str; n : Number} ;
  Prep = {s : Str; c : Case} ;

  -- Open lexical classes, e.g. Lexicon
  V  = {s : VForm => Str ; p : Str ; refl : Str}; ----AR: +p particle
  VS = {s : VForm => Str ; p : Str ; refl : Str};
  VQ = {s : VForm => Str};
  VV = {s : VForm => Str};
  V2 = {s : VForm => Str; c2 : Prep ; p : Str ; refl : Str};  ----AR: +p particle
  V3 = {s : VForm => Str; c2 : Prep ; c3 : Prep ; p : Str ; refl : Str};

  A = {s : AForm => Str};
  
  N = {s : Case => Number => Str; g : AGender};
  PN = {s : Case => Str; g : AGender; n : Number};

}
