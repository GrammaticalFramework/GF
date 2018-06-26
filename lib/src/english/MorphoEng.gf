--# -path=.:../../prelude

--1 A Simple English Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEng$, which
-- gives a higher-level access to this module.

resource MorphoEng = open Prelude, (Predef=Predef), ResEng in {

  flags optimize=all ;

--2 Determiners

  oper 

  mkDeterminer : Number -> Str -> 
    {s : Str ; sp : Gender => Bool => NPCase => Str; n : Number ; hasNum : Bool} = \n,s -> mkDeterminerSpec n s s s False ; --- was True!?

  mkDeterminerSpec : Number -> Str -> Str -> Str -> Bool ->
    {s : Str ; sp : Gender => Bool => NPCase => Str; n : Number ; hasNum : Bool} = \n,s,sp1,sp2,hasNum ->
    {s = s;
     sp = \\g,hasAdj,c => regGenitiveS (case g of {Masc=>sp1; Fem=>sp1; Neutr=>sp2}) ! npcase2case c ;
     n = n ;
     hasNum = hasNum ; --- doesn't matter when s = sp
     } ;

--2 Pronouns


  mkPron : (i,me,my,mine : Str) -> Number -> Person -> Gender -> 
    {s : NPCase => Str ; sp : Case => Str ; a : Agr} =
     \i,me,my,mine,n,p,g -> {
     s = table {
       NCase Nom => i ;
       NPAcc => me ;
       NPNomPoss => mine ;
       NCase Gen => my
       } ;
     a = toAgr n p g ;
     sp = table {
       Nom => mine ;
       _ => genitiveS mine
       }
   } ;

} ;

