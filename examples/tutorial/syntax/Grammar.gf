abstract Grammar = {

  flags startcat=Phr ;

  cat
    Phr ;  -- any complete sentence e.g. "Is this pizza good?"
    S ;    -- declarative sentence  e.g. "this pizza is good"
    QS ;   -- question sentence     e.g. "is this pizza good"
    NP ;   -- noun phrase           e.g. "this pizza"
    IP ;   -- interrogative phrase  e.g  "which pizza"
    CN ;   -- common noun phrase    e.g. "very good pizza"
    Det ;  -- determiner            e.g. "this"
    IDet ; -- interrog. determiner  e.g. "which"
    AP ;   -- adjectival phrase     e.g. "very good"
    AdA ;  -- adadjective           e.g. "very"
    VP ;   -- verb phrase           e.g. "is good"
    N ;    -- noun                  e.g. "pizza"
    A ;    -- adjective             e.g. "good"
    V ;    -- intransitive verb     e.g. "boil"
    V2 ;   -- two-place verb        e.g. "eat"
    Pol ;  -- polarity (pos or neg)           

  fun
    PhrS    : S  -> Phr ;
    PhrQS   : QS -> Phr ;

    PredVP  : Pol -> NP -> VP -> S ;
    QuestVP : Pol -> NP -> VP -> QS ;

    IPPredVP : Pol -> IP -> VP -> QS ;
    IPPredV2 : Pol -> IP -> NP -> V2 -> QS ;
 
    ComplV2 : V2 -> NP -> VP ;
    ComplAP : AP -> VP ;

    DetCN   : Det -> CN -> NP ;

    ModCN   : AP -> CN -> CN ;

    AdAP    : AdA -> AP -> AP ;

    IDetCN  : IDet -> CN -> IP ;

  -- lexical insertion

    UseN : N -> CN ;
    UseA : A -> AP ;
    UseV : V -> VP ;

  -- entries of the closed lexicon

    this_Det  : Det ;
    that_Det  : Det ;
    these_Det : Det ;
    those_Det : Det ;
    every_Det : Det ;
    theSg_Det : Det ;
    thePl_Det : Det ;
    indef_Det : Det ;
    plur_Det  : Det ;
    two_Det   : Det ;

    which_IDet : IDet ;

    very_AdA  : AdA ;

  -- polarities

    PPos, PNeg : Pol ;

}
