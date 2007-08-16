abstract Syntax = {

  flags startcat=Phr ;

  cat
    Phr ;  -- any complete sentence e.g. "Is this pizza good?"
    S ;    -- declarative sentence  e.g. "this pizza is good"
    QS ;   -- question sentence     e.g. "is this pizza good"
    NP ;   -- noun phrase           e.g. "this pizza"
    IP ;   -- interrogative phrase  e.g  "which pizza"
    CN ;   -- common noun phrase    e.g. "very good pizza"
    Det ;  -- determiner            e.g. "this"
    AP ;   -- adjectival phrase     e.g. "very good"
    AdA ;  -- adadjective           e.g. "very"
    VP ;   -- verb phrase           e.g. "is good"
    N ;    -- noun                  e.g. "pizza"
    A ;    -- adjective             e.g. "good"
    V ;    -- intransitive verb     e.g. "boil"
    V2 ;   -- two-place verb        e.g. "eat"

  fun
    PhrS  : S -> Phr ;
    PhrQS : QS -> Phr ;

    PosVP, NegVP : NP -> VP -> S ;
    QPosVP, QNegVP : NP -> VP -> QS ;

    IPPosVP, IPNegVP : IP -> VP -> QS ;
    IPPosV2, IPNegV2 : IP -> NP -> V2 -> QS ;
 
    ComplV2 : V2 -> NP -> VP ;
    ComplAP : AP -> VP ;

    DetCN  : Det -> CN -> NP ;

    ModCN  : AP -> CN -> CN ;

    AdAP   : AdA -> AP -> AP ;

    WhichCN : CN -> IP ;

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

    very_AdA  : AdA ;
}
