--1 A Simple Finnish Resource Morphology
--
-- Aarne Ranta 2002
--
-- This resource morphology contains definitions needed in the resource
-- syntax. It moreover contains the most usual inflectional patterns.
--
-- We use the parameter types and word classes defined in $Types.gf$.

resource Morpho = Types ** open (Predef = Predef), Prelude in {

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
    mkSubst (ifTok Str (Predef.dp 1 talona) "a" "a" "ä")
      talo (Predef.tk 1 talon) (Predef.tk 2 talona) taloa taloon
      (Predef.tk 2 taloina) (Predef.tk 3 taloissa) talojen taloja taloihin ;

-- Here some useful special cases; more will be given in $paradigms.Fin.gf$.
--         
-- Nouns with partitive "a"/"ä" ; 
-- to account for grade and vowel alternation, three forms are usually enough
-- Examples: "talo", "kukko", "huippu", "koira", "kukka", "syylä",...

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

-- The special case with no alternations: the vowel harmony is inferred from the
-- last letter - which must be one of "o", "u", "ö", "y".

  sTalo : Str -> CommonNoun = \talo ->
    let {a = getHarmony (Predef.dp 1 talo)} in
    sKukko talo (talo + "n") (talo + ("j" + a)) ;

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

-- Nouns of at least 3 syllables ending with "a" or "ä", like "peruna", "rytinä".

  sPeruna : Str -> CommonNoun = \peruna ->
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

-- The following covers nouns like "nauris" and adjectives like "kallis", "tyyris".

  sNauris : (_ : Str) -> CommonNoun = \naurista ->
    let {
      a        = Predef.dp 1 naurista ;
      nauris   = Predef.tk 2 naurista ;
      nauri    = Predef.tk 3 naurista ;
      naurii   = nauri + "i"
    } 
    in
    mkSubst a 
            nauris
            naurii
            naurii
            (nauris + ("t" + a)) 
            (naurii + "seen")
            naurii
            naurii
            (naurii + "den")
            (naurii + ("t" + a))
            (naurii + "siin") ;

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

getHarmony : Str -> Str = \u -> 
  ifTok Str u "a" "a" (
  ifTok Str u "o" "a" (
  ifTok Str u "u" "a" "ä")) ;


-- We could use an extension of the following for grade alternation, but we don't;
-- in general, *whether there is* grade alternation must be given in the lexicon
-- anyway (cf. "auto" - "auton", not "audon").

  weakGrade : Str -> Str = \kukko -> 
    let {
      ku = Predef.tk 3 kukko ;
      kk = Predef.tk 1 (Predef.dp 3 kukko) ;
      o  = Predef.dp 1 kukko ;
      ifkk = ifTok Str kk ;
      k =
        ifkk "kk" "k"  (
        ifkk "pp" "p"  (
        ifkk "tt" "t"  (
        ifkk "nt" "nn" (
        ifkk "mp" "mm" (
        ifkk "rt" "rr" (
        ifkk "lt" "ll" (
        kk)))))))
    } 
    in ku + k + o ;


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
      PAcc         => Predef.tk 1 minun + "t"
      } ;
     n = n ; p = p} ; 

  pronMina = mkPronoun "minä" "minun" "minua" "minuna" "minuun" Sg P1 ;
  pronSina = mkPronoun "sinä" "sinun" "sinua" "sinuna" "sinuun"  Sg P2 ;
  pronHan  = mkPronoun "hän" "hänen" "häntä"  "hänenä" "häneen" Sg P3 ;
  pronMe   = mkPronoun "me" "meidän" "meitä" "meinä" "meihin" Pl P1 ;
  pronTe   = mkPronoun "te" "teidän" "teitä" "teinä" "teihin"  Pl P2 ;
  pronHe   = mkPronoun "he" "heidän" "heitä" "heinä" "heihin"  Pl P3 ;
  pronNe   = mkPronoun "ne" "niiden" "niitä" "niinä" "niihin"  Pl P3 ;

-- The non-human pronoun "se" ('it') is even more irregular,
-- Its accusative cases do not
-- have a special form with "t", but have the normal genitive/nominative variation.
-- We use the type $ProperName$ for "se", because of the accusative but also
-- because the person and number are as for proper names.

  pronSe : ProperName  = {
    s = table {
      Nom    => "se" ;
      Gen    => "sen" ;
      Part   => "sitä" ;
      Transl => "siksi" ;
      Ess    => "sinä" ;
      Iness  => "siinä" ;
      Elat   => "siitä" ;
      Illat  => "siihen" ;
      Adess  => "sillä" ;
      Ablat  => "siltä" ;
      Allat  => "sille"
      } ;
    } ;

-- The possessive suffixes will be needed in syntax. It will show up
-- as a separate word ("auto &ni"), which needs unlexing. Unlexing also
-- has to fix the vowel harmony in cases like "äiti &nsä".

  suff : Str -> Str = \ni -> "&" + ni ;

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
        Nom => "mikä" ;
        Gen => "minkä" ;
        c   => mi.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "mitkä" ;
        Gen => "mittenkä" ;
        c   => mi.s ! NCase Sg c
        }
      } ;

  kukaInt : Number => Case => Str = 
    let {
      ku = sRae "kuka" "kenenä" ;
      ket = sRae "kuka" "keinä"} in
    table {
      Sg => table {
        Nom => "kuka" ;
        Part => "ketä" ;
        Illat => "keneen" ;
        c   => ku.s ! NCase Sg c
       } ; 
      Pl => table {
        Nom => "ketkä" ;
        Illat => "keihin" ;
        c   => ket.s ! NCase Pl c
        }
      } ;

caseTable : Number -> CommonNoun -> Case => Str = \n,cn -> 
  \\c => cn.s ! NCase n c ;


--2 Adjectives
--
-- For the comparison of adjectives, three noun declensions 
-- are needed in the worst case.

  mkAdjDegr : (_,_,_ : CommonNoun) -> AdjDegr = \hyva,parempi,paras -> 
    {s = table {
      Pos  => hyva.s ;
      Comp => parempi.s ;
      Sup  => paras.s
      }
    } ;

-- However, it is usually enough to give the positive declension and
-- the characteristic forms of comparative and superlative. 

  regAdjDegr : CommonNoun -> Str -> Str -> AdjDegr = \kiva, kivempaa, kivinta ->
    mkAdjDegr kiva (sSuurempi kivempaa) (sSuurin kivinta) ;


--3 Verbs
--

  mkVerb : (_,_,_,_,_ : Str) -> Verb = \tulla,tulen,tulee,tulevat,tulkaa -> 
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
      ImpNegPl  => Predef.tk 2 tulkaa + (ifTok Str a "a" "o" "ö") 
      }
    } ;

-- For "sanoa", "valua", "kysyä".

  vSanoa : Str -> Verb = \sanoa -> 
    let {
      a    = Predef.dp 1 sanoa ;
      sano = Predef.tk 1 sanoa ;
      o    = Predef.dp 1 sano
    } in
    mkVerb
      sanoa
      (sano + "n")
      (sano + o)
      (sano + (("v" + a) + "t"))
      (sano + (("k" + a) + a)) ;

-- For "ottaa", "käyttää", "löytää", "huoltaa", "hiihtää", "siirtää".

  vOttaa : (_,_ : Str) -> Verb = \ottaa,otan -> 
    let {
      a    = Predef.dp 1 ottaa ;
      ota  = Predef.tk 1 otan ;
      otta = Predef.tk 1 ottaa
    } in
    mkVerb
      ottaa
      (ota + "n")
      ottaa
      (otta + (("v" + a) + "t"))
      (otta + (("k" + a) + a)) ;

-- For "poistaa", "ryystää".

  vPoistaa : Str -> Verb = \poistaa -> 
    vOttaa poistaa (Predef.tk 1 poistaa + "n") ;

-- For "juosta", "piestä", "nousta", "rangaista", "kävellä", "surra", "panna".

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
      (juos + (("k" + a) + a)) ;

-- For "juoda", "syödä".

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
      (juo + (("k" + a) + a)) ;


  verbOlla : Verb = mkVerb "olla" "olen" "on" "ovat" "olkaa" ;

-- The negating operator "ei" is actually a verb, which has has present 
-- indicative and imperative forms, but no infinitive.

  verbEi : Verb = 
    let {ei = mkVerb nonExist "en" "ei" "eivät" "älkää"} in
    {s = table {
      Ind Pl P3 => "eivät" ;
      v => ei.s ! v
      }
    } ;


--2 Some structural words

  kuinConj = "kuin" ;

  conjEtta = "että" ;
  advSiten = "siten" ;

  mikakukaInt : Gender => Number => Case => Str = 
    table {
      NonHuman => mikaInt ;
      Human => kukaInt
    } ;

  kaikkiPron : Case => Str = 
    let {kaiket = caseTable Pl (sKukko "kaikki" "kaiken" "kaikkia")} in
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