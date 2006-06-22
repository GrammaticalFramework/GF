--1 Numerals

-- This grammar defines numerals from 1 to 999999. 
-- The implementations are adapted from the
-- [numerals library http://www.cs.chalmers.se/~aarne/GF/examples/numerals/] 
-- which defines numerals for 88 languages.
-- The resource grammar implementations add to this inflection (if needed)
-- and ordinal numbers.
--
-- *Note* 1. Number 1 as defined 
-- in the category $Numeral$ here should not be used in the formation of
-- noun phrases, and should therefore be removed. Instead, one should use
-- [Structural Structural.html]$.one_Quant$. This makes the grammar simpler
-- because we can assume that numbers form plural noun phrases.
--
-- *Note* 2. The implementations introduce spaces between
-- parts of a numeral, which is often incorrect - more work on
-- (un)lexing is needed to solve this problem.

abstract Numeral = Cat ** {

cat 
  Digit ;       -- 2..9
  Sub10 ;       -- 1..9
  Sub100 ;      -- 1..99
  Sub1000 ;     -- 1..999
  Sub1000000 ;  -- 1..999999

fun 
  num : Sub1000000 -> Numeral ;

  n2, n3, n4, n5, n6, n7, n8, n9 : Digit ;

  pot01 : Sub10 ;                               -- 1
  pot0 : Digit -> Sub10 ;                       -- d * 1
  pot110 : Sub100 ;                             -- 10
  pot111 : Sub100 ;                             -- 11
  pot1to19 : Digit -> Sub100 ;                  -- 10 + d
  pot0as1 : Sub10 -> Sub100 ;                   -- coercion of 1..9
  pot1 : Digit -> Sub100 ;                      -- d * 10
  pot1plus : Digit -> Sub10 -> Sub100 ;         -- d * 10 + n
  pot1as2 : Sub100 -> Sub1000 ;                 -- coercion of 1..99
  pot2 : Sub10 -> Sub1000 ;                     -- m * 100
  pot2plus : Sub10 -> Sub100 -> Sub1000 ;       -- m * 100 + n
  pot2as3 : Sub1000 -> Sub1000000 ;             -- coercion of 1..999
  pot3 : Sub1000 -> Sub1000000 ;                -- m * 1000
  pot3plus : Sub1000 -> Sub1000 -> Sub1000000 ; -- m * 1000 + n

}
