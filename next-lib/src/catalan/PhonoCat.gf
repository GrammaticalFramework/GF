--# -path=../common:prelude

resource PhonoCat = open Prelude in {

--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Catalan it includes both vowels and 'h'.

---TODO: L'elisi— depŽn de la tonicitat.

oper 
  vocal : Strs = strs {
    "a" ; "ˆ" ;
	"e" ; "" ; "Ž" ; "o" ; "˜" ; "—" ;
	"i" ; "’" ; "•" ; "u" ; "œ" ; "Ÿ" ;  "h" 
	} ;
  
  vocalForta : Strs = strs {
	"a" ; "ˆ" ; "ha" ; "hˆ" ;
	"e" ; "" ; "Ž" ; "he" ; "h" ; "hŽ" ;
	"o" ; "˜" ; "—" ; "ho" ; "h˜" ; "h—" ;
	"’"  ; "œ" ; "h’" ; "hœ" ; 
	} ;
	
  vocalFeble : Strs = strs {
	"i" ; "•" ; "u" ; "Ÿ" ;
	"hi" ; "h•" ; "hu" ; "hŸ" ;
	} ;
	
	
elisDe = pre { "de" ; "d'" / vocal };
elisEl = pre { "el" ; "l'" / vocal } ;
elisLa = pre { "la" ; "l'" / vocalForta } ;
elisEm = pre { "em" ; "m'" / vocal } ;
elisEt = pre { "et" ; "t'" / vocal } ;

-- AR after pre syntax change 25/5/2009
elisEs = pre {
  vocal => "s'" ;
  "s"   => "se" ;
  _     => "es"
  } ;

--elisEs = pre {
--			pre { "es" ; "s'" / vocal} ;
--			"se" / strs { "s" } } ;

}
