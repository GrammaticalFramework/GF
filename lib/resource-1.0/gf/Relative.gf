abstract Relative = Cat, Sentence ** {

  fun

    RelCl    : Cl -> RCl ;
    RelVP    : RP -> VP -> RCl ;
    RelSlash : RP -> Slash -> RCl ;

    FunRP : Prep -> NP -> RP -> RP ;
    IdRP : RP ;

}

