--# -path=.:../abstract

concrete ConstructionGer of Construction = CatGer ** 
  open SyntaxGer, SymbolicGer, ParadigmsGer, 
       (L = LexiconGer), (E = ExtraGer), (G = GrammarGer), (I = IrregGer), (R = ResGer), (N = NounGer), Prelude in {
flags coding=utf8 ;


lin
  hungry_VP = mkVP (mkA "hungrig") ;
  thirsty_VP = mkVP (mkA "durstig") ;
  has_age_VP card = mkVP (lin AP (mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> L.year_N))) L.old_A)) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 I.heißen_V) (lin NP y) ;
  married_Cl x y = ----mkCl (lin NP x) L.married_A2 (lin NP y) | 
                   mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "verheiratet") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) I.heißen_V) ;
----  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ; ---- compilation slow
  how_old_QCl x = mkQCl (E.IAdvAdv (ParadigmsGer.mkAdv "alt")) (mkCl (lin NP x) G.UseCopula) ; ----
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (mkCl (mkVP (SyntaxGer.mkAdv to_Prep (lin NP x)))) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP have_V2 (mkNP (ParadigmsGer.mkN "Recht")) ;
  is_wrong_VP = mkVP have_V2 (mkNP (ParadigmsGer.mkN "Unrecht")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;
 
  bottle_of_CN np = N.ApposCN (mkCN (mkN "Flasche")) np ;
  cup_of_CN np    = N.ApposCN (mkCN (mkN "Tasse"))   np ;
  glass_of_CN np  = N.ApposCN (mkCN (mkN "Glas"))    np ;

-- spatial deixis and motion verbs
  where_go_QCl np = mkQCl (lin IAdv (ss "wohin")) (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "woher")) (mkCl np (mkVP L.come_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) (mkAdv "her") ;
  come_here_VP = mkVP (mkVP L.come_V) (mkAdv "her") ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "von hier") ;

  go_there_VP = mkVP (mkVP L.go_V) (mkAdv "hin") ;
  come_there_VP = mkVP (mkVP L.come_V) (mkAdv "hin") ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "von dort") ;

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = SyntaxGer.mkAdv anDat_Prep (mkNP the_Det w) ;         -- am Montag
  weekdayHabitualAdv w = SyntaxGer.mkAdv (mkPrep "" accusative) (mkNP every_Det w) ;            ---- jeden Montag
  weekdayLastAdv w = SyntaxGer.mkAdv (mkPrep "am letzten" dative) (mkNP w)  ; -- letzten Montag ----
  weekdayNextAdv w = SyntaxGer.mkAdv (mkPrep "am nächsten" dative) (mkNP w)  ; -- nächsten Montag ----

  monthAdv m = SyntaxGer.mkAdv inDat_Prep (mkNP the_Det m) ;
  yearAdv y = SyntaxGer.mkAdv (mkPrep "im Jahr" dative) y ; ----
  dayMonthAdv d m = ParadigmsGer.mkAdv ("am" ++ d.s ! dative ++ BIND ++ "." ++ m.s ! R.Sg ! R.Nom) ; -- am 17 Mai
  monthYearAdv m y = SyntaxGer.mkAdv inDat_Prep (mkNP the_Det (mkCN m y)) ; -- im Mai 2012
  dayMonthYearAdv d m y = ParadigmsGer.mkAdv ("am" ++ d.s ! dative ++ BIND ++ "." ++ m.s ! R.Sg ! R.Nom ++ y.s ! accusative) ; -- am 17 Mai 2013

  intYear = symb ;
  intMonthday = symb ;

lincat Language = N ;

lin InLanguage l = SyntaxGer.mkAdv on_Prep (mkNP l) ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

oper mkLanguage : Str -> N = \s -> mkN s neuter ; ---- produces Neuter

----------------------------------------------
---- lexicon of special names

lin monday_Weekday = mkN "Montag" ;
lin tuesday_Weekday = mkN "Dienstag" ;
lin wednesday_Weekday = mkN "Mittwoch" ;
lin thursday_Weekday = mkN "Donnerstag" ;
lin friday_Weekday = mkN "Freitag" ;
lin saturday_Weekday = mkN "Samstag" ;
lin sunday_Weekday = mkN "Sonntag" ;

lin january_Month = mkN "Januar" ; 
lin february_Month = mkN "Februar" ; 
lin march_Month = mkN "März" ; 
lin april_Month = mkN "April" ;
lin may_Month = mkN "Mai" ;
lin june_Month = mkN "Juni" ;
lin july_Month = mkN "Juli" ;
lin august_Month = mkN "August" ;
lin september_Month = mkN "September" ;
lin october_Month = mkN "Oktober" ;
lin november_Month = mkN "November" ;
lin december_Month = mkN "Dezember" ;

lin afrikaans_Language = mkLanguage "Afrikaans" ;
lin amharic_Language = mkLanguage "Amharisch" ;
lin arabic_Language = mkLanguage "Arabisch" ;
lin bulgarian_Language = mkLanguage "Bulgarisch" ;
lin catalan_Language = mkLanguage "Katalanish" ;
lin chinese_Language = mkLanguage "Chinesisch" ;
lin danish_Language = mkLanguage "Dänisch" ;
lin dutch_Language = mkLanguage "Holländisch" ;
lin english_Language = mkLanguage "Englisch" ;
lin estonian_Language = mkLanguage "Estnisch" ;
lin finnish_Language = mkLanguage "Finnisch" ;
lin french_Language = mkLanguage "Französisch" ;
lin german_Language = mkLanguage "Deutsch" ;
lin greek_Language = mkLanguage "Griechisch" ;
lin hebrew_Language = mkLanguage "Hebräisch" ;
lin hindi_Language = mkLanguage "Hindi" ;
lin japanese_Language = mkLanguage "Japanisch" ;
lin italian_Language = mkLanguage "Italienisch" ;
lin latin_Language = mkLanguage "Latein" ;
lin latvian_Language = mkLanguage "Lettisch" ;
lin maltese_Language = mkLanguage "Maltesisch" ;
lin nepali_Language = mkLanguage "Nepali" ;
lin norwegian_Language = mkLanguage "Norwegisch" ;
lin persian_Language = mkLanguage "Persisch" ;
lin polish_Language = mkLanguage "Polnisch" ;
lin punjabi_Language = mkLanguage "Punjabi" ;
lin romanian_Language = mkLanguage "Rumänisch" ;
lin russian_Language = mkLanguage "Russisch" ;
lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "Spanisch" ;
lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "Schwedisch" ;
lin thai_Language = mkLanguage "Thai" ;
lin turkish_Language = mkLanguage "Türkisch" ;
lin urdu_Language = mkLanguage "Urdu" ;
  
}
