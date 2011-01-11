resource DefArtGer = {

  param DetForm = DSg Gender Case | DPl Case ;
  param Gender = Masc | Fem | Neutr ;
  param Case = Nom | Acc | Dat | Gen ;

  oper artDef : DetForm => Str = table {
    DSg Masc Acc | DPl Dat => "den" ;
    DSg (Masc | Neutr) Dat => "dem" ;
    DSg (Masc | Neutr) Gen => "des" ;
    DSg Neutr _ => "das" ;
    DSg Fem (Nom | Acc) | DPl (Nom | Acc) => "die" ; 
    _ => "der"
    } ;

}
