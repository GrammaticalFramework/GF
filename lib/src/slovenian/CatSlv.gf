concrete CatSlv of Cat = open ResSlv in {

lincat
  Prep = {s : Str; c : Case} ;

  N = {s : Case => Number => Str; g : Gender};
  PN = {s : Case => Number => Str; g : Gender};

  A = {s : AForm => Str};

  V = {s : VForm => Str};

}
