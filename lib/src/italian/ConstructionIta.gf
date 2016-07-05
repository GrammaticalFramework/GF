--# -path=alltenses:.:../abstract

concrete ConstructionIta of Construction = CatIta ** 
  open SyntaxIta, SymbolicIta, ParadigmsIta, 
       (L = LexiconIta), (E = ExtraIta), (I = IrregIta), (R = ResIta), (C = CommonRomance),
       Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "fame")) ;
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "sete")) ;
  tired_VP = mkVP (mkA "stanco") ;
  scared_VP = E.ComplCN have_V2 (mkCN (mkN "paura" feminine)) ;
  ill_VP = mkVP (mkA "malato") ;
  ready_VP = mkVP (mkA "pronto") ;

  has_age_VP card = mkVP have_V2 (mkNP <lin Card card : Card> L.year_N) ;

  have_name_Cl x y = mkCl x (mkV2 (reflV (mkV "chiamare"))) y ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "sposato") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) (reflV (mkV "chiamare"))) ;
  how_old_QCl x = mkQCl (mkIP how8many_IDet L.year_N) x have_V2 ;
  how_far_QCl x = mkQCl how8much_IAdv (mkCl x (mkV "distare")) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (mkVA I.fare_V) (lin AP ap)) ;
   
  is_right_VP = E.ComplCN have_V2 (mkCN (mkN "ragione")) ;
  is_wrong_VP = mkVP (reflV (mkV "sbagliare")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "bottiglia" feminine) part_Prep)) np ;
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "tazza") part_Prep)) np ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 (mkN "bicchiere") part_Prep)) np ;

{-
-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl where_IAdv (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "d'où")) (mkCl np (mkVP L.go_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) here_Adv ;
  come_here_VP = mkVP (mkVP L.come_V) here_Adv ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "d'ici") ;

  go_there_VP = mkVP (mkVP L.go_V)  there_Adv ;
  come_there_VP = mkVP (mkVP L.come_V) there_Adv ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "de là") ;
-}  

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
oper
  noPrep : Prep = mkPrep [] ;

lin
  weekdayPunctualAdv w = lin Adv {s = w.s ! C.Sg} ;         -- lundi
  weekdayHabitualAdv w = SyntaxIta.mkAdv noPrep (mkNP the_Det w) ; -- il lunedí ----
  weekdayLastAdv w = SyntaxIta.mkAdv noPrep (mkNP the_Det (mkCN (mkA "scorso") w)) ; -- il lunedí scorso
  weekdayNextAdv w = SyntaxIta.mkAdv noPrep (mkNP the_Det (mkCN (mkA "prossimo") w)) ; -- il lunedí prossimo

  monthAdv m = lin Adv {s = "in" ++ m.s ! C.Sg} ;         -- in mggio
  yearAdv y = SyntaxIta.mkAdv (mkPrep "nel") y ; ----
  dayMonthAdv d m = ParadigmsIta.mkAdv ("il" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg) ; -- le 17 mai 
  monthYearAdv m y = lin Adv {s = "in" ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp} ;         -- in maggio 2012
  dayMonthYearAdv d m y = ParadigmsIta.mkAdv ("il" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp) ; -- il 17 maggio 2013

  intYear = symb ;
  intMonthday = symb ;
  

lincat Language = N ;

lin InLanguage l = SyntaxIta.mkAdv (mkPrep "in") (mkNP l) ;

lin
  weekdayN w = w ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "lunedí" ;
lin tuesday_Weekday = mkN "martedí" ;
lin wednesday_Weekday = mkN "mercoledí" ;
lin thursday_Weekday = mkN "giovedí" ;
lin friday_Weekday = mkN "venerdi" ;
lin saturday_Weekday = mkN "sabato" ;
lin sunday_Weekday = mkN "domenica" ;

lin january_Month = mkN "gennaio" ; 
lin february_Month = mkN "febbraio" ; 
lin march_Month = mkN "marzo" ; 
lin april_Month = mkN "aprile" ;
lin may_Month = mkN "maggio" ;
lin june_Month = mkN "giugno" ;
lin july_Month = mkN "luglio" ;
lin august_Month = mkN "agosto" ;
lin september_Month = mkN "settembre" ;
lin october_Month = mkN "ottobre" ;
lin november_Month = mkN "novembre" ;
lin december_Month = mkN "dicembre" ;

lin afrikaans_Language = mkLanguage "afrikaans" ;
lin amharic_Language = mkLanguage "amarico" ; 
lin arabic_Language = mkLanguage "arabo" ;
lin bulgarian_Language = mkLanguage "bulgaro" ;
lin catalan_Language = mkLanguage "catalano" ;
lin chinese_Language = mkLanguage "cinese" ;
lin danish_Language = mkLanguage "danese" ;
lin dutch_Language = mkLanguage "olandese" ;
lin english_Language = mkLanguage "inglese" ;
lin estonian_Language = mkLanguage "estone" ;
lin finnish_Language = mkLanguage "finnico" ;
lin french_Language = mkLanguage "francese" ;
lin german_Language = mkLanguage "tedesco" ;
lin greek_Language = mkLanguage "greco" ;
lin hebrew_Language = mkLanguage "ebraico" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "giapponese" ;
lin italian_Language = mkLanguage "italiano" ;
lin latin_Language = mkLanguage "latino" ;
lin latvian_Language = mkLanguage "lettone" ;
lin maltese_Language = mkLanguage "maltese" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norvegese" ;
lin persian_Language = mkLanguage "persiano" ;
lin polish_Language = mkLanguage "polacco" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "rumeno" ;
lin russian_Language = mkLanguage "russo" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "spagnolo" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "svedese" ;
lin thai_Language = mkLanguage "thai" ;
lin turkish_Language = mkLanguage "turco" ;
lin urdu_Language = mkLanguage "urdu" ;

}
