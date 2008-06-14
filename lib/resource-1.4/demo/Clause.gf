abstract Clause = Cat ** {

fun 
  PredV   : NP -> V -> Cl ;
  PredV2  : NP -> V2 -> NP -> Cl ;
  PredAP  : NP -> AP -> Cl ;
  PredAdv : NP -> Adv -> Cl ;

}
