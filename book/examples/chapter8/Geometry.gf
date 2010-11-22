abstract Geometry = Logic ** {
fun
  Line, Point, Circle : Dom ;
  Intersect, Parallel : Ind -> Ind -> Atom ;
  Vertical : Ind -> Atom ;
  Centre : Ind -> Ind ;
}
