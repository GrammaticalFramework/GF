abstract Syntax = {

  flags startcat=Phr ;

  cat
    S ;    -- declarative sentence  e.g. "this pizza is good"
    NP ;   -- noun phrase           e.g. "this pizza"
    CN ;   -- common noun           e.g. "pizza"
    Det ;  -- determiner            e.g. "this"
    AP ;   -- adjectival phrase     e.g. "very good"
    AdA ;  -- adadjective           e.g. "very"
    VP ;   -- verb phrase           e.g. "is good"
    V ;    -- intransitive verb     e.g. "boil"
    V2 ;   -- two-place verb        e.g. "eat"

  fun
    PosVP, NegVP : NP -> VP -> S ;
 
    PredAP : AP -> VP ;
    PredV  : V  -> VP ;
    PredV2 : V2 -> NP -> VP ;

    DetCN  : Det -> CN -> NP ;

    ModCN  : AP -> CN -> CN ;

    AdAP   : AdA -> AP -> AP ;


  -- entries of the closed lexicon

    this_Det  : Det ;
    that_Det  : Det ;
    these_Det : Det ;
    those_Det : Det ;
    every_Det : Det ;
    theSg_Det : Det ;
    thePl_Det : Det ;
    a_Det     : Det ;
    plur_Det  : Det ;
    two_Det   : Det ;

    very_AdA  : AdA ;
    too_AdA   : AdA ;

}