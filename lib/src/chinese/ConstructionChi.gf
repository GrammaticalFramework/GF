--# -path=.:../abstract

concrete ConstructionChi of Construction = CatChi ** 
  open SyntaxChi, ParadigmsChi, (L = LexiconChi), (E = ExtraChi), (G = GrammarChi), (R = ResChi), Prelude in {


lin
  hungry_VP = mkVP (mkV "饿") ;
  thirsty_VP = mkVP (mkA "渴") ;
  has_age_VP card = mkVP (lin AdV card) (mkVP (mkV "岁")) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 (mkV "叫")) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) ;

  what_name_QCl x = mkQCl whatSg_IP (mkClSlash (lin NP x) (mkV2 (mkV "叫"))) ;
  how_old_QCl x = {s = \\p,a => x.s ++ (R.word "几岁" | R.word "多大")} ; ----
----  how_far_QCl x = mkQCl (E.IAdvAdv (ss "far")) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsChi.mkA "对") ; 
  is_wrong_VP = mkVP (ParadigmsChi.mkV "错") ; 

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ; ----
  
}
