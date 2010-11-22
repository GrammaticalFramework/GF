abstract Logic = {
  cat
    Prop ; Ind ;
  data
    And, Or, If : Prop -> Prop -> Prop ;
    Not         : Prop -> Prop ;
    All, Exist  : (Ind -> Prop) -> Prop ;
    Past        : Prop -> Prop ;
}
