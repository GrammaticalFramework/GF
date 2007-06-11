--# -path=.:prelude

concrete Toy1Eng of Toy1 = open Prelude in {

-- grammar Toy1 from the Regulus book

flags startcat = Utterance ;

param
  Number = Sg | Pl ;
  VForm = VImp | VPart ;

lincat 
  Utterance = SS ;
  Command = SS ;
  Question = SS ;
  Kind = {s : Number => Str} ; 
  Action = {s : VForm => Str ; part : Str} ;
  Device = {s : Str ; n : Number} ;
  Location = SS ;

lin
  UCommand  c = c ;
  UQuestion q = q ;

  CAction _ act dev = ss (act.s ! VImp ++ bothWays act.part dev.s) ;
  QAction _ act dev = ss (be dev.n ++ dev.s ++ act.s ! VPart ++ act.part) ;

  DKindOne  k = {
    s = "the" ++ k.s ! Sg ; 
    n = Sg
    } ;
  DKindMany k = {
    s = "the" ++ k.s ! Pl ; 
    n = Pl
    } ;
  DLoc _ dev loc = {
    s = dev.s ++ "in" ++ "the" ++ loc.s ; 
    n = dev.n
    } ;

  light = mkNoun "light" ;
  fan = mkNoun "fan" ;

  switchOn _ = mkVerb "switch" "swithced" "on" ;
  switchOff _ = mkVerb "switch" "swithced" "off" ;

  dim = mkVerb "dim" "dimmed" [] ;

  kitchen = ss "kitchen" ;
  livingRoom = ss ["living room"] ;
  
oper
  mkNoun : Str -> {s : Number => Str} = \dog -> {
    s = table {
      Sg => dog ;
      Pl => dog + "s"
      }
    } ;
  
  mkVerb : (_,_,_ : Str) -> {s : VForm => Str ; part : Str} = \go,gone,away -> {
    s = table {
      VImp => go ;
      VPart => gone
      } ;
    part = away
    } ;

  be : Number -> Str = \n -> case n of {
    Sg => "is" ;
    Pl => "are"
    } ;


}

