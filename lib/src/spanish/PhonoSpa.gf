resource PhonoSpa = open Prelude in {
flags coding=utf8 ;

--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Spanish it includes both vowels and 'h'.

oper 
  vocale : Strs = strs {
    "a" ; "e" ; "h" ; "i" ; "o" ; "u"
    } ;

    --Feminine nouns that start with stressed a use the masculine article el for phonetic reasons:
    --e.g. "el agua pura" but "la pura agua".
    --To prevent "el aguamarina", we list explicitly words that begin with these words
    falseAWords : pattern Str = #("aguam"|"aguaf"|"almac"|"alab"|"alac"|"alam"|"alan"|"alar") ;
    aWords : pattern Str = #("agua" | "alma" | "ala") ;

    chooseLa = pre {
      falseAWords  => "la" ;
      aWords => "el" ;
      "á"  => "el" ;
      _    => "la" 
    } ;
    chooseDeLa = pre {
      falseAWords  => "de la" ;
      aWords => "del" ; 
      "á"  => "del" ;
      _    => "de la"
    } ;

    chooseALa = pre {
      falseAWords  => "a la" ;
      aWords => "al" ;
      "á"  => "al" ; 
      _    => "a la" 
    } ;
}
