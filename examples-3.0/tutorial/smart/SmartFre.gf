--# -path=.:prelude

concrete SmartFre of Smart = open Prelude in {

-- grammar Toy1 from the Regulus book

flags startcat = Utterance ;

param
  Number = Sg | Pl ;
  Gender = Masc | Fem ;
  VForm  = VInf | VPart Gender Number ;

lincat 
  Utterance = SS ;
  Command = SS ;
  Question = SS ;
  Kind = {s : Number => Str ; g : Gender} ; 
  Action = {s : VForm => Str} ;
  Device = {s : Str ; g : Gender ; n : Number} ;
  Location = {s : Number => Str ; g : Gender} ; 

lin
  UCommand  c = c ;
  UQuestion q = q ;

  CAction _ act dev = ss (act.s ! VInf ++ dev.s) ;
  QAction _ act st dev = 
    ss (dev.s ++ est dev.g dev.n ++ act.s ! VPart dev.g dev.n ++ st.s) ;

  DKindOne  k = {
    s = defArt k.g ++ k.s ! Sg ; 
    g = k.g ;
    n = Sg
    } ;
  DKindMany k = {
    s = "les" ++ k.s ! Pl ; 
    g = k.g ;
    n = Pl
    } ;
  DLoc _ dev loc = {
    s = dev.s ++ "dans" ++ defArt loc.g ++ loc.s ! Sg ;
    g = dev.g ; 
    n = dev.n
    } ;

  light = mkNoun "lampe" Fem ;
  fan = mkNoun "ventilateur" Masc ;

  switchOn _ _ = mkVerb "allumer" "allumé" ;
  switchOff _ _ = mkVerb "éteindre" "éteint" ;

  dim _ _ = mkVerb "baisser" "baissé" ;

  kitchen = mkNoun "cuisine" Fem ;
  livingRoom = mkNoun "salon" Masc ;
  
oper
  mkNoun : Str -> Gender -> {s : Number => Str ; g : Gender} = \dog,g -> {
    s = table {
      Sg => dog ;
      Pl => dog + "s"
      } ;
    g = g
    } ;
  
  mkVerb : (_,_ : Str) -> {s : VForm => Str} = \venir,venu -> {
    s = table {
      VInf => venir ;
      VPart Masc Sg => venu ;
      VPart Masc Pl => venu + "s" ;
      VPart Fem  Sg => venu + "e" ;
      VPart Fem  Pl => venu + "es"
      }
    } ;

  est : Gender -> Number -> Str = \g,n -> case <g,n> of {
    <Masc,Sg> => "est-il" ;
    <Fem, Sg> => "est-elle" ;
    <Masc,Pl> => "sont-ils" ;
    <Fem, Pl> => "sont-elles"
    } ;

  defArt : Gender -> Str = \g -> case g of {Masc => "le" ; Fem => "la"} ;

lin
  switchable_light = ss [] ;
  switchable_fan  = ss [] ;
  dimmable_light  = ss [] ;

  statelike_switchOn _ _ = ss [] ;
  statelike_switchOff _ _ = ss [] ;

}

