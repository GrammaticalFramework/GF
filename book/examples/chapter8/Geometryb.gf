abstract Geometry = Logic ** {
fun
  Line, Point, Circle : Dom ;
  Intersect, Parallel : Ind -> Ind -> Prop ;
  Vertical : Ind -> Prop ;
  Centre : Ind -> Ind ;
}
