instance DiffPhrasebookFin of DiffPhrasebook = open 
  SyntaxFin,
  ParadigmsFin 
in {

flags coding = utf8 ;

oper
  want_V2 = mkV2 (mkV "haluta")  ;
  like_V2 = mkV2 (mkV "pitää") elative ;

  cost_V2 = mkV2 (mkV "maksaa") ;
  cost_V  = mkV "maksaa" ;
}
