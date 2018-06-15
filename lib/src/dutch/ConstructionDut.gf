--# -path=.:../abstract

concrete ConstructionDut of Construction = CatDut ** 
  open SyntaxDut, SymbolicDut, ParadigmsDut, 
       (L = LexiconDut), (E = ExtendDut), (G = GrammarDut), (I = IrregDut), (R = ResDut), (N = NounDut), (P=ParamX), Prelude in {


lin
  hungry_VP = mkVP have_V2 (mkNP (mkN "honger")) ;
  thirsty_VP = mkVP have_V2 (mkNP (mkN "dorst")) ;
  tired_VP = mkVP (mkA "moe") ;
  scared_VP = mkVP (mkA "bang") ;
  ill_VP = mkVP (mkA "ziek") ;
  ready_VP = mkVP (mkA "klaar") ;

  has_age_VP card = mkVP (mkNP <card : Card> L.year_N) ;

  have_name_Cl x y = mkCl (lin NP x) (mkV2 I.heten_V) (lin NP y) ;
  married_Cl x y = ----mkCl (lin NP x) L.married_A2 (lin NP y) | 
                   mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "getrouwd") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) I.heten_V) ;
----  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ; ---- compilation slow in Ger
  how_old_QCl x = mkQCl (E.IAdvAdv (ParadigmsDut.mkAdv "oud")) (mkCl (lin NP x) G.UseCopula) ; ----
  how_far_QCl x = mkQCl (E.IAdvAdv L.far_Adv) (mkCl (mkVP (SyntaxDut.mkAdv to_Prep (lin NP x)))) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP have_V2 (mkNP (ParadigmsDut.mkN "gelijk")) ;
  is_wrong_VP = mkVP have_V2 (mkNP (ParadigmsDut.mkN "ongelijk")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;
 
  bottle_of_CN np = N.ApposCN (mkCN (mkN "vles")) np ; --- vlesje for beer
  cup_of_CN np    = N.ApposCN (mkCN (mkN "kopje"))   np ;
  glass_of_CN np  = N.ApposCN (mkCN (mkN "glas"))    np ;

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  weekdayPunctualAdv w = SyntaxDut.mkAdv (mkPrep "op") (mkNP the_Det w) ;         -- op maandag
  weekdayHabitualAdv w = SyntaxDut.mkAdv (mkPrep "") (mkNP every_Det w) ;         -- elke maandag
  weekdayLastAdv w = SyntaxDut.mkAdv (mkPrep "afgelopen") (mkNP w)  ; -- afgelopen maandag
  weekdayNextAdv w = SyntaxDut.mkAdv (mkPrep "volgende") (mkNP w)  ; -- volgende maandag

  monthAdv m = SyntaxDut.mkAdv in_Prep (mkNP the_Det m) ;
  yearAdv y = SyntaxDut.mkAdv (mkPrep "in jaar") y ; ----
  dayMonthAdv d m = ParadigmsDut.mkAdv ("op" ++ d.s ! R.NPNom ++ m.s ! R.NF R.Sg R.Nom) ; -- op 17 mei
  monthYearAdv m y = SyntaxDut.mkAdv in_Prep (mkNP the_Det (mkCN m y)) ; -- in mei 2012
  dayMonthYearAdv d m y = ParadigmsDut.mkAdv ("op" ++ d.s ! R.NPNom ++ m.s ! R.NF R.Sg R.Nom ++ y.s ! R.NPNom ) ; -- op 17 mei 2013

  intYear = symb ;
  intMonthday = symb ;

lincat Language = N ;

lin InLanguage l = SyntaxDut.mkAdv on_Prep (mkNP l) ;

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

lin monday_Weekday = mkN "maandag" ;
lin tuesday_Weekday = mkN "dinsdag" ;
lin wednesday_Weekday = mkN "woensdag" ;
lin thursday_Weekday = mkN "donderdag" ;
lin friday_Weekday = mkN "vrijdag" ;
lin saturday_Weekday = mkN "zaterdag" ;
lin sunday_Weekday = mkN "zondag" ;

lin january_Month = mkN "januari" ; 
lin february_Month = mkN "februari" ; 
lin march_Month = mkN "maart" ; 
lin april_Month = mkN "april" ;
lin may_Month = mkN "mei" ;
lin june_Month = mkN "juni" ;
lin july_Month = mkN "juli" ;
lin august_Month = mkN "augustus" ;
lin september_Month = mkN "september" ;
lin october_Month = mkN "oktober" ;
lin november_Month = mkN "november" ;
lin december_Month = mkN "december" ;

lin afrikaans_Language = mkLanguage "Afrikaans" ;
lin amharic_Language = mkLanguage "Amhaars" ;
lin arabic_Language = mkLanguage "Arabisch" ;
lin bulgarian_Language = mkLanguage "Bulgaars" ;
lin catalan_Language = mkLanguage "Catalaans" ;
lin chinese_Language = mkLanguage "Chinees" ;
lin danish_Language = mkLanguage "Deens" ;
lin dutch_Language = mkLanguage "Nederlands" ;
lin english_Language = mkLanguage "Engels" ;
lin estonian_Language = mkLanguage "Estisch" ;
lin finnish_Language = mkLanguage "Fins" ;
lin french_Language = mkLanguage "Frans" ;
lin german_Language = mkLanguage "Duits" ;
lin greek_Language = mkLanguage "Grieks" ;
lin hebrew_Language = mkLanguage "Hebreeuws" ;
lin hindi_Language = mkLanguage "Hindi" ;
lin japanese_Language = mkLanguage "Japans" ;
lin italian_Language = mkLanguage "Italiaans" ;
lin latin_Language = mkLanguage "Latijn" ;
lin latvian_Language = mkLanguage "Lets" ;
lin maltese_Language = mkLanguage "Maltees" ;
lin nepali_Language = mkLanguage "Nepali" ;
lin norwegian_Language = mkLanguage "Noors" ;
lin persian_Language = mkLanguage "Perzisch" ;
lin polish_Language = mkLanguage "Pools" ;
lin punjabi_Language = mkLanguage "Punjabi" ;
lin romanian_Language = mkLanguage "Roemeens" ;
lin russian_Language = mkLanguage "Russisch" ;
lin sindhi_Language = mkLanguage "Sindhi" ;
lin spanish_Language = mkLanguage "Spaans" ;
lin swahili_Language = mkLanguage "Swahili" ;
lin swedish_Language = mkLanguage "Zweeds" ;
lin thai_Language = mkLanguage "Thai" ;
lin turkish_Language = mkLanguage "Turks" ;
lin urdu_Language = mkLanguage "Urdu" ;
  
}
