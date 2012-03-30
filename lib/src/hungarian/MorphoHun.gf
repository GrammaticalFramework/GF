--# -path=.:../../prelude

--1 A Simple Hunlish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsHun$, which
-- gives a higher-level access to this module.

resource MorphoHun = open Prelude, (Predef=Predef), ResHun in 
{
--{
--
--  flags optimize=all ;
--
----2 Determiners
--
--  oper 
--
--  mkDeterminer : Number -> Str -> 
--    {s : Str ; sp : NPCase => Str; n : Number ; hasNum : Bool} = \n,s ->
--    {s = s; 
--     sp = \\c => regGenitiveS s ! npcase2case c ;
--     n = n ;
--     hasNum = True ; -- doesn't matter since s = sp
--     } ;
--
----2 Pronouns
--
--
--  mkPron : (i,me,my,mine : Str) -> Number -> Person -> Gender -> 
--    {s : NPCase => Str ; sp : Case => Str ; a : Agr} =
--     \i,me,my,mine,n,p,g -> {
--     s = table {
--       NCase Nom => i ;
--       NPAcc => me ;
--       NCase Gen => my
--       } ;
--     a = toAgr n p g ;
--     sp = regGenitiveS mine
--   } ;
--
--} ;
--

}
