concrete LexiconIta of Lexicon = GrammarIta ** open ParadigmsIta in {

lin
  man_N = mkN "uomo" "uomini" masculine ;
  woman_N = mkN "donna" ;
  house_N = mkN "casa" ;
  tree_N = mkN "albero" ;
  big_A = preA (mkA "grande") ;
  small_A = preA (mkA "piccolo") ;
  green_A = mkA "verde" ;
  walk_V = mkV "camminare" ;
  arrive_V = essereV (mkV "arrivare") ;
  sleep_V = mkV "dormire"
    "dormo" "dormi" "dorme" "dormiamo" "dormite" "dormono"
    "dormivo" "dormirò" "dorma" "dormissi" "dormito" ;
  love_V2 = mkV2 "amare" ;
  look_V2 = mkV2 "guardare" ;
  please_V2 = mkV2 (essereV (mkV "piacere" "piaccio" "piaci" "piace" 
                        "piacciamo" "piacete" "piacciono"
                        "piacevo" "piacerò" 
                        "piaccia" "piacessi" "piaciuto")) dative ;

  believe_VS = mkVS (mkV "credere") conjunctive ;

  know_VS = mkVS (mkV 
     "sapere" "so" "sai" "sa" "sappiamo" "sapete" "sanno"
     "sapevo" "saprò" "sappia" "sapessi" "saputo") indicative ;

  wonder_VQ = mkVQ (mkV "domandare") ; ---- domandarsi
  john_PN = mkPN "Giovanni" ;
  mary_PN = mkPN "Maria" ;

}
