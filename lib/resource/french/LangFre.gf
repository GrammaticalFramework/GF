--# -path=.:../romance:../abstract:../../prelude

concrete LangFre of Lang = 
  RulesFre, 
  ClauseFre, 
  StructuralFre,  
  BasicFre,
  TimeFre,
  CountryFre,
  MathFre

   ** open Prelude, ParadigmsFre in {

lin
  AdvDate d = prefixSS "le" d ;
  AdvTime t = prefixSS "à" t ;
  NWeekday w = w ;
  PNWeekday w = mkPN (w.s ! singular) w.g ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}
