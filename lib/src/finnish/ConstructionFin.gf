--# -path=alltenses:.:../abstract

concrete ConstructionFin of Construction = CatFin ** 
  open SyntaxFin, SymbolicFin, ParadigmsFin, (L = LexiconFin), (E = ExtraFin), (R = ResFin), Prelude  in {

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

lincat
  Weekday = {noun : N ; habitual : SyntaxFin.Adv} ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  monday_Weekday = mkWeekday "maanantai" ;
  tuesday_Weekday = mkWeekday "tiistai" ;
  wednesday_Weekday = mkWeekday "keskiviikko" ;
  thursday_Weekday = mkWeekday "torstai" ;
  friday_Weekday = mkWeekday "perjantai" ;
  saturday_Weekday = mkWeekday"lauantai" ;
  sunday_Weekday = mkWeekday "sunnuntai" ;

  weekdayPunctualAdv w = lin Adv {s = pointWeekday w} ;
  weekdayHabitualAdv w = w.habitual ;
  weekdayLastAdv w = ParadigmsFin.mkAdv ("viime" ++ pointWeekday w) ;
  weekdayNextAdv w = ParadigmsFin.mkAdv ("ensi" ++ pointWeekday w) ;

  monthAdv m = SyntaxFin.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxFin.mkAdv (prePrep nominative "vuonna") y ;
----  dayMonthAdv d m = ParadigmsFin.mkAdv (d.s ! R.NPCase R.Nom ++ BIND ++ "." ++ m.s ! R.NCase R.Sg R.Part) ;  
----  monthYearAdv m y = SyntaxFin.mkAdv in_Prep (mkNP (mkNP m) (SyntaxFin.mkAdv (casePrep nominative) y)) ;
----  dayMonthYearAdv d m y = 
----    lin Adv {s = d.s ! R.NPCase R.Nom ++ BIND ++ "." ++ m.s ! R.NCase R.Sg R.Part ++ y.s ! R.NPCase R.Nom} ;  

  intYear = symb ;
  intMonthday = symb ;
  
  january_Month = mkN "tammikuu" ; 
  february_Month = mkN "helmikuu" ; 
  march_Month = mkN "maaliskuu" ; 
  april_Month = mkN "huhtikuu" ;
  may_Month = mkN "toukokuu" ;
  june_Month = mkN "kesäkuu" ;
  july_Month = mkN "heinäkuu" ;
  august_Month = mkN "elokuu" ;
  september_Month = mkN "syyskuu" ;
  october_Month = mkN "lokakuu" ;
  november_Month = mkN "marraskuu" ;
  december_Month = mkN "joulukuu" ;

oper

  mkWeekday : Str -> Weekday = \d -> 
      lin Weekday {
       noun = mkN d ; 
       habitual = case d of {
         _ + "i" => ParadigmsFin.mkAdv (d + "sin") ; -- tiistaisin
         _ => ParadigmsFin.mkAdv (d + "isin")  -- keskiviikkoisin
         }
      } ; 

  pointWeekday : Weekday -> Str = \w -> (SyntaxFin.mkAdv (casePrep essive) (mkNP w.noun)).s ; 

}
