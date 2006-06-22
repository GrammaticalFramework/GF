--# -path=.:../abstract:../../prelude

concrete LangRus of Lang = 
  RulesRus, 
  ClauseRus, 
  StructuralRus,  
--  BasicRus,
  TimeRus,
  CountryRus,
--  MathRus

   ** open Prelude, ParadigmsRus, TypesRus 
in {
flags  coding=utf8 ;
lin
  AdvDate d = {s=d.s ! (SF Sg Acc) };
  AdvTime t = prefixSS "в" t ;
  NWeekday w = w ;
  PNWeekday w = nounPN w ;
  
  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;

}
