--# -path=.:../abstract

concrete ConstructionGer of Construction = CatGer ** 
  open SyntaxGer, ParadigmsGer, (L = LexiconGer), (E = ExtraGer), (G = GrammarGer), (I = IrregGer), Prelude in {


lin
  hungry_VP = mkVP (mkA "hungrig") ;
  thirsty_VP = mkVP (mkA "durstig") ;
  has_age_VP card = mkVP (lin AP (mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> L.year_N))) L.old_A)) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 I.heißen_V) (lin NP y) ;
  married_Cl x y = ----mkCl (lin NP x) L.married_A2 (lin NP y) | 
                   mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "verheiratet") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) I.heißen_V) ;
----  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ; ---- compilation slow
  how_old_QCl x = mkQCl (E.IAdvAdv (ParadigmsGer.mkAdv "alt")) (mkCl (lin NP x) G.UseCopula) ; ----
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (mkCl (mkVP (SyntaxGer.mkAdv to_Prep (lin NP x)))) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP have_V2 (mkNP (ParadigmsGer.mkN "Recht")) ;
  is_wrong_VP = mkVP have_V2 (mkNP (ParadigmsGer.mkN "Unrecht")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;
  
}
