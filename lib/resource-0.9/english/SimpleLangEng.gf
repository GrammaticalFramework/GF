--# -path=.:../abstract:../../prelude

concrete SimpleLangEng of SimpleLang = 
  SimpleEng, 
  StructuralEng,
  BasicEng,
  TimeEng,
  CountryEng

   ** open Prelude, ParadigmsEng in {

lin
  AdvDate d = prefixSS "on" d ;
  AdvTime t = prefixSS "at" t ;
  NWeekday w = w ;
  PNWeekday w = nounPN w ;

  PNCountry x = x ;
  ANationality x = x ;
  NLanguage x = x ;
}