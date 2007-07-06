--# -path=.:prelude

concrete SmartEng of Smart = open Prelude in {

-- part of grammar Toy1 from the Regulus book

lincat 
  Command, Kind, Action, Device = SS ;
lin
  CAction _ act dev = ss (act.s ++ dev.s) ;
  DKindOne  k = ss ("the" ++ k.s) ;
 
  light = ss "light" ;
  fan = ss "fan" ;
  switchOn _ = ss ["switch on"] ;
  switchOff _ = ss ["switch off"] ;
  dim = ss "dim" ;
}

