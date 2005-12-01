abstract Adjective = Cat ** {

  fun

    PositA  : A -> AP ;
    ComparA : A -> NP -> AP ;

-- $SuperlA$ belongs to determiner syntax in $Noun$.

    ComplA2 : A2 -> NP -> AP ;

    ReflA2  : A2 -> AP ;

    SentAP  : AP -> S  -> AP ;
    QuestAP : AP -> QS -> AP ;

    AdAP : AdA -> AP -> AP ;

-- $AdvA$ that forms adverbs belongs to $Adverb$.

-- Elliptic constructions as usual.

    UseA2 : A2 -> A ;

}
