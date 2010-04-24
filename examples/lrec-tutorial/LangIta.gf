concrete LangIta of Lang = GrammarIta ** open ResIta in {

lin
  man_N = mkN "uomo" "uomini" Masc ;
  woman_N = mkN "donna" ;
  house_N = mkN "casa" ;
  tree_N = mkN "albero" ;
  big_A = preA (mkA "grande") ;
  small_A = preA (mkA "piccolo") ;
  green_A = mkA "verde" ;
  walk_V = mkV "camminare" ;
  arrive_V = essereV (mkV "arrivare") ;
  love_V2 = mkV2 "amare" ;
  please_V2 = mkV2 (mkV "piacere" "piaccio" "piaci" "piace" 
       "piacciamo" "piacete" "piacciono" "piaciuto" Essere) Dat ;

} ;
