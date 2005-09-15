--# -path=.:../../prelude

abstract Lang = 
  Rules, 
  Clause, 
  Structural, 
  Basic, 
  Time, 
  Country,
  Math

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
