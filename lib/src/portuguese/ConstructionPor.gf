--# -path=alltenses:.:../abstract

concrete ConstructionPor of Construction = CatPor **
  open SyntaxPor, SymbolicPor, ParadigmsPor, BeschPor,
       (L = LexiconPor), (E = ExtraPor), (I = IrregPor), (R = ResPor), (C = CommonRomance),
       Prelude in {
  flags coding=utf8 ;

lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "fome" feminine)) ;
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "sede" feminine)) ;
  tired_VP = mkVP (mkA "cansado") ;
  scared_VP = mkVP (mkA "assustado") ;
  ill_VP = mkVP (mkA "doente") ;
  ready_VP = mkVP (mkA "pronto") ;
  has_age_VP card = mkVP have_V2 (mkNP <lin Card card : Card> L.year_N) ;

  have_name_Cl x y = mkCl x (mkV2 (reflV (mkV "chamar"))) y ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "casado") ;

  what_name_QCl x = mkQCl how_IAdv (mkCl (lin NP x) (reflV (mkV "chamar"))) ;
  how_old_QCl x = mkQCl (mkIP how8many_IDet L.year_N) x have_V2 ;
  how_far_QCl x = mkQCl (lin IAdv (ss "a que distância")) (mkCl x I.estar_V) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (mkVA I.fazer_V) (lin AP ap)) ;

  is_right_VP = E.ComplCN have_V2 (mkCN (mkN "razão")) ;
  is_wrong_VP = mkVP (mkVA I.estar_V) (mkAP (mkA "errado")) ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;

  bottle_of_CN np = mkCN (lin N2 (mkN2 (mkN "garrafa" feminine) part_Prep)) np ;
  cup_of_CN    np = mkCN (lin N2 (mkN2 (mkN "copo") part_Prep)) np ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 (mkN "taça") part_Prep)) np ;

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
    Timeunit = N ;
    Weekday = N ;
    Monthday = NP ;
    Month = N ;
    Year = NP ;
oper
  noPrep : Prep = mkPrep [] ;

  lin
    timeunitAdv n time =
      let n_card : Card = lin Card n;
          n_hours_NP : NP = mkNP n_card time ;
      in  SyntaxPor.mkAdv for_Prep n_hours_NP ;--| SyntaxPor.mkAdv (n_hours_NP.s ! R.Nom) ;

  weekdayPunctualAdv w = lin Adv {s = w.s ! C.Sg} ;         -- lundi
  weekdayHabitualAdv w = SyntaxPor.mkAdv noPrep (mkNP the_Det w) ; -- il lunedí ----
  weekdayLastAdv w = SyntaxPor.mkAdv noPrep (mkNP the_Det (mkCN (mkA "passado") w)) ; -- il lunedí scorso
  weekdayNextAdv w = SyntaxPor.mkAdv noPrep (mkNP the_Det (mkCN (prefixA (mkA "próximo")) w)) ; -- il lunedí prossimo

  monthAdv m = lin Adv {s = "em" ++ m.s ! C.Sg} ;         -- in maggio
  yearAdv y = SyntaxPor.mkAdv (mkPrep "em") y ; ----
  dayMonthAdv d m = ParadigmsPor.mkAdv ("o" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg) ; -- le 17 mai
  monthYearAdv m y = lin Adv {s = "em" ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp} ;         -- in maggio 2012
  dayMonthYearAdv d m y = ParadigmsPor.mkAdv ("o" ++ (d.s ! R.Nom).comp ++ m.s ! C.Sg ++ (y.s ! R.Nom).comp) ; -- il 17 maggio 2013

  intYear = symb ;
  intMonthday = symb ;


lincat Language = N ;

lin InLanguage l = SyntaxPor.mkAdv (mkPrep "em") (mkNP l) ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN w ;
  monthPN m = mkPN m ;

  languageNP l = mkNP l ;
  languageCN l = mkCN l ;

oper mkLanguage : Str -> N = \s -> mkN s ;

----------------------------------------------
---- lexicon of special names
lin second_Timeunit = mkN "segundo" ;
lin minute_Timeunit = mkN "minuto" ;
lin hour_Timeunit = mkN "hora" ;
lin day_Timeunit = mkN "dia" masculine ;
lin week_Timeunit = mkN "semana" ;
lin month_Timeunit = mkN "mês" "meses" ;
lin year_Timeunit = mkN "ano" ;

lin monday_Weekday    = mkN "segunda" ;
lin tuesday_Weekday   = mkN "terça" ;
lin wednesday_Weekday = mkN "quarta" ;
lin thursday_Weekday  = mkN "quinta" ;
lin friday_Weekday    = mkN "sexta" ;
lin saturday_Weekday  = mkN "sábado" ;
lin sunday_Weekday    = mkN "domingo" ;

lin january_Month   = mkN "janeiro" ;
lin february_Month  = mkN "fevereiro" ;
lin march_Month     = mkN "março" ;
lin april_Month     = mkN "abril" ;
lin may_Month       = mkN "maio" ;
lin june_Month      = mkN "junho" ;
lin july_Month      = mkN "julho" ;
lin august_Month    = mkN "agosto" ;
lin september_Month = mkN "setembro" ;
lin october_Month   = mkN "outubro" ;
lin november_Month  = mkN "novembro" ;
lin december_Month  = mkN "dezembro" ;

lin afrikaans_Language = mkLanguage "africâner" ;
lin amharic_Language   = mkLanguage "amárico" ;
lin arabic_Language    = mkLanguage "árabe" ;
lin bulgarian_Language = mkLanguage "búlgaro" ;
lin catalan_Language   = mkLanguage "catalão" ;
lin chinese_Language   = mkLanguage "chinês" ;
lin danish_Language    = mkLanguage "dinamarquês" ;
lin dutch_Language     = mkLanguage "holandês" ;
lin english_Language   = mkLanguage "inglês" ;
lin estonian_Language  = mkLanguage "estônio" ;
lin finnish_Language   = mkLanguage "finlandês" ;
lin french_Language    = mkLanguage "francês" ;
lin german_Language    = mkLanguage "alemão" ;
lin greek_Language     = mkLanguage "grego" ;
lin hebrew_Language    = mkLanguage "hebraico" ;
lin hindi_Language     = mkLanguage "hindi" ;
lin japanese_Language  = mkLanguage "japonês" ;
lin italian_Language   = mkLanguage "italiano" ;
lin latin_Language     = mkLanguage "latim" ;
lin latvian_Language   = mkLanguage "letão" ;
lin maltese_Language   = mkLanguage "maltês" ;
lin nepali_Language    = mkLanguage "nepalês" ;
lin norwegian_Language = mkLanguage "norueguês" ;
lin persian_Language   = mkLanguage "persa" ;
lin polish_Language    = mkLanguage "polonês" ;
lin punjabi_Language   = mkLanguage "punjabi" ;
lin romanian_Language  = mkLanguage "romeno" ;
lin russian_Language   = mkLanguage "russo" ;
lin sindhi_Language    = mkLanguage "sindhi" ;
lin spanish_Language   = mkLanguage "espanhol" | mkLanguage "castelhano" ;
lin swahili_Language   = mkLanguage "suaíli" ;
lin swedish_Language   = mkLanguage "sueco" ;
lin thai_Language      = mkLanguage "tailandês" ;
lin turkish_Language   = mkLanguage "turco" ;
lin urdu_Language      = mkLanguage "urdu" ;

}
