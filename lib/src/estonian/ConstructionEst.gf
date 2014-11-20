--# -path=alltenses:.:../abstract:../api:../common

concrete ConstructionEst of Construction = CatEst ** 
  open SyntaxEst, SymbolicEst, ParadigmsEst, (L = LexiconEst), (E = ExtraEst), (R = ResEst), Prelude  in {
flags coding=utf8 ;

lin
  hungry_VP = mkVP have_V2 (lin NP (mkNP (mkPN "kõht tühi"))) ;
  thirsty_VP = mkVP have_V2 (lin NP (mkNP (ParadigmsEst.mkN "janu"))) ;
  has_age_VP card = 
    let n_years_AdA : AdA = lin AdA (mkUtt (lin NP (mkNP <lin Card card : Card> L.year_N)))
    in  mkVP (mkAP n_years_AdA L.old_A) ;

  have_name_Cl x y = mkCl (mkNP (E.GenNP x) L.name_N) (lin NP y) ;
  married_Cl x y = mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (ParadigmsEst.mkAdv "abielus") ;

  what_name_QCl x = mkQCl (mkIComp whatSg_IP) (mkNP (E.GenNP x) L.name_N) ;
  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ;
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP have_V2 (lin NP (mkNP (ParadigmsEst.mkN "õigus"))) ;
  is_wrong_VP = mkVP (ParadigmsEst.mkV "eksima") ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (lin NP (mkNP <lin Card card : Card> (lin CN cn))))) (lin A a) ;

{-
  glass_of_CN  np =  mkCN (lin N2 (mkN2 (mkN "klaas") (mkPrep partitive))) (lin NP np) | mkCN (lin N2 (mkN2 (mkN "klaasitäis") (mkPrep partitive))) (lin NP np) ;


  where_go_QCl np = mkQCl (lin IAdv (ss "kuhu")) (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "kust")) (mkCl np (mkVP L.come_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) (mkAdv "siia") ;
  come_here_VP = mkVP (mkVP L.come_V) (mkAdv "siia") ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "sealt") ;

  go_there_VP = mkVP (mkVP L.go_V) (mkAdv "siia") ;
  come_there_VP = mkVP (mkVP L.come_V) (mkAdv "siia") ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "sealt") ;
-}

lincat
  Weekday = {noun : N ; habitual : SyntaxEst.Adv} ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin

  weekdayPunctualAdv w = lin Adv {s = pointWeekday w} ;
  weekdayHabitualAdv w = w.habitual ;
  weekdayLastAdv w = ParadigmsEst.mkAdv ("eelmisel" ++ pointWeekday w) ;
  weekdayNextAdv w = ParadigmsEst.mkAdv ("järgmisel" ++ pointWeekday w) ;

  monthAdv m = SyntaxEst.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxEst.mkAdv (prePrep nominative "aastal") y ;
----  dayMonthAdv d m = ParadigmsEst.mkAdv (d.s ! R.NPCase R.Nom ++ BIND ++ "." ++ m.s ! R.NCase R.Sg R.Part) ;  
----  monthYearAdv m y = SyntaxEst.mkAdv in_Prep (mkNP (mkNP m) (SyntaxEst.mkAdv (casePrep nominative) y)) ;
----  dayMonthYearAdv d m y = 
----    lin Adv {s = d.s ! R.NPCase R.Nom ++ BIND ++ "." ++ m.s ! R.NCase R.Sg R.Part ++ y.s ! R.NPCase R.Nom} ;  

  intYear = symb ;
  intMonthday = symb ;

oper
  pointWeekday : Weekday -> Str = \w -> (SyntaxEst.mkAdv (casePrep essive) (mkNP w.noun)).s ; 

lincat Language = N ;

--lin InLanguage l = SyntaxEst.mkAdv (mkPrep translative) (mkNP l) ;

lin
  weekdayN w = w.noun ;
  monthN m = m ;
  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

--------------- lexicon of special names

oper mkLanguage : Str -> N = \s -> mkN (s ++ "keel") ;

oper mkWeekday : Str -> Weekday = \d -> 
      lin Weekday {
       noun = mkN d ; 
       habitual = ParadigmsEst.mkAdv (d + "iti") ; --kolmapäeviti
      } ; 


lin monday_Weekday = mkWeekday "esmaspäev" ;
lin tuesday_Weekday = mkWeekday "teisipäev" ;
lin wednesday_Weekday = mkWeekday "kolmapäev" ;
lin thursday_Weekday = mkWeekday "neljapäev" ;
lin friday_Weekday = mkWeekday "reede" ;
lin saturday_Weekday = mkWeekday "laupäev" ;
lin sunday_Weekday = mkWeekday "pühapäev" ;

lin january_Month = mkN "jaanuar" ; 
lin february_Month = mkN "veebruar" ;
lin march_Month = mkN "märts" ; 
lin april_Month = mkN "aprill" ;
lin may_Month = mkN "mai" ;
lin june_Month = mkN "juuni" ;
lin july_Month = mkN "juuli" ;
lin august_Month = mkN "august" ;
lin september_Month = mkN "september" ;
lin october_Month = mkN "oktoober" ;
lin november_Month = mkN "november" ;
lin december_Month = mkN "detsember" ;



lin afrikaans_Language = mkLanguage "afrikaani" ;
lin amharic_Language = mkLanguage "amhara" ;
lin arabic_Language = mkLanguage "araabia" ;
lin bulgarian_Language = mkLanguage "bulgaaria" ;
lin catalan_Language = mkLanguage "katalaani" ;
lin chinese_Language = mkLanguage "hiina" ;
lin danish_Language = mkLanguage "taani" ;
lin dutch_Language = mkLanguage "hollandi" ;
lin english_Language = mkLanguage "inglise" ;
lin estonian_Language = mkLanguage "eesti" ;
lin finnish_Language = mkLanguage "soome" ;
lin french_Language = mkLanguage "prantsuse" ;
lin german_Language = mkLanguage "saksa" ;
lin greek_Language = mkLanguage "kreeka" ;
lin hebrew_Language = mkLanguage "heebrea" ;
lin hindi_Language = mkLanguage "hindi" ;
lin japanese_Language = mkLanguage "jaapani" ;
lin italian_Language = mkLanguage "itaalia" ;
lin latin_Language = mkLanguage "ladina" ;
lin latvian_Language = mkLanguage "läti" ;
lin maltese_Language = mkLanguage "malta" ;
lin nepali_Language = mkLanguage "nepali" ;
lin norwegian_Language = mkLanguage "norra" ;
lin persian_Language = mkLanguage "pärsia" ;
lin polish_Language = mkLanguage "poola" ;
lin punjabi_Language = mkLanguage "pandžabi" ;
lin romanian_Language = mkLanguage "rumeenia" ;
lin russian_Language = mkLanguage "vene" ;
lin sindhi_Language = mkLanguage "sindhi" ;
lin spanish_Language = mkLanguage "hispaania" ;
lin swahili_Language = mkLanguage "suahiili" ;
lin swedish_Language = mkLanguage "rootsi" ;
lin thai_Language = mkLanguage "tai" ;
lin turkish_Language = mkLanguage "türgi" ;
lin urdu_Language = mkLanguage "urdu" ;


}
