--# -path=.:../romance:../common:../../prelude

----1 A Simple Catalan Resource Morphology
----
---- Aarne Ranta 2002 -- 2005
----
---- This resource morphology contains definitions needed in the resource
---- syntax. To build a lexicon, it is better to use $ParadigmsCat$, which
---- gives a higher-level access to this module.
--
resource MorphoCat = CommonRomance, ResCat ** 
  open PhonoCat, Prelude, Predef in {
--
--  flags optimize=all ;
--
--
----2 Nouns
----
---- The following macro is useful for creating the forms of number-dependent
---- tables, such as common nouns.
--
oper
  numForms : (_,_ : Str) -> Number => Str = \vi, vins ->
    table {Sg => vi ; Pl => vins} ; 

-- For example:

  nomHome : Str -> Number => Str = \home -> 
    numForms home (home + "s") ;
    
  nomDona : Str -> Number => Str = \dona ->
  	numForms dona (init dona + "es") ;
  	
  nomDisc : Str -> Number => Str = \disc ->
  	numForms disc (variants {disc + "s"; disc + "os"}) ; 

--  nomPilar : Str -> Number => Str = \pilar -> 
--    numForms pilar (pilar + "es") ;
--
--  nomTram : Str -> Number => Str = \tram ->
--    numForms tram tram ;
--
-- Common nouns are inflected in number and have an inherent gender.

  mkNoun : (Number => Str) -> Gender -> Noun = \noinois,gen -> 
    {s = noinois ; g = gen} ;

  mkNounIrreg : Str -> Str -> Gender -> Noun = \vi,vins -> 
    mkNoun (numForms vi vins) ;

  mkNomReg : Str -> Noun = \noi ->
    case last noi of {
      "o" | "e" => mkNoun (nomHome noi) Masc ; 
      "a" => mkNoun (nomDona noi) Fem ;
      "c" => mkNoun (nomDisc noi) Masc ;
      --- "u" => mkNounIrreg mec (init mec + "ces") Fem ;
      _   => mkNoun (nomHome noi) Masc
      } ;

----2 Adjectives
----
-- Adjectives are conveniently seen as gender-dependent nouns.
-- Here are some patterns. First one that describes the worst case.

  mkAdj : (_,_,_,_,_ : Str) -> Adj = \petit,petita,petits,petites,petitament ->
    {s = table {
       AF Masc n => numForms petit petits ! n ;
       AF Fem  n => numForms petita petites ! n ;
       AA        => petitament
       }
    } ;

---- Then the regular and invariant patterns.
--
--  adjfort : Str -> Adj = \solo -> 
--    let 
--      sol = Predef.tk 1 solo
--    in
--    mkAdj solo (sol + "a") (sol + "os") (sol + "as") (sol + "amente") ;
--
  adjFort : Str -> Adj = \fort -> 
    mkAdj fort (fort + "a") (fort + "s") (fort + "es") (fort + "ament") ;
--
--  adjBlu : Str -> Adj = \blu -> 
--    mkAdj blu blu blu blu blu ; --- 
--
  mkAdjReg : Str -> Adj = \fort -> adjFort fort ;
{-
    case last solo of {
      "o" => adjSolo solo ;
      --- "e" => adjUtil solo (solo + "s") ;
	  "a" => 
      _   => adjUtil solo (solo + "es")
      } ;
-}
--
----2 Personal pronouns
----
---- All the eight personal pronouns can be built by the following macro.
---- The use of "ne" as atonic genitive is debatable.
---- We follow the rule that the atonic nominative is empty.
--
  mkPronoun : (_,_,_,_,_,_,_,_ : Str) -> 
              Gender -> Number -> Person -> Pronoun =
    \il,le,lui,Lui,son,sa,ses,see,g,n,p ->
    {s = table {
       Ton Nom => il ;
       Ton x => prepCase x ++ Lui ;
       Aton Nom => strOpt il ; ---- [] ;
       Aton Acc => le ;
       Aton (CPrep P_a) => lui ;
       Aton q       => prepCase q ++ Lui ; ---- GF bug with c or p! 
       Poss {n = Sg ; g = Masc} => son ;
       Poss {n = Sg ; g = Fem}  => sa ;
       Poss {n = Pl ; g = Masc} => ses ;
       Poss {n = Pl ; g = Fem}  => see
       } ;
     a = {g = g ; n = n ; p = p} ;
     hasClit = True
    } ;
--
--
----2 Determiners
----
---- Determiners, traditionally called indefinite pronouns, are inflected
---- in gender and number, like adjectives.
--
  pronForms : Adj -> Gender -> Number -> Str = \tale,g,n -> tale.s ! AF g n ;
--
}
