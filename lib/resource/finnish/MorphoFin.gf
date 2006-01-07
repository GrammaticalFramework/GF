--# -path=.:../../prelude

--1 A Simple Finnish Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
--
-- We use the parameter types and word classes defined in $TypesFin.gf$.

resource MorphoFin = TypesFin ** open Prelude in {

--- flags optimize=noexpand ;

--2 Nouns
--

oper

  NounH : Type = {
    a,vesi,vede,vete,vetta,veteen,vetii,vesii,vesien,vesia,vesiin : Str
    } ;

-- worst-case macro

  mkSubst : Str -> (_,_,_,_,_,_,_,_,_,_ : Str) -> NounH = 
    \a,vesi,vede,vete,vetta,veteen,vetii,vesii,vesien,vesia,vesiin -> 
    {a = a ;
     vesi = vesi ;
     vede = vede ;
     vete = vete ;
     vetta = vetta ;
     veteen = veteen ;
     vetii = vetii ;
     vesii = vesii ;
     vesien = vesien ;
     vesia = vesia ;
     vesiin = vesiin
    } ;

  nhn : NounH -> CommonNoun = \nh ->
    let
     a = nh.a ;
     vesi = nh.vesi ;
     vede = nh.vede ;
     vete = nh.vete ;
     vetta = nh.vetta ;
     veteen = nh.veteen ;
     vetii = nh.vetii ;
     vesii = nh.vesii ;
     vesien = nh.vesien ;
     vesia = nh.vesia ;
     vesiin = nh.vesiin
    in
    {s = table {
      NCase Sg Nom    => vesi ;
      NCase Sg Gen    => vede + "n" ;
      NCase Sg Part   => vetta ;
      NCase Sg Transl => vede + "ksi" ;
      NCase Sg Ess    => vete + ("n" + a) ;
      NCase Sg Iness  => vede + ("ss" + a) ;
      NCase Sg Elat   => vede + ("st" + a) ;
      NCase Sg Illat  => veteen ;
      NCase Sg Adess  => vede + ("ll" + a) ;
      NCase Sg Ablat  => vede + ("lt" + a) ;
      NCase Sg Allat  => vede + "lle" ;
      NCase Sg Abess  => vede + ("tt" + a) ;

      NCase Pl Nom    => vede + "t" ;
      NCase Pl Gen    => vesien ;
      NCase Pl Part   => vesia ;
      NCase Pl Transl => vesii + "ksi" ;
      NCase Pl Ess    => vetii + ("n" + a) ;
      NCase Pl Iness  => vesii + ("ss" + a) ;
      NCase Pl Elat   => vesii + ("st" + a) ;
      NCase Pl Illat  => vesiin ;
      NCase Pl Adess  => vesii + ("ll" + a) ;
      NCase Pl Ablat  => vesii + ("lt" + a) ;
      NCase Pl Allat  => vesii + "lle" ;
      NCase Pl Abess  => vesii + ("tt" + a) ;

      NComit    => vetii + "ne" ;
      NInstruct => vesii + "n" ;

      NPossNom       => vete ;
      NPossGenPl     => Predef.tk 1 vesien ;
      NPossTransl Sg => vede + "kse" ;
      NPossTransl Pl => vesii + "kse" ;
      NPossIllat Sg  => Predef.tk 1 veteen ;
      NPossIllat Pl  => Predef.tk 1 vesiin
      }
    } ;

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
-- Nouns with partitive "a"/"‰" ; 
-- to account for grade and vowel alternation, three forms are usually enough
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syyl‰",...

  sKukko : (_,_,_ : Str) -> NounH = \kukko,kukon,kukkoja ->
    let {
      o      = Predef.dp 1 kukko ;
      a      = Predef.dp 1 kukkoja ;
      kukkoj = Predef.tk 1 kukkoja ;
      i      = Predef.dp 1 kukkoj ;
      ifi    = ifTok Str i "i" ;
      kukkoi = ifi kukkoj (Predef.tk 1 kukkoj) ;
      e      = Predef.dp 1 kukkoi ;
      kukoi  = Predef.tk 2 kukon + Predef.dp 1 kukkoi
    } 
    in
    mkSubst a 
            kukko 
            (Predef.tk 1 kukon) 
            kukko
            (kukko + a) 
            (kukko + o + "n")
            (kukkoi + ifi "" "i") 
            (kukoi + ifi "" "i") 
            (ifTok Str e "e" (Predef.tk 1 kukkoi + "ien") (kukkoi + ifi "en" "jen"))
            kukkoja
            (kukkoi + ifi "in" "ihin") ;

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

-- Surpraisingly, making the test for the partitive, this not only covers
-- "rae", "perhe", "savuke", but also "rengas", "lyhyt" (except $Sg Illat$), etc.

  sRae : (_,_ : Str) -> NounH = \rae,rakeena ->
    let {
      a      = Predef.dp 1 rakeena ;
      rakee  = Predef.tk 2 rakeena ;
      rakei  = Predef.tk 1 rakee + "i" ;
      raet   = rae + (ifTok Str (Predef.dp 1 rae) "e" "t" [])
    } 
    in
    mkSubst a 
            rae
            rakee 
            rakee
            (raet + ("t" + a)) 
            (rakee + "seen")
            rakei
            rakei
            (rakei + "den") 
            (rakei + ("t" + a))
            (rakei + "siin") ;

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
  "a" => "a" ;
  "o" => "a" ;
  "u" => "a" ;
  _   => "‰"
  } ;

-- This function inspects the whole word.

vowelHarmony : Str -> Str = \liitin ->
  if_then_Str (pbool2bool (Predef.occurs "aou" liitin)) "a" "‰" ;

-- The following function defines how grade alternation works if it is active.
-- In general, *whether there is* grade alternation must be given in the lexicon
-- (cf. "auto - auton" not "audon"; "vihje - vihjeen" not "vihkeen").

  weakGrade : Str -> Str = \kukko -> 
    let {
      kukk = init kukko ;
      ku = Predef.tk 3 kukko ;
      kul = Predef.tk 2 kukko ;
      kk = init (Predef.dp 3 kukko) ;
      k  = last kk ;
      o  = last kukko ;
      kuk = case kk of {
        "kk" => ku + "k" ;
        "pp" => ku + "p" ;
        "tt" => ku + "t" ;
        "nk" => ku + "ng" ;
        "nt" => ku + "nn" ;
        "mp" => ku + "mm" ;
        "rt" => ku + "rr" ;
        "lt" => ku + "ll" ;
        "lk" => kul + case o of {
           "i" | "e" => "j" ;
           _   => ""
           } ;
        "rk" => kul + case o of {
           "i" | "e" => "j" ;
           _   => ""
           } ;
        "hk" | "tk" => kukk ;  -- *tahko-tahon, *pitk‰-pitk‰n
        "sk" => kukk ;  -- *lasku-lasvun
        "sp" => kukk ;  -- *raspi-rasvin
        "st" => kukk ;  -- *lastu-lasdun
        _ => case k of {
          "k" => case o of {
            "u" => kul + "v" ;
            _ => kul 
            };
          "p" => kul + "v" ;
          "t" => kul + "d" ;
          _ => kukk
          }
        }
    } 
    in kuk + o ;

--- This is only used to analyse nouns "rae", "hake", etc.

  strongGrade : Str -> Str = \hake -> 
    let
      hak = init hake ;
      ha = init hak ;
      k  = last hak ;
      e  = last hake ;
      ly = Predef.tk 2 hak ;
      hd = Predef.dp 2 hak ;
      ifE : Str -> Str = \hant -> ifTok Str e "e" hant hak ;
      hakk =
      case hd of {
        "ng" => ha + "k" ;
        "nn" => ha + "t" ;
        "mm" => ha + "p" ;
        "rr" => ha + "t" ;
        "ll" => ha + "t" ;
        "lj" => ifE (ha + "k") ; -- paljas-paljaan
        "hk" | "sk" | "sp" | "st" => hak ;
        _ =>     -- vihje/pohje: impossible to infer
      case k of {
        "k" => hak + "k" ;
        "p" => hak + "p" ;
        "t" => hak + "t" ;
        "d" => ha + "t" ;
        "v" => ha + "p" ;  -- rove/hyve impossible
        "a" | "‰" => hak + "k" ;
        _ => hak
        }
     }
     in hakk + e ;  


--3 Proper names
--
-- Proper names are similar to common nouns in the singular.

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

  mkPronoun : (_,_,_,_,_ : Str) ->  Number -> Person -> Pronoun = 
    \mina, minun, minua, minuna, minuun, n, p ->
    let {
      minu = Predef.tk 2 minuna ;
      a    = Predef.dp 1 minuna
    } in 
    {s = table {
      PCase Nom    => mina ;
      PCase Gen    => minun ;
      PCase Part   => minua ;
      PCase Transl => minu + "ksi" ;
      PCase Ess    => minuna ;
      PCase Iness  => minu + ("ss" + a) ;
      PCase Elat   => minu + ("st" + a) ;
      PCase Illat  => minuun ;
      PCase Adess  => minu + ("ll" + a) ;
      PCase Ablat  => minu + ("lt" + a) ;
      PCase Allat  => minu + "lle" ;
      PCase Abess  => minu + ("tt" + a) ;
      PAcc         => Predef.tk 1 minun + "t"
      } ;
     n = n ; p = p} ; 

  pronMina = mkPronoun "min‰" "minun" "minua" "minuna" "minuun" Sg P1 ;
  pronSina = mkPronoun "sin‰" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  pronHan  = mkPronoun "h‰n" "h‰nen" "h‰nt‰"  "h‰nen‰" "h‰neen" Sg P3 ;
  pronMe   = mkPronoun "me" "meid‰n" "meit‰" "mein‰" "meihin" Pl P1 ;
  pronTe   = mkPronoun "te" "teid‰n" "teit‰" "tein‰" "teihin"  Pl P2 ;
  pronHe   = mkPronoun "he" "heid‰n" "heit‰" "hein‰" "heihin"  Pl P3 ;
  pronNe   = mkPronoun "ne" "niiden" "niit‰" "niin‰" "niihin"  Pl P3 ;

  pronTama = mkPronoun "t‰m‰" "t‰m‰n" "t‰t‰" "t‰n‰" "t‰h‰n"  Sg P3 ;
  pronNama = mkPronoun "n‰m‰" "n‰iden" "n‰it‰" "n‰in‰" "n‰ihin"  Pl P3 ;
  pronTuo  = mkPronoun "tuo" "tuon" "tuota" "tuona" "tuohon"  Sg P3 ;
  pronNuo  = mkPronoun "nuo" "noiden" "noita" "noina" "noihin"  Pl P3 ;

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

  relPron : RelPron = 
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

moniPron : Case => Str = caseTable singular (nhn (sSusi "moni" "monen" "monena")) ;

caseTable : Number -> CommonNoun -> Case => Str = \n,cn -> 
  \\c => cn.s ! NCase n c ;


--2 Adjectives
--
-- To form an adjective, it is usually enough to give a noun declension: the
-- adverbial form is regular.

  noun2adj : CommonNoun -> Adjective = noun2adjComp True ;

  noun2adjComp : Bool -> CommonNoun -> Adjective = \isPos,tuore ->
    let 
      tuoreesti  = Predef.tk 1 (tuore.s ! NCase Sg Gen) + "sti" ; 
      tuoreemmin = Predef.tk 2 (tuore.s ! NCase Sg Gen) + "in"
    in {s = table {
         AN f => tuore.s ! f ;
         AAdv => if_then_Str isPos tuoreesti tuoreemmin
         }
       } ;

-- For the comparison of adjectives, three noun declensions 
-- are needed in the worst case.

  mkAdjDegr : (_,_,_ : Adjective) -> AdjDegr = \hyva,parempi,paras -> 
    {s = table {
      Pos  => hyva.s ;
      Comp => parempi.s ;
      Sup  => paras.s
      }
    } ;

-- However, it is usually enough to give the positive declension and
-- the characteristic forms of comparative and superlative. 

  regAdjDegr : CommonNoun -> Str -> Str -> AdjDegr = \kiva, kivempaa, kivinta ->
    mkAdjDegr 
      (noun2adj kiva) 
      (noun2adjComp False (nhn (sSuurempi kivempaa))) 
      (noun2adjComp False (nhn (sSuurin kivinta))) ;


--3 Verbs
--
-- The present, past, conditional. and infinitive stems, acc. to Koskenniemi.
-- Unfortunately not enough (without complicated processes).
-- We moreover give grade alternation forms as arguments, since it does not
-- happen automatically.
--- A problem remains with the verb "seist‰", where the infinitive
--- stem has vowel harmony "‰" but the others "a", thus "seisoivat" but "seisk‰‰".


  mkVerb : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> Verb = 
    \tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun -> 
    v2v (mkVerbH 
     tulla tulee tulen tulevat tulkaa tullaan tuli tulin tulisi tullut tultu tullun
      ) ;

  v2v : VerbH -> Verb = \vh -> 
    let
      tulla = vh.tulla ; 
      tulee = vh.tulee ; 
      tulen = vh.tulen ; 
      tulevat = vh.tulevat ;
      tulkaa = vh.tulkaa ; 
      tullaan = vh.tullaan ; 
      tuli = vh.tuli ; 
      tulin = vh.tulin ;
      tulisi = vh.tulisi ;
      tullut = vh.tullut ;
      tultu = vh.tultu ;
      tultu = vh.tultu ;
      tullun = vh.tullun ;
      tuje = init tulen ;
      tuji = init tulin ;
      a = Predef.dp 1 tulkaa ;
      tulko = Predef.tk 2 tulkaa + (ifTok Str a "a" "o" "ˆ") ;
      o = last tulko ;
      tulleena = Predef.tk 2 tullut + ("een" + a) ;
      tulleen = (noun2adj (nhn (sRae tullut tulleena))).s ;
      tullun = (noun2adj (nhn (sKukko tultu tullun (tultu + ("j"+a))))).s  ;
      tulema = tuje + "m" + a ;
      vat = "v" + a + "t"
    in
    {s = table {
      Inf => tulla ;
      Pres Sg P1 => tuje + "n" ;
      Pres Sg P2 => tuje + "t" ;
      Pres Sg P3 => tulee ;
      Pres Pl P1 => tuje + "mme" ;
      Pres Pl P2 => tuje + "tte" ;
      Pres Pl P3 => tulevat ;
      Impf Sg P1 => tuji + "n" ;
      Impf Sg P2 => tuji + "t" ;
      Impf Sg P3 => tuli ;
      Impf Pl P1 => tuji + "mme" ;
      Impf Pl P2 => tuji + "tte" ;
      Impf Pl P3 => tuli + vat ;
      Cond Sg P1 => tulisi + "n" ;
      Cond Sg P2 => tulisi + "t" ;
      Cond Sg P3 => tulisi ;
      Cond Pl P1 => tulisi + "mme" ;
      Cond Pl P2 => tulisi + "tte" ;
      Cond Pl P3 => tulisi + vat ;
      Imper Sg   => tuje ;
      Imper Pl   => tulkaa ;
      ImperP3 Sg => tulko + o + "n" ;
      ImperP3 Pl => tulko + o + "t" ;
      ImperP1Pl  => tulkaa + "mme" ;
      ImpNegPl   => tulko ;
      Pass True  => tullaan ;
      Pass False => Predef.tk 2 tullaan ;
      PastPartAct n => tulleen ! n ;
      PastPartPass n => tullun ! n ;
      Inf3Iness => tulema + "ss" + a ;
      Inf3Elat  => tulema + "st" + a ;
      Inf3Illat => tulema +  a   + "n" ;
      Inf3Adess => tulema + "ll" + a ;
      Inf3Abess => tulema + "tt" + a 
      }
    } ;

  VerbH : Type = {
    tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun
      : Str
    } ;

  mkVerbH : (_,_,_,_,_,_,_,_,_,_,_,_ : Str) -> VerbH = 
    \tulla,tulee,tulen,tulevat,tulkaa,tullaan,tuli,tulin,tulisi,tullut,tultu,tullun -> 
    {tulla = tulla ; 
     tulee = tulee ; 
     tulen = tulen ; 
     tulevat = tulevat ;
     tulkaa = tulkaa ; 
     tullaan = tullaan ; 
     tuli = tuli ; 
     tulin = tulin ;
     tulisi = tulisi ;
     tullut = tullut ;
     tultu = tultu ;
     tullun = tullun
     } ; 

  regVerbH : Str -> VerbH = \soutaa -> 
  let
    taa = Predef.dp 3 soutaa ;
    ta  = init taa ;
    aa  = Predef.dp 2 taa ;
    juo = Predef.tk 2 soutaa ;
    souda = weakGrade (init soutaa) ;
    soudan = juo + "en" ;
    o  = Predef.dp 1 juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    joi = Predef.tk 2 juo + (o + "i")
  in case ta of {
    "it" => vHarkita soutaa ;
    "st" | "nn" | "rr" | "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
      _ => case aa of {
    "aa" | "‰‰" => vOttaa soutaa (souda + "n") ;
    "da" | "d‰" => vJuoda soutaa joi ;
    "ta" | "t‰" => vOsata soutaa ;
    _ => vHukkua soutaa souda
    }} ;

  reg2VerbH : (soutaa,souti : Str) -> VerbH = \soutaa,souti ->
  let
    soudat = regVerbH soutaa ;
    soudan = weakGrade (init soutaa) + "n" ;
    soudin = weakGrade souti + "n" ;
    souden = init souti + "en" ;
    juo = Predef.tk 2 soutaa ;
    o  = Predef.dp 1 juo ;
    u = ifTok Str (last soutaa) "a" "u" "y" ;
    aa  = Predef.dp 2 soutaa ;
    taa = Predef.dp 3 soutaa ;
    ta  = Predef.tk 1 taa ;
  in 
  case aa of {
    "aa" | "‰‰" => vHuoltaa soutaa soudan souti soudin ;
     _ => case ta of {
    "at" | "‰t" => vPalkata soutaa souti ;
    "st"        => vJuosta soutaa souden (juo +   o+u+"t") (juo + "t"+u) ;
    _ => soudat
    }} ** {sc = Nom ; lock_V = <>} ;

  reg3VerbH : (_,_,_ : Str) -> VerbH = \soutaa,soudan,souti -> 
  let
    taa   = Predef.dp 3 soutaa ;
    ta    = init taa ;
    aa    = Predef.dp 2 taa ;
    souda = init soudan ;
    juo = Predef.tk 2 soutaa ;
    o  = last juo ;
    a = last aa ;
    u = ifTok Str a "a" "u" "y" ;
    soudin = weakGrade souti + "n" ;
    soudat = reg2VerbH soutaa souti ;
  in case ta of {
    "ll" => vJuosta soutaa soudan (juo +   o+u+"t") (juo + "t"+u) ;
    "ot" | "ˆt" => vPudota soutaa souti ;
      _ => case aa of {
    "aa" | "‰‰" => vHuoltaa soutaa soudan souti soudin ;
    "da" | "d‰" => vJuoda soutaa souti ;
    _ => soudat
    }} ** {sc = Nom ; lock_V = <>} ;


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

  verbOlla : Verb = 
    mkVerb 
      "olla" "on" "olen" "ovat" "olkaa" "ollaan" 
      "oli" "olin" "olisi" "ollut" "oltu" "ollun" ;

-- The negating operator "ei" is actually a verb, which has present 
-- active indicative and imperative forms, but no infinitive.

  verbEi : Verb = 
    let ei = 
      mkVerb 
        "ei" "ei" "en" "eiv‰t" "‰lk‰‰" 
        "ei" "e" "en" "e" "ei" "ei" "ei"
    in
    {s = table {
      Imper Sg => "‰l‰" ;
--      Impf n p | Cond n p => ei.s ! Pres n p ;
      Impf n p => ei.s ! Pres n p ;
      Cond n p => ei.s ! Pres n p ;
      v => ei.s ! v
      }
    } ;

--2 Some structural words

  kuinConj = "kuin" ;

  conjEtta = "ett‰" ;
  advSiten = "siten" ;

  mikakukaInt : Gender => Number => Case => Str = 
    table {
      NonHuman => mikaInt ;
      Human => kukaInt
    } ;

  kaikkiPron : Number -> Case => Str = \n -> 
    let {kaiket = caseTable n (nhn (sKorpi "kaikki" "kaiken" "kaikkena"))} in
    table {
      Nom => "kaikki" ;
      c => kaiket ! c
      } ;

  stopPunct  = "." ;
  commaPunct = "," ;
  questPunct = "?" ;
  exclPunct  = "!" ;

  koPart = suff "ko" ;

-- For $NumeralsFin$.

  param NumPlace = NumIndep | NumAttr  ;

oper
  yksiN = nhn (mkSubst "‰" "yksi" "yhde" "yhte" "yht‰" "yhteen" "yksi" "yksi" 
                "yksien" "yksi‰" "yksiin") ;
  kymmenenN = nhn (mkSubst "‰" "kymmenen" "kymmene" "kymmene" "kymment‰" 
     "kymmeneen" "kymmeni" "kymmeni" "kymmenien" "kymmeni‰"
     "kymmeniin") ;
  sataN = nhn (sLukko "sata") ;

  tuhatN = nhn (mkSubst "a" "tuhat" "tuhanne" "tuhante" "tuhatta" "tuhanteen"
    "tuhansi" "tuhansi" "tuhansien" "tuhansia" "tuhansiin") ;

  kymmentaN = {s = table {
    NCase Sg Nom => "kymment‰" ;
    c => kymmenenN.s ! c
    }
  } ;

  sataaN = {s = table {
    Sg => sataN.s ;
    Pl => table {
      NCase Sg Nom => "sataa" ;
      c => sataN.s ! c
      }
    }
  } ;
  tuhattaN = {s = table {
    Sg => tuhatN.s ;
    Pl => table {
      NCase Sg Nom => "tuhatta" ;
      c => tuhatN.s ! c
      }
    }
  } ;
} ;
