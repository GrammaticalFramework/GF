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

fun
  UCommand  : Command -> Utterance ;
  UQuestion : Question -> Utterance ;

  CAction : (k : Kind) -> Action k -> Device k -> Command ;
  QAction : (k : Kind) -> Action k -> Device k -> Question ;

  DKindOne  : (k : Kind) -> Device k ;
  DKindMany : (k : Kind) -> Device k ;
  DLoc  : (k : Kind) -> Device k -> Location -> Device k ;

  light, fan : Kind ;

  switchOn, switchOff : (k : Kind) -> Action k ;

  dim : Action light ;

  kitchen, livingRoom : Location ;
  

}

