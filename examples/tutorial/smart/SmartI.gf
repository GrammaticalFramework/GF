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
  Switchable = {} ;
  Dimmable = {} ;
  Statelike = {} ;

lin
  UCommand  c = mkUtt politeImpForm c ;
  UQuestion q = mkUtt q ;

  CAction _ act dev = mkImp act dev ;
  QAction _ act _ dev = 
    mkQS anteriorAnt (mkQCl (mkCl dev (passiveVP act))) ;

  DKindOne k = mkNP the_Det k ;
  DKindMany k = mkNP thePl_Det k ;
  DLoc _ dev loc = mkNP dev (mkAdv in_Prep (mkNP the_Det loc)) ;

  light = light_N ;
  fan = fan_N ;

  switchOn _ _ = switchOn_V2 ;
  switchOff _ _ = switchOff_V2 ;

  dim _ _ = dim_V2 ;

  kitchen = kitchen_N ;
  livingRoom = livingRoom_N ;

}
