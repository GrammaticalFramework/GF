abstract Classes = {

flags 
  startcat = Command ;

cat
  Command ;
  Kind ;
  Class ;
  Instance Class Kind ;
  Action Class ;
  Device Kind ;

fun
  Act  : (c : Class) -> (k : Kind) -> Instance c k -> Action c -> Device k -> Command ;
  The : (k : Kind) -> Device k ;

  Light, Fan : Kind ;
  Switchable, Dimmable : Class ;
  
  SwitchOn, SwitchOff : Action Switchable ;
  Dim : Action Dimmable ;

  switchable_Light : Instance Switchable Light ;
  switchable_Fan : Instance Switchable Fan ;
  dimmable_Light : Instance Dimmable Light ;

}
