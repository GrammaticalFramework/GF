--# -path=.:../../prelude

abstract LangSats = 
  Rules, 
  Sats,
  Structural, 
  Basic, 
  Time, 
  Country 

  ** {
  fun

-- Mount $Time$.

  AdvDate : Date -> Adv ;
  AdvTime : Time -> Adv ;
  NWeekday : Weekday -> N ;
  PNWeekday : Weekday -> PN ;

-- Mount $Country$.

  PNCountry : Country -> PN ;
  ANationality : Nationality -> A ;
  NLanguage : Language -> N ;

}
