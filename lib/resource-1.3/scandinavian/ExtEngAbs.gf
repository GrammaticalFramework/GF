abstract ExtEngAbs = Cat ** {

  cat
    Aux ;  -- auxiliary verbs: "can", "must", etc

-- Notice that $Aux$ cannot form $VP$ with infinitive, imperative, etc.

  fun
    PredAux  : NP -> Aux -> VP -> Cl ;
    QuestAux : IP -> Aux -> VP -> QCl ;

    can_Aux  : Aux ;
    must_Aux : Aux ;

}
