--# -path=.:../../prelude

abstract Minimal = Categories ** {

-- a minimum sample of lexicon to test resource grammar with

fun
  -- nouns: count and mass, relational
  man_N : N ;      
  wine_N : N ;
  mother_N2 : N2 ;
  distance_N3 : N3 ;

  -- proper names
  john_PN : PN ;   

  -- adjectives: with and without degree
  blue_ADeg : ADeg ;
  american_A : A ;

  -- adjectives: noun phase, sentence, and verb complements
  married_A2 : A2 ; 
  probable_AS : AS ;
  important_A2S : A2S ;
  easy_A2V : A2V ;

  -- adverbs
  now_Adv : Adv ;

  -- verbs
  walk_V : V ;
  love_V2 : V2 ;
  give_V3 : V3 ;
  believe_VS : VS ;
  try_VV : VV ;
  wonder_VQ : VQ ;
  become_VA : VA ;
  paint_V2A : V2A ;
  promise_V2V : V2V ;
  ask_V2Q : V2Q ;
  tell_V2S : V2S ;
  rain_V0 : V0 ;
} ;
