abstract Miniresource = {

-- module Grammar in GF book, Chapter 9: syntax and structural words

  flags startcat = S ;

  cat 
    S ; Cl ; NP ; VP ; AP ; CN ; 
    Det ; N ; A ; V ; V2 ; AdA ; 
    Tense ; Pol ;
    Conj ;
  data
    UseCl   : Tense -> Pol -> Cl -> S ;
    PredVP  : NP -> VP -> Cl ;
    ComplV2 : V2 -> NP -> VP ;
    DetCN   : Det -> CN -> NP ;
    ModCN   : AP -> CN -> CN ;

    CompAP  : AP -> VP ;
    AdAP    : AdA -> AP -> AP ;

    ConjS   : Conj -> S  -> S  -> S ;
    ConjNP  : Conj -> NP -> NP -> NP ;

    UseV    : V -> VP ;
    UseN    : N -> CN ;
    UseA    : A -> AP ;

    a_Det, the_Det, every_Det : Det ;
    this_Det, these_Det : Det ;
    that_Det, those_Det : Det ;
    i_NP, youSg_NP, he_NP, she_NP, we_NP, youPl_NP, they_NP : NP ;
    very_AdA : AdA ;

    Pos, Neg : Pol ;
    Pres, Perf : Tense ;

    and_Conj, or_Conj : Conj ;

-- module Test: content word lexicon for testing

    man_N, woman_N, house_N, tree_N : N ;
    big_A, small_A, green_A : A ;
    walk_V, arrive_V : V ;
    love_V2, please_V2 : V2 ;

}

