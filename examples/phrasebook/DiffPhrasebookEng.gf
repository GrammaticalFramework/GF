instance DiffPhrasebookEng of DiffPhrasebook = open 
  SyntaxEng,
  ParadigmsEng 
in {

oper
  want_V2 = mkV2 (mkV "want") ;
  like_V2 = mkV2 (mkV "like") ;

}
