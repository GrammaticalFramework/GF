--# -path=.:../abstract

concrete ConstructionEng of Construction = CatEng ** 
  open SyntaxEng, SymbolicEng, ParadigmsEng, (L = LexiconEng), (E = ExtraEng), (G = GrammarEng), (R = ResEng), Prelude in {


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

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = SyntaxEng.mkAdv on_Prep (mkNP w) ;         -- on Sunday
  weekdayHabitualAdv w = SyntaxEng.mkAdv on_Prep (mkNP aPl_Det w) ; -- on Sundays
  weekdayNextAdv w = SyntaxEng.mkAdv (mkPrep "next") (mkNP w) ;     -- next Sunday
  weekdayLastAdv w = SyntaxEng.mkAdv (mkPrep "last") (mkNP w) ;     -- last Sunday

  monthAdv m = SyntaxEng.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxEng.mkAdv in_Prep y ;
  dayMonthAdv d m = ParadigmsEng.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom) ; -- on 17 May
  monthYearAdv m y = SyntaxEng.mkAdv in_Prep (mkNP (mkCN m y)) ; -- in May 2012
  dayMonthYearAdv d m y = ParadigmsEng.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom ++ y.s ! R.NPAcc) ; -- on 17 May 2013

  intYear = symb ;
  intMonthday = symb ;

  monday_Weekday = mkN "Monday" ;
  tuesday_Weekday = mkN "Tuesday" ;
  wednesday_Weekday = mkN "Wednesday" ;
  thursday_Weekday = mkN "Thursday" ;
  friday_Weekday = mkN "Friday" ;
  saturday_Weekday = mkN "Saturday" ;
  sunday_Weekday = mkN "Sunday" ;

  january_Month = mkN "January" ; 
  february_Month = mkN "February" ; 
  march_Month = mkN "March" ; 
  april_Month = mkN "April" ;
  may_Month = mkN "May" ;
  june_Month = mkN "June" ;
  july_Month = mkN "July" ;
  august_Month = mkN "August" ;
  september_Month = mkN "September" ;
  october_Month = mkN "October" ;
  november_Month = mkN "November" ;
  december_Month = mkN "December" ;

}
