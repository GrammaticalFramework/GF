--# -path=.:../abstract

concrete ConstructionEng of Construction = CatEng ** 
  open SyntaxEng, ParadigmsEng, (L = LexiconEng), (E = ExtraEng), (G = GrammarEng), Prelude in {


lin
  hungry_VP = mkVP (mkA "hungry") ;
  thirsty_VP = mkVP (mkA "thirsty") ;
  has_age_VP card = mkVP (mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> L.year_N))) L.old_A) ;

  have_name_Cl x y = mkCl (mkNP (E.GenNP x) L.name_N) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "married") ;

  what_name_QCl x = mkQCl (mkIComp whatSg_IP) (mkNP (E.GenNP x) L.name_N) ;
  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ;
  how_far_QCl x = mkQCl (E.IAdvAdv (ss "far")) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsEng.mkA "right") ;
  is_wrong_VP = mkVP (ParadigmsEng.mkA "wrong") ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;
  
}
