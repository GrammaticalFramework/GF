--# -path=alltenses:.:../abstract

concrete ConstructionFre of Construction = CatFre ** 
  open SyntaxFre, SymbolicFre, ParadigmsFre, 
       (L = LexiconFre), (E = ExtraFre), (I = IrregFre), (R = ResFre), (C = CommonRomance),
       Prelude in {


lin
  hungry_VP = E.ComplCN have_V2 (mkCN (mkN "faim")) ;
  thirsty_VP = E.ComplCN have_V2 (mkCN (mkN "soif")) ;
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


-- spatial deixis and motion verbs

  where_go_QCl np = mkQCl where_IAdv (mkCl np (mkVP L.go_V)) ;
  where_come_from_QCl np =  mkQCl (lin IAdv (ss "d'où")) (mkCl np (mkVP L.go_V)) ;
  
  go_here_VP = mkVP (mkVP L.go_V) here_Adv ;
  come_here_VP = mkVP (mkVP L.come_V) here_Adv ;
  come_from_here_VP = mkVP (mkVP L.come_V) (mkAdv "d'ici") ;

  go_there_VP = mkVP (mkVP L.go_V)  there_Adv ;
  come_there_VP = mkVP (mkVP L.come_V) there_Adv ;
  come_from_there_VP = mkVP (mkVP L.come_V) (mkAdv "de là") ;
  
lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;
oper
  noPrep : Prep = mkPrep [] ;

lin
  monday_Weekday = mkN "lundi" ;
  tuesday_Weekday = mkN "mardi" ;
  wednesday_Weekday = mkN "mercredi" ;
  thursday_Weekday = mkN "jeudi" ;
  friday_Weekday = mkN "vendredi" ;
  saturday_Weekday = mkN "samedi" ;
  sunday_Weekday = mkN "dimanche" masculine ;

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
  
  january_Month = mkN "janvier" ; 
  february_Month = mkN "février" ; 
  march_Month = mkN "mars" ; 
  april_Month = mkN "avril" ;
  may_Month = mkN "mai" ;
  june_Month = mkN "juin" ;
  july_Month = mkN "juillet" ;
  august_Month = mkN "août" ;
  september_Month = mkN "septembre" ;
  october_Month = mkN "octobre" ;
  november_Month = mkN "novembre" ;
  december_Month = mkN "décembre" ;

}
