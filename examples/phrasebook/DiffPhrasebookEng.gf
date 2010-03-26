instance DiffPhrasebookEng of DiffPhrasebook = open 
  SyntaxEng,
  ParadigmsEng,
  IrregEng 
in {

oper
  want_V2 = mkV2 (mkV "want") ;
  like_V2 = mkV2 (mkV "like") ;
  cost_V2 = mkV2 IrregEng.cost_V ;
  cost_V  = IrregEng.cost_V ;
}
