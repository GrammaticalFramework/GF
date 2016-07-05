--# -path=alltenses:.:../abstract

concrete ConstructionSpa of Construction = CatSpa ** 
  open SyntaxSpa, SymbolicSpa, ParadigmsSpa, BeschSpa,
       (L = LexiconSpa), (E = ExtraSpa), (I = IrregSpa), (R = ResSpa), (C = CommonRomance),
       Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "hambre" feminine)) ;
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "sed" feminine)) ;
  tired_VP = mkVP stateCopula (mkAP (mkA "cansado")) ;
  scared_VP = E.ComplCN have_V2 (mkCN (mkN "miedo")) ;
  ill_VP = mkVP stateCopula (mkAP (mkA "enfermo")) ;
  ready_VP = mkVP stateCopula (mkAP (mkA "listo")) ;

  has_age_VP card = mkVP have_V2 (mkNP <lin Card card : Card> L.year_N) ;

  have_name_Cl x y = mkCl x (mkV2 (reflV (mkV "llamar"))) y ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "casado") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) (reflV (mkV "llamar"))) ;
  how_old_QCl x = mkQCl (mkIP how8many_IDet L.year_N) x have_V2 ;
  how_far_QCl x = mkQCl (lin IAdv (ss "a qué distancia")) (mkCl x I.estar_V) ; 

-- some more things
  weather_adjCl ap = mkCl (mkVP (mkVA I.hacer_V) (lin AP ap)) ;
   
  is_right_VP = E.ComplCN have_V2 (mkCN (mkN "razón")) ;
  is_wrong_VP = mkVP (mkVA I.estar_V) (mkAP (mkA "equivocado")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "botella" feminine) part_Prep)) np ;
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "taza") part_Prep)) np ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 (mkN "vaso") part_Prep)) np ; -- copa

{-
-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl where_IAdv (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "de dónde")) (mkCl np (mkVP L.go_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) here_Adv ;
  come_here_VP = mkVP (mkVP L.come_V) here_Adv ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "de aquí") ;

  go_there_VP = mkVP (mkVP L.go_V)  there_Adv ;
  come_there_VP = mkVP (mkVP L.come_V) there_Adv ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "de allí") ; -- "de allá"
-}  

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
oper
  noPrep : Prep = mkPrep [] ;
  stateCopula = mkVA (mkV (estar_2 "estar")) ;

lin
  weekdayPunctualAdv w = lin Adv {s = w.s ! C.Sg} ;         -- lundi
  weekdayHabitualAdv w = SyntaxSpa.mkAdv noPrep (mkNP the_Det w) ; -- il lunedí ----
  weekdayLastAdv w = SyntaxSpa.mkAdv noPrep (mkNP the_Det (mkCN (mkA "pasado") w)) ; -- il lunedí scorso
  weekdayNextAdv w = SyntaxSpa.mkAdv noPrep (mkNP the_Det (mkCN (mkA "próximo") w)) ; -- il lunedí prossimo

  monthAdv m = lin Adv {s = "en" ++ m.s ! C.Sg} ;         -- in mggio
  yearAdv y = SyntaxSpa.mkAdv (mkPrep "en") y ; ----
  dayMonthAdv d m = ParadigmsSpa.mkAdv ("el" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg) ; -- le 17 mai 
  monthYearAdv m y = lin Adv {s = "en" ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp} ;         -- in maggio 2012
  dayMonthYearAdv d m y = ParadigmsSpa.mkAdv ("el" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp) ; -- il 17 maggio 2013

  intYear = symb ;
  intMonthday = symb ;
  

lincat Language = N ;

lin InLanguage l = SyntaxSpa.mkAdv (mkPrep "en") (mkNP l) ;

lin
  weekdayN w = w ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "lunes" ;
lin tuesday_Weekday = mkN "martes" ;
lin wednesday_Weekday = mkN "miércoles" ;
lin thursday_Weekday = mkN "jueves" ;
lin friday_Weekday = mkN "viernes" ;
lin saturday_Weekday = mkN "sábado" ;
lin sunday_Weekday = mkN "domingo" ;

lin january_Month = mkN "enero" ; 
lin february_Month = mkN "febrero" ; 
lin march_Month = mkN "marzo" ; 
lin april_Month = mkN "abril" ;
lin may_Month = mkN "mayo" ;
lin june_Month = mkN "junio" ;
lin july_Month = mkN "julio" ;
lin august_Month = mkN "agosto" ;
lin september_Month = mkN "septiembre" ;
lin october_Month = mkN "octubre" ;
lin november_Month = mkN "noviembre" ;
lin december_Month = mkN "diciembre" ;

lin afrikaans_Language = mkLanguage "afrikáans" ; 
lin amharic_Language = mkLanguage "amárico" ; 
lin arabic_Language = mkLanguage "árabe" ; 
lin bulgarian_Language = mkLanguage "búlgaro" ;
lin catalan_Language = mkLanguage "catalán" ;
lin chinese_Language = mkLanguage "chino" ; 
lin danish_Language = mkLanguage "danés" ; 
lin dutch_Language = mkLanguage "neerlandés" ;
lin english_Language = mkLanguage "inglés" ;
lin estonian_Language = mkLanguage "estonio" ;
lin finnish_Language = mkLanguage "finés" ;
lin french_Language = mkLanguage "francés" ;
lin german_Language = mkLanguage "alemán" ;
lin greek_Language = mkLanguage "griego" ; 
lin hebrew_Language = mkLanguage "ebreo" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japonés" ;
lin italian_Language = mkLanguage "italiano" ;
lin latin_Language = mkLanguage "latín" ;
lin latvian_Language = mkLanguage "letón" ;
lin maltese_Language = mkLanguage "maltés" ;
lin nepali_Language = mkLanguage "nepalí" ;
lin norwegian_Language = mkLanguage "noruego" ;
lin persian_Language = mkLanguage "persa" ;
lin polish_Language = mkLanguage "polaco" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "rumano" ;
lin russian_Language = mkLanguage "ruso" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "español" | mkLanguage "castellano" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "sueco" ;
lin thai_Language = mkLanguage "tailandés" ;
lin turkish_Language = mkLanguage "turco" ;
lin urdu_Language = mkLanguage "urdu" ;

}
