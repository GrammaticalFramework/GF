resource PhonoFre = open Prelude in {

flags coding=utf8 ;

oper 
  voyelle : Strs = strs {
    "a" ; "à" ; "â" ; "e" ; "é" ; "è" ; "ê" ; 
    "h" ; 
    "i" ; "î" ; "o" ; "ô" ; "u" ; "û" ; "y" ;
    "A" ; "À" ; "Â" ; "E" ; "É" ; "È" ; "Ê" ; 
    "H" ; 
    "I" ; "Î" ; "O" ; "Ô" ; "U" ; "Û" ; "Y"
    } ;

----  elision : Str -> Str = \d -> d + pre {"e" ; "'" / voyelle} ;
  elision : Str -> Str = \d -> d + pre {"e" ; ("'" ++ Predef.BIND) / voyelle} ;

-- The following morphemes are the most common uses of elision.

  elisDe  = elision "d" ;
----  elisLa  = pre {"la" ; ("l'") / voyelle} ;
  elisLa  = pre {"la" ; ("l'" ++ Predef.BIND) / voyelle} ; --- doesn't work properly 15/4/2014
  elisLe  = elision "l" ;
  elisNe  = elision "n" ;
  elisQue = elision "qu" ; 

-- The subjunction "si" has a special kind of elision. The rule is
-- only approximatively correct, for "si" is not really elided before
-- the string "il" in general, but before the pronouns "il" and "ils".

  elisSi = pre {"si" ; ("s'" ++ Predef.BIND) / strs {"il"}} ;

}
