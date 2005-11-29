abstract Tensed = Cat, Tense ** {

  fun
    UseCl  : Tense -> Ant -> Pol -> Cl  -> S ;
    UseQCl : Tense -> Ant -> Pol -> QCl -> QS ;
    UseRCl : Tense -> Ant -> Pol -> RCl -> RS ;

}