--# -path=.:../romance:../common:../../prelude

--1 A Simple Catalan Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
-- Jordi Saludes 2008: Derived from MorphoSpa. 
-- Inari Listenmaa 2012: Added smart paradigms for adjectives.
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

  nomVaca : Str -> Number => Str = \vaca ->
    let va : Str = Predef.tk 2 vaca ;
        ca : Str = Predef.dp 2 vaca ;
        ques : Str = case (ca) of {
          "ca" => "ques" ;
          _    => "gues"
        } ;
    in numForms vaca (va + ques) ;

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
    case noi of {
      _ + ("ca"|"ga")  => mkNoun (nomVaca noi) Fem ;
      _ + "a"          => mkNoun (nomCasa "es" noi) Fem ;
      _ + "s"|"x"|"ç"  => mkNounMas nomCas ;
      _ + "i"          => mkNounMas nomFre ;
      _ + "í"          => mkNounMas (nomCasa "ins") ;
      _ + "à"          => mkNounMas (nomCasa "ans") ;
      _ + "ó"          => mkNounMas (nomCasa "ons") ;
      _ + "ig"         => mkNounMas nomFaig ;
      _                => mkNounMas nomCep
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
    let blav = Predef.tk 1 blava
    in  mkAdj blau blava (blau + "s") (blav + "es")
             (blava + "ment") ;
        
  adjFondo : Str -> Adj = \fondo ->
    let fond = Predef.tk 1 fondo
    in  adjBlau fondo (fond + "a") ;
        
  adjBo : Str -> Adj = \bo ->
    mkAdj bo (bo + "na") (bo + "ns") (bo + "nes") (bo + "nament") ;

  adjFidel : Str -> Adj = \fidel ->
    let fidels : Str = case (last fidel) of {
      _ + ("s"|"ç"|"x") => fidel + "os" ; --feliç; capaç
      _ => fidel + "s"
    } ; 
    in  mkAdj fidel fidel fidels fidels 
             (fidel + "ment") ;
          
  --boig, boja, bojos, boges
  --lleig, lletja, lletjos, lletges
  adjIg : Str -> Str -> Adj = \boig,boja ->
    let boj : Str = tk 1 boja ;
        llet : Str = tk 1 boj
    in  mkAdj boig (boj + "a") (boj + "os") (llet + "ges")
             (boj + "ament") ;
            
  --públic pública públics públiques
  --llarg llarga llargs llargues
  adjXc : Str -> Adj = \blanc ->
    let blan : Str = init blanc ;
        blanqu : Str = case last blanc of {
          "c" => blan + "qu" ;
          "g" => blan + "gu"  --llarg, not boig.
        } ;
    in  mkAdj blanc (blanc + "a")
              (blanc + "s") (blanqu + "es")
              (blanc + "ament") ;

  --sibilant endings
  adjXs : Str -> Str -> Adj = \famos,famosa ->
    let russ : Str = tk 1 famosa ;
    in  mkAdj famos famosa (russ + "os") (russ + "es") 
             (russ + "ament") ;

  -- català catalana catalans catalanes
  adjVn : Str -> Adj = \catalA ->
    let catal : Str = init catalA ;
        v : Str = unaccent (last catalA) ; 
        catalVn : Str = catal + v + "n" ;
    in mkAdj catalA (catalVn + "a") 
            (catalVn + "s") (catalVn + "es")
            (catalVn + "ament") ;
            
  --casat casada ; groc groga  
  adjCasat : Str -> Adj = \casat ->
    let casa : Str = init casat ;
        casad : Str = case last casat of {
          "t" => casa + "d" ;
          "c" => casa + "g"
        } ;
        grogu : Str = case last casad of {
          "g" => casa + "gu" ;
          _   => casad
        } ; 
    in mkAdj casat (casad + "a")
             (casat + "s") (grogu + "es") 
             (casad + "ament") ;

  -- francès francesa francesos franceses
  adjFrances : Str -> Adj = \francEs ->
    let franc  : Str = tk 2 francEs ;
        e : Str = last (tk 1 francEs) ;
        v : Str = unaccent e ;
        francVs : Str = franc + v + "s" 
    in mkAdj francEs (francVs + "a") 
            (francVs + "os") (francVs + "es")
            (francVs + "ament") ;
            
  --europeu europea europeus europees
  adjEuropeu : Str -> Adj = \europeu ->
    let europe : Str = tk 1 europeu ;
    in  mkAdj europeu (europe + "a")
             (europeu + "s") (europe + "es")
             (europe + "ament") ;
             
  --belga belga belgues belgues
  adjBelga : Str -> Adj = \belga ->
    let belg : Str = init belga ;
        belgu : Str = case last belg of {
          ("g"|"c") => belg + "u" ;
           _        => belg
        } ;
        belgues : Str = belgu + "es" 
    in  mkAdj belga belga belgues belgues (belga + "ment") ;
  
  
  mkAdjReg : Str -> Adj = \prim ->
    case prim of {
        _ + "ll"             => adjPrim prim ; --vell~vella
        _ + "rn"             => adjPrim prim ; --modern~moderna
        _ + ("l"|"n"|"ç")    => adjFidel prim ; --local; gran; capaç. For espanyol~espanyola mk2A.
        _ + "a"              => adjBelga prim ; --invariable, -es in plural
        _ + ("eu")           => adjFidel prim ; --greu; breu. most "eu" are invariable, europeu and jueu with mk2A.
        _ + ("au"|"ou"|"iu") => adjBlau prim (tk 1 prim + "va"); --blau; nou; viu
        _ + ("e"|"o")        => adjFondo prim ; 
        _ + "ig"             => adjIg prim (tk 2 prim + "ja") ; --boig~boja. lleig~lletja with mk2A.
        _ + ("c"|"g")        => adjXc prim ; --públic; llarg. cec~cega with mk2A
        _ + ("n"|"l"|"r"|"s") + "t" => adjPrim prim ; --mort,llest,distint
        _ + "t"              => adjCasat prim ; --tancat~tancada. petit~petita with mk2A. 
        _ + ("à"|"é"|"è"|"í"|"ó"|"ò"|"ú") => adjVn prim ; --comú~comuna
        _ + ("à"|"é"|"è"|"í"|"ó"|"ò"|"ú") + "s" => adjFrances prim ;
        _ + ("s"|"x")        => adjXs prim (prim + "a") ; --divers~diversa
        _                    => adjPrim prim  
        } ;

  --Used for the following:
  --diferent diferent : doesn't end in l/n/ç/eu but has invariant feminine
  --petit petita petits petites : voiceless plosive in the stem. 
  --ridícul ridícula : ends in l/n/ç but is not invariant.
  --lleig lletja : the geminated variant of boig boja
  --bo bona ; pla plana : like adjVn, but for one syllable words
  --diari diària ; ingenu ingènua : in feminine, stress in antepenultimate
  --jueu jueva ; europeu europea : exceptional paradigms for "eu" ending
  --rus russa : voiceless s in the stem
  --groc groga : voiced g in the stem
  mkAdj2Reg : Str -> Str -> Adj = \petit,petita ->
    case <petit,petita> of {
        <_, _ + ("b"|"c"|"d"|"e"|"f"|"g"|"h"|"i"|"j"|"k"|"l"|"m"|"n"|"o"|"p"|"q"|"r"|"s"|"t"|"u"|"v"|"x"|"y"|"z")> => adjFidel petit ; --feminine doesn't end in "a"
        <p@(_ + ("t"|"l"|"ç")), p+"a"> => adjPrim petit ; --1) petit~petita 2) ridícul~ridícula, dolç~dolça
        <_ + "ig", _> => adjIg petit petita ; --lleig~letja
        <_, _+ "na">  => adjVn petit ; --pla~plana
        <_, _ + ("à"|"é"|"è"|"í"|"ó"|"ò"|"ú") + _> => adjBlau petit petita ; --diari~diària
        <_ + "u" , _ + "va"> => adjBlau petit petita ; --jueu~jueva
        <_ + "eu", _ + "ea"> => adjEuropeu petit ; --europeu~europea
        <_ + "s" , _> => adjXs petit petita ; --rus~russa
        <_ + "c" , _ + "ga"> => adjCasat petit ; --groc~groga
        _       => mkAdjReg petit 
    } ;

oper unaccent : Str -> Str = \vocal ->
        case vocal of {
          ("é"|"è") => "e" ;
          ("ó"|"ò") => "o" ;
          "à" => "a" ;
          "í" => "i" ;
          "ú" => "u" ;
           _  => vocal
        } ;


--2 Personal pronouns
--
-- All the eight personal pronouns can be built by the following macro.
-- The use of "en" as atonic genitive is debatable.

  mkPronoun : (_,_,_,_,_,_,_,_ : Str) -> 
              Gender -> Number -> Person -> Pronoun =
    \ell,el,li,Ell,son,sa,elsSeus,lesSeves,g,n,p ->
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
          <Pl,Masc> => elsSeus ;
      <Pl,Fem>  => lesSeves
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
