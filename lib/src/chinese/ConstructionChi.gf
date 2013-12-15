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

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = lin Adv {s = w.s ; advType = timeAdvType} ;
  weekdayHabitualAdv w = lin Adv {s = w.s ; advType = timeAdvType} ;
  weekdayNextAdv w = lin Adv {s = "下" ++ w.s ; advType = timeAdvType} ;
  weekdayLastAdv w = lin Adv {s = "上" ++ w.s ; advType = timeAdvType} ;

  monthAdv m = lin Adv {s = m.s ; advType = timeAdvType} ;
  yearAdv y = lin Adv {s = y.s ++ "年" ; advType = timeAdvType} ;
  dayMonthAdv d m = lin Adv {s = m.s ++ d.s ++ "日" ; advType = timeAdvType} ;
  monthYearAdv m y = lin Adv {s = y.s ++ "年" ++ m.s ; advType = timeAdvType} ;
  dayMonthYearAdv d m y = lin Adv {s = y.s ++ "年"  ++ m.s ++ d.s ++ "日" ; advType = timeAdvType} ;

  intYear i = lin NP i ;
  intMonthday i = lin NP i ;

  monday_Weekday = mkN "星期一" ;
  tuesday_Weekday = mkN "星期二" ;
  wednesday_Weekday = mkN "星期三" ;
  thursday_Weekday = mkN "星期四" ;
  friday_Weekday = mkN "星期五" ;
  saturday_Weekday = mkN "星期六" ;
  sunday_Weekday = mkN "星期日" ;

  january_Month = mkN "一月" ; 
  february_Month = mkN "二月" ; 
  march_Month = mkN "三月" ; 
  april_Month = mkN "四月" ;
  may_Month = mkN "五月" ;
  june_Month = mkN "六月" ;
  july_Month = mkN "七月" ;
  august_Month = mkN "八月t" ;
  september_Month = mkN "九月" ;
  october_Month = mkN "十月" ;
  november_Month = mkN "十一月" ;
  december_Month = mkN "十二月" ;

}
