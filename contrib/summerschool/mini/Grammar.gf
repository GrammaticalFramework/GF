abstract Grammar = {

  flags startcat = S ;

  cat 
    S ; Cl ; NP ; VP ; AP ; CN ; 
    Det ; N ; A ; V ; V2 ; AdA ; 
    Tense ; Pol ;
    Conj ;
  fun
    UseCl   : Tense -> Pol -> Cl -> S ;
    PredVP  : NP -> VP -> Cl ;
    ComplV2 : V2 -> NP -> VP ;
    DetCN   : Det -> CN -> NP ;
    ModCN   : AP -> CN -> CN ;

    CompAP  : AP -> VP ;
    AdAP    : AdA -> AP -> AP ;

    ConjNP  : Conj -> NP -> NP -> NP ;

    UseV    : V -> VP ;
    UseN    : N -> CN ;
    UseA    : A -> AP ;

    a_Det, the_Det : Det ;
    this_Det, these_Det : Det ;
    that_Det, those_Det : Det ;
    i_NP, she_NP, we_NP : NP ;
    very_AdA : AdA ;

    Pos, Neg : Pol ;
    Pres, Perf : Tense ;

    and_Conj, or_Conj : Conj ;
}
