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
  Switchable = SS ;
  Dimmable = SS ;
  Statelike = SS ;

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

  switchOn _ proof = mkVerb proof.s "allumer" "allumé" ;
  switchOff _ proof = mkVerb proof.s "éteindre" "éteint" ;

  dim _ proof = mkVerb proof.s "baisser" "baissé" ;

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
  
  mkVerb : (_,_,_ : Str) -> {s : VForm => Str} = \proof,venir,venu -> {
    s = table {
      VInf => proof++venir ;
      VPart Masc Sg => proof++venu ;
      VPart Masc Pl => proof++venu + "s" ;
      VPart Fem  Sg => proof++venu + "e" ;
      VPart Fem  Pl => proof++venu + "es"
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

