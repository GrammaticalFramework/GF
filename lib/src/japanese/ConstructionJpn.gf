concrete ConstructionJpn of Construction = CatJpn **
  open SyntaxJpn, ParadigmsJpn, (R=ResJpn), (L = LexiconJpn), SymbolicJpn in {

lin
  hungry_VP = mkVP (mkV "お腹が空いている" R.Gr1) ;
  thirsty_VP = mkVP (mkA "喉が乾いている" "渇した") ;
  tired_VP = mkVP (mkA "疲れている" "疲れた") ;
  scared_VP = mkVP (mkA "怖い") ;
  ill_VP = mkVP (mkA "病気の") ;
  ready_VP = mkVP L.ready_A ;


lincat
  Timeunit = N ;
  Weekday = N ;
  Monthday = NP ;
  Month = N ;
  Year = NP ;

lin

  -- : Weekday -> Adv ;
  weekdayPunctualAdv w = SyntaxJpn.mkAdv in_Prep (mkNP w) ;     -- on Sunday
  weekdayHabitualAdv w = SyntaxJpn.mkAdv in_Prep (mkNP w) ;     -- on Sundays
  weekdayNextAdv w = SyntaxJpn.mkAdv in_Prep (mkNP (mkCN (mkA "次の") w)) ; -- next Sunday
  weekdayLastAdv w = SyntaxJpn.mkAdv in_Prep (mkNP (mkCN (mkA "先週の") w)) ; -- last Sunday

  -- : Month -> Adv ;                        -- in June
  monthAdv m = SyntaxJpn.mkAdv in_Prep (mkNP m) ;

  -- : Year -> Adv ;                         -- in 1976
  yearAdv y = SyntaxJpn.mkAdv in_Prep y ;

  -- : Monthday -> Month -> Adv ;            -- on 17 May /  五月十七日に
  dayMonthAdv day month = 
    let futsukaNi : Adv = SyntaxJpn.mkAdv in_Prep day ;
        sangatsu : R.Style => Str = month.s ! R.Sg ;
     in futsukaNi ** { s = \\style => sangatsu ! style ++ futsukaNi.s ! style } ;

  -- : Month -> Year -> Adv ;                -- in May 2013
  monthYearAdv m y = SyntaxJpn.mkAdv in_Prep (mkNP (mkCN m y)) ;

  -- : Monthday -> Month -> Year -> Adv ;    -- on 17 May 2013
  dayMonthYearAdv d m y = 
    let futsukaNi : Adv = SyntaxJpn.mkAdv in_Prep d ;
        sangatsu2013 : R.Style => Str = \\st => y.s ! st ++ "年" ++ m.s ! R.Sg ! st;

     in futsukaNi ** { s = \\style => sangatsu2013 ! style ++ futsukaNi.s ! style } ;

  -- : Int -> Year ;  -- (year) 1963
  intYear = symb ;

  -- : Int -> Monthday ; -- 31th (March)
  intMonthday i = symb { s = i.s ++ "日" } ; 



-- coercions to RGL categories

  weekdayN w = w ;
  monthN m = m ;

  weekdayPN w = mkPN (w.s ! R.Sg ! R.Plain) ;
  monthPN m = mkPN (m.s ! R.Sg ! R.Plain)  ;


----------------------------------------------
---- lexicon of special names

-- This is pure guessing /IL 2017-07
--  second_Timeunit = mkN "second" ;
--  minute_Timeunit = mkN "minute" ;
--  hour_Timeunit = mkN "hour" ;
  day_Timeunit = mkN "日" ;
  week_Timeunit = mkN "週間" ;
  month_Timeunit = mkN "箇月" ;
  year_Timeunit = mkN "年" ;

  monday_Weekday = mkN "月曜日" ;  -- "getsuyoubi"
  tuesday_Weekday = mkN "火曜日" ;  -- "kayoubi"
  wednesday_Weekday = mkN "水曜日" ;  -- "suiyoubi"
  thursday_Weekday = mkN "木曜日" ;  -- "mokuyoubi"
  friday_Weekday = mkN "金曜日" ;  -- "kin'youbi"
  saturday_Weekday = mkN "土曜日" ;  -- "doyoubi"
  sunday_Weekday = mkN "日曜日" ;  -- "nichiyoubi"

  january_Month = mkN "一月" ;   -- ichigatsu
  february_Month = mkN "二月" ;  -- nigatsu
  march_Month = mkN "三月" ;     -- sangatsu
  april_Month = mkN "四月" ;     -- shigatsu
  may_Month = mkN "五月" ;       -- gogatsu
  june_Month = mkN "六月" ;      -- rokugatsu
  july_Month = mkN "七月" ;      -- shichigatsu
  august_Month = mkN "八月" ;    -- hachigatsu
  september_Month = mkN "九月" ; -- kugatsu
  october_Month = mkN "十月" ;   -- jyuugatsu
  november_Month = mkN "十一月" ; -- jyuuichigatsu
  december_Month = mkN "十二月" ; -- jyuunigatsu

}
