--# -path=../common:prelude

resource PhonoCat = open Prelude in {

flags
  coding = utf8 ;

--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Catalan it includes both vowels and 'h'.

---TODO: L'elisió depén de la tonicitat.

oper 
  vocal : Strs = strs {
    "a" ; "à" ;
	"e" ; "è" ; "é" ; "o" ; "ò" ; "ó" ;
	"i" ; "í" ; "ï" ; "u" ; "ú" ; "ü" ;  "h" 
	} ;
  
  vocalForta : Strs = strs {
	"a" ; "à" ; "ha" ; "hà" ;
	"e" ; "è" ; "é" ; "he" ; "hè" ; "hé" ;
	"o" ; "ò" ; "ó" ; "ho" ; "hò" ; "hó" ;
	"í"  ; "ú" ; "hí" ; "hú" ; 
	} ;
	
  vocalFeble : Strs = strs {
	"i" ; "ï" ; "u" ; "ü" ;
	"hi" ; "hï" ; "hu" ; "hü" ;
	} ;
	
	
elisDe = pre { "de" ; ("d'" ++ Predef.BIND) / vocal };
elisEl = pre { "el" ; ("l'" ++ Predef.BIND) / vocal } ;
elisLa = pre { "la" ; ("l'" ++ Predef.BIND) / vocalForta } ;
elisEm = pre { "em" ; ("m'" ++ Predef.BIND) / vocal } ;
elisEt = pre { "et" ; ("t'" ++ Predef.BIND) / vocal } ;

-- AR after pre syntax change 25/5/2009
elisEs = pre {
  vocal => "s'" ++ Predef.BIND ;
  "s"   => "se" ;
  _     => "es"
  } ;

--elisEs = pre {
--			pre { "es" ; "s'" / vocal} ;
--			"se" / strs { "s" } } ;

}
