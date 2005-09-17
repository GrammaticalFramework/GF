

abstract Math = Categories ** {

--3 Noun phrases with symbols

fun
  SymbPN      : String -> PN ;             -- "x"
  IntPN       : Int -> PN ;                -- "27"
  IntNP       : CN -> Int -> NP ;          -- "level 53"

  IndefSymbNumNP : Num -> CN -> SymbList -> NP ;         -- "(2) numbers x and y"
  DefSymbNumNP   : Num -> CN -> SymbList -> NP ;         -- "the (2) numbers x and y"
  NDetSymbNP     : NDet -> Num -> CN -> SymbList -> NP ; -- "some (3) points x, y and z"

--3 Symbol lists

-- A symbol list has at least two elements. The last two are separated
-- by a conjunction ("and" in English), the others by commas.
-- This produces "x, y and z", in English. 

cat
  SymbList ;

fun
  SymbTwo  : String -> String   -> SymbList ;
  SymbMore : String -> SymbList -> SymbList ;

--3 Special forms of expression

-- This expression form is typical of mathematical texts.
-- It is realized with different constructs in different languages, typically
-- some kind of 3rd person imperative of the verb "be".

  LetImp   : NP -> NP -> Imp ;         -- let x be a number

-- This rule is slightly overgenerating: "there exists every number x". 
-- The problem seems to be of semantic nature. By this we avoid having many rules.

  ExistNP : NP -> Cl ;  -- there exist (2) number(s) x and y

--3 Rules moved from $Rules$.

-- This rule is powerful but overgenerating.

  SymbCN      : CN -> String -> CN ;       -- "number x"

-- This rule is simply wrong, and will be deprecated: the correct
-- value type is $NP$.

  IntCN       : CN -> Int -> CN ;          -- "level 53"

}
