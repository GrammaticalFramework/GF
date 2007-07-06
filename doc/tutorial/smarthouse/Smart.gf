abstract Smart = {

flags startcat = Command ;

cat 
  Command ; 
  Kind ; 
  Action Kind ; 
  Device Kind ; 
fun
  CAction : (k : Kind) -> Action k -> Device k -> Command ;
  DKindOne  : (k : Kind) -> Device k ;
  light, fan : Kind ;
  switchOn, switchOff : (k : Kind) -> Action k ;
  dim : Action light ;
}

