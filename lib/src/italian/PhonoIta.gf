resource PhonoIta = open Prelude in {

--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Italian it includes both vowels and the *impure 's'*.

oper 
  vocale : Strs = strs {
    "a" ; "e" ; "h" ; "i" ; "o" ; "u" ; "è" ; "y"
    } ;

  sImpuro : Strs = strs {
    "z" ; "sb" ; "sc" ; "sd" ; "sf" ; "sm" ; "sp" ; "sq" ; "sr" ; "st" ; "sv"
    } ;

  elision : (_,_,_ : Str) -> Str = \il, l', lo -> 
    pre {il ; l' / vocale ; lo / sImpuro} ;
---    pre {vocale => l' ;  sImpuro => lo ; _ => il} ;

}
