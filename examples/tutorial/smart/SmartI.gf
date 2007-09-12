--# -path=.:present:prelude

incomplete concrete SmartI of Smart = open Syntax, LexSmart, Prelude in {

-- grammar Toy1 from the Regulus book

flags startcat = Utterance ;

lincat 
  Utterance = Utt ;
  Command = Imp ;
  Question = QS ;
  Kind = N ;
  Action = V2 ;
  Device = NP ;
  Location = N ;

lin
  UCommand  c = mkUtt politeImpForm c ;
  UQuestion q = mkUtt q ;

  CAction _ act dev = mkImp act dev ;
  QAction _ act st dev = 
    mkQS anteriorAnt (mkQCl (mkCl dev (passiveVP act))) ; ---- show empty proof

  DKindOne k = mkNP defSgDet k ;
  DKindMany k = mkNP defPlDet k ;
  DLoc _ dev loc = mkNP dev (mkAdv in_Prep (mkNP defSgDet loc)) ;

  light = light_N ;
  fan = fan_N ;

  switchOn _ _ = switchOn_V2 ;
  switchOff _ _ = switchOff_V2 ;

  dim _ _ = dim_V2 ;

  kitchen = kitchen_N ;
  livingRoom = livingRoom_N ;
  
lin
  switchable_light = ss [] ;
  switchable_fan  = ss [] ;
  dimmable_light  = ss [] ;

  statelike_switchOn _ _ = ss [] ;
  statelike_switchOff _ _ = ss [] ;


}
