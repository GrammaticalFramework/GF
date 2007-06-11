abstract Toy1 = {

flags startcat = Utterance ;

cat 
  Utterance ; 
  Command ; 
  Question ; 
  Kind ; 
  Action Kind ; 
  Device Kind ; 
  Location ;

  Switchable Kind ;
  Dimmable Kind ;
  Statelike (k : Kind) (Action k) ;

fun
  UCommand  : Command -> Utterance ;
  UQuestion : Question -> Utterance ;

  CAction : (k : Kind) -> Action k -> Device k -> Command ;
  QAction : (k : Kind) -> (a : Action k) -> Statelike k a -> Device k -> Question ;

  DKindOne  : (k : Kind) -> Device k ;
  DKindMany : (k : Kind) -> Device k ;
  DLoc  : (k : Kind) -> Device k -> Location -> Device k ;

  light, fan : Kind ;

  switchOn, switchOff : (k : Kind) -> Switchable k -> Action k ;

  dim : (k : Kind) -> Dimmable k -> Action k ;

  kitchen, livingRoom : Location ;

-- proof objects

  switchable_light : Switchable light ;
  switchable_fan : Switchable fan ;
  dimmable_fan : Dimmable fan ;

  statelike_switchOn  : (k : Kind) -> (s : Switchable k) -> Statelike k (switchOn k s) ;
  statelike_switchOff : (k : Kind) -> (s : Switchable k) -> Statelike k (switchOff k s) ;

}

