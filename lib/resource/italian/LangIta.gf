--# -path=.:../romance:../abstract:../../prelude

concrete LangIta of Lang = 
  RulesIta, 
  ClauseIta, 
  StructuralIta,  
  BasicIta,
  TimeIta,
  CountryIta

   ** open Prelude, ParadigmsIta in {

lin
  AdvDate d = prefixSS "il" d ;
  AdvTime t = prefixSS "alle" t ;
  NWeekday w = w ;
  PNWeekday w = mkPN (w.s ! singular) w.g ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}
