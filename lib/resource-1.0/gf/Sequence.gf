abstract Sequence = Cat ** {

  fun
    TwoS : S -> S -> SeqS ;
    AddS : SeqS -> S -> SeqS ;
    TwoAdv : Adv -> Adv -> SeqAdv ;
    AddAdv : SeqAdv -> Adv -> SeqAdv ;
    TwoNP : NP -> NP -> SeqNP ;
    AddNP : SeqNP -> NP -> SeqNP ;
    TwoAP : AP -> AP -> SeqAP ;
    AddAP : SeqAP -> AP -> SeqAP ;

}