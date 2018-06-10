--# -path=.:../abstract

concrete ConstructionSwe of Construction = CatSwe ** 
  open SyntaxSwe, SymbolicSwe, ParadigmsSwe, (L = LexiconSwe), (E = ExtraSwe), (G = GrammarSwe), (R = ResSwe), (C = CommonScand), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP (mkA "hungrig") ;
  thirsty_VP = mkVP (mkA "törstig") ;
  tired_VP = mkVP (mkA "trött") ;
  scared_VP = mkVP (mkA "rädd") ;
  ill_VP = mkVP (mkA "sjuk") ;
  ready_VP = mkVP (mkA "färdig") ;

  has_age_VP card = mkVP (lin AP (mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> L.year_N))) L.old_A)) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 (mkV "heta" "hette" "hetat")) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "gift") ;

  what_name_QCl x = mkQCl whatSg_IP (lin NP x) (mkV2 (mkV "heta" "hette" "hetat")) ;
  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ;
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (mkCl (mkVP (SyntaxSwe.mkAdv to_Prep (lin NP x)))) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP have_V2 (mkNP (ParadigmsSwe.mkN "rätt")) ;
  is_wrong_VP = mkVP have_V2 (mkNP (ParadigmsSwe.mkN "fel")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "flaska") noPrep))      (lin NP np) ;
  cup_of_CN np    = mkCN (lin N2 (mkN2 (mkN "kopp") noPrep))        (lin NP np) ;
  glass_of_CN np  = mkCN (lin N2 (mkN2 (mkN "glas" "glas") noPrep)) (lin NP np) ;

{-
-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl (lin IAdv (ss "vart")) (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "varifrån")) (mkCl np (mkVP L.come_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) (mkAdv "hit") ;
  come_here_VP = mkVP (mkVP L.come_V) (mkAdv "hit") ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "härifrån") ;

  go_there_VP = mkVP (mkVP L.go_V) (mkAdv "dit") ;
  come_there_VP = mkVP (mkVP L.come_V) (mkAdv "dit") ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "därifrån") ;
-}

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = SyntaxSwe.mkAdv on_Prep (mkNP w) ;         -- på söndag
  weekdayHabitualAdv w = SyntaxSwe.mkAdv on_Prep (mkNP aPl_Det w) ; -- på söndagar
  weekdayLastAdv w = SyntaxSwe.mkAdv in_Prep (mkNP (E.GenNP (mkNP w))) ; -- i söndags
  weekdayNextAdv w = SyntaxSwe.mkAdv (mkPrep "nästa") (mkNP w) ; -- nästa söndag --- can mean a week later than English "next Sunday"

  monthAdv m = SyntaxSwe.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxSwe.mkAdv (mkPrep "år") y ;
  dayMonthAdv d m = ParadigmsSwe.mkAdv ("den" ++ d.s ! C.NPAcc ++ m.s ! C.Sg ! C.Indef ! C.Nom) ; -- den 17 maj
  monthYearAdv m y = SyntaxSwe.mkAdv in_Prep (mkNP (mkCN m y)) ; -- i maj 2012
  dayMonthYearAdv d m y = ParadigmsSwe.mkAdv ("den" ++ d.s ! C.NPAcc ++ m.s ! C.Sg ! C.Indef ! C.Nom ++ y.s ! C.NPAcc) ; -- den 17 maj 2013

  intYear = symb ;
  intMonthday = symb ;
  

lincat Language = N ;

lin InLanguage l = SyntaxSwe.mkAdv on_Prep (mkNP l) ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageCN l = mkCN l ;
  languageNP l = mkNP l ;

oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = changeCompoundN "måndags" (mkN "måndag") ;
lin tuesday_Weekday = changeCompoundN "tisdags" (mkN "tisdag") ;
lin wednesday_Weekday = changeCompoundN "onsdags" (mkN "onsdag") ;
lin thursday_Weekday = changeCompoundN "torsdags" (mkN "torsdag") ;
lin friday_Weekday = changeCompoundN "fredags" (mkN "fredag") ;
lin saturday_Weekday = changeCompoundN "lördags" (mkN "lördag") ;
lin sunday_Weekday = changeCompoundN "söndags" (mkN "söndag") ;

lin january_Month = mkN "januari" ; 
lin february_Month = mkN "februari" ; 
lin march_Month = mkN "mars" ; 
lin april_Month = mkN "april" ;
lin may_Month = mkN "maj" ;
lin june_Month = mkN "juni" ;
lin july_Month = mkN "juli" ;
lin august_Month = mkN "augusti" ;
lin september_Month = mkN "september" ;
lin october_Month = mkN "oktober" ;
lin november_Month = mkN "november" ;
lin december_Month = mkN "december" ;

lin afrikaans_Language = mkLanguage "afrikaans" ;
lin amharic_Language = mkLanguage "amhariska" ;
lin arabic_Language = mkLanguage "arabiska" ;
lin bulgarian_Language = mkLanguage "bulgariska" ;
lin catalan_Language = mkLanguage "catalanska" ;
lin chinese_Language = mkLanguage "kinesiska" ;
lin danish_Language = mkLanguage "danska" ;
lin dutch_Language = mkLanguage "holländska" ;
lin english_Language = mkLanguage "engelska" ;
lin estonian_Language = mkLanguage "estniska" ;
lin finnish_Language = mkLanguage "finska" ;
lin french_Language = mkLanguage "franska" ;
lin german_Language = mkLanguage "tyska" ;
lin greek_Language = mkLanguage "grekiska" ;
lin hebrew_Language = mkLanguage "hebreiska" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "japanska" ;
lin italian_Language = mkLanguage "italienska" ;
lin latin_Language = mkLanguage "latin" ;
lin latvian_Language = mkLanguage "lettiska" ;
lin maltese_Language = mkLanguage "maltesiska" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norska" ;
lin persian_Language = mkLanguage "persiska" ;
lin polish_Language = mkLanguage "polska" ;
lin punjabi_Language = mkLanguage "punjabi" ;
lin romanian_Language = mkLanguage "rumänska" ;
lin russian_Language = mkLanguage "ryska" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "spanska" ;
lin swahili_Language = mkLanguage "swahili" ;
lin swedish_Language = mkLanguage "svenska" ;
lin thai_Language = mkLanguage "thai" ;
lin turkish_Language = mkLanguage "turkiska" ;
lin urdu_Language = mkLanguage "urdu" ;

}
