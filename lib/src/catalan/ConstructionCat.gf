--# -path=alltenses:.:../abstract

concrete ConstructionCat of Construction = CatCat **
  open SyntaxCat, SymbolicCat, ParadigmsCat, BeschCat,
       (L = LexiconCat), (E = ExtraCat), (I = IrregCat), (R = ResCat), (C = CommonRomance),
       Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "gana" feminine)) ; -- "fam" (val)
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "set" feminine)) ;
  tired_VP = mkVP stateCopula (mkAP (mkA "cansat")) ;
  scared_VP = E.ComplCN have_V2 (mkCN (mkN "por" feminine)) ;
  ill_VP = mkVP stateCopula (mkAP (mkA "malalt")) ;
  ready_VP = mkVP stateCopula (mkAP (mkA "preparat")) ;

  has_age_VP card = mkVP have_V2 (mkNP <lin Card card : Card> L.year_N) ;

  have_name_Cl x y = mkCl x (mkV2 (reflV (mkV "dir"))) y ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "casat") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) (reflV (mkV "dir"))) ;
  how_old_QCl x = mkQCl (mkIP how8many_IDet L.year_N) x have_V2 ;
----  how_far_QCl x = mkQCl (lin IAdv (ss "a quina distància")) (mkCl x I.estar_V) ;

-- some more things
----  weather_adjCl ap = mkCl (mkVP (mkVA I.fer_V) (lin AP ap)) ;

  is_right_VP = E.ComplCN have_V2 (mkCN (mkN "raó")) ;
----  is_wrong_VP = mkVP (mkVA I.estar_V) (mkAP (mkA "equivocat")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "ampolla" feminine) part_Prep)) np ; -- "botella" (val)
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "tassa") part_Prep)) np ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 (mkN "got") part_Prep)) np ;

{-
-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl where_IAdv (mkCl np (mkVP L.go_V)) ;

  where_come_from_QCl np =  mkQCl (lin IAdv (ss "d'on")) (mkCl np (mkVP L.go_V)) ;

  go_here_VP = mkVP (mkVP L.go_V) here_Adv ;
  come_here_VP = mkVP (mkVP L.come_V) here_Adv ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "d'aquí") ;

  go_there_VP = mkVP (mkVP L.go_V)  there_Adv ;
  come_there_VP = mkVP (mkVP L.come_V) there_Adv ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "d'allà") ;
-}  

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
oper
  noPrep : Prep = mkPrep [] ;
  stateCopula = mkVA (mkV (estar_54 "estar")) ;

lin
  weekdayPunctualAdv w = lin Adv {s = w.s ! C.Sg} ;         -- lundi
  weekdayHabitualAdv w = SyntaxCat.mkAdv noPrep (mkNP the_Det w) ; -- il lunedí ----
  weekdayLastAdv w = SyntaxCat.mkAdv noPrep (mkNP the_Det (mkCN (mkA "passat") w)) ; -- il lunedí scorso
  weekdayNextAdv w = SyntaxCat.mkAdv noPrep (mkNP the_Det (mkCN (mkA "proper") w)) ; -- il lunedí prossimo

  monthAdv m = lin Adv {s = "en" ++ m.s ! C.Sg} ;         -- in mggio
  yearAdv y = SyntaxCat.mkAdv (mkPrep "el") y ; ----
  dayMonthAdv d m = ParadigmsCat.mkAdv ("el" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg) ; -- le 17 mai
  monthYearAdv m y = lin Adv {s = "el" ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp} ;         -- in maggio 2012
  dayMonthYearAdv d m y = ParadigmsCat.mkAdv ("el" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp) ; -- il 17 maggio 2013

  intYear = symb ;
  intMonthday = symb ;


lincat Language = PN ;

lin InLanguage l = SyntaxCat.mkAdv (mkPrep "en") (mkNP l) ;

lin
  weekdayN w = w ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languagePN l = l ;

oper mkLanguage : Str -> PN = \s -> mkPN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "dilluns" ;
lin tuesday_Weekday = mkN "dimarts" ;
lin wednesday_Weekday = mkN "dimecres" ;
lin thursday_Weekday = mkN "dijous" ;
lin friday_Weekday = mkN "divendres" ;
lin saturday_Weekday = mkN "dissabte" ;
lin sunday_Weekday = mkN "diumenge" ;

lin january_Month = mkN "gener" ; 
lin february_Month = mkN "febrer" ; 
lin march_Month = mkN "març" ; 
lin april_Month = mkN "abril" ;
lin may_Month = mkN "maig" ;
lin june_Month = mkN "juny" ;
lin july_Month = mkN "juliol" ;
lin august_Month = mkN "agost" ;
lin september_Month = mkN "septembre" ;
lin october_Month = mkN "octubre" ;
lin november_Month = mkN "novembre" ;
lin december_Month = mkN "desembre" ;

lin afrikaans_Language = mkLanguage "afrikáans" ;
lin amharic_Language = mkLanguage "amàric" ;
lin arabic_Language = mkLanguage "àrabe" ;
lin bulgarian_Language = mkLanguage "búlgar" ;
lin catalan_Language = mkLanguage "català" ;
lin chinese_Language = mkLanguage "xinès" ;
lin danish_Language = mkLanguage "danès" ;
lin dutch_Language = mkLanguage "neerlandès" ;
lin english_Language = mkLanguage "anglès" ;
lin estonian_Language = mkLanguage "estonià" ;
lin finnish_Language = mkLanguage "finès" ;
lin french_Language = mkLanguage "francès" ;
lin german_Language = mkLanguage "alemany" ;
lin greek_Language = mkLanguage "grec" ;
lin hebrew_Language = mkLanguage "hebreu" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japonès" ;
lin italian_Language = mkLanguage "italià" ;
lin latin_Language = mkLanguage "llatí" ;
lin latvian_Language = mkLanguage "letó" ;
lin maltese_Language = mkLanguage "maltès" ;
lin nepali_Language = mkLanguage "nepalès" ;
lin norwegian_Language = mkLanguage "noruec" ;
lin persian_Language = mkLanguage "persa" ;
lin polish_Language = mkLanguage "polonès" ;
lin punjabi_Language = mkLanguage "panjabi" ;
lin romanian_Language = mkLanguage "romanès" ;
lin russian_Language = mkLanguage "rus" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "castellà" ; -- espanyol
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "suec" ;
lin thai_Language = mkLanguage "tailandès" ;
lin turkish_Language = mkLanguage "turc" ;
lin urdu_Language = mkLanguage "urdu" ;

}
