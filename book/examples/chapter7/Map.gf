abstract Map = {
flags startcat = Query ;
cat
  Query ; Input ; Place ; Click ;
fun
  GoFromTo   : Place -> Place -> Input ;
  ThisPlace  : Click -> Place ;
  QueryInput : Input -> Query ;
  ClickCoord : Int -> Int -> Click ;
}
