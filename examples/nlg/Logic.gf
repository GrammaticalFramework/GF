abstract Logic = {

cat
  Ind; Prop;

fun
  john : Ind;
  mary : Ind;
  boy   : Ind -> Prop;
  love  : Ind -> Ind -> Prop;
  leave : Ind -> Prop;
  smart : Ind -> Prop;
  exists : (Ind -> Prop) -> Prop;
  forall : (Ind -> Prop) -> Prop;
  and,or : Prop -> Prop -> Prop;
  impl : Prop -> Prop -> Prop;
  not : Prop -> Prop;
  eq : Ind -> Ind -> Prop;

}
