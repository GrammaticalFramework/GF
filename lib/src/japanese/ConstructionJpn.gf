concrete ConstructionJpn of Construction = CatJpn **
  open SyntaxJpn, ParadigmsJpn, (R=ResJpn), (L = LexiconJpn) in {

lin
  hungry_VP = mkVP (mkV "お腹が空いている" R.Gr1) ;
  thirsty_VP = mkVP (mkA "喉が乾いている" "渇した") ;
  tired_VP = mkVP (mkA "疲れている" "疲れた") ;
  scared_VP = mkVP (mkA "怖い") ;
  ill_VP = mkVP (mkA "病気の") ;
  ready_VP = mkVP L.ready_A ;


lincat
--TODO add rest as soon as I learn that stuff in Duolingo ^^ /IL 2017-07
--  Timeunit ;
  Weekday = N ;
--  Month ;
--  Monthday ;
--  Year ;

lin


  weekdayPunctualAdv w = SyntaxJpn.mkAdv in_Prep (mkNP w) ;     -- on Sunday
  weekdayHabitualAdv w = SyntaxJpn.mkAdv in_Prep (mkNP w) ;     -- on Sundays
  weekdayNextAdv w = SyntaxJpn.mkAdv in_Prep (mkNP (mkCN (mkA "次の") w)) ; -- next Sunday
  weekdayLastAdv w = SyntaxJpn.mkAdv in_Prep (mkNP (mkCN (mkA "先週の") w)) ; -- last Sunday

{-
  monthAdv        : Month -> Adv ;                        -- in June
  yearAdv         : Year -> Adv ;                         -- in 1976
  dayMonthAdv     : Monthday -> Month -> Adv ;            -- on 17 May
  monthYearAdv    : Month -> Year -> Adv ;                -- in May 2013
  dayMonthYearAdv : Monthday -> Month -> Year -> Adv ;    -- on 17 May 2013
  
  intYear     : Int -> Year ;  -- (year) 1963
  intMonthday : Int -> Monthday ; -- 31th (March)
-}

-- coercions to RGL categories

  -- : Weekday -> N ; -- (this) Monday
  weekdayN w = w ;

{-
  monthN     : Month -> N ;   -- (this) November

  weekdayPN  : Weekday -> PN ; -- Monday (is free)
  monthPN    : Month -> PN ;   -- March (is cold)

  languageNP : Language -> NP ;  -- French (is easy)
  languageCN : Language -> CN ;  -- (my) French
-}

----------------------------------------------
---- lexicon of special names

  monday_Weekday = mkN "月曜日" ;  -- "getsuyoubi"
  tuesday_Weekday = mkN "火曜日" ;  -- "kayoubi"
  wednesday_Weekday = mkN "水曜日" ;  -- "suiyoubi"
  thursday_Weekday = mkN "木曜日" ;  -- "mokuyoubi"
  friday_Weekday = mkN "金曜日" ;  -- "kin'youbi"
  saturday_Weekday = mkN "土曜日" ;  -- "doyoubi"
  sunday_Weekday = mkN "日曜日" ;  -- "nichiyoubi"

}
