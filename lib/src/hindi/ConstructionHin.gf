--# -path=.:../abstract

concrete ConstructionHin of Construction = CatHin ** 
  open SyntaxHin, SymbolicHin, ParadigmsHin, (L = LexiconHin), (E = ExtraHin), (G = GrammarHin), (R = ResHin), (S = StructuralHin), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP  (mkA "भूखा") ;
  thirsty_VP = mkVP (mkA "प्यासा") ;
--  tired_VP = mkVP (mkCompoundA "थका" "हुआ") ;
--  scared_VP = mkVP (mkCompoundA "डरा" "हुआ") ;
  ill_VP = mkVP (mkA "बीमार") ;
  ready_VP = mkVP (mkA "तैयार") ;

  has_age_VP card = mkVP (mkNP <card : Card> (mkCN (mmodN L.year_N))) ;

  have_name_Cl x y = mkCl (mkNP (E.GenNP x) L.name_N) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) ;

  what_name_QCl x = mkQCl (mkIComp whatSg_IP) (mkNP (E.GenNP x) L.name_N) ;
  how_old_QCl x = mkQCl (lin IAdv {s = "कितनी"}) (mkNP (E.GenNP x) (mkN "उम्र" "उम्र" "उम्र" "उम्र" "उम्र" "उम्र" feminine)) ;
  how_far_QCl x = mkQCl (E.IAdvAdv (ParadigmsHin.mkAdv "दूर")) (lin NP x) ;

oper
  mmodN : N -> N = \noun -> lin N {s = \\n,c =>noun.s!n!c++"का" ; g =noun.g} ;

-- some more things
----  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
----  is_right_VP = mkVP (ParadigmsHin.mkA "right") ;
----  is_wrong_VP = mkVP (ParadigmsHin.mkA "wrong") ;

----  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;


----  bottle_of_CN np = mkCN (lin N2 (mkN2 "bottle")) (lin NP np) ;
----  cup_of_CN    np = mkCN (lin N2 (mkN2 "cup"))    (lin NP np) ;
----  glass_of_CN  np = mkCN (lin N2 (mkN2 "glass"))  (lin NP np) ;

{-
-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl where_IAdv (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl from_where_IAdv (mkCl np (mkVP L.go_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) S.here_Adv ;
  come_here_VP = mkVP (mkVP L.come_V) S.here_Adv ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "from here") ;

  go_there_VP = mkVP (mkVP L.go_V)  S.there_Adv ;
  come_there_VP = mkVP (mkVP L.come_V) S.there_Adv ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "from there") ;

--TODO "where did X come from" instead of "from where did X come"
oper from_where_IAdv : IAdv = lin IAdv (ss "from where") ;

-}


lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;

lin
{- ----
  weekdayPunctualAdv w = SyntaxHin.mkAdv on_Prep (mkNP w) ;         -- on Sunday
  weekdayHabitualAdv w = SyntaxHin.mkAdv on_Prep (mkNP aPl_Det w) ; -- on Sundays
  weekdayNextAdv w = SyntaxHin.mkAdv (mkPrep "next") (mkNP w) ;     -- next Sunday
  weekdayLastAdv w = SyntaxHin.mkAdv (mkPrep "last") (mkNP w) ;     -- last Sunday

  monthAdv m = SyntaxHin.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxHin.mkAdv in_Prep y ;
  dayMonthAdv d m = ParadigmsHin.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom) ; -- on 17 May
  monthYearAdv m y = SyntaxHin.mkAdv in_Prep (mkNP (mkCN m y)) ; -- in May 2012
  dayMonthYearAdv d m y = ParadigmsHin.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom ++ y.s ! R.NPAcc) ; -- on 17 May 2013
-}
  intYear = symb ;
  intMonthday = symb ;

lincat Language = PN ;

lin InLanguage l = SyntaxHin.mkAdv in_Prep (mkNP l) ; ----

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languagePN l = l ;

oper mkLanguage : Str -> PN = \s -> mkPN s ;

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "सोमवार" ;
lin tuesday_Weekday = mkN "मंगलवार" ;
lin wednesday_Weekday = mkN "बुधवार" ;
lin thursday_Weekday = mkN "गुरुवार" ;
lin friday_Weekday = mkN "शुक्रवार" ;
lin saturday_Weekday = mkN "शनिवार" ;
lin sunday_Weekday = mkN "रविवार" ;

lin january_Month = mkN "जनवरी" ;
lin february_Month = mkN "फ़रवरी" ;
lin march_Month = mkN "मार्च" ;
lin april_Month = mkN "अप्रैल" ;
lin may_Month = mkN "मई" ;
lin june_Month = mkN "जून" ;
lin july_Month = mkN "जुलाई" ;
lin august_Month = mkN "अगस्त" ;
lin september_Month = mkN "सितम्बर" ; 
lin october_Month = mkN "अक्टूबर" ;
lin november_Month = mkN "नवम्बर" ;
lin december_Month = mkN "दिसम्बर" ;

lin afrikaans_Language = mkLanguage "Afrikaans" ;
lin amharic_Language = mkLanguage "Amharic" ;
lin arabic_Language = mkLanguage "Arabic" ;
lin bulgarian_Language = mkLanguage "बल्गेरियाई" ;
lin catalan_Language = mkLanguage "Catalan" ;
lin chinese_Language = mkLanguage "चीनी" ;
lin danish_Language = mkLanguage "Danish" ;
lin dutch_Language = mkLanguage "Dutch" ;
lin english_Language = mkLanguage "अंग्रेज़ी" ;
lin estonian_Language = mkLanguage "Estonian" ;
lin finnish_Language = mkLanguage "Finnish" ;
lin french_Language = mkLanguage "फ्रेंच" ;
lin german_Language = mkLanguage "जर्मन" ;
lin greek_Language = mkLanguage "Greek" ;
lin hebrew_Language = mkLanguage "Hebrew" ;
lin hindi_Language = mkLanguage "हिंदी" ;
lin japanese_Language = mkLanguage "Japanese" ;
lin italian_Language = mkLanguage "Italian" ;
lin latin_Language = mkLanguage "Latin" ;
lin latvian_Language = mkLanguage "Latvian" ;
lin maltese_Language = mkLanguage "Maltese" ;
lin nepali_Language = mkLanguage "Nepali" ;
lin norwegian_Language = mkLanguage "Norwegian" ;
lin persian_Language = mkLanguage "Persian" ;
lin polish_Language = mkLanguage "Polish" ;
lin punjabi_Language = mkLanguage "Punjabi" ;
lin romanian_Language = mkLanguage "Romanian" ;
lin russian_Language = mkLanguage "Russian" ;
lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "Spanish" ;
lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "Swedish" ;
lin thai_Language = mkLanguage "Thai" ;
lin turkish_Language = mkLanguage "Turkish" ;
lin urdu_Language = mkLanguage "Urdu" ;


}
