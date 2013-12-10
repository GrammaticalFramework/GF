--# -path=alltenses:.:../abstract

concrete ConstructionFin of Construction = CatFin ** 
  open SyntaxFin, ParadigmsFin, (L = LexiconFin), (E = ExtraFin), (D = DictEngFin), Prelude in {

lincat
  Weekday = {name : NP ; point : SyntaxFin.Adv ; habitual : SyntaxFin.Adv} ;

lin
  hungry_VP = mkVP have_V2 (lin NP (mkNP (ParadigmsFin.mkN "nälkä"))) ;
  thirsty_VP = mkVP have_V2 (lin NP (mkNP (ParadigmsFin.mkN "jano"))) ;
  has_age_VP card = mkVP (mkAP (lin AdA (mkUtt (lin NP (mkNP <lin Card card : Card> L.year_N)))) L.old_A) ;

  have_name_Cl x y = mkCl (mkNP (E.GenNP x) L.name_N) (lin NP y) ;
  married_Cl x y = mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (ParadigmsFin.mkAdv "naimisissa") ;

  what_name_QCl x = mkQCl (mkIComp whatSg_IP) (mkNP (E.GenNP x) L.name_N) ;
  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ;
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsFin.mkAdv "oikeassa") ;
  is_wrong_VP = mkVP (ParadigmsFin.mkAdv "väärässä") ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (lin NP (mkNP <lin Card card : Card> (lin CN cn))))) (lin A a) ;

  monday = mkDay D.monday_PN "maanantaisin" ;
  tuesday = mkDay D.tuesday_PN "tiistaisin" ;
  wednesday = mkDay D.wednesday_PN "keskiviikkoisin" ;
  thursday = mkDay D.thursday_PN "torstaisin" ;
  friday = mkDay D.friday_PN "perjantaisin" ;
  saturday = mkDay D.saturday_PN "lauantaisin" ;
  sunday = mkDay D.sunday_PN "sunnuntaisin" ;

  weekdayAdv w = w.point | w.habitual ;

oper

  mkDay : PN -> Str -> Weekday = \d,s -> 
      let day = mkNP d in
      lin Weekday {name = day ; 
       point = SyntaxFin.mkAdv (casePrep essive) day ; 
       habitual = ParadigmsFin.mkAdv s
      } ; 
}
