abstract Clause = Cat ** {

fun 
  PredV   : NP -> V -> Cl ;
  PredV2  : NP -> V2 -> NP -> Cl ;
  PredAP  : NP -> AP -> Cl ;
  PredAdv : NP -> Adv -> Cl ;

    UseCl  : Tense -> Ant -> Pol -> Cl  -> S ;

  QuestV  : IP -> V -> QCl ;
  QuestV2 : IP -> V2 -> NP -> QCl ;
  QuestV2Slash : IP -> NP -> V2 -> QCl ;

    UseQCl : Tense -> Ant -> Pol -> QCl -> QS ;

  ImpV   : V -> Imp ;
  ImpV2  : V2 -> NP -> Imp ;


}
