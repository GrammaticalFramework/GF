--# -path=.:../../prelude

--1 A Simple Finnish Resource Morphology
--
-- Aarne Ranta 2002 -- 2005
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsFin$, which
-- gives a higher-level access to this module.

resource MorphoFin = ResFin ** open Prelude in {

  flags optimize=all ;

--- flags optimize=noexpand ;

--2 Nouns
--

oper


-- A user-friendly variant takes existing forms and infers the vowel harmony.

  mkNoun : (_,_,_,_,_,_,_,_,_,_ : Str) -> CommonNoun =
    \talo,talon,talona,taloa,taloon,taloina,taloissa,talojen,taloja,taloihin ->
    nhn (mkSubst (ifTok Str (Predef.dp 1 talona) "a" "a" "‰")
      talo (Predef.tk 1 talon) (Predef.tk 2 talona) taloa taloon
      (Predef.tk 2 taloina) (Predef.tk 3 taloissa) talojen taloja taloihin) ;

-- Regular heuristics.

{-
  regNounH : Str -> NounH = \vesi -> 
  let
    esi = Predef.dp 3 vesi ;   -- analysis: suffixes      
    si  = Predef.dp 2 esi ;
    i   = last si ;
    s   = init si ;
    a   = if_then_Str (pbool2bool (Predef.occurs "aou" vesi)) "a" "‰" ;
    ves = init vesi ;          -- synthesis: prefixes
    vet = strongGrade ves ;
    ve  = init ves ;
  in 
       case esi of {
    "uus" | "yys" => sRakkaus vesi ;
    "nen" =>       sNainen (Predef.tk 3 vesi + ("st" + a)) ;

  _ => case si of {
    "aa" | "ee" | "ii" | "oo" | "uu" | "yy" | "‰‰" | "ˆˆ" => sPuu vesi ;
    "ie" | "uo" | "yˆ" => sSuo vesi ;
    "ea" | "e‰" => 
      mkSubst
        a
        vesi (vesi) (vesi) (vesi + a)  (vesi + a+"n")
        (ves + "i") (ves + "i") (ves + "iden")  (ves + "it"+a)
        (ves + "isiin") ;
    "is"        => sNauris (vesi + ("t" + a)) ;
    "ut" | "yt" => sRae vesi (ves + ("en" + a)) ;
    "as" | "‰s" => sRae vesi (vet + (a + "n" + a)) ;
    "ar" | "‰r" => sRae vesi (vet + ("ren" + a)) ;
  _ => case i of {
    "n"         => sLiitin vesi (vet + "men") ;
    "s"         => sTilaus vesi (ves + ("ksen" + a)) ;
    "i" =>         sBaari (vesi + a) ;
    "e" =>         sRae vesi (strongGrade vesi + "en" + a) ;
    "a" | "o" | "u" | "y" | "‰" | "ˆ" => sLukko vesi ;
    _ =>           sLinux (vesi + "i" + a)
  }
  }
  } ;

  reg2NounH : (savi,savia : Str) -> NounH = \savi,savia -> 
  let
    savit = regNounH savi ;
    ia = Predef.dp 2 savia ;
    i  = init ia ;
    a  = last ia ;
    o  = last savi ;
    savin = weakGrade savi + "n" ;
  in
  case <o,ia> of {
    <"i","ia">              => sArpi  savi ;
    <"i","i‰">              => sSylki savi ;
    <"i","ta"> | <"i","t‰"> => sTohtori (savi + a) ;
    <"o","ta"> | <"ˆ","t‰"> => sRadio savi ;  
    <"a","ta"> | <"‰","t‰"> => sPeruna savi ;  
    <"a","ia"> | <"a","ja"> => sKukko savi savin savia ;
    _ => savit
    } ;
-}

-- Here some useful special cases; more will be given in $paradigms.Fin.gf$.
--         

  sLukko : Str -> NounH = \lukko -> 
   let
     o = last lukko ;
     lukk = init lukko ; 
     a = getHarmony o ;
     lukkoja = case o of {
       "a" => lukk + if_then_Str (pbool2bool (Predef.occurs "ou" lukk)) "ia" "oja" ;
       "‰" => lukk + "i‰" ;
       _   => lukko + "j" + a 
       }
   in
   sKukko lukko (weakGrade lukko + "n") lukkoja ;

-- The special case with no alternations.

  sTalo : Str -> NounH = sLukko ;

  sBaari : Str -> NounH = \baaria ->
    let
      baari = Predef.tk 1 baaria ; 
      baar = Predef.tk 1 baari ; 
      a = getHarmony (Predef.dp 1 baaria) 
    in
      sKukko baari (weakGrade baari + "n") (baar + ("ej" + a)) ;

  sKorpi : (_,_,_ : Str) -> NounH = \korpi,korven,korpena ->
    let
      a      = Predef.dp 1 korpena ;
      korpe  = Predef.tk 2 korpena ;
      korp   = init korpi ;
      korpea = case last korp of {
        "r" | "l" | "n" => korp + "t" + a ;
        _ => korpe + a
        } ;        
      korve  = Predef.tk 1 korven ;
      korvi  = Predef.tk 1 korve + "i" ;
      korpien = case last korp of {
        "r" | "l" | "n" => korp + "ten" ;
        _ => korpi + "en"
        } ;        
    in
    mkSubst a 
            korpi
            korve
            korpe
            korpea 
            (korpe + "en")
            korpi
            korvi
            korpien 
            (korpi + a)
            (korpi + "in") ;

  sArpi : Str -> NounH = \arpi -> 
    sKorpi arpi (init (weakGrade arpi) + "en") (init arpi + "ena") ;
  sSylki : Str -> NounH = \sylki -> 
    sKorpi sylki (init (weakGrade sylki) + "en") (init sylki + "en‰") ;

  sKoira : Str -> NounH = \koira ->
    let a = getHarmony (last koira) in
    sKukko koira (koira + "n") (init koira + "i" + a) ;

-- Loan words ending in consonants are actually similar to words like
-- "malli"/"mallin"/"malleja", with the exception that the "i" is not attached
-- to the singular nominative.

  sLinux : Str -> NounH = \linuxia ->
    let {
       linux = Predef.tk 2 linuxia ; 
       a = getHarmony (Predef.dp 1 linuxia) ;
       linuxi = linux + "i"
    } in 
    mkSubst a 
            linux
            linuxi 
            linuxi
            (linuxi + a) 
            (linuxi + "in")
            (linux + "ei")
            (linux + "ei")
            (linux + "ien")
            (linux + "ej" + a)
            (linux + "eihin") ;

-- Nouns of at least 3 syllables ending with "a" or "‰", like "peruna", "rytin‰".

  sPeruna : Str -> NounH = \peruna ->
    let {
      a  = Predef.dp 1 peruna ;
      perun = Predef.tk 1 peruna ;
      perunoi = perun + (ifTok Str a "a" "o" "ˆ" + "i")
    } 
    in
    mkSubst a 
            peruna
            peruna
            peruna
            (peruna + a) 
            (peruna + a + "n")
            perunoi
            perunoi
            (perunoi + "den")
            (perunoi + ("t" + a))
            (perunoi + "hin") ;

  sTohtori : Str -> NounH = \tohtoria ->
    let
      a  = last tohtoria ;
      tohtori = init tohtoria ;
      tohtorei = init tohtori + "ei" ;
    in
    mkSubst a 
            tohtori
            tohtori
            tohtori
            tohtoria
            (tohtori + "in")
            tohtorei
            tohtorei
            (tohtorei + "den")
            (tohtorei + "t" + a)
            (tohtorei + "hin") ;

  sRadio : Str -> NounH = \radio ->
    let
      o  = last radio ;
      a  = getHarmony o ;
      radioi = radio + "i" ;
    in
    mkSubst a 
            radio
            radio
            radio
            (radio + "t" + a)
            (radio + o + "n")
            radioi
            radioi
            (radioi + "den")
            (radioi + "t" + a)
            (radioi + "hin") ;


  sSusi : (_,_,_ : Str) -> NounH = \susi,suden,sutena ->
    let
      a      = Predef.dp 1 sutena ;
      sude   = Predef.tk 1 suden ;
      sute   = Predef.tk 2 sutena ;
      sutt   = Predef.tk 1 sute + "t" 
    in
    mkSubst a 
            susi
            sude 
            sute
            (sutt + a) 
            (sute + "en")
            susi
            susi
            (sutt + "en") --- var susi + "en" bad with suuri 
            (susi + a)
            (susi + "in") ;

  sPuu : Str -> NounH = \puu ->
    let {
      u  = Predef.dp 1 puu ;
      a  = getHarmony u ;
      pu = Predef.tk 1 puu ;
      pui = pu + "i"
    } 
    in
    mkSubst a 
            puu
            puu
            puu
            (puu + ("t" + a)) 
            (puu + ("h" + u + "n"))
            pui
            pui
            (pui + "den")
            (pui + ("t" + a))
            (pui + "hin") ;

  sSuo : Str -> NounH = \suo ->
    let {
      o  = Predef.dp 1 suo ;
      a  = getHarmony o ;
      soi = Predef.tk 2 suo + (o + "i")
    } 
    in
    mkSubst a 
            suo
            suo
            suo
            (suo + ("t" + a)) 
            (suo + ("h" + o + "n"))
            soi
            soi
            (soi + "den")
            (soi + ("t" + a))
            (soi + "hin") ;

-- Here in fact it is handy to use the partitive form as the only stem.

  sNainen : Str -> NounH = \naista ->
    let {
      nainen = Predef.tk 3 naista + "nen" ;
      nais   = Predef.tk 2 naista ;
      naise  = nais + "e" ;
      naisi  = nais + "i" ;
      a      = Predef.dp 1 naista
    } 
    in
    mkSubst a 
            nainen
            naise
            naise
            (nais + ("t" + a)) 
            (nais + "een")
            naisi
            naisi
            (nais + "ten")
            (nais + ("i" + a))
            (nais + "iin") ;

-- The following covers: "tilaus", "kaulin", "paimen", "laidun", "sammal",
-- "kyynel" (excep $Sg Iness$ for the last two?).

  sTilaus : (_,_ : Str) -> NounH = \tilaus, tilauksena ->
    let {
      tilauks  = Predef.tk 3 tilauksena ;
      tilaukse = tilauks + "e" ;
      tilauksi = tilauks + "i" ;
      a        = Predef.dp 1 tilauksena
    } 
    in
    mkSubst a 
            tilaus
            tilaukse
            tilaukse
            (tilaus + ("t" + a)) 
            (tilauks + "een")
            tilauksi
            tilauksi
            (tilaus + "ten")
            (tilauks + ("i" + a))
            (tilauks + "iin") ;

-- Some words have the three grades ("rakkaus","rakkauden","rakkautena"), which
-- are however derivable from the stem.

  sRakkaus : Str -> NounH = \rakkaus ->
    let {
      rakkau    = Predef.tk 1 rakkaus ;
      rakkaut   = rakkau + "t" ;
      rakkaute  = rakkau + "te" ;
      rakkaude  = rakkau + "de" ;
      rakkauksi = rakkau + "ksi" ;
      u         = Predef.dp 1 rakkau ;
      a         = ifTok Str u "u" "a" "‰"
    } 
    in
    mkSubst a 
            rakkaus
            rakkaude
            rakkaute
            (rakkaut + ("t" + a)) 
            (rakkaut + "een")
            rakkauksi
            rakkauksi
            (rakkauksi + "en")
            (rakkauksi + a)
            (rakkauksi + "in") ;

-- The following covers nouns like "nauris" and adjectives like "kallis", "tyyris".

  sNauris : (_ : Str) -> NounH = \naurista ->
    let {
      a        = Predef.dp 1 naurista ;
      nauris   = Predef.tk 2 naurista ;
      nauri    = Predef.tk 3 naurista ;
      i        = Predef.dp 1 nauri ;
      naurii   = nauri + i ;
      naurei   = nauri + "i"
    } 
    in
    mkSubst a 
            nauris
            naurii
            naurii
            (nauris + ("t" + a)) 
            (naurii + "seen")
            naurei
            naurei
            (naurei + "den")
            (naurei + ("t" + a))
            (naurei + "siin") ;

-- Words of the form "siitin", "avain", "hˆyhen" (w or wo grade alternation).

  sLiitin : Str -> Str -> NounH = \liitin,liittimen ->
    let
      liittime = init liittimen ;
      liitti = Predef.tk 2 liittime ;
      m = last (init liittime) ;
      liittimi = liitti + m + "i" ;
      a = vowelHarmony liitin ;
    in 
    mkSubst a 
            liitin
            liittime
            liittime
            (liitin + "t" + a) 
            (liittime + "en")
            (liittimi)
            (liittimi)
            (liittimi + "en")
            (liittimi + a)
            (liittimi + "in") ;

-- The following covers adjectives like "kapea", "leve‰".

  sKapea : (_ : Str) -> NounH = \kapea ->
    let
      a        = last kapea ;
      kape     = init kapea ;
      kapei    = kape + "i"
    in
    mkSubst a 
            kapea
            kapea
            kapea
            (kapea + a) 
            (kapea + a+"n")
            kapei
            kapei
            (kapei + "den")
            (kapei + ("t" + a))
            (kapei + "siin") ;

-- The following two are used for adjective comparison.

  sSuurempi : Str -> NounH = \suurempaa ->
    let {
      a        = Predef.dp 1 suurempaa ;
      suure    = Predef.tk 4 suurempaa ;
      suurempi = suure + "mpi" ;
      suurempa = suure + ("mp" + a) ;
      suuremm  = suure + "mm"
    } 
    in
    mkSubst a 
            suurempi
            (suuremm + a)
            suurempa
            (suurempa + a)
            (suurempa + (a + "n"))
            suurempi
            (suuremm + "i")
            (suurempi + "en")
            (suurempi + a)
            (suurempi + "in") ;

  sSuurin : Str -> NounH = \suurinta ->
    let {
      a        = Predef.dp 1 suurinta ;
      suuri    = Predef.tk 3 suurinta ;
      suurin   = suuri + "n" ;
      suurimma = suuri + ("mm" + a) ;
      suurimpa = suuri + ("mp" + a) ;
      suurimpi = suuri + "mpi" ;
      suurimmi = suuri + "mmi"
    } 
    in
    mkSubst a 
            suurin
            suurimma
            suurimpa
            (suurin + ("t" + a)) 
            (suurimpa + (a + "n"))
            suurimpi
            suurimmi
            (suurimpi + "en")
            (suurimpi + a)
            (suurimpi + "in") ;

-- This auxiliary resolves vowel harmony from a given letter.

getHarmony : Str -> Str = \u -> case u of {
  "a"|"o"|"u" => "a" ;
  _   => "‰"
  } ;

-- This function inspects the whole word.

vowelHarmony : Str -> Str = \liitin ->
  if_then_Str (pbool2bool (Predef.occurs "aou" liitin)) "a" "‰" ;

-- The following function defines how grade alternation works if it is active.
-- In general, *whether there is* grade alternation must be given in the lexicon
-- (cf. "auto - auton" not "audon"; "vihje - vihjeen" not "vihkeen").

  weakGrade : Str -> Str = \kukko ->
    let
      ku  = Predef.tk 3 kukko ;
      kko = Predef.dp 3 kukko ;
      o   = last kukko
    in
      case kko of {
        "kk" + _ => ku + "k"  + o  ;
        "pp" + _ => ku + "p"  + o  ;
        "tt" + _ => ku + "t"  + o  ;
        "nk" + _ => ku + "ng" + o  ;
        "nt" + _ => ku + "nn" + o  ;
        "mp" + _ => ku + "mm" + o  ;
        "rt" + _ => ku + "rr" + o  ;
        "lt" + _ => ku + "ll" + o  ;
        "lk" + ("i" | "e") => ku + "lj" + o ;
        "rk" + ("i" | "e") => ku + "rj" + o ;
        "lk" + _ => ku + "l" + o  ;
        "rk" + _ => ku + "r" + o  ;
        ("hk" | "tk") + _ => kukko ;           -- *tahko-tahon, *pitk‰-pitk‰n
        "s" + ("k" | "p" | "t") + _ => kukko ; -- *lasku-lasvun, *raspi-rasvin, *lastu-lasdun
        x + "ku" => ku + x + "vu" ;
        x + "k" + ("a" | "e" | "i" | "o" | "u" | "y" | "‰" | "ˆ") => ku + x      + o ; 
        x + "p" + ("a" | "e" | "i" | "o" | "u" | "y" | "‰" | "ˆ") => ku + x + "v" + o ; 
        x + "t" + ("a" | "e" | "i" | "o" | "u" | "y" | "‰" | "ˆ") => ku + x + "d" + o ; 
        _ => kukko
        } ;

--- This is only used to analyse nouns "rae", "hake", etc.

  strongGrade : Str -> Str = \hake ->
    let
      ha = Predef.tk 2 hake ;
      e  = last hake ;
      hak = init hake ;
      hd = Predef.dp 2 hak
    in
      case hd of {
        "ng" => ha + "k" ;
        "nn" => ha + "t" ;
        "mm" => ha + "p" ;
        "rr" | "ll" => ha + "t" ;
        "hj" | "lj" => ha + "k" ;  -- pohje/lahje impossible
        "hk" | "sk" | "sp" | "st" => hak ; 
        _ + "k"  => ha + "kk" ;
        _ + "p"  => ha + "pp" ;
        _ + "t"  => ha + "tt" ;
        _ + "d"  => ha + "t" ;
        _ + ("a" | "‰") => hak + "k" ;  -- s‰e, tae
        _ + "v"  => ha + "p" ;  -- rove/hyve impossible
        _    => hak
        } + e ;

--3 Proper names
--
-- Proper names are similar to common nouns in the singular.

  ProperName = {s : Case => Str} ;

  mkProperName : CommonNoun -> ProperName = \jussi -> 
    {s = \\c => jussi.s ! NCase Sg c} ;

-- An ending given to a symbol cannot really be decided
-- independently. The string $a$ gives the vowel harmony.
-- Only some South-West dialects have the generally valid
-- Illative form.

  caseEnding : Str -> Case -> Str = \a,c -> case c of {
    Nom => [] ;
    Gen => "n" ;
    Part => a ; --- 
    Transl => "ksi" ; 
    Ess => "n" + a ;
    Iness => "ss" + a ;
    Elat => "st" + a ;
    Illat => "sse" ; ---
    Adess => "ll" + a ;
    Ablat => "lt" + a ;
    Allat => "lle" ;
    Abess => "tt" + a
    } ;

  symbProperName : Str -> ProperName = \x -> 
    {s = table {
       Nom => x ;
       c => glue x (":" + caseEnding "a" c)
       }
    } ;

--2 Pronouns
--
-- Here we define personal and relative pronouns.

  mkPronoun : (_,_,_,_,_ : Str) ->  Number -> Person -> 
    {s : NPForm => Str ; a : Agr} = 
    \mina, minun, minua, minuna, minuun, n, p ->
    let {
      minu = Predef.tk 2 minuna ;
      a    = Predef.dp 1 minuna
    } in 
    {s = table {
      NPCase Nom    => mina ;
      NPCase Gen    => minun ;
      NPCase Part   => minua ;
      NPCase Transl => minu + "ksi" ;
      NPCase Ess    => minuna ;
      NPCase Iness  => minu + ("ss" + a) ;
      NPCase Elat   => minu + ("st" + a) ;
      NPCase Illat  => minuun ;
      NPCase Adess  => minu + ("ll" + a) ;
      NPCase Ablat  => minu + ("lt" + a) ;
      NPCase Allat  => minu + "lle" ;
      NPCase Abess  => minu + ("tt" + a) ;
      NPAcc         => Predef.tk 1 minun + "t"
      } ;
     a = {n = n ; p = p}
    } ; 


-- The non-human pronoun "se" ('it') is even more irregular,
-- Its accusative cases do not
-- have a special form with "t", but have the normal genitive/nominative variation.
-- We use the type $ProperName$ for "se", because of the accusative but also
-- because the person and number are as for proper names.

  pronSe : ProperName  = {
    s = table {
      Nom    => "se" ;
      Gen    => "sen" ;
      Part   => "sit‰" ;
      Transl => "siksi" ;
      Ess    => "sin‰" ;
      Iness  => "siin‰" ;
      Elat   => "siit‰" ;
      Illat  => "siihen" ;
      Adess  => "sill‰" ;
      Ablat  => "silt‰" ;
      Allat  => "sille" ;
      Abess  => "sitt‰"
      } ;
    } ;

-- The possessive suffixes will be needed in syntax. It will show up
-- as a separate word ("auto &+ ni"), which needs unlexing. Unlexing also
-- has to fix the vowel harmony in cases like "‰iti &+ ns‰".

  suff : Str -> Str = \ni -> ni ;

  possSuffix : Number => Person => Str = \\n,p => 
    suff (case <n,p> of {
      <Sg,P1> => "ni" ;
      <Sg,P2> => "si" ;
      <Sg,P3> => "nsa" ;
      <Pl,P1> => "mme" ;
      <Pl,P2> => "nne" ;
      <Pl,P3> => "nsa"
    } ) ;

-- The relative pronoun, "joka", is inflected in case and number, 
-- like common nouns, but it does not take possessive suffixes.
-- The inflextion shows a surprising similarity with "suo".

  relPron : {s : Number => Case => Str} =
    let {jo = nhn (sSuo "jo")} in {s = 
    table {
      Sg => table {
        Nom => "joka" ;
        Gen => "jonka" ;
        c   => jo.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "jotka" ;
        c   => "j" + (jo.s ! NCase Pl c)
        }
      } 
    } ;
  
  mikaInt : Number => Case => Str = 
    let {
      mi  = nhn (sSuo "mi")
    } in
    table {
      Sg => table {
        Nom => "mik‰" ;
        Gen => "mink‰" ;
        c   => mi.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "mitk‰" ;
        Gen => "mittenk‰" ;
        c   => mi.s ! NCase Sg c
        }
      } ;

  kukaInt : Number => Case => Str = 
    let {
      ku = nhn (sRae "kuka" "kenen‰") ;
      ket = nhn (sRae "kuka" "kein‰")} in
    table {
      Sg => table {
        Nom => "kuka" ;
        Part => "ket‰" ;
        Illat => "keneen" ;
        c   => ku.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "ketk‰" ;
        Illat => "keihin" ;
        c   => ket.s ! NCase Pl c
        }
      } ;

  mikaanPron : Number => Case => Str = \\n,c =>
    case <n,c> of {
        <Sg,Nom> => "mik‰‰n" ;
        <_,Part> => "mit‰‰n" ;
        <Sg,Gen> => "mink‰‰n" ;
        <Pl,Nom> => "mitk‰‰n" ;
        <Pl,Gen> => "mittenk‰‰n" ;
        <_,Ess>  => "min‰‰n" ;
        <_,Iness> => "miss‰‰n" ;
        <_,Elat> => "mist‰‰n" ;
        <_,Adess> => "mill‰‰n" ;
        <_,Ablat> => "milt‰‰n" ;
        _   => mikaInt ! n ! c + "k‰‰n"
       } ; 

  kukaanPron : Number => Case => Str =
    table {
      Sg => table {
        Nom => "kukaan" ;
        Part => "ket‰‰n" ;
        Ess => "ken‰‰n" ;
        Iness => "kess‰‰n" ;
        Elat  => "kest‰‰n" ;
        Illat => "kehenk‰‰n" ;
        Adess => "kell‰‰n" ;
        Ablat => "kelt‰‰n" ;
        c   => kukaInt ! Sg ! c + "k‰‰n"
       } ; 
      Pl => table {
        Nom => "ketk‰‰n" ;
        Part => "keit‰‰n" ;
        Ess => "kein‰‰n" ;
        Iness => "keiss‰‰n" ;
        Elat => "keist‰‰n" ;
        Adess => "keill‰‰n" ;
        Ablat => "keilt‰‰n" ;
        c   => kukaInt ! Pl ! c + "k‰‰n"
        }
      } ;

  jokuPron : Number => Case => Str =
    let 
      ku = nhn (sPuu "ku") ;
      kui = nhn (sPuu "kuu") 
    in
    table {
      Sg => table {
        Nom => "joku" ;
        Gen => "jonkun" ;
        c => relPron.s ! Sg ! c + ku.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "jotkut" ;
        c => relPron.s ! Pl ! c + kui.s ! NCase Pl c
        }
      } ;

  jokinPron : Number => Case => Str =
    table {
      Sg => table {
        Nom => "jokin" ;
        Gen => "jonkin" ;
        c => relPron.s ! Sg ! c + "kin"
       } ; 
      Pl => table {
        Nom => "jotkin" ;
        c => relPron.s ! Pl ! c + "kin"
        }
      } ;

moniPron : Case => Str = caseTable Sg (nhn (sSusi "moni" "monen" "monena")) ;

caseTable : Number -> CommonNoun -> Case => Str = \n,cn -> 
  \\c => cn.s ! NCase n c ;


--2 Adjectives
--


-- For the comparison of adjectives, three noun declensions 
-- are needed in the worst case.

  mkAdjective : (_,_,_ : Adj) -> Adjective = \hyva,parempi,paras -> 
    {s = table {
      Posit  => hyva.s ;
      Compar => parempi.s ;
      Superl  => paras.s
      }
    } ;

-- However, it is usually enough to give the positive declension and
-- the characteristic forms of comparative and superlative. 

  regAdjective : CommonNoun -> Str -> Str -> Adjective = \kiva, kivempaa, kivinta ->
    mkAdjective 
      (noun2adj kiva) 
      (noun2adjComp False (nhn (sSuurempi kivempaa))) 
      (noun2adjComp False (nhn (sSuurin kivinta))) ;



  regVerbH : Str -> VerbH = \soutaa -> 
  let
    taa = Predef.dp 3 soutaa ;
    juo = Predef.tk 2 soutaa ;
    souda = weakGrade (init soutaa) ;
    soudan = juo + "en" ;
    o  = Predef.dp 1 juo ;
    a = last soutaa ;
    u = ifTok Str a "a" "u" "y" ;
    joi = Predef.tk 2 juo + (o + "i")
  in 
  case taa of {
    "it" + _ => vHarkita soutaa ;
    ("st" | "nn" | "rr" | "ll") + _ => 
      vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
    _ + ("aa" | "‰‰")     => vOttaa soutaa (souda + "n") ;
    ("o" | "u" | "y" | "ˆ") + ("da" | "d‰") => vJuoda soutaa joi ;
    ("ata" | "‰t‰") => vOsata soutaa ;
    _ => vHukkua soutaa souda
    } ;

  reg2VerbH : (soutaa,souti : Str) -> VerbH = \soutaa,souti ->
  let
----    soudat = regVerbH soutaa ;
    soudan = weakGrade (init soutaa) + "n" ;
    soudin = weakGrade souti + "n" ;
    souden = init souti + "en" ;
    juo = Predef.tk 2 soutaa ;
    o  = Predef.dp 1 juo ;
    u = ifTok Str (last soutaa) "a" "u" "y" ;
    taa = Predef.dp 3 soutaa ;
  in 
  case taa of {
    "taa" | "t‰‰" => vHuoltaa soutaa soudan souti soudin ;
    "ata" | "‰t‰" => vPalkata soutaa souti ;
    "ota" | "ˆt‰" => vPudota soutaa souti ;
    "sta" | "st‰" => vJuosta soutaa souden (juo +   o+u+"t") (juo + "t"+u) ;
    _ + ("da" | "d‰") => vJuoda soutaa souti
----    _ => soudat
    } ;

  reg3VerbH : (_,_,_ : Str) -> VerbH = \soutaa,soudan,souti -> 
  let
    taa   = Predef.dp 3 soutaa ;
    souda = init soudan ;
    juo = Predef.tk 2 soutaa ;
    o  = last juo ;
    a = last taa ;
    u = ifTok Str a "a" "u" "y" ;
    soudin = souti + "n" ; ----weakGrade souti + "n" ;
    ----soudat = reg2VerbH soutaa souti ;
  in case taa of {
    "lla" | "ll‰" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
    "taa" | "t‰‰" => vHuoltaa soutaa soudan souti soudin
----    _ => soudat
    } ;

-- For "harppoa", "hukkua", "lˆyty‰", with grade alternation.

  vHukkua : (_,_ : Str) -> VerbH = \hukkua,huku -> 
    let {
      a     = Predef.dp 1 hukkua ;
      hukku = Predef.tk 1 hukkua ;
      u     = Predef.dp 1 huku ;
      i = case u of {
        "e" | "i" => [] ;
        _ => u
        } ;
      y = case a of {
        "a" => "u" ;
        _ => "y"
        } ;
      hukkui = init hukku + i + "i" ; 
      hukui  = init huku + i + "i" ; 
    } in
    mkVerbH
      hukkua
      (hukku + u)
      (huku + "n")
      (hukku + "v" + a + "t")
      (hukku + (("k" + a) + a))
      (huku + ((("t" + a) + a) + "n"))
      (hukkui)
      (hukui + "n")
      (hukkui + "si")
      (hukku + "n" + y + "t")
      (huku + "tt" + y)
      (huku + "t" + y + "t") ;

-- For cases with or without alternation: "sanoa", "valua", "kysy‰".

  vSanoa : Str -> VerbH = \sanoa ->
    vHukkua sanoa (Predef.tk 1 sanoa) ;
----    vHukkua sanoa (weakGrade (Predef.tk 1 sanoa)) ;
---- The gfr file becomes 6* bigger if this change is done

-- For "ottaa", "k‰ytt‰‰", "lˆyt‰‰", "huoltaa", "hiiht‰‰", "siirt‰‰".

  vHuoltaa : (_,_,_,_ : Str) -> VerbH = \ottaa,otan,otti,otin -> 
    let {
      a    = Predef.dp 1 ottaa ;
      aa   = a + a ;
      u    = case a of {"a" => "u" ; _ => "y"} ;
      ota  = Predef.tk 1 otan ;
      otta = Predef.tk 1 ottaa ;
      ote  = Predef.tk 1 ota + "e"
    } in
    mkVerbH
      ottaa
      ottaa
      otan
      (otta + "v" + a + "t") 
      (otta + "k" + aa) 
      (ote  + "t" + aa + "n")
      otti
      otin
      (otta + "isi")
      (otta + "n" + u + "t")
      (ote + "tt" + u)
      (ote + "t" + u + "n") ;

-- For cases where grade alternation is not affected by the imperfect "i".

  vOttaa : (_,_ : Str) -> VerbH = \ottaa,otan -> 
    let 
      i = "i" ; --- wrong rule if_then_Str (pbool2bool (Predef.occurs "ou" ottaa)) "i" "oi"
    in
    vHuoltaa ottaa otan (Predef.tk 2 ottaa + i) (Predef.tk 2 otan + i + "n") ;

-- For "poistaa", "ryyst‰‰".

  vPoistaa : Str -> VerbH = \poistaa -> 
    vOttaa poistaa ((Predef.tk 1 poistaa + "n")) ;


-- For "osata", "lis‰t‰"; grade alternation is unpredictable, as seen
-- from "pel‰t‰-pelk‰si" vs. "palata-palasi"


  vOsata : Str -> VerbH = \osata -> 
    vPalkata osata (Predef.tk 2 osata + "si") ;

  vPalkata : Str -> Str -> VerbH = \palkata,palkkasi -> 
    let
      a   = Predef.dp 1 palkata ;
      palka = Predef.tk 2 palkata ;
      palkka = Predef.tk 2 palkkasi ;
      u   = case a of {"a" => "u" ; _ => "y"}
    in
    mkVerbH
      palkata
      (palkka + a)
      (palkka + (a + "n"))
      (palkka + (((a + "v") + a) + "t"))
      (palka + ((("t" + "k") + a) + a)) 
      (palkata + (a + "n"))
      (palkka + "si")
      (palkka + "sin")
      (palkka + "isi")
      (palka + "nn" + u + "t")
      (palka + "tt" + u)
      (palka + "t" + u + "n") ;

  vPudota : Str -> Str -> VerbH = \pudota, putosi -> 
    let
      a    = Predef.dp 1 pudota ;
      pudo = Predef.tk 2 pudota ;
      puto = Predef.tk 2 putosi ;
      putoa = puto + a ;
      u   = case a of {"a" => "u" ; _ => "y"}
    in
    mkVerbH
      pudota
      (putoa  + a)
      (putoa  + "n")
      (putoa  + "v"  + a + "t")
      (pudo   + "tk" + a + a) 
      (pudota + a + "n")
      (puto   + "si")
      (puto   + "sin")
      (puto   + a + "isi")
      (pudo   + "nn" + u + "t")
      (pudo   + "tt" + u)
      (pudo   + "t" + u + "n") ;

  vHarkita : Str -> VerbH = \harkita -> 
    let
      a      = Predef.dp 1 harkita ;
      harki  = Predef.tk 2 harkita ;
      harkitse = harki + "tse" ;
      harkitsi = harki + "tsi" ;
      u   = case a of {"a" => "u" ; _ => "y"}
    in
    mkVerbH
      harkita
      (harkitse + "e")
      (harkitse + "n")
      (harkitse + "v" + a + "t")
      (harki    + "tk"+ a + a) 
      (harkita  +  a + "n")
      (harkitsi)
      (harkitsi + "n")
      (harkitsi + "si")
      (harki + "nn" + u + "t")
      (harki + "tt" + u)
      (harki + "t" + u + "n") ;


----- tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun

-- For "juosta", "piest‰", "nousta", "rangaista", "k‰vell‰", "surra", "panna".

  vJuosta : (_,_,_,_ : Str) -> VerbH = \juosta,juoksen,juossut,juostu -> 
    let
      a      = Predef.dp 1 juosta ;
      t      = last (init juosta) ;
      juokse = Predef.tk 1 juoksen ;
      juoksi = Predef.tk 2 juoksen + "i" ;
      juos   = Predef.tk 2 juosta ;
      juostun = ifTok Str t "t" (juostu + "n") (init juossut + "n") ;
    in
    mkVerbH
      juosta
      (juokse + "e")
      juoksen
      (juokse + (("v" + a) + "t"))
      (juos + (("k" + a) + a)) 
      (juosta + (a + "n")) 
      juoksi
      (juoksi + "n")
      (juoksi + "si")
      juossut
      juostu
      juostun ;

-- For "juoda", "syˆd‰", "vied‰", "naida", "saada".

  vJuoda : (_,_ : Str) -> VerbH = \juoda, joi -> 
    let
      a   = Predef.dp 1 juoda ;
      juo = Predef.tk 2 juoda ;
      u   = case a of {"a" => "u" ; _ => "y"}
    in
    mkVerbH
      juoda
      juo
      (juo + "n")
      (juo + (("v" + a) + "t"))
      (juo + (("k" + a) + a)) 
      (juoda + (a + "n")) 
      joi
      (joi + "n")
      (joi + "si")
      (juo + "n" + u + "t")
      (juo + "t" + u)
      (juo + "d" + u + "n") ;

} ;



