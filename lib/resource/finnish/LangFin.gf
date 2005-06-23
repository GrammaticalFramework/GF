--# -path=.:../abstract:../../prelude

concrete LangFin of Lang = 
  RulesFin, 
  ClauseFin, 
  StructuralFin,  
  BasicFin
----  TimeEng,
----  CountryEng

   ** open Prelude, ParadigmsFin in {

flags unlexer=finnish ;

{-
lin
  AdvDate d = prefixSS "on" d ;
  AdvTime t = prefixSS "at" t ;
  NWeekday w = w ;
  PNWeekday w = nounPN w ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
-}
}