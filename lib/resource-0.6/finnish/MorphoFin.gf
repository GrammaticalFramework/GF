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

--2 Nouns
--

oper

-- worst-case macro

  mkSubst : Str -> (_,_,_,_,_,_,_,_,_,_ : Str) -> CommonNoun = 
    \a,vesi,vede,vete,vetta,veteen,vetii,vesii,vesien,vesia,vesiin -> 
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
    mkSubst (ifTok Str (Predef.dp 1 talona) "a" "a" "‰")
      talo (Predef.tk 1 talon) (Predef.tk 2 talona) taloa taloon
      (Predef.tk 2 taloina) (Predef.tk 3 taloissa) talojen taloja taloihin ;

-- Here some useful special cases; more will be given in $paradigms.Fin.gf$.
--         
-- Nouns with partitive "a"/"‰" ; 
-- to account for grade and vowel alternation, three forms are usually enough
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syyl‰",...

  sKukko : (_,_,_ : Str) -> CommonNoun = \kukko,kukon,kukkoja ->
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

  sLukko : Str -> CommonNoun = \lukko -> 
   let a = getHarmony (last lukko) 
   in
   sKukko lukko (weakGrade lukko + "n") (lukko + "j" + a) ;

-- The special case with no alternations: the vowel harmony is inferred from the
-- last letter - which must be one of "o", "u", "ˆ", "y".

  sTalo : Str -> CommonNoun = \talo ->
    let {a = getHarmony (Predef.dp 1 talo)} in
    sKukko talo (talo + "n") (talo + ("j" + a)) ;

  sBaari : Str -> CommonNoun = \baaria ->
    let
      baari = Predef.tk 1 baaria ; 
      baar = Predef.tk 1 baari ; 
      a = getHarmony (Predef.dp 1 baaria) 
    in
      sKukko baari (baari + "n") (baar + ("ej" + a)) ;

  sKorpi : (_,_,_ : Str) -> CommonNoun = \korpi,korven,korpena ->
    let {
      a      = Predef.dp 1 korpena ;
      korpe  = Predef.tk 2 korpena ;
      korve  = Predef.tk 1 korven ;
      korvi  = Predef.tk 1 korve + "i"
    } 
    in
    mkSubst a 
            korpi
            korve
            korpe
            (korpe + a) 
            (korpe + "en")
            korpi
            korvi
            (korpi + "en") 
            (korpi + a)
            (korpi + "in") ;

  sArpi : Str -> CommonNoun = \arpi -> 
    sKorpi arpi (init (weakGrade arpi) + "en") (init arpi + "ena") ;
  sSylki : Str -> CommonNoun = \sylki -> 
    sKorpi sylki (init (weakGrade sylki) + "en") (init sylki + "en‰") ;

--- This is not quite right.

  sKoira : Str -> CommonNoun = \koira ->
    let a = getHarmony (last koira) in
    sKorpi koira (koira + "n") (koira + "n" + a) ;

-- Loan words ending in consonants are actually similar to words like
-- "malli"/"mallin"/"malleja", with the exception that the "i" is not attached
-- to the singular nominative.

  sLinux : Str -> CommonNoun = \linuxia ->
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
            (linux + "eja")
            (linux + "eihin") ;

-- Nouns of at least 3 syllables ending with "a" or "‰", like "peruna", "rytin‰".

  sPeruna : Str -> CommonNoun = \peruna ->
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

-- Surpraisingly, making the test for the partitive, this not only covers
-- "rae", "perhe", "savuke", but also "rengas", "lyhyt" (except $Sg Illat$), etc.

  sRae : (_,_ : Str) -> CommonNoun = \rae,rakeena ->
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

  sSusi : (_,_,_ : Str) -> CommonNoun = \susi,suden,sutena ->
    let {
      a      = Predef.dp 1 sutena ;
      sude   = Predef.tk 1 suden ;
      sute   = Predef.tk 2 sutena
    } 
    in
    mkSubst a 
            susi
            sude 
            sute
            (Predef.tk 1 sute + ("t" + a)) 
            (sute + "en")
            susi
            susi
            (susi + "en") 
            (susi + a)
            (susi + "in") ;

  sPuu : Str -> CommonNoun = \puu ->
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

  sSuo : Str -> CommonNoun = \suo ->
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

  sNainen : Str -> CommonNoun = \naista ->
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

  sTilaus : (_,_ : Str) -> CommonNoun = \tilaus, tilauksena ->
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

  sRakkaus : Str -> CommonNoun = \rakkaus ->
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

  sNauris : (_ : Str) -> CommonNoun = \naurista ->
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

-- The following two are used for adjective comparison.

  sSuurempi : Str -> CommonNoun = \suurempaa ->
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

  sSuurin : Str -> CommonNoun = \suurinta ->
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


-- The following function defines how grade alternation works if it is active.
-- In general, *whether there is* grade alternation must be given in the lexicon
-- (cf. "auto" - "auton", not "audon").

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
           "i" => "j" ;
           _   => ""
           } ;
        "rk" => kul + case o of {
           "i" => "j" ;
           _   => ""
           } ;
        "hk" => kukk ;  -- *tahko-tahon
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


--3 Proper names
--
-- Proper names are similar to common nouns in the singular.

  mkProperName : CommonNoun -> ProperName = \jussi -> 
    {s = \\c => jussi.s ! NCase Sg c} ;

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

  suff : Str -> Str = \ni -> BIND ++ ni ;

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
    let {jo = sSuo "jo"} in {s = 
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
      mi  = sSuo "mi"
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
      ku = sRae "kuka" "kenen‰" ;
      ket = sRae "kuka" "kein‰"} in
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
      ku = sPuu "ku" ;
      kui = sPuu "kuu" 
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

moniPron : Case => Str = caseTable singular (sSusi "moni" "monen" "monena") ;

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
      (noun2adjComp False (sSuurempi kivempaa)) 
      (noun2adjComp False (sSuurin kivinta)) ;


--3 Verbs
--

  mkVerb : (_,_,_,_,_,_ : Str) -> Verb = 
    \tulla,tulen,tulee,tulevat,tulkaa,tullaan -> 
    let {
      tule = Predef.tk 1 tulen ;
      a = Predef.dp 1 tulkaa
    } in
    {s = table {
      Inf => tulla ;
      Ind Sg P1 => tulen ;
      Ind Sg P2 => tule + "t" ;
      Ind Sg P3 => tulee ;
      Ind Pl P1 => tule + "mme" ;
      Ind Pl P2 => tule + "tte" ;
      Ind Pl P3 => tulevat ;
      Imper Sg  => tule ;
      Imper Pl  => tulkaa ;
      ImpNegPl  => Predef.tk 2 tulkaa + (ifTok Str a "a" "o" "ˆ") ;
      Pass True => tullaan ;
      Pass False => Predef.tk 2 tullaan
      }
    } ;

-- For "harppoa", "hukkua", "lˆyty‰", with grade alternation.

  vHukkua : (_,_ : Str) -> Verb = \hukkua,huku -> 
    let {
      a     = Predef.dp 1 hukkua ;
      hukku = Predef.tk 1 hukkua ;
      u     = Predef.dp 1 huku 
    } in
    mkVerb
      hukkua
      (huku + "n")
      (hukku + u)
      (hukku + (("v" + a) + "t"))
      (hukku + (("k" + a) + a))
      (huku + ((("t" + a) + a) + "n")) ;

-- For cases without alternation: "sanoa", "valua", "kysy‰".

  vSanoa : Str -> Verb = \sanoa ->
    vHukkua sanoa (Predef.tk 1 sanoa) ;

-- For "ottaa", "k‰ytt‰‰", "lˆyt‰‰", "huoltaa", "hiiht‰‰", "siirt‰‰".

  vOttaa : (_,_ : Str) -> Verb = \ottaa,otan -> 
    let {
      a    = Predef.dp 1 ottaa ;
      ota  = Predef.tk 1 otan ;
      otta = Predef.tk 1 ottaa ;
      ote  = Predef.tk 1 ota + "e"
    } in
    mkVerb
      ottaa
      (ota + "n")
      ottaa
      (otta + (("v" + a) + "t"))
      (otta + (("k" + a) + a)) 
      (ote  + ((("t" + a) + a) + "n")) ;

-- For "poistaa", "ryyst‰‰".

  vPoistaa : Str -> Verb = \poistaa -> 
    vOttaa poistaa (Predef.tk 1 poistaa + "n") ;

-- For "osata", "lis‰t‰"

  vOsata : Str -> Verb = \osata -> 
    let {
      a   = Predef.dp 1 osata ;
      osa = Predef.tk 2 osata
    } in
    mkVerb
      osata
      (osa + (a + "n"))
      (osa + a)
      (osa + ((("a" + "v") + a) + "t"))
      (osa + ((("t" + "k") + a) + a)) 
      (osata + (a + "n")) ;

-- For "juosta", "piest‰", "nousta", "rangaista", "k‰vell‰", "surra", "panna".

  vJuosta : (_,_ : Str) -> Verb = \juosta,juoksen -> 
    let {
      a      = Predef.dp 1 juosta ;
      juokse = Predef.tk 1 juoksen ;
      juos   = Predef.tk 2 juosta
    } in
    mkVerb
      juosta
      juoksen
      (juokse + "e")
      (juokse + (("v" + a) + "t"))
      (juos + (("k" + a) + a)) 
      (juosta + (a + "n")) ;

-- For "juoda", "syˆd‰".

  vJuoda : Str -> Verb = \juoda -> 
    let {
      a   = Predef.dp 1 juoda ;
      juo = Predef.tk 2 juoda
    } in
    mkVerb
      juoda
      (juo + "n")
      juo
      (juo + (("v" + a) + "t"))
      (juo + (("k" + a) + a)) 
      (juoda + (a + "n")) ;


  verbOlla : Verb = mkVerb "olla" "olen" "on" "ovat" "olkaa" "ollaan" ;

-- The negating operator "ei" is actually a verb, which has present 
-- active indicative and imperative forms, but no infinitive.

  verbEi : Verb = 
    let {ei = mkVerb nonExist "en" "ei" "eiv‰t" "‰lk‰‰" "ei"} in
    {s = table {
      Ind Pl P3 => "eiv‰t" ;
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
    let {kaiket = caseTable n (sKorpi "kaikki" "kaiken" "kaikkena")} in
    table {
      Nom => "kaikki" ;
      c => kaiket ! c
      } ;

  stopPunct  = "." ;
  commaPunct = "," ;
  questPunct = "?" ;
  exclPunct  = "!" ;

  koPart = suff "ko" ;

} ;
