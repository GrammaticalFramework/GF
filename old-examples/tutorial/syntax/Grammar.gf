abstract Grammar = {

  flags startcat=Phr ;

  cat
    Phr ;  -- any complete sentence e.g. "Is this pizza good?"
    S ;    -- declarative sentence  e.g. "this pizza is good"
    QS ;   -- question sentence     e.g. "is this pizza good"
    Cl ;   -- declarative clause    e.g. "this pizza is good"
    QCl ;  -- question clause       e.g. "is this pizza good"
    NP ;   -- noun phrase           e.g. "this pizza"
    IP ;   -- interrogative phrase  e.g  "which pizza"
    CN ;   -- common noun phrase    e.g. "very good pizza"
    Det ;  -- determiner            e.g. "this"
    IDet ; -- interrog. determiner  e.g. "which"
    AP ;   -- adjectival phrase     e.g. "very good"
    Adv ;  -- adverb                e.g. "today"
    AdA ;  -- adadjective           e.g. "very"
    VP ;   -- verb phrase           e.g. "is good"
    N ;    -- noun                  e.g. "pizza"
    A ;    -- adjective             e.g. "good"
    V ;    -- intransitive verb     e.g. "boil"
    V2 ;   -- two-place verb        e.g. "eat"
    Pol ;  -- polarity (pos or neg)           
    Conj ; -- conjunction           e.g. "and"
    Subj ; -- conjunction           e.g. "because"

  fun
    PhrS    : S  -> Phr ;
    PhrQS   : QS -> Phr ;

    UseCl   : Pol -> Cl -> S ;
    UseQCl  : Pol -> QCl -> QS ;

    QuestCl : Cl -> QCl ;

    SubjS   : Subj -> S -> Adv ;

    PredVP  : NP -> VP -> Cl ;

    QuestVP : IP -> VP -> QCl ;
    QuestV2 : IP -> NP -> V2 -> QCl ;
 
    ComplV2 : V2 -> NP -> VP ;
    ComplAP : AP -> VP ;

    DetCN   : Det -> CN -> NP ;

    ModCN   : AP  -> CN -> CN ;
    AdVP    : Adv -> VP -> VP ;
    AdAP    : AdA -> AP -> AP ;

    IDetCN  : IDet -> CN -> IP ;

    ConjS   : Conj -> S -> S -> S ;
    ConjNP  : Conj -> NP -> NP -> NP ;

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
    today_Adv  : Adv ;
    very_AdA  : AdA ;
    and_Conj  : Conj ;
    because_Subj : Subj ;

  -- polarities

    PPos, PNeg : Pol ;

}
