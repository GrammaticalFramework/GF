concrete CatSlv of Cat = CommonX ** open ResSlv, (P=ParamX) in {

lincat
  -- Sentence
  Cl = {s : P.Tense => P.Anteriority => P.Polarity => Str} ;

  -- Verb
  VP = ResSlv.VP ;

  -- Adjective
  AP = {s : Species => Gender => Case => Number => Str} ;

  -- Noun
  CN = {s : Species => Case => Number => Str; g : Gender} ;
  NP = {s : Case => Str ; a : Agr} ;

  Pron = {s : Case => Str ; a : Agr} ;

  Det = {s : Case => Str; spec : Species; n : Number} ;
  Num  = {s : Case => Str ; n : Number} ;
  Quant = {s : Str; spec : Species} ;

  -- Structural
  Prep = {s : Str; c : Case} ;

  -- Open lexical classes, e.g. Lexicon
  V = {s : VForm => Str};

  A = {s : AForm => Str};
  
  N = {s : Case => Number => Str; g : Gender};
  PN = {s : Case => Number => Str; g : Gender};

}
