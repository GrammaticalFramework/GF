resource PhonoFre = open Prelude in {

oper 
  voyelle : Strs = strs {
    "a" ; "à" ; "â" ; "e" ; "é" ; "è" ; "ê¨" ; 
    "h" ; 
    "i" ; "î" ; "o" ; "ô" ; "u" ; "û" ; "y"
    } ;

  elision : Str -> Str = \d -> d + pre {"e" ; "'" / voyelle} ;

-- The following morphemes are the most common uses of elision.

  elisDe  = elision "d" ;
  elisLa  = pre {"la" ; "l'" / voyelle} ;
  elisLe  = elision "l" ;
  elisNe  = elision "n" ;
  elisQue = elision "qu" ;

-- The subjunction "si" has a special kind of elision. The rule is
-- only approximatively correct, for "si" is not really elided before
-- the string "il" in general, but before the pronouns "il" and "ils".

  elisSi = pre {"si" ; "s'" / strs {"il"}} ;

}
