--# -path=.:../scandinavian:../abstract:../../prelude

concrete LangDan of Lang = 
  RulesDan, 
  ClauseDan, 
  StructuralDan,  
  BasicDan,
  TimeDan,
  CountryDan

   ** open Prelude, ParadigmsDan in {

lin
  AdvDate d = prefixSS "på" d ;
  AdvTime t = prefixSS "klokken" t ;
  NWeekday w = w ;
  PNWeekday w = nounPN w ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}
