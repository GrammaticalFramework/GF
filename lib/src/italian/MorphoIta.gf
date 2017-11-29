--# -path=.:../romance:../common:../../prelude

--1 A Simple Italian Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsIta$, which
-- gives a higher-level access to this module.

resource MorphoIta = CommonRomance, ResIta **
  open PhonoIta, Prelude, Predef in {

  flags optimize=all ;
    coding=utf8 ;



--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.

oper
  numForms : (_,_ : Str) -> Number => Str = \vino, vini ->
    table {Sg => vino ; Pl => vini} ;

-- For example:

  nomVino : Str -> Number => Str = \vino -> let {vin = Predef.tk 1 vino} in
    numForms vino (vin + "i") ;

  nomRana : Str -> Number => Str = \rana -> let {ran = Predef.tk 1 rana} in
    numForms rana (ran + "e") ;

  nomSale : Str -> Number => Str = \sale -> let {sal = Predef.tk 1 sale} in
    numForms sale (sal + "i") ;

  nomTram : Str -> Number => Str = \tram ->
    numForms tram tram ;

-- Common nouns are inflected in number and have an inherent gender.

  mkNoun : (Number => Str) -> Gender -> Noun = \mecmecs,gen ->
    {s = mecmecs ; g = gen} ;

  mkNounIrreg : Str -> Str -> Gender -> Noun = \mec,mecs ->
    mkNoun (numForms mec mecs) ;

  mkNomReg : Str -> Noun = \vino ->
   let
     o = last vino ;
     vin = init vino ;
     n = last vin
   in
   case vino of {
     _ + "ico" => {s = numForms vino (vin + "i") -- amico -> amici
       ; g = Masc} ;
     _ + "ccia" => {s = numForms vino (init vin + "e") -- doccia -> docce
       ; g = Fem} ;
     _ + "o" => {s = case n of {
       "c" | "g" => numForms vino (vin + "hi") ;
       "i"       => numForms vino vin ;
       _         => numForms vino (vin + "i")
       } ; g = Masc} ;
     _ + "a" => {s = case n of {
       "c" | "g" => numForms vino (vin + "he") ;
       _         => numForms vino (vin + "e")
       } ; g = Fem} ;
     _ + ("ione" | "tudine") => {s = numForms vino (vin + "i")
       ; g = Fem} ;
     _ + "e" => {s = numForms vino (vin + "i")
       ; g = Masc} ;
     _ + "à" | "ù" => {s = numForms vino vino
       ; g = Fem} ;
     _ => {s = numForms vino vino
       ; g = Masc}
     } ;



--2 Adjectives
--
-- Adjectives are conveniently seen as gender-dependent nouns.
-- Here are some patterns. First one that describes the worst case.

  mkAdj : (_,_,_,_,_ : Str) -> Adj = \solo,sola,soli,sole,solamente ->
    {s = table {
       AF Masc n => numForms solo soli ! n ;
       AF Fem  n => numForms sola sole ! n ;
       AA        => solamente
       }
    } ;

-- Then the regular and invariant patterns.

  adjSolo : Str -> Adj = \solo ->
    let
      sol = Predef.tk 1 solo
    in
    mkAdj solo (sol + "a") (sol + "i") (sol + "e") (sol + "amente") ;

  adjTale : Str -> Adj = \tale ->
    let
      tal  = Predef.tk 1 tale ;
      tali = tal + "i" ;
      tala = if_then_Str (pbool2bool (Predef.occur (Predef.dp 1 tal) "lr")) tal tale
    in
    mkAdj tale tale tali tali (tala + "mente") ;

  adjBlu : Str -> Adj = \blu ->
    mkAdj blu blu blu blu blu ; ---


  mkAdjReg : Str -> Adj = \solo ->
   let
     o = last solo ;
     sol = init solo ;
     l = last sol ;
     solamente = (sol + "amente")
   in
   case o of {
     "o" => case l of {
     -- "c" | "g" => mkAdj solo (sol + "a") (sol + "hi") (sol + "he") solamente ;
       "c" => case last (init sol) of {
         "i" => mkAdj solo (sol + "a") (sol + "i") (sol + "he") solamente ; -- pubblico -> pubblici
         _   => mkAdj solo (sol + "a") (sol + "hi") (sol + "he") solamente  -- ricco -> ricchi
         } ;
       "g"       => mkAdj solo (sol + "a") (sol + "hi") (sol + "he") solamente ;
       "i"       => mkAdj solo (sol + "a") sol (sol + "e") solamente ;
       _         => mkAdj solo (sol + "a") (sol + "i") (sol + "e") solamente
       } ;
     "e" => mkAdj solo solo (sol + "i") (sol + "i") (case l of {
       "l" => sol + "mente" ;
       _   => solo + "mente"
       }) ;
     _ => mkAdj solo solo solo solo (sol + "mente")
     } ;


--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "ne" as atonic genitive is debatable.
-- We follow the rule that the atonic nominative is empty.
-- (The form $glie$ is no longer used, and also the other clitics are
-- given in $DiffIta.argPron$ and therefore wouldn't be needed in the
-- pronoun itself.)

  mkPronoun : (_,_,_,_,_,_,_,_,_ : Str) ->
              Gender -> Number -> Person -> Pronoun =
    \il,le,lui,glie,Lui,son,sa,ses,see,g,n,p ->
    let
      alui : Case -> Str = \x -> prepCase x ++ Lui ;
    in {
    s = table {
      Nom        => {c1 = [] ; c2 = []  ; comp = il ; ton = Lui} ;
      Acc        => {c1 = le ; c2 = []  ; comp = [] ; ton = Lui} ;
      CPrep P_a  => {c1 = [] ; c2 = lui ; comp = [] ; ton = alui (CPrep P_a)} ;
      c          => {c1 = [] ; c2 = []  ; comp, ton = alui c}
      } ;
    ----e glie??
    poss = \\n,g => case <n,g> of {
       <Sg,Masc> => son ;
       <Sg,Fem>  => sa ;
       <Pl,Masc> => ses ;
       <Pl,Fem>  => see
       } ;
    a = Ag g n p ;
    hasClit = True ; isPol = False
    } ;

{- --e
  mkPronoun : (_,_,_,_,_,_,_,_,_ : Str) ->
              Gender -> Number -> Person -> Pronoun =
    \il,le,lui,glie,Lui,son,sa,ses,see,g,n,p ->
    {s = table {
       Ton Nom => il ;
       Ton x => prepCase x ++ Lui ;
       Aton Nom => strOpt il ; -- [] or il
       Aton Acc => le ;
       Aton (CPrep P_di) => "ne" ; --- hmm
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
-}

--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str = \tale,g,n -> tale.s ! AF g n ;

}
