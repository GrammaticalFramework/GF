--# -path=alltenses:.:../abstract

concrete ConstructionFre of Construction = CatFre ** 
  open SyntaxFre, SymbolicFre, ParadigmsFre, 
       (L = LexiconFre), (E = ExtraFre), (I = IrregFre), (R = ResFre), (C = CommonRomance),
       Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "faim")) ;
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "soif")) ;
  tired_VP = mkVP (mkA "fatigué") ;
  scared_VP = E.ComplCN have_V2 (mkCN (mkN "peur" feminine)) ;
  ill_VP = mkVP (mkA "malade") ;
  ready_VP = mkVP (mkA "prêt") ;

  has_age_VP card = mkVP have_V2 (mkNP <lin Card card : Card> L.year_N) ;

  have_name_Cl x y = mkCl x (mkV2 (reflV (mkV "appeler"))) y ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "marié") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) (reflV (mkV "appeler"))) ;
  how_old_QCl x = mkQCl (mkIP whichSg_IDet (mkN "âge" masculine)) (lin NP x) have_V2 ;
  how_far_QCl x = mkQCl (mkIAdv dative (mkIP which_IDet (mkN "distance"))) x ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (mkVA (mkV I.faire_V2)) (lin AP ap)) ;
   
  is_right_VP = E.ComplCN have_V2 (mkCN (mkN "raison")) ;
  is_wrong_VP = E.ComplCN have_V2 (mkCN (mkN "tort")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "bouteille" feminine) part_Prep)) np ;
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "tasse") part_Prep)) np ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 (mkN "verre") part_Prep)) np ;

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
  weekdayHabitualAdv w = SyntaxFre.mkAdv noPrep (mkNP the_Det w) ; -- le lundi
  weekdayLastAdv w = SyntaxFre.mkAdv noPrep (mkNP the_Det (mkCN (mkA "dernier") w)) ; -- le lundi dernier
  weekdayNextAdv w = SyntaxFre.mkAdv noPrep (mkNP the_Det (mkCN (mkA "prochain") w)) ; -- le lundi prochain

  monthAdv m = lin Adv {s = "en" ++ m.s ! C.Sg} ;         -- en mai
  yearAdv y = SyntaxFre.mkAdv (mkPrep "en") y ;
  dayMonthAdv d m = ParadigmsFre.mkAdv ("le" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg) ; -- le 17 mai ---- le 1 mai should be le 1er mai
  monthYearAdv m y = lin Adv {s = "en" ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp} ;         -- en mai 2012
  dayMonthYearAdv d m y = ParadigmsFre.mkAdv ("le" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp) ; -- le 17 mai 2013

  intYear = symb ;
  intMonthday = symb ;
  

lincat Language = N ;

lin InLanguage l = SyntaxFre.mkAdv (mkPrep "en") (mkNP l) ;

lin
  weekdayN w = w ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageCN l = mkCN l ;
  languageNP l = mkNP the_Det l ;

oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "lundi" ;
lin tuesday_Weekday = mkN "mardi" ;
lin wednesday_Weekday = mkN "mercredi" ;
lin thursday_Weekday = mkN "jeudi" ;
lin friday_Weekday = mkN "vendredi" ;
lin saturday_Weekday = mkN "samedi" ;
lin sunday_Weekday = mkN "dimanche" masculine ;

lin january_Month = mkN "janvier" ; 
lin february_Month = mkN "février" ; 
lin march_Month = mkN "mars" ; 
lin april_Month = mkN "avril" ;
lin may_Month = mkN "mai" ;
lin june_Month = mkN "juin" ;
lin july_Month = mkN "juillet" ;
lin august_Month = mkN "août" ;
lin september_Month = mkN "septembre" ;
lin october_Month = mkN "octobre" ;
lin november_Month = mkN "novembre" ;
lin december_Month = mkN "décembre" ;

lin afrikaans_Language = mkLanguage "afrikaans" ;
lin amharic_Language = mkLanguage "amharique" ; ----
lin arabic_Language = mkLanguage "arabe" ;
lin bulgarian_Language = mkLanguage "bulgare" ;
lin catalan_Language = mkLanguage "catalan" ;
lin chinese_Language = mkLanguage "chinois" ;
lin danish_Language = mkLanguage "danois" ;
lin dutch_Language = mkLanguage "hollandais" ;
lin english_Language = mkLanguage "anglais" ;
lin estonian_Language = mkLanguage "estonien" ;
lin finnish_Language = mkLanguage "finnois" ;
lin french_Language = mkLanguage "français" ;
lin german_Language = mkLanguage "allemand" ;
lin greek_Language = mkLanguage "grècque" ;
lin hebrew_Language = mkLanguage "hebreu" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japonais" ;
lin italian_Language = mkLanguage "italien" ;
lin latin_Language = mkLanguage "latin" ;
lin latvian_Language = mkLanguage "letton" ;
lin maltese_Language = mkLanguage "maltais" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norvégien" ;
lin persian_Language = mkLanguage "persien" ;
lin polish_Language = mkLanguage "polonais" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "roumain" ;
lin russian_Language = mkLanguage "russe" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "espagnol" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "suédois" ;
lin thai_Language = mkLanguage "thaï" ;
lin turkish_Language = mkLanguage "turque" ;
lin urdu_Language = mkLanguage "urdu" ;

}
