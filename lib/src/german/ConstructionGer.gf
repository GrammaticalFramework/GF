--# -path=.:../abstract

concrete ConstructionGer of Construction = CatGer ** 
  open SyntaxGer, SymbolicGer, ParadigmsGer, 
       (L = LexiconGer), (E = ExtraGer), (G = GrammarGer), (I = IrregGer), (R = ResGer), Prelude in {


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
 


lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  monday_Weekday = mkN "Montag" ;
  tuesday_Weekday = mkN "Dienstag" ;
  wednesday_Weekday = mkN "Mittwoch" ;
  thursday_Weekday = mkN "Donnerstag" ;
  friday_Weekday = mkN "Freitag" ;
  saturday_Weekday = mkN "Samstag" ;
  sunday_Weekday = mkN "Sonntag" ;

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
  
  january_Month = mkN "Januar" ; 
  february_Month = mkN "Februar" ; 
  march_Month = mkN "März" ; 
  april_Month = mkN "April" ;
  may_Month = mkN "Mai" ;
  june_Month = mkN "Juni" ;
  july_Month = mkN "Juli" ;
  august_Month = mkN "August" ;
  september_Month = mkN "September" ;
  october_Month = mkN "Oktober" ;
  november_Month = mkN "November" ;
  december_Month = mkN "Dezember" ;
 
}
