abstract Face = {

flags startcat = Message ;

cat
  Message ; Person ; Object ; Number ;
fun
  Have : Person -> Number -> Object -> Message ;
  Like : Person -> Object -> Message ;
  You : Person ;
  Friend, Invitation : Object ;
  One, Two, Hundred : Number ;

}
