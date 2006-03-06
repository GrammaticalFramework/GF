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
    nhn (mkSubst (ifTok Str (Predef.dp 1 talona) "a" "a" "ä")
      talo (Predef.tk 1 talon) (Predef.tk 2 talona) taloa taloon
      (Predef.tk 2 taloina) (Predef.tk 3 taloissa) talojen taloja taloihin) ;


-- Here some useful special cases; more are given in $ParadigmsFin.gf$.
--         

  sLukko : Str -> NounH = \lukko -> 
   let
     o = last lukko ;
     lukk = init lukko ; 
     a = getHarmony o ;
     lukkoja = case o of {
       "a" => lukk + if_then_Str (pbool2bool (Predef.occurs "ou" lukk)) "ia" "oja" ;
       "ä" => lukk + "iä" ;
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
    sKorpi sylki (init (weakGrade sylki) + "en") (init sylki + "enä") ;

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

-- Nouns of at least 3 syllables ending with "a" or "ä", like "peruna", "rytinä".

  sPeruna : Str -> NounH = \peruna ->
    let {
      a  = Predef.dp 1 peruna ;
      perun = Predef.tk 1 peruna ;
      perunoi = perun + (ifTok Str a "a" "o" "ö" + "i")
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
      a         = ifTok Str u "u" "a" "ä"
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

-- Words of the form "siitin", "avain", "höyhen" (w or wo grade alternation).

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

-- The following covers adjectives like "kapea", "leveä".

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
  _   => "ä"
  } ;

-- This function inspects the whole word.

vowelHarmony : Str -> Str = \liitin ->
  if_then_Str (pbool2bool (Predef.occurs "aou" liitin)) "a" "ä" ;

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
        ("hk" | "tk") + _ => kukko ;           -- *tahko-tahon, *pitkä-pitkän
        "s" + ("k" | "p" | "t") + _ => kukko ; -- *lasku-lasvun, *raspi-rasvin, *lastu-lasdun
        x + "ku" => ku + x + "vu" ;
        x + "k" + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") => ku + x      + o ; 
        x + "p" + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") => ku + x + "v" + o ; 
        x + "t" + ("a" | "e" | "i" | "o" | "u" | "y" | "ä" | "ö") => ku + x + "d" + o ; 
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
        _ + ("a" | "ä") => hak + "k" ;  -- säe, tae
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

  mkDemPronoun : (_,_,_,_,_ : Str) ->  Number -> 
    {s : NPForm => Str ; a : Agr} = 
    \tuo, tuon, tuota, tuona, tuohon, n ->
    let pro = mkPronoun tuo tuon tuota tuona tuohon n P3
    in {
      s = table {
        NPAcc => tuo ;
        c => pro.s ! c
        } ;
      a = pro.a
      } ;

-- Determiners

  mkDet : Number -> CommonNoun -> {
      s1 : Case => Str ;       -- minun kolme
      s2 : Str ;               -- -ni
      n : Number ;             -- Pl   (agreement feature for verb)
      isNum : Bool ;           -- True (a numeral is present)
      isPoss : Bool ;          -- True (a possessive suffix is present)
      isDef : Bool             -- True (verb agrees in Pl, Nom is not Part)
      } = \n, noun -> {
    s1 = \\c => noun.s ! NCase n c ;
    s2 = [] ;
    n = n ;
    isNum, isPoss = False ;
    isDef = True  --- does this hold for all new dets?
    } ;

  mkQuant : CommonNoun -> {
    s1 : Number => Case => Str ; 
    s2 : Str ; 
    isPoss, isDef : Bool
    } = \noun -> {
      s1 = \\n,c => noun.s ! NCase n c ;
      s2 = [] ;
      isPoss = False ;
      isDef = True  --- does this hold for all new dets?
    } ;

-- The relative pronoun, "joka", is inflected in case and number, 
-- like common nouns, but it does not take possessive suffixes.
-- The inflextion shows a surprising similarity with "suo".

oper
  relPron : Number => Case => Str =
    let {jo = nhn (sSuo "jo")} in
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
      } ;
  
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
    _ + ("aa" | "ää")     => vOttaa soutaa (souda + "n") ;
    ("o" | "u" | "y" | "ö") + ("da" | "dä") => vJuoda soutaa joi ;
    ("ata" | "ätä") => vOsata soutaa ;
    _ => vHukkua soutaa souda
    } ;

  reg2VerbH : (soutaa,souti : Str) -> VerbH = \soutaa,souti ->
  let
    soudan = weakGrade (init soutaa) + "n" ;
    soudin = weakGrade souti + "n" ;
    souden = init souti + "en" ;
    juo = Predef.tk 2 soutaa ;
    o  = Predef.dp 1 juo ;
    u = ifTok Str (last soutaa) "a" "u" "y" ;
    taa = Predef.dp 3 soutaa ;
  in 
  case taa of {
    "taa" | "tää" => vHuoltaa soutaa soudan souti soudin ;
    "ata" | "ätä" => vPalkata soutaa souti ;
    "ota" | "ötä" => vPudota soutaa souti ;
    "sta" | "stä" => vJuosta soutaa souden (juo +   o+u+"t") (juo + "t"+u) ;
    _ + ("da" | "dä") => vJuoda soutaa souti ;
    _ => regVerbH soutaa
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
  in case taa of {
    "lla" | "llä" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
    "taa" | "tää" => vHuoltaa soutaa soudan souti soudin ;
    _ => reg2VerbH soutaa souti
    } ;

-- For "harppoa", "hukkua", "löytyä", with grade alternation.

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

-- For cases with or without alternation: "sanoa", "valua", "kysyä".

  vSanoa : Str -> VerbH = \sanoa ->
    vHukkua sanoa (Predef.tk 1 sanoa) ;
----    vHukkua sanoa (weakGrade (Predef.tk 1 sanoa)) ;
---- The gfr file becomes 6* bigger if this change is done

-- For "ottaa", "käyttää", "löytää", "huoltaa", "hiihtää", "siirtää".

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

-- For "poistaa", "ryystää".

  vPoistaa : Str -> VerbH = \poistaa -> 
    vOttaa poistaa ((Predef.tk 1 poistaa + "n")) ;


-- For "osata", "lisätä"; grade alternation is unpredictable, as seen
-- from "pelätä-pelkäsi" vs. "palata-palasi"


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

-- For "juosta", "piestä", "nousta", "rangaista", "kävellä", "surra", "panna".

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

-- For "juoda", "syödä", "viedä", "naida", "saada".

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



