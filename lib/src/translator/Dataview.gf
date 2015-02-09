abstract Dataview = Dictionary ** {

-- Generating database entries from Dictionary
-- AR 9/1/2015 under LGPL/BSD

cat
  Row ; -- a row in the database

fun
  RowN   : N -> Row ;
  RowN2  : N2 -> Row ;
  RowN3  : N3 -> Row ;
  RowA   : A -> Row ;
  RowA2  : A2 -> Row ;
  RowV   : V -> Row ;
  RowV2  : V2 -> Row ;
  RowVV  : VV -> Row ;
  RowVS  : VS -> Row ;
  RowVQ  : VQ -> Row ;
  RowVA  : VA -> Row ;
  RowV3  : V3 -> Row ;
  RowV2V : V2V -> Row ;
  RowV2S : V2S -> Row ;
  RowV2Q : V2Q -> Row ;
  RowV2A : V2A -> Row ;
  RowAdv : Adv -> Row ;
  RowPrep : Prep -> Row ;

}
