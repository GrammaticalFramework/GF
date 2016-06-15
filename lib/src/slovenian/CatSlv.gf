concrete CatSlv of Cat = CommonX ** open ResSlv, (P=ParamX) in {

lincat
  -- Sentence
  Cl = {s : P.Tense => P.Anteriority => P.Polarity => Str} ;
  Imp = {s : P.Polarity => Gender => Number => Str} ;

  -- Question
  QCl = {s : P.Tense => P.Anteriority => P.Polarity => Str} ;

  -- Verb
  VP = ResSlv.VP ;
  VPSlash = ResSlv.VP ** {c2 : Prep} ;
  Comp = {s : Agr => Str} ; 

  -- Adjective
  AP = {s : Species => Gender => Case => Number => Str} ;

  -- Noun
  CN = {s : Species => Case => Number => Str; g : Gender} ;
  NP = {s : Case => Str ; a : Agr} ;

  Pron = {s : Case => Str; poss : Str; a : Agr} ;

  Det = {s : Gender => Case => Str; spec : Species; n : NumAgr} ;
  Num  = {s : Gender => Case => Str ; n : NumAgr} ;
  Card = {s : Gender => Case => Str ; n : NumAgr} ;
  Quant = {s : Str; spec : Species} ;

  -- Numeral
  Numeral = {s : Gender => Case => Str ; n : NumAgr} ;

  -- Structural
  Conj = {s : Str} ;
  Prep = {s : Str; c : Case} ;

  -- Open lexical classes, e.g. Lexicon
  V  = {s : VForm => Str};
  VQ = {s : VForm => Str};
  VV = {s : VForm => Str};
  V2 = {s : VForm => Str; c2 : Prep};

  A = {s : AForm => Str};
  
  N = {s : Case => Number => Str; g : Gender};
  PN = {s : Case => Number => Str; g : Gender};

}
