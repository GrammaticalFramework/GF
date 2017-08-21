--1 A Simple Estonian Resource Morphology
--
-- Inari Listenmaa, Kaarel Kaljurand, based on Aarne Ranta's Finnish grammar
--
-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsEst$, which
-- gives a higher-level access to this module.

resource MorphoEst = ResEst ** open Prelude, Predef, HjkEst in {

  flags optimize=all ; coding=utf8;

  oper
    
----------------------
-- morph. paradigms --
----------------------

  --Noun paradigms in HjkEst

  --Comparative adjectives
  --(could just use hjk_type_IVb_audit "suurem" "a") 
  -- Comparative adjectives inflect in the same way
  -- TODO: confirm this
  dSuurempi : Str -> NForms = \suurem ->
    let
      suurema = suurem + "a" ;
    in nForms6
      suurem (suurema) (suurema + "t") (suurema + "sse")
      (suurema + "te") (suurema + "id") ;

  -- Superlatives follow the exact same pattern as comparatives
  -- TODO: confirm this
  dSuurin : Str -> NForms = \suurim -> dSuurempi suurim ;

  --Verb paradigms


  -- TS 49
  -- d in da, takse, dud ; imperfect 3sg ends in i
  cSaama : (_ : Str) -> VForms = \saama ->
    let
      saa = Predef.tk 2 saama ;
      sa = init saa ;
      sai = sa + "i" ;
    in vForms8
      saama
      (saa + "da")
      (saa + "b")
      (saa + "dakse") 
      (saa + "ge") -- Imper Pl
      sai
      (saa + "nud") 
      (saa + "dud") ;

  -- TS 49
  -- no d/t in da, takse ; imperfect 3sg ends in s
  cKaima : (_ : Str) -> VForms = \kaima ->
    let
      kai = Predef.tk 2 kaima ;      
    in vForms8
      kaima
      (kai + "a")
      (kai + "b")
      (kai + "akse")
      (kai + "ge")
      (kai + "s")
      (kai + "nud") 
      (kai + "dud") ;

  -- TS 49 
  -- vowel changes in da, takse, no d/t ; imperfect 3sg ends in i
  cJooma : (_ : Str) -> VForms = \jooma ->
    let
      j = Predef.tk 4 jooma ;
      joo = Predef.tk 2 jooma;
      o = last joo ;
      u = case o of {
        "o" => "u" ;
        "ö" => "ü" ;
         _  => o 
        } ;
      q = case o of {
        ("o"|"ö") => "õ" ;
         _        => o
        } ;
       juua = j + u + u + "a" ;
       j6i = j + q + "i" ;
    in vForms8
      jooma
      juua
      (joo + "b")
      (juua + "kse")
      (joo + "ge") 
      j6i
      (joo + "nud") 
      (joo + "dud") ;

  -- TS 50-52 (elama, muutuma, kirjutama), 53 (tegelema) alt forms
  -- t in takse, tud; no cons.grad
  cElama : (_ : Str) -> VForms = \elama ->
    let
      ela = Predef.tk 2 elama;
    in vForms8
      elama
      (ela + "da")
      (ela + "b")
      (ela + "takse") 
      (ela + "ge") -- Imperative P1 Pl
      (ela + "s")  -- Imperfect P3 Sg 
      (ela + "nud") 
      (ela + "tud") ;

  -- TS 53 (tegelema)
  -- d in takse, tud; g in ge; consonant stem in takse, tud, nud, ge; no cons.grad
  cTegelema : (_ : Str) -> VForms = \tegelema ->
    let
      tegele = Predef.tk 2 tegelema ;
      tegel = init tegele ;
    in vForms8
      tegelema
      (tegel + "da")
      (tegele + "b")
      (tegel + "dakse") 
      (tegel + "ge") -- Imperative P1 Pl
      (tegele + "s") -- Imperfect P3 Sg 
      (tegel + "nud") 
      (tegel + "dud") ; 	
      
  -- TS 54 (tulema)
  -- consonant assimilation (l,r,n) in da, takse
  -- d in tud, g in ge
  -- imperfect 3sg ends in i
  cTulema : (_ : Str) -> VForms = \tulema ->
    let
      tul = Predef.tk 3 tulema ;
      l = last tul ;
      tull = tul + l ;
    in
      vForms8
        tulema
        (tull + "a")
        (tul + "eb")
        (tull + "akse")
        (tul + "ge")
        (tul + "i")
        (tul + "nud")
        (tul + "dud") ;
  
  -- TS 55-56 (õppima, sündima)
  -- t in takse, tud ; consonant gradation on stem
  cLeppima : (_ : Str) -> VForms = \leppima ->
    let
      leppi = Predef.tk 2 leppima ;
      i = last leppi ;
      lepp = init leppi ;
      lepi = (weaker lepp) + i 
    in vForms8
      leppima
      (leppi + "da")
      (lepi + "b")
      (lepi + "takse")
      (leppi + "ge") -- Imperative P1 Pl
      (leppi + "s")  -- Imperfect P3 Sg
      (leppi + "nud")
      (lepi + "tud") ;
      
  -- TS 57 (lugema)
  -- Like 55-56 but irregular gradation patterns, that shouldn't be in HjkEst.weaker
  --including also marssima,valssima
  cLugema : (_ : Str) -> VForms = \lugema ->
    let
      luge = Predef.tk 2 lugema ;
      lug = init luge ;
      l = Predef.tk 3 luge ;
      e = last luge ;
      loe = case luge of {
        _ + ("aju"|"adu"|"agu") => l + "ao" ;
        _ + "adi"               => l + "ae" ;
            "haudu"             => "hau" ;
        _ + ("idu"|"igu")       => l + "eo" ;
        _ + "ida"               => l + "ea" ;
        _ + "udu"               => l + "oo" ;
        _ + ("uge"|"ude")       => l + "oe" ;

        _ + #c + "ssi"          => (init lug) + e;
        _ => (weaker lug) + e 
      } ;
    in vForms8
      lugema
      (luge + "da")
      (loe + "b")
      (loe + "takse")
      (luge + "ge") -- Imperative P1 Pl
      (luge + "s")  -- Imperfect P3 Sg
      (luge + "nud")
      (loe + "tud") ;
      
      
  -- TS 58 muutma, saatma,
  -- like laskma (TS 62, 64), but no reduplication of stem consonant (muutma~muuta, not *muutta)
  -- like andma (TS 63) but different takse (muudetakse vs. antakse)
  cMuutma : (_ : Str) -> VForms = \muutma ->
    let
      muut = Predef.tk 2 muutma ;
      muud = weaker muut ;
    in vForms8
      muutma
      (muut + "a")
      (muud + "ab")
      (muud + "etakse") -- always e?
      (muut + "ke")
      (muut + "is")
      (muut + "nud")
      (muud + "etud") ; -- always e?
  
  -- TS 59-60 (petma~petetakse, jätma~jäetakse) 
  -- takse given as second argument
    cPetma : (_,_ : Str) -> VForms = \petma,jaetakse ->
    let
      pet = Predef.tk 2 petma ;
      pett = stronger pet ;
      jaet = Predef.tk 4 jaetakse ;
      jaetud = jaet + "ud"
    in vForms8
      petma
      (pett + "a")
      (pet + "ab")
      jaetakse
      (pet + "ke")
      (pett + "is")
      (pet + "nud")
      jaetud ;

{-  -- TS 60 (jatma)
  -- weak stem in ma, strong in da ; irregular takse, tud
  cJatma : (_ : Str) -> VForms = \jatma ->
    let
      jat = Predef.tk 2 jatma ;
      jatt = stronger jat ;
      ko = (weaker (weaker jat))
      --weaker jät = jäd ; weaker (weaker jät) = jä
      --weaker küt = kö  ; weaker (weaker küt) = kö
      --HjkEst.weaker takes care of kütma->köetud
    in vForms8
      jatma
      (jatt + "a")
      (jat + "ab")
      (ko + "etakse") --always e?
      (jat + "ke")
      (jatt + "is")
      (jat + "nud")
      (ko + "etud") ;
-}      
      
  -- TS 61 (laulma)
  --vowel (a/e) given with the second argument
  --veenma,naerma
  cKuulma : (_,_ : Str) -> VForms = \kuulma,kuuleb ->
    let
      kuul = Predef.tk 2 kuulma ;
    in vForms8
      kuulma
      (kuul + "da")
      kuuleb
      (kuul + "dakse")
      (kuul + "ge")
      (kuul + "is")
      (kuul + "nud")
      (kuul + "dud") ;
      
  -- TS 62 (tõusma), 64 (mõksma)
  -- vowel (a/e) given with the second argument
  -- doesn't give alt. forms joosta, joostes
  cLaskma : (_,_ : Str) -> VForms = \laskma,laseb ->
    let
      lask = Predef.tk 2 laskma ;
      las = weaker lask ; --no effect on tõusma
    in vForms8
      laskma
      (las + "ta")
      laseb
      (las + "takse")
      (las + "ke")
      (lask + "is")
      (lask + "nud") 
      (las + "tud") ;
      
  -- TS 62 alt forms
  cJooksma : (_ : Str) -> VForms = \jooksma ->
    let
      jooks = Predef.tk 2 jooksma ;
      joos = (Predef.tk 2 jooks) + "s" ;
    in vForms8
      jooksma
      (joos + "ta")
      (jooks + "eb")
      (joos + "takse")
      (joos + "ke")
      (jooks + "is")
      (jooks + "nud") 
      (joos + "tud") ;

  -- TS 63 (andma, murdma, hoidma) 
  -- vowel given in second arg (andma~annab; tundma~tunneb)
  cAndma : (_,_ : Str) -> VForms = \andma,annab ->
    let
      and = Predef.tk 2 andma ; --murd(ma), hoid(ma)
      an = init and ;           --mur(d),   hoi(d)
      ann = weaker and ;        --murr,     hoi
      te = case (last ann) of { --to prevent teadma~teaab
         "a" => init ann ;
         _   => ann 
      } ;
    in vForms8
      andma
      (and + "a")
      annab 
      (an + "takse")
      (and + "ke")
      (and + "is")
      (and + "nud")
      (an + "tud") ;
      
  -- TS 65 (pesema)
  -- a consonant stem verb in disguise
  cPesema : (_ : Str) -> VForms = \pesema ->
    let
      pese = Predef.tk 2 pesema ;
      pes =  init pese ;
    in vForms8
      pesema
      (pes + "ta")
      (pese + "b")
      (pes + "takse")
      (pes + "ke")
      (pes + "i")
      (pes + "nud")
      (pes + "tud") ;

  -- TS 66 (nägema)
  -- näg, näh and näi stems
  cNagema : (_ : Str) -> VForms = \nagema ->
    let
      nage = Predef.tk 2 nagema ;
      nag =  init nage ;
      na = init nag ;
      nah = na + "h" ;
      nai = na + "i" ;
    in vForms8
      nagema
      (nah + "a")
      (na + "eb")
      (nah + "akse")
      (nah + "ke")
      (nag + "i")
      (nai + "nud")
      (nah + "tud") ;
  
  
  -- TS 67-68 (hüppama, tõmbama) 
  -- strong stem in ma, b, s
  -- weak stem in da, takse, ge, nud, tud
  -- t in da, takse; k in ge
  cHyppama : (_ : Str) -> VForms = \hyppama ->
    let
      hyppa = Predef.tk 2 hyppama ;
      hypp = init hyppa ;
      a = last hyppa ;
      hypa = (weaker hypp) + a
    in vForms8
      hyppama
      (hypa + "ta")
      (hyppa + "b")
      (hypa + "takse") -- Passive
      (hypa + "ke") -- Imperative P1 Pl
      (hyppa + "s") -- Imperfect Sg P3
      (hypa + "nud") -- PastPartAct
      (hypa + "tud") ; -- PastPartPass

  -- TS 69 (õmblema)
  cOmblema : (_ : Str) -> VForms = \omblema ->
    let
      omble = Predef.tk 2 omblema ;
      e = last omble ;
      l = last (init omble) ;
      omb = Predef.tk 2 omble ;
      omm = case omb of {
        "mõt" => "mõe" ; --some "double weak" patterns; however weaker (weaker omb) makes the coverage worse
         _    => weaker omb 
      } ;
      ommel = omm + e + l ;
    in vForms8
      omblema
      (ommel + "da")
      (omble + "b")
      (ommel + "dakse") -- Passive
      (ommel + "ge") -- Imperative P1 Pl
      (omble + "s") -- Imperfect Sg P3
      (ommel + "nud") -- PastPartAct
      (ommel + "dud") ; -- PastPartPass

  -- 2-arg paradigm to distinguish between 50-52 and 55-57
  cSattumaPettuma : (_,_ : Str) -> VForms = \pettuma,satub ->
    let
      pettu = Predef.tk 2 pettuma ;
      satu = init satub ;
    in vForms8
      pettuma
      (pettu + "da")
      (satu + "b")
      (satu + "takse") -- Passive
      (pettu + "ge") -- Imperative P1 Pl
      (pettu + "s") -- Imperfect Sg P3
      (pettu + "nud") -- PastPartAct
      (satu + "tud") ; -- PastPartPass



-----------------
-- auxiliaries --
-----------------


{- Noun internal opers moved to ResEst

These used to be here:
  NForms : Type = Predef.Ints 5 => Str ;
  Noun : Type   = {s: NForm => Str } ;
  nForms6  : (x1,_,_,_,_,x6 : Str) -> NForms ;
  n2nforms : Noun -> NForms ;
  nForms2N : NForms -> Noun ;

-}

-- Adjective forms

    AForms : Type = {
      posit  : NForms ;
      compar : NForms ;
      superl : NForms ;
      adv_posit, adv_compar, adv_superl : Str ;
      } ;

    aForms2A : AForms -> Adjective = \afs -> {
      s = table {
        Posit => table {
          AN n => (nForms2N afs.posit).s ! n ; 
          AAdv => afs.adv_posit
          } ;
        Compar => table {
          AN n => (nForms2N afs.compar).s ! n ; 
          AAdv => afs.adv_compar
          } ;
        Superl => table {
          AN n => (nForms2N afs.superl).s ! n ; 
          AAdv => afs.adv_superl
          }
        } ;
      lock_A = <>
      } ;

    nforms2aforms : NForms -> AForms = \nforms -> 
      let
        suure = init (nforms ! 1) ;
        suur = Predef.tk 4 (nforms ! 8) ;
      in {
        posit = nforms ;
        compar = dSuurempi (suure ++ "m") ;
        superl = dSuurin   (suur ++ "im") ;
        adv_posit = suure + "sti" ;
        adv_compar = suure + "mmin" ;
        adv_superl = suur + "immin" ;
      } ;

{-  Verb internal opers moved to ResEst

These used to be here:
  VForms : Type = Predef.Ints 7 => Str ;
  vForms8 : (x1,_,_,_,_,_,_,x8 : Str) -> VForms ; 
  regVForms : (x1,_,_,x4 : Str) -> VForms ;
  vforms2V : VForms -> Verb ;
-}


-----------------------
-- for Structural
-----------------------

caseTable : Number -> CommonNoun -> Case => Str = \n,cn -> 
  \\c => cn.s ! NCase n c ;

  mkDet : Number -> CommonNoun -> {
      s,sp : Case => Str ;       -- minun kolme
      n : Number ;             -- Pl   (agreement feature for verb)
      isNum : Bool ;           -- True (a numeral is present)
      isDef : Bool             -- True (verb agrees in Pl, Nom is not Part)
      } = \n, noun -> heavyDet {
    s = \\c => noun.s ! NCase n c ;
    n = n ;
    isNum = False ;
    isDef = True  --- does this hold for all new dets?
    } ;

-- Here we define personal and relative pronouns.

  -- input forms: Nom, Gen, Part
  -- Note that the Fin version required 5 input forms, the
  -- Est pronouns thus seem to be much simpler.
  -- TODO: remove NPAcc?
  -- I: keep NPAcc; see appCompl in ResEst, it takes care of finding a right case for various types of complements; incl. when pronouns get different treatment than nouns (PassVP).
  mkPronoun : (_,_,_ : Str) -> Number -> Person ->
    {s : NPForm => Str ; a : Agr} = 
    \mina, minu, mind, n, p ->
    let {
      minu_short = ie_to_i minu
    } in 
    {s = table {
      NPCase Nom    => mina ;
      NPCase Gen    => minu ;
      NPCase Part   => mind ;
      NPCase Transl => minu + "ks" ;
      NPCase Ess    => minu + "na" ;
      NPCase Iness  => minu_short + "s" ;
      NPCase Elat   => minu_short + "st" ;
      NPCase Illat  => minu_short + "sse" ;
      NPCase Adess  => minu_short + "l" ;
      NPCase Ablat  => minu_short + "lt" ;
      NPCase Allat  => minu_short + "le" ;
      NPCase Abess  => minu + "ta" ;
      NPCase Comit  => minu + "ga" ;
      NPCase Termin => minu + "ni" ;
      NPAcc         => mind
      } ;
     a = Ag n p
    } ; 

  -- meiesse/teiesse -> meisse/teisse
  ie_to_i : Str -> Str ;
  ie_to_i x =
	case x of {
		x1 + "ie" + x2 => x1 + "i" + x2 ;
		_ => x
	} ;

  shortPronoun : (_,_,_,_ : Str) -> Number -> Person -> 
    {s : NPForm => Str ; a : Agr} = 
      \ma, mu, mind, minu, n, p ->
    let shortMa = mkPronoun ma mu mind n p ;
        mulle : Str = case mu of {
           "mu" => "mulle" ; 
           "su" => "sulle" ;
           _     => shortMa.s ! NPCase Allat 
        } ;

     in shortMa ** { s = table {
         NPCase Allat => mulle ;
         NPCase Transl => minu + "ks" ;
         NPCase Ess    => minu + "na" ;
         NPCase Abess  => minu + "ta" ;
         NPCase Comit  => minu + "ga" ;
         NPCase Termin => minu + "ni" ;
         x          => shortMa.s ! x } } ;
   

  -- TODO: this does not seem to be called from anyway
  mkDemPronoun : (_,_,_,_,_ : Str) ->  Number -> 
    {s : NPForm => Str ; a : Agr} = 
    \tuo, tuon, tuota, tuona, tuohon, n ->
    let pro = mkPronoun tuo tuon tuota n P3
    in {
      s = table {
        NPAcc => tuo ;
        c => pro.s ! c
        } ;
      a = pro.a
      } ;

-- The relative pronoun, "joka", is inflected in case and number, 
-- like common nouns, but it does not take possessive suffixes.
-- The inflextion shows a surprising similarity with "suo".

oper
  -- TODO: fix: Nom => kelled
  -- TODO: mis
  relPron : Number => Case => Str =
    let kes = nForms2N (nForms6 "kes" "kelle" "keda" "kellesse" "kelle" "keda") in
    \\n,c => kes.s ! NCase n c ;

  ProperName = {s : Case => Str} ;

  -- TODO: generate using mkPronoun
  pronSe : ProperName  = {
    s = table {
      Nom    => "see" ;
      Gen    => "selle" ;
      Part   => "seda" ;
      Transl => "selleks" ;
      Ess    => "sellena" ;
      Iness  => "selles" ;
      Elat   => "sellest" ;
      Illat  => "sellesse" ;
      Adess  => "sellel" ;
      Ablat  => "sellelt" ;
      Allat  => "sellele" ;
      Abess  => "selleta" ;
      Comit  => "sellega" ;
      Termin => "selleni"
      } ;
    } ;

  -- TODO: generate using mkPronoun
  pronNe : ProperName  = {
    s = table {
      Nom    => "need" ;
      Gen    => "nende" ;
      Part   => "neid" ;
      Transl => "nendeks" ;
      Ess    => "nendena" ;
      Iness  => "nendes" ;
      Elat   => "nendest" ;
      Illat  => "nendesse" ;
      Adess  => "nendel" ;
      Ablat  => "nendelt" ;
      Allat  => "nendele" ;
      Abess  => "nendeta" ;
      Comit  => "nendega" ;
      Termin => "nendeni" 
      } ;
    } ;

}
