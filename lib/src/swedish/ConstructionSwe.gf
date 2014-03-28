--# -path=.:../abstract

concrete ConstructionSwe of Construction = CatSwe ** 
  open SyntaxSwe, SymbolicSwe, ParadigmsSwe, (L = LexiconSwe), (E = ExtraSwe), (G = GrammarSwe), (R = ResSwe), (C = CommonScand), Prelude in {


lin
  hungry_VP = mkVP (mkA "hungrig") ;
  thirsty_VP = mkVP (mkA "törstig") ;
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

-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl (lin IAdv (ss "vart")) (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "varifrån")) (mkCl np (mkVP L.come_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) (mkAdv "hit") ;
  come_here_VP = mkVP (mkVP L.come_V) (mkAdv "hit") ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "härifrån") ;

  go_there_VP = mkVP (mkVP L.go_V) (mkAdv "dit") ;
  come_there_VP = mkVP (mkVP L.come_V) (mkAdv "dit") ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "därifrån") ;


lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
lin
  monday_Weekday = mkN "måndag" ;
  tuesday_Weekday = mkN "tisdag" ;
  wednesday_Weekday = mkN "onsdag" ;
  thursday_Weekday = mkN "torsdag" ;
  friday_Weekday = mkN "fredag" ;
  saturday_Weekday = mkN "lördag" ;
  sunday_Weekday = mkN "söndag" ;

  weekdayPunctualAdv w = SyntaxSwe.mkAdv on_Prep (mkNP w) ;         -- på söndag
  weekdayHabitualAdv w = SyntaxSwe.mkAdv on_Prep (mkNP aPl_Det w) ; -- på söndagar
  weekdayLastAdv w = SyntaxSwe.mkAdv in_Prep (mkNP (E.GenNP (mkNP w))) ; -- i söndags
  weekdayNextAdv w = SyntaxSwe.mkAdv (mkPrep "nästa") (mkNP w) ; -- nästa söndag --- can mean a week later than Swelish "next Sunday"

  monthAdv m = SyntaxSwe.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxSwe.mkAdv (mkPrep "år") y ;
  dayMonthAdv d m = ParadigmsSwe.mkAdv ("den" ++ d.s ! C.NPAcc ++ m.s ! C.Sg ! C.Indef ! C.Nom) ; -- den 17 maj
  monthYearAdv m y = SyntaxSwe.mkAdv in_Prep (mkNP (mkCN m y)) ; -- i maj 2012
  dayMonthYearAdv d m y = ParadigmsSwe.mkAdv ("den" ++ d.s ! C.NPAcc ++ m.s ! C.Sg ! C.Indef ! C.Nom ++ y.s ! C.NPAcc) ; -- den 17 maj 2013

  intYear = symb ;
  intMonthday = symb ;
  
  january_Month = mkN "januari" ; 
  february_Month = mkN "februari" ; 
  march_Month = mkN "mars" ; 
  april_Month = mkN "april" ;
  may_Month = mkN "maj" ;
  june_Month = mkN "juni" ;
  july_Month = mkN "juli" ;
  august_Month = mkN "augusti" ;
  september_Month = mkN "september" ;
  october_Month = mkN "oktober" ;
  november_Month = mkN "november" ;
  december_Month = mkN "december" ;

}
