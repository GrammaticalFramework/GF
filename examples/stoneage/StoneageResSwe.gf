resource StoneageResSwe = open ResourceSwe, ParadigmsSwe in {

oper
  PresV : V -> NP -> S = \v,s -> PresCl (SPredV s v) ;
  PresV2 : V2 -> NP -> NP -> S = \v,s,o -> PresCl (SPredV2 s v o) ;
  PresVasV2 : V -> NP -> NP -> S = \ v -> PresV2 (dirV2 v) ;

  PresCl : Cl -> S = UseCl (PosTP TPresent ASimul) ;
 
  ModPosA : ADeg -> CN -> CN = \a -> ModAP (PositADeg a) ;
  ModA : A -> CN -> CN = \a -> ModAP (UseA a) ;

}