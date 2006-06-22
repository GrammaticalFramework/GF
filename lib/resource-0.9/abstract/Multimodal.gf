--# -path=.:../../prelude

abstract Multimodal = 
  Rules, 
  Structural, 
  Basic, 
  Time,
  Demonstrative

  ** {

  flags startcat=Phr ;

  fun

-- Interface to $Demonstrative$.

   DemNP    : NP  -> DNP ; 
   DemAdv   : Adv -> DAdv ; 
   SentMS   : Pol -> MS  -> Phr ;
   QuestMS  : Pol -> MS  -> Phr ;
   QuestMQS : Pol -> MQS -> Phr ;
   ImpMImp  : Pol -> MImp -> Phr ;

-- Mount $Time$.

   AdvDate : Date -> Adv ;
   AdvTime : Time -> Adv ;

}
