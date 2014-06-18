concrete ConstructionBul of Construction = CatBul ** 
  open ParadigmsBul, (R=ResBul), Prelude, SyntaxBul, SymbolicBul, ExtraBul, MorphoFunsBul in {

flags
  coding=utf8;

lincat
  Weekday = N ;
  Monthday = NP ;
  Month = N ; 
  Year = NP ;
  Language = PN ;

lin
  hungry_VP = mkVP (mkA079 "гладен") ;
  thirsty_VP = mkVP (mkA079 "жаден") ;
  has_age_VP card = mkVP (SyntaxBul.mkAdv (mkPrep "на" R.Acc) (mkNP <lin Card card : Card> (mkN041 "година"))) ;
  have_name_Cl x name = mkCl <lin NP x : NP> (dirV2 (medialV (actionV (mkV186 "казвам") (mkV156 "кажа")) R.Acc)) <lin NP name : NP> ;
  how_old_QCl p = mkQCl (MorphoFunsBul.mkIAdv "на колко") (mkCl <lin NP p : NP> (mkNP a_Quant plNum (mkN041 "година"))) ;
  how_far_QCl name = mkQCl (ExtraBul.IAdvAdv (ss "далече")) name ;
  married_Cl p1 p2 = mkCl <lin NP p1 : NP> 
                         (mkVP (mkVP (mkA076 (case p1.a.gn of {
                                                R.GSg R.Fem => "омъжен" ;
                                                _           => "женен"
                                              }))) (SyntaxBul.mkAdv (mkPrep "за" R.Acc) <lin NP p2 : NP>));
  what_name_QCl	p = mkQCl how_IAdv (mkCl <lin NP p : NP> (medialV (actionV (mkV186 "казвам") (mkV156 "кажа")) R.Acc)) ;
  is_right_VP = mkVP (mkA084 "верен") ;
  is_wrong_VP = mkVP (mkA079 "грешен") ;
  n_units_AP card cn a = mkAP (lin AdA (mkUtt (mkNP <lin Card card : Card> (lin CN cn)))) (lin A a) ;
  weather_adjCl a = R.mkClause (a.s ! R.ASg R.Masc R.Indef) {gn=R.GSg R.Masc; p=R.P3} R.Pos (R.insertObj (\\_=>"") R.Pos (R.predV R.verbBe)) ;

lin
  weekdayPunctualAdv w = SyntaxBul.mkAdv in_Prep (mkNP w) ;         -- on Sunday
  weekdayHabitualAdv w = SyntaxBul.mkAdv in_Prep (mkNP thePl_Det w) ; -- on Sundays
  weekdayNextAdv w = {s = (mkNP theSg_Det (mkCN (mkA076 "следващ") w)).s ! R.RSubj} ;     -- next Sunday
  weekdayLastAdv w = {s = (mkNP theSg_Det (mkCN (mkA076 "минал") w)).s ! R.RSubj} ;     -- last Sunday

  monthAdv m = SyntaxBul.mkAdv (mkPrep "през" R.Acc) (mkNP m) ;
  yearAdv y = SyntaxBul.mkAdv (mkPrep "през" R.Acc) y ;
  dayMonthAdv d m = {s="на" ++ d.s ! R.RSubj ++ m.s ! R.NF R.Sg R.Indef} ; -- on 17 May
  monthYearAdv m y = SyntaxBul.mkAdv (mkPrep "през" R.Acc) (mkNP (mkCN m y)) ; -- in May 2012
  dayMonthYearAdv d m y = {s="на" ++ d.s ! R.RSubj ++ m.s ! R.NF R.Sg R.Indef ++ y.s ! R.RSubj} ; -- on 17 May 2013

  intYear = symb ;
  intMonthday = symb ;

lin
  InLanguage l = SyntaxBul.mkAdv on_Prep (mkNP l) ;
  languagePN l = l ;

lin
  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN (w.s ! R.NF R.Sg R.Indef) 
                     (case w.g of {
                        R.AMasc _       => R.Masc ;
                        R.AFem          => R.Fem ;
                        R.ANeut         => R.Neut
                      }) ;
  monthPN m = mkPN (m.s ! R.NF R.Sg R.Indef) R.Masc ;

lin
  bottle_of_CN np = {s = \\nf => (mkN041 "бутилка").s ! nf ++ np.s ! R.RSubj; g=R.AFem} ;
  cup_of_CN    np = {s = \\nf => (mkN041 "чаша").s ! nf ++ np.s ! R.RSubj; g=R.AFem} ;
  glass_of_CN  np = {s = \\nf => (mkN041 "чаша").s ! nf ++ np.s ! R.RSubj; g=R.AFem} ;

lin
  monday_Weekday = dualN (mkN014 "понеделник") (mkA079 "понеделничен") ;
  tuesday_Weekday = dualN (mkN014 "вторник") (mkA079 "вторничен") ;
  wednesday_Weekday = mkN041 "сряда" ;
  thursday_Weekday = dualN (mkN014 "четвъртък") (mkA079 "четвъртъчен") ;
  friday_Weekday = dualN (mkN014 "петък") (mkA079 "петъчен") ;
  saturday_Weekday = dualN (mkN041 "събота") (mkA079 "съботен") ;
  sunday_Weekday = dualN (mkN047 "неделя") (mkA079 "неделен") ;

  january_Month = mkMonth "януари" "януарски" ;
  february_Month = mkMonth "февруари" "февруарски" ;
  march_Month = mkMonth "март" "мартовски" ;
  april_Month = mkMonth "април" "априлски" ;
  may_Month = mkMonth "май" "майски" ;
  june_Month = mkMonth "юни" "юнски" ;
  july_Month = mkMonth "юли" "юлски" ;
  august_Month = mkMonth "август" "августовски" ;
  september_Month = mkMonth "септември" "септемврийски" ;
  october_Month = mkMonth "октомври" "октомврийски" ;
  november_Month = mkMonth "ноември" "ноемврийски" ;
  december_Month = mkMonth "декември" "декемврийски" ;

lin
  afrikaans_Language = mkPN "африканс" R.Masc;
  amharic_Language = mkPN "амхарски" R.Masc;
  arabic_Language = mkPN "aрабски" R.Masc;
  bulgarian_Language = mkPN "български" R.Masc;
  catalan_Language = mkPN "каталунски" R.Masc;
  chinese_Language = mkPN "китайски" R.Masc;
  danish_Language = mkPN "датски" R.Masc;
  dutch_Language = mkPN "холандски" R.Masc;
  english_Language = mkPN "английски" R.Masc;
  estonian_Language = mkPN "естонски" R.Masc;
  finnish_Language = mkPN "финландски" R.Masc;
  french_Language = mkPN "френски" R.Masc;
  german_Language = mkPN "немски" R.Masc;
  greek_Language = mkPN "гръцки" R.Masc;
  hebrew_Language = mkPN "еврейски" R.Masc;
  hindi_Language = mkPN "хинди" R.Masc;
  japanese_Language = mkPN "японски" R.Masc;
  italian_Language = mkPN "италиянски" R.Masc;
  latin_Language = mkPN "латински" R.Masc;
  latvian_Language = mkPN "латвийски" R.Masc;
  maltese_Language = mkPN "малтийски" R.Masc;
  nepali_Language = mkPN "непалски" R.Masc;
  norwegian_Language = mkPN "норвежки" R.Masc;
  persian_Language = mkPN "персийски" R.Masc;
  polish_Language = mkPN "полски" R.Masc;
  punjabi_Language = mkPN "пънджаби" R.Masc;
  romanian_Language = mkPN "румънски" R.Masc;
  russian_Language = mkPN "руски" R.Masc;
  sindhi_Language = mkPN "синди" R.Masc;
  spanish_Language = mkPN "испански" R.Masc;
  swahili_Language = mkPN "суахили" R.Masc;
  swedish_Language = mkPN "шведски" R.Masc;
  thai_Language = mkPN "тайландски" R.Masc;
  turkish_Language = mkPN "турски" R.Masc;
  urdu_Language = mkPN "урду" R.Masc;

oper 
  mkMonth : Str -> Str -> N = \n,a -> lin N {
    s = \\_ => n ;
    rel = (mkA078 a).s ;
    g = R.AMasc R.NonHuman
  } ;
}
