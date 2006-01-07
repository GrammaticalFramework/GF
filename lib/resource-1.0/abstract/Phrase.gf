abstract Phrase = Cat, Tense ** {

  fun
    PhrUtt  : PConj -> Utt -> Voc -> Phr ;

    UttS    : S -> Utt ;
    UttQS   : QS -> Utt ;
    UttImpSg, UttImpPl  : Pol -> Imp -> Utt ;

    UttIP   : IP   -> Utt ;
    UttIAdv : IAdv -> Utt ;
    UttNP   : NP   -> Utt ;
    UttAdv  : Adv  -> Utt ;
    UttVP   : VP   -> Utt ;

    NoPConj : PConj ;
    PConjConj : Conj -> PConj ;

    NoVoc   : Voc ;
    VocNP   : NP -> Voc ;
}
