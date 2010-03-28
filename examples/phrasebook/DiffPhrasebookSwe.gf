instance DiffPhrasebookSwe of DiffPhrasebook = open 
  SyntaxSwe,
  ParadigmsSwe 
in {

oper
  want_V2 = mkV2 (mkV "önska")  ;  ---- vill ha
  like_V2 = mkV2 (mkV "tycker") (mkPrep "om") ;

  cost_V2 = mkV2 (mkV "kosta") ;
  cost_V  = mkV "kosta" ;
}
