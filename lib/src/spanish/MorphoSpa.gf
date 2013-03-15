--# -path=.:../romance:../common:../../prelude

--1 A Simple Spanish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsSpa$, which
-- gives a higher-level access to this module.

resource MorphoSpa = CommonRomance, ResSpa ** 
  open PhonoSpa, Prelude, Predef,
  CatSpa in {

  flags optimize=all ;


--2 Nouns
--
-- The following macro is useful for creating the forms of number-dependent
-- tables, such as common nouns.

oper
  numForms : (_,_ : Str) -> Number => Str = \vino, vini ->
    table {Sg => vino ; Pl => vini} ; 

-- For example:

  nomVino : Str -> Number => Str = \vino -> 
    numForms vino (vino + "s") ;

  nomPilar : Str -> Number => Str = \pilar -> 
    numForms pilar (pilar + "es") ;

  nomTram : Str -> Number => Str = \tram ->
    numForms tram tram ;

-- Common nouns are inflected in number and have an inherent gender.

  mkNoun : (Number => Str) -> Gender -> Noun = \mecmecs,gen -> 
    {s = mecmecs ; g = gen} ;

  mkNounIrreg : Str -> Str -> Gender -> Noun = \mec,mecs -> 
    mkNoun (numForms mec mecs) ;

  mkNomReg : Str -> Noun = \mec ->
    case mec of {
      _ + ("o" | "e" | "é" | "á") => mkNoun (nomVino mec) Masc ;  --bebé, papá; how about other accented vocal endings? champú champúes
      _ + "a" => mkNoun (nomVino mec) Fem ;
      _ + "z" => mkNounIrreg mec (init mec + "ces") Fem ;
      _ + "án" => mkNounIrreg mec (tk 2 mec + "anes") Masc ;
      _ + "én" => mkNounIrreg mec (tk 2 mec + "enes") Masc ;
      _ + "ín" => mkNounIrreg mec (tk 2 mec + "ines") Masc ;
      _ + "ón" => mkNounIrreg mec (tk 2 mec + "ones") Masc ;
      _ + "ún" => mkNounIrreg mec (tk 2 mec + "unes") Masc ;
      _   => mkNoun (nomPilar mec) Masc
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
    mkAdj solo (sol + "a") (sol + "os") (sol + "as") (sol + "amente") ;

  -- masculine and feminine are identical: 
  -- adjectives ending with -e, -a and many but not all that end in a consonant
  adjUtil : Str -> Str -> Adj = \util,utiles -> 
    mkAdj util util utiles utiles (util + "mente") ;

  -- adjectives that end in consonant but have different masc and fem forms
  -- español, hablador ...
  adjEspanol : Str -> Str -> Adj = \espanol,espanola ->
    mkAdj espanol espanola (espanol + "es") (espanol + "as") (espanola + "mente") ;

  adjBlu : Str -> Adj = \blu -> 
    mkAdj blu blu blu blu blu ; --- 

 -- francés francesa franceses francesas
  adjEs : Str -> Adj = \francEs ->
    let franc  : Str = Predef.tk 2 francEs ;
        frances : Str = franc + "es" ;
    in mkAdj francEs (frances + "a") (frances + "es") (frances + "as") (frances + "amente") ;
 

   -- alemán alemana alemanes alemanas
  adjVn : Str -> Adj = \alemAn ->
    let alemA : Str = init alemAn ;
        alem  : Str = init alemA ;
        A : Str = last alemA ;
        V : Str = case A of {
          "á" => "a" ;
          "é" => "e" ;
          "í" => "i" ;
          "ó" => "o" ;
          "ú" => "u"
        } ;
        alemVn : Str = alem + V + "n" ;
    in mkAdj alemAn (alemVn + "a") (alemVn + "es")
            (alemVn + "as") (alemVn + "amente") ;

  mkAdjReg : Str -> Adj = \solo -> 
    case solo of {
      _ + "o" => adjSolo solo ;
      _ + ("e" | "a") => adjUtil solo (solo + "s") ;
      _ + "és" => adjEs solo ;
      _ + ("á" | "é" | "í" | "ó" | "ú")  + "n" => adjVn solo ;
      _   => adjUtil solo (solo + "es")
      } ;

--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "ne" as atonic genitive is debatable.
-- We follow the rule that the atonic nominative is empty.

  mkPronoun : (_,_,_,_,_,_,_,_ : Str) -> 
              Gender -> Number -> Person -> Pronoun =
    \il,le,lui,Lui,son,sa,ses,see,g,n,p ->
    let
      alui : Case -> Str = \x -> prepCase x ++ Lui ;
    in {
    s = table {
      Nom        => {c1 = [] ; c2 = []  ; comp = il ; ton = Lui} ;
      Acc        => {c1 = le ; c2 = []  ; comp = [] ; ton = Lui} ;
      CPrep P_a  => {c1 = [] ; c2 = lui ; comp = [] ; ton = alui (CPrep P_a)} ;
      c          => {c1 = [] ; c2 = []  ; comp, ton = alui c}
      } ;
    poss = \\n,g => case <n,g> of {
       <Sg,Masc> => son ;
       <Sg,Fem>  => sa ;
       <Pl,Masc> => ses ;
       <Pl,Fem>  => see 
       } ;

    a = Ag g n p ;
    hasClit = True ; isPol = False
    } ;


--2 Determiners
--
-- Determiners, traditionally called indefinite pronouns, are inflected
-- in gender and number, like adjectives.

  pronForms : Adj -> Gender -> Number -> Str = \tale,g,n -> tale.s ! AF g n ;

  mkOrdinal : A -> Ord = \adj->
  lin Ord {
    s = \\ag => adj.s ! Posit ! AF ag.g ag.n ;
    } ;

  mkQuantifier : (ese,esa,esos,esas : Str) -> Quant = \ese,esa,esos,esas->
    let 
      se  : Str = Predef.drop 1 ese ;
      sa  : Str = Predef.drop 1 esa ;
      sos : Str = Predef.drop 1 esos ;
      sas : Str = Predef.drop 1 esas ;
      E   : Str = "é" ;
      attrforms : Number => Gender => Case => Str = table {
        Sg => \\g,c => prepCase c ++ genForms ese esa ! g ;
        Pl => \\g,c => prepCase c ++ genForms esos esas ! g ---- 
        } ;
      npforms : Number => Gender => Case => Str = table {
        Sg => \\g,c => prepCase c ++ genForms (E + se)  (E + sa)  ! g ;
        Pl => \\g,c => prepCase c ++ genForms (E + sos) (E + sas) ! g }
    in lin Quant {
      s = \\_ => attrforms ;
      s2 = [] ;
      sp = npforms  ; isNeg = False
      } ;

  mkDeterminer : (mucho,mucha : Str) -> Number -> Bool -> Det = \mucho,mucha,number,neg ->
    lin Det {
      s,sp = \\g,c => prepCase c ++ genForms mucho mucha ! g ;
      n = number;
      s2 = [] ;
      isNeg = neg
      } ;
      
   mkIDet : (cuantos, cuantas : Str) -> Number -> IDet = \cuantos,cuantas,number ->
     lin IDet {
       s = \\g,c => prepCase c ++ genForms cuantos cuantas ! g ;
       n = number
       } ;
}
