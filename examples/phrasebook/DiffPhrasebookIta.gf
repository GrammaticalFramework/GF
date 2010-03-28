instance DiffPhrasebookIta of DiffPhrasebook = open 
  SyntaxIta,
  BeschIta,
  ParadigmsIta 
in {

oper
  want_V2 = mkV2 (mkV (volere_96 "volere")) ;
  like_V2 = mkV2 (mkV "amare") ; ----

  cost_V2 = mkV2 (mkV "costare") ;
  cost_V  = mkV "costare" ;

}
