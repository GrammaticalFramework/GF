abstract Math = Cat ** {

--3 Noun phrases with symbols

fun

  SymbPN      : Symb -> PN ;                -- "x"
  IntPN       : Int -> PN ;                 -- "27"
  CNIntNP     : CN -> Int -> NP ;           -- "level 53"
  CNSymbNP    : Det -> CN -> [Symb] -> NP ; -- "(the) (2) numbers x and y"

--3 Symbol lists

-- A symbol list has at least two elements. The last two are separated
-- by a conjunction ("and" in English), the others by commas.
-- This produces "x, y and z", in English. 

cat
  Symb ;
  [Symb]{2} ;

fun
  MkSymb : String -> Symb ;

}
