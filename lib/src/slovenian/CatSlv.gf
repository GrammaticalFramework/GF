concrete CatSlv of Cat = open ResSlv in {

lincat
  -- Adjective
  AP = {s : Species => Gender => Case => Number => Str} ;

  -- Noun
  CN = {s : Species => Case => Number => Str; g : Gender} ;

  -- Structural
  Prep = {s : Str; c : Case} ;

  -- Open lexical classes, e.g. Lexicon
  V = {s : VForm => Str};

  A = {s : AForm => Str};
  
  N = {s : Case => Number => Str; g : Gender};
  PN = {s : Case => Number => Str; g : Gender};

}
