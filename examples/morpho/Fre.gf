-- French irregular verbs, built using Eng as template.

abstract Fre = IrregFreAbs ** {

flags startcat = Display ; 

cat 
  Display ; Word ; Form ;

-- French verb forms have an internal structure.

  TMood ; Number ; Person ; NumPersI ; Gender ; Mood ;

fun
--  DAll : Word -> Display ;
  DForm : Word -> Form -> Display ;

  VInfin : Form ;
  VFin   : TMood -> Number -> Person -> Form ;
  VImper : NumPersI -> Form ;
  VPart  : Gender -> Number -> Form ;
  VGer   : Form ;

  VPres   : Mood -> TMood ;
  VImperf : Mood -> TMood ;
  VPasse, VFut, VCondit : TMood ;

  SgP2, PlP1, PlP2 : NumPersI ;

  Sg, Pl : Number ;
  P1, P2, P3 : Person ;
  Masc, Fem : Gender ;
  Indic, Conjunct : Mood ;

  WVerb : V -> Word ;
  WVerb2 : V2 -> Word ;

}
