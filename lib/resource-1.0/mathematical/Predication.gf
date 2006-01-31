--1 A Small Predication Library
--
-- (c) Aarne Ranta 2003-2006 under Gnu GPL.
--
-- This library is a derived library built on the language-independent Ground 
-- API of resource grammars. 

abstract Predication = Cat ** {

--2 The category of atomic sentences

-- These sentences have both a positive and a negative form

cat
  AS ;

fun
  PosAS : AS -> S ;
  NegAS : AS -> S ;

--2 Predication patterns.

  predV     : V  -> NP -> AS ;         -- one-place verb:      "x converges"
  predV2    : V2 -> NP -> NP -> AS ;   -- two-place verb:      "x intersects y"
  predV3    : V3 -> NP->NP-> NP -> AS; -- three-place verb:    "x intersects y at z"
  predVColl : V  -> NP -> NP -> AS ;   -- collective verb:     "x and y intersect"
  predA     : A  -> NP -> AS ;         -- one-place adjective: "x is even"
  predA2    : A2 -> NP -> NP -> AS ;   -- two-place adj:       "x is divisible by y"
  predAComp : A  -> NP -> NP -> AS;    -- comparative adj:     "x is greater than y"
  predAColl : A  -> NP -> NP -> AS ;   -- collective adj:      "x and y are parallel"
  predN     : N  -> NP -> AS ;         -- one-place noun:      "x is a point"
  predN2    : N2 -> NP -> NP -> AS ;   -- two-place noun:      "x is a divisor of y"
  predNColl : N  -> NP -> NP -> AS ;   -- collective noun:     "x and y are duals"
  predAdv   : Adv -> NP -> AS ;        -- adverb:              "x is inside"
  predPrep  : Prep -> NP -> NP -> AS ; -- preposition:         "x is outside y"

--2 Individual-valued function applications

  appN2     : N2 -> NP -> NP ;         -- one-place function:  "the successor of x"
  appN3     : N3 -> NP -> NP -> NP ;   -- two-place function: "the distance from x to y"
  appColl   : N2 -> NP -> NP -> NP ;   -- collective function: "the sum of x and y"

--2 Families of types

-- These are expressed by relational nouns applied to arguments.

  famN2     : N2 -> NP -> CN ;         -- one-place family:    "divisor of x"
  famN3     : N3 -> NP -> NP -> CN ;   -- two-place family:    "path from x to y"
  famColl   : N2 -> NP -> NP -> CN ;   -- collective family:   "path between x and y"

--2 Type constructor

-- This is similar to a family except that the argument is a type.

  typN2     : N2 -> CN -> CN ;         -- constructed type:   "list of integers"

}
