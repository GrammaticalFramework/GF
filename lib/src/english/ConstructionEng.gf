--# -path=.:../abstract

concrete ConstructionEng of Construction = CatEng ** 
  open SyntaxEng, SymbolicEng, ParadigmsEng, (L = LexiconEng), (E = ExtraEng), (G = GrammarEng), (R = ResEng), (S = StructuralEng), Prelude in {


lin
  hungry_VP = mkVP (mkA "hungry") ;
  thirsty_VP = mkVP (mkA "thirsty") ;
  has_age_VP card = mkVP (mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> L.year_N))) L.old_A) ;

  have_name_Cl x y = mkCl (mkNP (E.GenNP x) L.name_N) (lin NP y) ;
  married_Cl x y = mkCl (lin NP x) L.married_A2 (lin NP y) | mkCl (mkNP and_Conj (lin NP x) (lin NP y)) (mkA "married") ;

  what_name_QCl x = mkQCl (mkIComp whatSg_IP) (mkNP (E.GenNP x) L.name_N) ;
  how_old_QCl x = mkQCl (E.ICompAP (mkAP L.old_A)) (lin NP x) ;
  how_far_QCl x = mkQCl (E.IAdvAdv (ss "far")) (lin NP x) ;

-- some more things
  weather_adjCl ap = mkCl (mkVP (lin AP ap)) ;
   
  is_right_VP = mkVP (ParadigmsEng.mkA "right") ;
  is_wrong_VP = mkVP (ParadigmsEng.mkA "wrong") ;

  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;


  bottle_of_CN np = mkCN (lin N2 (mkN2 "bottle")) (lin NP np) ;
  cup_of_CN    np = mkCN (lin N2 (mkN2 "cup"))    (lin NP np) ;
  glass_of_CN  np = mkCN (lin N2 (mkN2 "glass"))  (lin NP np) ;

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
  weekdayPunctualAdv w = SyntaxEng.mkAdv on_Prep (mkNP w) ;         -- on Sunday
  weekdayHabitualAdv w = SyntaxEng.mkAdv on_Prep (mkNP aPl_Det w) ; -- on Sundays
  weekdayNextAdv w = SyntaxEng.mkAdv (mkPrep "next") (mkNP w) ;     -- next Sunday
  weekdayLastAdv w = SyntaxEng.mkAdv (mkPrep "last") (mkNP w) ;     -- last Sunday

  monthAdv m = SyntaxEng.mkAdv in_Prep (mkNP m) ;
  yearAdv y = SyntaxEng.mkAdv in_Prep y ;
  dayMonthAdv d m = ParadigmsEng.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom) ; -- on 17 May
  monthYearAdv m y = SyntaxEng.mkAdv in_Prep (mkNP (mkCN m y)) ; -- in May 2012
  dayMonthYearAdv d m y = ParadigmsEng.mkAdv ("on" ++ d.s ! R.NPAcc ++ m.s ! R.Sg ! R.Nom ++ y.s ! R.NPAcc) ; -- on 17 May 2013

  intYear = symb ;
  intMonthday = symb ;

lincat Language = PN ;

lin InLanguage l = SyntaxEng.mkAdv in_Prep (mkNP l) ;

lin
  weekdayN w = w ;
  monthN m = m ;
  languagePN l = l ;

}
