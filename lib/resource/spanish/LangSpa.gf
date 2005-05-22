--# -path=.:../romance:../abstract:../../prelude

concrete LangSpa of Lang = 
  RulesSpa, 
  ClauseSpa, 
  StructuralSpa,  
  BasicSpa,
  TimeSpa,
  CountrySpa

   ** open Prelude, ParadigmsSpa in {

lin
  AdvDate d = prefixSS "el" d ;
  AdvTime t = prefixSS ["a las"] t ;
  NWeekday w = w ;
  PNWeekday w = mkPN (w.s ! singular) w.g ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}
