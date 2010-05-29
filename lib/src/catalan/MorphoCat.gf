--# -path=.:../romance:../common:../../prelude

--1 A Simple Catalan Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
-- Jordi Saludes 2008: Derived from MorphoSpa. 
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsCat$, which
-- gives a higher-level access to this module.

resource MorphoCat = CommonRomance, ResCat ** 
  open PhonoCat, Prelude, Predef in {

  flags optimize=all ; coding=utf8 ;

--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.
-- gcc M2.3
oper
  numForms : (_,_ : Str) -> Number => Str = \vi, vins ->
    table {Sg => vi ; Pl => vins} ; 

  nomCep : Str -> Number => Str = \cep -> 
    numForms cep (cep + "s") ;


  nomCasa : Str -> Str -> Number => Str = \es,casa ->
  	numForms casa (init casa + es) ;

  nomFre : Str -> Number => Str = \fre ->
  	numForms fre (fre + "ns") ;
	
  nomCas : Str -> Number => Str = \cas ->
	numForms cas (cas + "os") ;
	
  nomTest : Str -> Number => Str = \test ->
  	numForms test (variants {test + "s"; test + "os"}) ; 

  nomFaig : Str -> Number => Str = \faig ->
	let
		fa = Predef.tk 2 faig
	in
	numForms faig (variants {fa + "jos" ; faig + "s"}) ;
	
  nomDesig : Str -> Number => Str = \desig ->
	let 
		desi = Predef.tk 1 desig
	in
	numForms desig (variants {desi + "tjos" ; desi + "gs"}) ;
	
  nomTemps : Str -> Number => Str = \temps ->
	numForms temps temps ;

-- Common nouns are inflected in number and have an inherent gender.

  mkNoun : (Number => Str) -> Gender -> Noun = \noinois,gen -> 
    {s = noinois ; g = gen} ;

  mkNounIrreg : Str -> Str -> Gender -> Noun = \vi,vins -> 
    mkNoun (numForms vi vins) ;

  mkNomReg : Str -> Noun = \noi ->
	let
		mkNounMas : (Str -> Number => Str) -> Noun = \rule -> mkNoun (rule noi) Masc
	in
    case last noi of {
      "a" 						=> mkNoun (nomCasa "es" noi) Fem ;
	  "s"|"x"|"ç" 				=> mkNounMas nomCas ;
	  "i"						=> mkNounMas nomFre ;
	  "í"						=> mkNounMas (nomCasa "ins") ;
	  "à"						=> mkNounMas (nomCasa "ans") ;
	  "ó"						=> mkNounMas (nomCasa "ons") ;
	  "g"						=> mkNounMas nomFaig ;
      _   						=> mkNounMas nomCep
     } ;

--2 Adjectives
--
-- Adjectives are conveniently seen as gender-dependent nouns.
-- Here are some patterns. First one that describes the worst case.
-- gcc M2.1

  mkAdj : (_,_,_,_,_ : Str) -> Adj = \prim,prima,prims,primes,primament ->
    {s = table {
       AF Masc n => numForms prim prims ! n ;
       AF Fem  n => numForms prima primes ! n ;
       AA        => primament
       }
    } ;

--- Then the regular and invariant patterns.

  adjPrim : Str -> Adj = \prim -> 
    mkAdj prim (prim + "a") (prim + "s") (prim + "es") (prim + "ament") ;

  adjBlau : Str -> Str -> Adj = \blau,blava ->
	let
		blav = Predef.tk 1 blava
	in
 	mkAdj blau blava (blau + "s") (blav + "es") (blava + "ment") ;
	
  adjFondo : Str -> Adj = \fondo ->
	let
		fond = Predef.tk 1 fondo
	in
	adjBlau fondo (fond + "a") ;
	
  adjBo : Str -> Adj = \bo ->
	mkAdj bo (bo + "na") (bo + "ns") (bo + "nes") (bo + "nament") ;

  adjFidel : Str -> Adj = \fidel ->
	let
		fidels = fidel + "s"
	in
	mkAdj fidel fidel fidels fidels (fidel + "ment") ;

  mkAdjReg : Str -> Adj = \prim ->
	case last prim of {
		"e"|"u"|"o"	=> adjFondo prim ;
		"l"|"r"       => adjFidel prim ;
		_			=> adjPrim prim  
	} ;


--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "en" as atonic genitive is debatable.

  mkPronoun : (_,_,_,_,_,_,_ : Str) -> 
              Gender -> Number -> Person -> Pronoun =
    \ell,el,li,Ell,son,sa,ses,g,n,p ->
    let
      aell : Case -> Str = \x -> prepCase x ++ Ell ;
    in {
    s = table {
      Nom        => {c1 = [] ; c2 = []  ; comp = ell ; ton = Ell} ;
      Acc        => {c1 = el ; c2 = []  ; comp = [] ; ton = Ell} ;
      CPrep P_a  => {c1 = [] ; c2 = li ; comp = [] ; ton = aell (CPrep P_a)} ;
      c          => {c1 = [] ; c2 = []  ; comp, ton = aell c}
      } ;
    poss = \\n,g => case <n,g> of {
      <Sg,Masc> => son ;
      <Sg,Fem>  => sa ;
      _         => ses
      } ;
    a = Ag g n p ;
    hasClit = True ; isPol = False
    } ;

  elisPoss : Str -> Str = \s ->
   pre {
     vocal => s + "on" ;
     _ => s + "a"
     } ;




--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str = \tal,g,n -> tal.s ! AF g n ;

}
