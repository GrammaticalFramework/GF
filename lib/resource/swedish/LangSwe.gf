--# -path=.:../scandinavian:../abstract:../../prelude

concrete LangSwe of Lang = 
  RulesSwe, 
  ClauseSwe, 
  StructuralSwe,  
  BasicSwe,
  TimeSwe,
  CountrySwe

   ** open Prelude, ResourceSwe, ParadigmsSwe in {

lin
  AdvDate d = prefixSS "på" d ;
  AdvTime t = prefixSS "klockan" t ;
  NWeekday w = w ;
  PNWeekday w = nounPN w ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}
