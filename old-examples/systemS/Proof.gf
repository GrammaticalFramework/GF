abstract Proof = Formula ** {

  cat
    Text ;
    Proof ;
    [Formula] ;

  fun
    Start : [Formula] -> Formula -> Proof -> Text ;

    Hypo : Proof ;
    Implic : [Formula] -> Formula -> Proof -> Proof ;
    RedAbs : Formula -> Proof -> Proof ;
    ExFalso : Formula -> Proof ;
    ConjSplit : Formula -> Formula -> Formula -> Proof -> Proof ;
    ModPon : [Formula] -> Formula -> Proof -> Proof ;
    Forget : [Formula] -> Formula -> Proof -> Proof ;

    DeMorgan1, DeMorgan2 : Formula -> Formula -> Proof -> Proof ;
    ImplicNeg : [Formula] -> Formula -> Proof -> Proof ;
    NegRewrite : Formula -> [Formula] -> Proof -> Proof ;

}
