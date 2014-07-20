--# -coding=latin1
resource PhonoIta = open Prelude in {

--3 Elision
--
-- The phonological rule of *elision* can be defined as follows in GF.
-- In Italian it includes both vowels and the *impure 's'*.

oper 
  vocale : Strs = strs {
    "a" ; "e" ; "h" ; "i" ; "o" ; "u" ; "è" ; "y" ; "A" ; "E" ; "I" ; "O" ; "U" ; "H"
    } ;

  sImpuro : Strs = strs {
    "z" ; "sb" ; "sc" ; "sd" ; "sf" ; "sm" ; "sp" ; "sq" ; "sr" ; "st" ; "sv" ;
    "Z" ; "Sb" ; "Sc" ; "Sd" ; "Sf" ; "Sm" ; "Sp" ; "Sq" ; "Sr" ; "St" ; "Sv"
    } ;

  elision : (_,_,_ : Str) -> Str = \il, l', lo -> 
    let ll = case last l' of {"'" => l' ++ Predef.BIND ; _ => l'} in
    pre {il ; ll / vocale ; lo / sImpuro} ;
---    pre {vocale => l' ;  sImpuro => lo ; _ => il} ;  --- doesn't work properly 15/4/2014

}
