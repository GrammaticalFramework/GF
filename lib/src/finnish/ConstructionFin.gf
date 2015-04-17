--# -path=alltenses:.:../abstract

concrete ConstructionFin of Construction = CatFin ** 
  open SyntaxFin, SymbolicFin, ParadigmsFin, (L = LexiconFin), (E = ExtraFin), (R = ResFin), Prelude  in {
flags coding=utf8 ;

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

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "pullo") (mkPrep partitive)))  (lin NP np) |  mkCN (lin N2 (mkN2 (mkN "pullollinen") (mkPrep partitive)))  (lin NP np);
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "kuppi") (mkPrep partitive)))  (lin NP np) | mkCN (lin N2 (mkN2 (mkN "kupillinen") (mkPrep partitive)))  (lin NP np) ;
  glass_of_CN  np =  mkCN (lin N2 (mkN2 (mkN "lasi") (mkPrep partitive))) (lin NP np) | mkCN (lin N2 (mkN2 (mkN "lasillinen") (mkPrep partitive))) (lin NP np) ;


  few_X_short_of_Y np x y =
    let kaikki_xt : Str =  (mkNP all_Predet ( mkNP aPl_Det x)).s ! R.NPCase R.Nom ;
  	yssa : Str = y.s ! R.NCase R.Sg R.Iness ; 
	kaikki_xt_yssa : Adv = ParadigmsFin.mkAdv (kaikki_xt ++ yssa) ;
	olla_V : V = lin V have_V2 ;
    in mkS negativePol 
         (mkCl np (mkVP (mkVP olla_V) kaikki_xt_yssa)) ;

{-
  where_go_QCl np = mkQCl (lin IAdv (ss "minne")) (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "mistä")) (mkCl np (mkVP L.come_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) (mkAdv "tänne") ;
  come_here_VP = mkVP (mkVP L.come_V) (mkAdv "tänne") ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "täältä") ;

  go_there_VP = mkVP (mkVP L.go_V) (mkAdv "sinne") ;
  come_there_VP = mkVP (mkVP L.come_V) (mkAdv "sinne") ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "sieltä") ;
-}

lincat
  Timeunit = N ;
  Weekday = {noun : N ; habitual : SyntaxFin.Adv} ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  timeunitAdv n time = mkAdv ((mkNP <lin Card n : Card> time).s ! R.NPCase R.Nom) ;

  weekdayPunctualAdv w = lin Adv {s = pointWeekday w} ;
  weekdayHabitualAdv w = w.habitual ;
  weekdayLastAdv w = ParadigmsFin.mkAdv ("viime" ++ pointWeekday w) ;
  weekdayNextAdv w = ParadigmsFin.mkAdv ("ensi" ++ pointWeekday w) ;

  monthAdv m = SyntaxFin.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxFin.mkAdv (prePrep nominative "vuonna") y ;
  dayMonthAdv d m = ParadigmsFin.mkAdv ((mkUtt d).s ++ BIND ++ "." ++ (mkUtt (mkNP m)).s) ;
  monthYearAdv m y = SyntaxFin.mkAdv in_Prep (mkNP (mkNP m) (SyntaxFin.mkAdv (casePrep nominative) y)) ;
----  dayMonthYearAdv d m y = 
----    lin Adv {s = d.s ! R.NPCase R.Nom ++ BIND ++ "." ++ m.s ! R.NCase R.Sg R.Part ++ y.s ! R.NPCase R.Nom} ;  

  intYear = symb ;
  intMonthday = symb ;

oper
  pointWeekday : Weekday -> Str = \w -> (SyntaxFin.mkAdv (casePrep essive) (mkNP w.noun)).s ; 

lincat Language = N ;

lin InLanguage l = SyntaxFin.mkAdv (mkPrep translative) (mkNP l) ;

lin
  weekdayN w = w.noun ;
  monthN m = m ;

  weekdayPN w = mkPN w.noun ;
  monthPN m = mkPN m ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

--------------- lexicon of special names

oper mkLanguage : Str -> N = \s -> mkN s ;

oper mkWeekday : Str -> Weekday = \d -> 
      lin Weekday {
       noun = mkN d ; 
       habitual = case d of {
         _ + "i" => ParadigmsFin.mkAdv (d + "sin") ; -- tiistaisin
         _ => ParadigmsFin.mkAdv (d + "isin")  -- keskiviikkoisin
         }
      } ; 

lin second_Timeunit = mkN "sekuntti" ;
lin minute_Timeunit = mkN "minuutti" ;
lin hour_Timeunit = mkN "tunti" ;
lin day_Timeunit = mkN "päivä" ;
lin week_Timeunit = mkN "viikko" ;
lin month_Timeunit = mkN "kuukausi" "kuukauden" "kuukausia" "kuukautta" ;
lin year_Timeunit = mkN "vuosi" "vuoden" "vuosia" "vuotta" ;

lin monday_Weekday = mkWeekday "maanantai" ;
lin tuesday_Weekday = mkWeekday "tiistai" ;
lin wednesday_Weekday = mkWeekday "keskiviikko" ;
lin thursday_Weekday = mkWeekday "torstai" ;
lin friday_Weekday = mkWeekday "perjantai" ;
lin saturday_Weekday = mkWeekday"lauantai" ;
lin sunday_Weekday = mkWeekday "sunnuntai" ;

lin january_Month = mkN "tammikuu" ; 
lin february_Month = mkN "helmikuu" ; 
lin march_Month = mkN "maaliskuu" ; 
lin april_Month = mkN "huhtikuu" ;
lin may_Month = mkN "toukokuu" ;
lin june_Month = mkN "kesäkuu" ;
lin july_Month = mkN "heinäkuu" ;
lin august_Month = mkN "elokuu" ;
lin september_Month = mkN "syyskuu" ;
lin october_Month = mkN "lokakuu" ;
lin november_Month = mkN "marraskuu" ;
lin december_Month = mkN "joulukuu" ;

lin afrikaans_Language = mkLanguage "afrikaans" ;
lin amharic_Language = mkLanguage "amhara" ;
lin arabic_Language = mkLanguage "arabia" ;
lin bulgarian_Language = mkLanguage "bulgaria" ;
lin catalan_Language = mkLanguage "katalaani" ;
lin chinese_Language = mkLanguage "kiina" ;
lin danish_Language = mkLanguage "tanska" ;
lin dutch_Language = mkLanguage "hollanti" ;
lin english_Language = mkLanguage "englanti" ;
lin estonian_Language = mkLanguage "viro" ;
lin finnish_Language = mkN "suomi" "suomia" ;
lin french_Language = mkLanguage "ranska" ;
lin german_Language = mkLanguage "saksa" ;
lin greek_Language = mkLanguage "kreikka" ;
lin hebrew_Language = mkLanguage "heprea" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japani" ;
lin italian_Language = mkLanguage "italia" ;
lin latin_Language = mkLanguage "latina" ;
lin latvian_Language = mkLanguage "latvia" ;
lin maltese_Language = mkLanguage "malta" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norja" ;
lin persian_Language = mkLanguage "persia" ;
lin polish_Language = mkLanguage "puola" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "romania" ;
lin russian_Language = mkLanguage "venäjä" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "espanja" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "ruotsi" ;
lin thai_Language = mkLanguage "thai" ;
lin turkish_Language = mkLanguage "turkki" ;
lin urdu_Language = mkLanguage "urdu" ;


}
