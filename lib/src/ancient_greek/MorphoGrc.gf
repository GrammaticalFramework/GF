--# -path=.:../prelude:../common
--
--1 A Simple Greek Resource Morphology
--
-- Based on E.Bornemann/E.Risch: Griechische Grammatik, 2.Auflage 1978 (2008)
-- (referred to as BR <Paragraph>) www.diesterweg.de, ISBN 978-3-425-06850-3  

-- Author: Hans Leiss, LMU Munich, CIS                     Aug.2012, Dec.2015

-- This resource morphology contains definitions needed in the resource
-- syntax. To build a lexicon, it is better to use $ParadigmsGrc$, which
-- gives a higher-level access to this module.

resource MorphoGrc = ResGrc ** open Prelude, (P=Predef), (Ph=PhonoGrc) in {

  flags optimize=noexpand ; -- 

--2 Phonology 
-- 
--  See PhonGrc.gf
--
-- For $ParadigmsGer$.
--
--2 Nouns
--
--  See ResGrc.gf. (Default case should be in ResGrc, the others be moved here.)
--
--3 Proper names
--
--  See ResGrc.gf. (Default case should be in ResGrc, the others be moved here.)

--2 Determiners
oper
--  Determiner : Type = {s : Gender => Case => Str ; n : Number} ;

  mkDeterminer : Number -> (Case => Str) -> (Case => Str) -> (Case => Str) -> Determiner = 
     \n,mc,fc,nc -> {s = table{ Masc => mc ; Fem => fc ; Neutr => nc } ; n = n} ;
  mkDeterminer2 : Number -> (Case => Str) -> (Case => Str) -> Determiner = 
     \n,mc,nc -> {s = table{ Masc|Fem => mc ; Neutr => nc } ; n = n} ;

-- Used in StructuralGrc:
-- cc mkDeterminer2 Sg (cases "tis" "tina'" "tino's*" "tini'") (cases "ti" "ti" "tino's*" "tini'")

  detLikeAdj = overload {   
   detLikeAdj : Number -> Str -> Determiner        = detLikeAdj1 ;
   detLikeAdj : Number -> Str -> Str -> Determiner = detLikeAdj2 ;
  } ;

   detLikeAdj2 : Number -> Str -> Str -> Determiner = \n,pas,pantos -> 
     let adj:Adj = adj3 pas pantos 
     in {s = \\g,c => adj.s ! AF g n c ; n = n } ;
   
   detLikeAdj1 : Number -> Str -> Determiner = \n,oligos -> 
     let adj:Adj = adjAO oligos
     in {s = \\g,c => adj.s ! AF g n c ; n = n } ;

--2 Pronouns

-- Personal pronouns have different forms, depending on whether they are
-- emphasized or not, e.g. "e)moy~" vs. "moy". Possessive pronouns are 
-- used like adjectives, not like determiners. 

-- A Pron here combines personal and possessive forms. 

  Pron : Type = {
    s : PronForm => Str ;  
    a : Agr 
    } ;

  mkPron : Gender -> Number -> Person -> Pron = \g,n,p ->
    let pers = mkPersPron g n p ;
        poss = mkPossPron g n p
     in { s = table { NPCase t c     => pers ! t ! c ;
                      NPPoss g' n' c => poss.s ! AF g' n' c } ;
          a = Ag g n p 
     } ;

  mkPersPron : Gender -> Number -> Person -> (Tonicity => Case => Str) = \g,n,p -> 
    case <g,n,p> of {
      <_,Sg,P1> => table{Ton  => cases "e)gw'" "e)me'" "e)moy~" "e)moi'" ;
                         Aton => cases "" "me" "moy" "moi"};
      <_,Sg,P2> => table{Ton  => cases "sy'"  "se'" "soy~" "soi'" ;
                         Aton => cases "" "se" "soy" "soi"} ;
      <_,Pl,P1> => table{Ton =>  cases "h(mei~s*" "h(ma~s*" "h(mw~n" "h(mi~n" ;
                         Aton => cases "" "" "h(mw~n" "h(~min"} ;
      <_,Pl,P2> => table{Ton =>  cases "y(mei~s*" "y(ma~s*" "y(mw~n" "y(mi~n" ; 
                         Aton => cases "" "" "y(mw~n" "y(mi~n"} ;
      <_,Dl,P1> => table{Ton =>  cases "nw'" "nw'" "nw|~n" "nw|~n" ;     -- BR 74.3
                         Aton => cases "" "" "nw|~n" "nw|~n"} ;
      <_,Dl,P2> => table{Ton =>  cases "sfw'" "sfw'" "sfw|~n" "sfw|~n" ; -- BR 74.3
                         Aton => cases "" "" "" ""} ;
      <Masc, Sg,P3> => table{Ton => cases "oy(~tos*" "toy~ton" "toy'toy" "toy'tw|" ;
                            Aton => cases "" "ay)to'n" "ay)toy~" "ay)tw|" } ; 
      <Fem,  Sg,P3> => table{Ton => cases "ay)'th" "tay'thn" "tay'ths*" "tay'th|" ;
                            Aton => cases "" "ay)th'n" "ay)th~s*" "ay)th|" } ; 

      <Neutr,Sg,P3> => table{Ton => cases "toy~to" "toy~to" "toy'toy" "toy'tw|" ;
                            Aton => cases "" "ay)to'" "ay)toy~" "ay)tw|" } ; 
      <Masc, Pl,P3> => table{Ton => cases "oy(~toi" "toy'toys*" "toy'twn" "toy'tois*" ;
                            Aton => cases "" "ay)toy's*" "ay)tw~n" "ay)toi~s*" } ; 
      <Fem,  Pl,P3> => table{Ton => cases "ay(~tai" "tay'tas*" "toy'wn" "tay'tais*" ;
                            Aton => cases "" "ay)ta's*" "ay)tw~n" "ay)tai~s*" } ; 
      <Neutr,Pl,P3> => table{Ton => cases "tay~ta" "tay~ta"  "toy'twn" "toy'tois*" ;
                            Aton => cases "" "ay)ta'" "ay)tw~n" "ay)toi~s" } ; 
      <_,Dl,P3> => table{Ton => cases "" "" "" "" ;  -- TODO (not in BR)
                        Aton => cases "" "" "" "" }  -- TODO (not in BR)
    } ;

  -- emphasized, non-reflexive possessive pronoun BR 67
  mkPossPron : Gender -> Number -> Person -> { s : AForm => Str } = \g,n,p -> 
     case <p,n> of { <P1,Sg> => (adjAO "e)mo's") ;
                     <P2,Sg> => (adjAO "so's") ;
                     <P1,Pl> => (adj2AO "h(me'teros" "h(mete'ra_s") ;
                     <P2,Pl> => (adj2AO "y(me'teros" "y(mete'ra_s") ;
                     <P3,Sg|Pl> => {s = \\_ => houtos_Quantifier.s!n!g!Gen } ; -- BR 67 2, or: "ekei~noy|hs" 
                     -- <P3,Pl> => (adj2AO "sfe'teros" "sfete'ra_s") ;          -- reflexive
                     -- else undefined ; 
                     _ => { s = \\_ => "---" } } ; -- dual 
  -- TODO: add reflexive forms (i.e. he sees his own child) vs. his=John's  ReflPron.Gen
  --       ATon: use postponed persPron.Gen: o filos moy

  -- Other forms of pronouns have different types:

  reflPron : Agr => Case => Str =  -- BR 66
     let dAsp : Str -> Str = 
                \str -> case str of { "ay)" + r => "ay" + r ; _ => str } 
      in table { 
           Ag g Sg P1 => \\c => "e)m"+ dAsp(autos.s ! g ! Sg ! c) ;
           Ag g Sg P2 => \\c => "se" + dAsp(autos.s ! g ! Sg ! c) ;
           Ag g Sg P3 => \\c => "e(" + dAsp(autos.s ! g ! Sg ! c) ;
           Ag g Pl P3 => \\c => "e(" + dAsp(autos.s ! g ! Pl ! c) ;
           Ag g n p   => \\c => (mkPersPron g n p) ! Ton ! c
                                          ++ autos.s ! g ! Pl ! c 
      } ;

  reciPron : Gender => Case => Str =  -- BR 65  (cf. ExtraGrc.gf)
     table { Masc => table { Acc => "a)llh'loys*" ;
                             Gen => "a)llh'lwn" ;
                             Dat => "a)llh'lois*" ;
                             _   => [] } ;
             Fem  => table { Acc => "a)llh'la_s*" ;
                             Gen => "a)llh'lwn" ;
                             Dat => "a)llh'lais*" ;
                             _   => [] } ;
            Neutr => table { Acc => "a)llh'la" ;
                             Gen => "a)llh'lwn" ;
                             Dat => "a)llh'lois*" ;
                             _   => [] } 
     } ;

-- Interrogative and indefinite pronouns:

  iPron : Number => Gender => Case => Str =  -- BR 70
     table { Sg => table { Masc | Fem => cases "ti's*" "ti'na" "ti'nos*" "ti'ni" ;
                           Neutr      => cases "ti'"   "ti'"   "ti'nos*" "ti'ni" } ;
             Pl | Dl => -- do dual forms exist?
                   table { Masc | Fem => cases "ti'nes*" "ti'nas*" "ti'nwn" "ti'si" ; -- ti'sin
                           Neutr      => cases "ti'na*"  "ti'na"   "ti'nwn" "ti'si" } -- tisi'n
           } ;

  indefPron : Number => Gender => Case => Str =  -- BR 70
     table { Sg => table { Masc | Fem => cases "tis*" "tina'" "tino's*" "tini'" ;
                           Neutr      => cases "ti"   "ti"    "tino's*" "tini'" } ;
             Pl | Dl => -- do dual forms exist?
                   table { Masc | Fem => cases "tine's*" "tina's*" "tinw~n" "tisi'" ; -- tisi'n
                           Neutr      => cases "tina*"  "tina"   "tinwn" "tisi" } -- tisi'n
           } ;

  iPronNP : Gender -> Number -> { s : Case => Str ; 
                                  a : Agr ; isPron : Prelude.Bool } =
     \g,n -> { s = iPron ! n ! g ; a = Ag g n P3 ; isPron = True } ;

  indefPronNP : Gender -> Number -> { s : Case => Str ; 
                                      a : Agr ; isPron : Prelude.Bool ; e : Case => Str } =
     \g,n -> { s = indefPron ! n ! g ; 
               a = Ag g n P3 ; 
               isPron = True ; 
               e = indefPron ! n ! g } ;     -- emphasized form?

-- Moved to RelativeGrc: relPronSg, relPronPl : Gender => Case => Str 

  mkIP : Number -> Gender -> { s : Case => Str ; n : Number } =
     \n,g -> { s = iPron ! n ! g ; n = n } ;  -- g : gender?
  -- ti's, ti' can be used attributetively, too, so g should not be inherent 

-- Demonstrative pronouns: BR 68 1. o'de, 2. oy~tos, 3. ekei~nos  see ExtraGrc.gf

--2 Adjectives
--
--  There are `two-ending' adjectives, where masculine and feminine forms are the same, 
--  and `three-ending' ones, with separate endings for masculine, feminine and neuter.
--  
--  Adj = {s : AForm => Str} ;
--
--  Adjectives inflect according to gender, number and case, and follow largely the
--  noun declension classes, i.e. are like the combination of a masculine, a feminine
--  and a neuter noun (of the same declension).
--  
--  However, there are separate accentuation rules (like BR 45.3, that the accent 
--  in adjectives whose stem ends in -n is as far to the left as consistent with 
--  the general accent rules).
--
--  See the beginning in ResGrc
-- 
--2 Verbs
--
--   Depending on a vowel insertion between stem and endings, one distinguishes
--     thematic conjugation = w-conjugation (paideyw) = mkVerbW     from
--    athematic conjugation = mi-conjugation (didwmi) = mkVerbMi
--
--   The forms of a greek verb are derived from 7 aspect/tempus-stems:   BR 80 2 
--  
--     asp/tempus-stem      w-          mi-       conjucation form:
--   act|med|pass Pres : paideyw      didwmi   VAct (VPres VInd) Sg P1
--        act|med Fut  : paideysw     dwsw     VAct (VFut FInd)  Sg P1
--        act|med Aor  : epaideysa    edwka    VAct (VAor VInd)  Sg P1
--            act Perf : pepaideyka   dedwka   VAct (VPerf VInd) Sg P1
--       med|pass Perf : pepaideymai  dedomai  VMed (VPerf VInd) Sg P1
--           pass Aor  : epaideyvhn   edothn   VPass (VAor VInd) Sg P1
--                VAdj : paideytos    dotos    VAdj Masc Sg Nom 
--   The verbal adjective VAdj may be missing.

--   The aspect/tempus stems are usually derived from a common verb stem by
--   ablaut, initial reduplication, or suffixes. 
  
--   *Weak* stems resp. tempora are those where the tempus stem is obtained by adding
--   a specific consonant, *strong* stems/tempora those without such a consonant.
--   Conjugation classes depend on how the following tempus stems are formed:
--     weak(I)/strong(II) act|med Aor,
--     weak(I)/strong(II) pass Aor,
--     weak(I)/strong(II) act Perf.

param
   tempType = weak | strong ;
   
-- Show the row of guessed verb stems (use a tuple with fields ordered as in verbstems; 
-- a record with field names would be reordered lexicographically)
-- Memo: gf > cc -list verbstems

oper
  verbstems = <"PresAct", "FutAct", "AorAct", "PerfAct", "PerfMedPass", "AorPass", "VAdj"> ;

  guessVerbstems : Str -> Str * Str * Str * Str * Str * Str * Str = \verb ->    
       case verb of { _ + "w"  => guessVerbstemsW verb ;
                      _ + "mi" => guessVerbstemsMi verb ; 
                      _        => P.error "Use -w or -mi" };

  -- tempusstems: BR 80 2 (weak: by adding tempus marker)
  -- act|med|pass Pres : paideyw      VAct (VPres VInd) Sg P1  
  --      act|med Fut  : paideysw     VAct (VFut FInd)  Sg P1
  --      act|med Aor  : epaideysa    VAct (VAor VInd)  Sg P1
  --          act Perf : pepaideyka   VAct (VPerf VInd) Sg P1
  --     med|pass Perf : pepaideymai  VMed (VPerf VInd) Sg P1
  --         pass Aor  : epaideyvhn   VPass (VAor VInd) Sg P1
  --              VAdj : paideytos    VAdj Masc Sg Nom 
                                      -- verbal adjective (may be missing)

-- Easier handling of accents:

  a3 : Str -> Str = \str -> addAccent (Acute 3) str ;
  a2 : Str -> Str = \str -> addAccent (Acute 2) str ;
  dA : Str -> Str = \str -> dropAccent str ;

  menos : Number -> Str = \n -> (case n of { Sg => "me'nos*" ;
                                              _ => "me'noi" }) ;

--3 W-conjugation: --------------------------------------------------------

-- BR distinguish 7 classes of present stems (see below), the first two of 
-- which are subdivided into 
--
--  (a) verba vocalia, i.e. verbal stem ends in a vowel
--      expl: paideyw_V, timaw_V, poiew_V, doylow_V 
--  (b) verba muta, i.e. verbal stem ends in muta consonant (p,b,f | t,d,v | k,g,c)
--      expl: leipw_V
--  (c) verba liquida, i.e. verbal stem ends in liq.consonant (l,r) or nasal (m,n,(n)g) 
--      expl: derw_V

  mkVerbW1 : Str -> Verb = \paidey'w ->     
     case paidey'w of {
       x + (#Ph.diphthong | #Ph.vowel) + (""| #Ph.accent) + "w" => mkVerbW1voc paidey'w ;
       x + (("p"|"k"|"t")
           |("f"|"c"|"v")|("b"|"g"|"d")|"z")     + "w" => mkVerbW1mut paidey'w ;
       x + (#Ph.vowel) + (""| #Ph.accent) + 
                          ("r"|"l"|"m"|"n"|"mn") + "w" => mkVerbW1liq paidey'w ; -- BR 103.1
       x + "ll"                                  + "w" => mkVerbW1liq paidey'w ; -- BR 103.2a
       x + (("ai'"|"ei'"|"i_"|"y_")+("n"|"r"))   + "w" => mkVerbW1liq paidey'w ; -- BR 103.2b
       _                                               => mkVerbW1voc paidey'w -- default
     } ;

  mkVerbW7 : (ActPresIndSgP1, ActFutSgP1, ActAorSgP1, ActPerfSgP1,
              MedPerfSgP1, PassAorSgP1, VAdj1 : Str) -> Verb = 
             \paidey'w, paidey'sw, epai'deysa, pepai'deyka, 
              pepai'deymai, epaidey'vhn, paideyto's ->
    case paidey'w of { _ + (#Ph.vowel|#Ph.diphthong) + (#Ph.accent|"") + "w" 
                         => mkVerbW7voc paidey'w paidey'sw epai'deysa pepai'deyka pepai'deymai epaidey'vhn paideyto's ;
                       _ + (#Ph.labial|#Ph.guttural|#Ph.dental|"z") + "w" 
                         => mkVerbW7mut paidey'w paidey'sw epai'deysa pepai'deyka pepai'deymai epaidey'vhn paideyto's ;
                       _ + (#Ph.liquid|#Ph.nasal) + "w" 
                         => mkVerbW7liq paidey'w paidey'sw epai'deysa pepai'deyka pepai'deymai epaidey'vhn paideyto's ;
                       _ => P.error "insufficient case in MorphoGrc.mkVerbW7" } ;

--   w-conjugation with weak tempus-stems: see BR 91 - 107

--   Show the row of stemforms, for weak w-conjugation:         -- BR 91, 92

  guessVerbstemsW : Str -> Str * Str * Str * Str * Str * Str * Str = \paidey'w -> 
     let 
         paidey' = P.tk 1 paidey'w ;   -- BR: Praesensstamm
         epaidey' = augment paidey' ;
         epai'dey = a2 epaidey' ;      -- check syllability?
         pepaidey' = reduplicate paidey' ;
         pepai'dey = a2 pepaidey' ;    -- check syllability?
     in  
         <paidey'w , (paidey'+"sw") , (epai'dey+"sa") ,
          (pepai'dey+"ka") , (pepai'dey+"mai") , (epaidey'+"vhn") ,
          (dA paidey' +"to's*")> ;
-- Active endings:
   actPresInd = endingsV <"w", "eis*", "ei", "omen", "ete", "oysi", "eton", "eton"> ;
   actPresConj= endingsV <"w", "h|s*", "h|", "wmen", "hte", "wsi", "hton", "hton"> ;
   actPresOpt = endingsV <"oimi", "ois*", "oi", "oimen", "oite", "oien", "oiton", "oi'thn"> ;
   actImpfInd = endingsV <"on", "es*", "e", "omen", "ete", "on", "eton", "e'thn"> ;
   actAorInd  = endingsV <"a", "as*", "e", "amen", "ate", "an", "aton", "a'thn"> ;
   actAorOpt  = endingsV <"aimi", "ais*", "ai", "aimen", "aite", "aien", "aiton", "ai'thn"> ; 
   actPerfInd = endingsV <"a", "as*", "e", "amen", "ate", "asi", "aton", "aton"> ;
   actPlqmInd = endingsV <"ein", "eis*", "ei", "emen", "ete", "esan", "eton", "e'thn"> ; 
   -- contracted future
   actFutInd = endingsV <"w~", "ei~s*", "ei~", "oy~men", "ei~te", "oy~si", 
                         "ei~ton", "ei~ton"> ;           -- BR 104.1 (dual:HL)
   actFutOpt = endingsV <"oi~mi", "oi~s*", "oi~", "oi~men", "oi~te", "oi~en", 
                         "oiton", "oi'thn"> ;            -- BR 104.1 

-- Medium endings:
   medPresInd = endingsV <"omai", "h|", "etai", "o'meva", "esve", "ontai", "esvon", "esvon"> ;
   medPresConj = endingsV <"wmai", "h|", "htai", "w'meva", "hsve", "wntai", "hsvon", "hsvon"> ;
   medPresOpt = endingsV <"oi'mhn","oio","oito","oi'meva","oisve","ointo","oisvon","oi'svhn"> ;
   medImpfInd = endingsV <"o'mhn", "oy", "eto", "o'meva", "esve", "onto", "esvon", "e'svhn"> ;
   medAorInd  = endingsV <"a'mhn", "w", "ato", "a'meva", "asve", "anto", "asvon", "a'svhn"> ;
   medAorOpt  = endingsV <"ai'mhn","aio","aito","ai'meva","aisve","ainto","aisvon","ai'svhn"> ; 
   medPerfInd = endingsV <"mai", "sai", "tai", "meva", "sve", "ntai", "svon", "svon"> ;
   medPerfConj = endingsV <"w)~", "h|)~s", "h|)~", "w)~men", "h)~te", "w)~si", 
                           "h~ton", "h~ton"> ;  -- Dual BR 138/141
   medPerfOpt = endingsV <"ei)'hn", "ei)'hs", "ei)'h", "ei)~men", "ei)~te", "ei)~en", 
                          "ei)~ton", "ei)~ton"> ; -- Dual BR 138, 141
   medPlqmInd = endingsV <"mhn", "so", "to", "meva", "sve", "nto", "svon", "svhn"> ;
   -- contracted future:
   medFutInd = endingsV <"oy~mai", "h|~", "ei~tai", "oy'meva", "ei~sve", "oy~ntai", 
                         "ei~svon", "ei~svon"> ;         -- BR 104.1 
   medFutOpt = endingsV <"oi'mhn","oi~o","oi~to","oi'meva","oi~sve","oi~nto",
                         "oi~svon","oi'svhn"> ;          -- BR 104.1 

-- Passive endings:
   passFutInd = endingsV <"h'somai","h'sh|","h'setai","hso'meva","h'sesve","h'sontai",
                          "h~svon","h~svon"> ; 
   passAorInd = endingsV <"hn","hs*","h","hmen","hte","hsan","hton","h'thn"> ;
   passAorConj= endingsV <"w~","h|~s*","h|~","w~men","h~te","w~si","h~ton","h'thn"> ;
   passAorOpt = endingsV <"ei'hn","ei'hs*","ei'h","ei~men","ei~te","ei~en","ei~ton","ei'thn"> ;

-- Imperative endings:
   actPresImp = endingsImp <"e","e'tw","ete","o'ntwn"> ;
   actAorImp  = endingsImp <"on","a'tw","ate","a'ntwn"> ;
   medPresImp = endingsImp <"oy","e'svw","esve","e'svwn"> ;
   medAorImp  = endingsImp <"ai","a'svw","asve","a'svwn"> ;
   medPerfImp = endingsImp <"so","svw","sve","svwn"> ;
   passAorImp = endingsImp <"vhti","vh'tw","vhte","ve'ntwn"> ;

-- We define mkVerbW in such a way that each full form depends on only one of the 
-- 7 aspect/tense stems, so that we can use mkVerbW for weak and strong verbs.
-- (Strong verbs are treated in (d) BR 108 - 115.)

-- Done: act|med VAor weak|strong   BR 109
--       act VPerf|VPlqm strong -a  BR 112 (anything to do?)
-- TODO: act VAor "wurzelaorist"    BR 110
--       pass VAor|VFut strong      BR 111
--       act VPerf|VPlqm strong -a  BR 112.1 ge-graf-[k]a: omit k after consonant-stem
-- TODO: cover monosyllabic stems, cover medium future in active verbs 

-- We split the construction of verb paradigms into active, medium and passive
-- constructions, so that intransitive verbs, deponentia and the similarity of medium
-- and passive can be defined more easily.

  mkActW : (ActPresIndSgP1, ActFutSgP1, ActAorSgP1, ActPerfSgP1 : Str) -> Vform => Str = 
            \paidey'w, paidey'sw, epai'deysa, pepai'deyka ->
     let  
         -- present stem: paidey (used for VPres(VInd|VConj|VOpt), 
         --                                VImpf, VImp, VInf GPres, partDiathPres)
         paidey'  = P.tk 1 paidey'w ;     
         pai'dey  = a2 paidey';     -- check syllability?
         paidey   = dA paidey' ; 
         epaidey' = augment paidey' ;          
         epaidey  = dA epaidey' ;
         epai'dey = a2 epaidey ;    -- check syllability?

         -- future stem:  paideys
         paidey's = P.tk 1 paidey'sw ;    
         paideys  = dA paidey's ;
                                              -- weak/strong: s/-
         -- act|med aorist stem: paideys      -- e-paideys-a / e-bal-on
         aor : tempType =                     -- e-li(ps)-a / TODO
           case epai'deysa of { stm + "on" => strong ; _ => weak } ; -- BR 109
         actAorInd' = case aor of { weak => actAorInd ; strong => actImpfInd } ;
         actAorOpt' = case aor of { weak => actAorOpt ; strong => actPresOpt } ;

         epai'deys : Str = case aor of { weak   =>  P.tk 1 epai'deysa ;
                                         strong =>  P.tk 2 epai'deysa } ;
         epaideys  = dA epai'deys ;           
         epaidey's = a3 epai'deys ;           
         pai'deyS  = unaugment epai'deys ;    -- aorist-stem =/= future-stem
         paidey'S  = a3 pai'deyS ;            
         paideyS   = dA pai'deyS ;

         -- act perfect stem: pepaideyk       -- weak/strong: k/-
         pepai'deyk = P.tk 1 pepai'deyka ;    -- for VAct (VPerf|VPlqm)
         pepaideyk  = dA pepai'deyk;          -- pepai'dey-k-a / ge'graph-a
         pepaidey'k = a3 pepaideyk ;          -- inflection: strong=weak BR 112
         epepaidey'k = augment pepaidey'k ;   -- perhaps ablaut,aspiration for Wlab,Wmut

         -- to cover verba contracta ending in -a.'w, -e'w, -o'w,
         -- apply contractVowels to the forms of the present stem:    BR 93
         cV : Str -> Str -> Str = case paidey' of { -- "a'" is short by convention 
                                _ + ("a'" | "e'" | "o'") => Ph.contractVowels ;  -- cV2
                                _                        => \w1,w2 -> w1+w2 } ;

         -- participles as adjectives (don't use adj3nt for each of the 4x45 af's):
         partPres = (adj3nt (paidey' + "wn")  (paidey' + "ontos")) ;
         partFut  = (adj3nt (paidey's + "wn") (paidey's + "ontos")) ;
         partAor  = (case aor of {                        -- BR 109
                               weak   => adj3nt (paidey'S + "a_s") (paidey'S + "antos") ;    
                               strong => adj3nt (paideyS  + "w~n" ) (paideyS  + "o'ntos") }) ;
         partPerf = (adj3d (pepaideyk + "w's") (pepaideyk + "o'tos")) ;
                                                          -- BR 44.6 (fem: kyi~a)
     in
        table { -- accents ok 
            Fin (VPres VInd)  n p => cV paidey' (actPresInd n p) ;         
            Fin (VPres VConj) n p => cV paidey' (actPresConj n p) ;        
            Fin (VPres VOpt)  n p => case <n,p> of { 
                          <Dl,P3> => cV paidey  (actPresOpt n p) ; 
                          _       => cV paidey' (actPresOpt n p) } ;       
            Fin VImpf n p         => case <n,p> of {
                          <Pl,P1> => cV epaidey' (actImpfInd n p) ;
                          <Pl,P2> => cV epaidey' (actImpfInd n p) ;
                          <Dl,P1> => cV epaidey' (actImpfInd n p) ;
                          <Dl,P2> => cV epaidey' (actImpfInd n p) ;
                          <Dl,P3> => cV epaidey  (actImpfInd n p) ;
                          _       => cV epai'dey (actImpfInd n p) } ;
            Fin (VFut FInd) n p   => paidey's + actPresInd n p ;   
            Fin (VFut FOpt) n p   => case <n,p> of {
                          <Dl,P3> => paideys  + actPresOpt n p ;   
                          _       => paidey's + actPresOpt n p } ; 
            Fin (VPerf VInd)  n p => case n of {
                               Sg => pepai'deyk + actPerfInd n p ;
                               _  => pepaidey'k + actPerfInd n p } ;
            Fin (VPerf VConj) n p => pepaidey'k + actPresConj n p ;
            Fin (VPerf VOpt)  n p => case <n,p> of {
                          <Dl,P3> => pepaideyk  + actPresOpt n p ;
                          _       => pepaidey'k + actPresOpt n p } ;
            Fin (VAor  VInd)  n p => case <n,p> of {
                 <Sg,_> | <Pl,P3> => epai'deys + actAorInd' n p ;
                          <Dl,P3> => epaideys  + actAorInd' n p ;
                          _       => epaidey's + actAorInd' n p } ;  
            Fin (VAor  VConj) n p => paidey'S + actPresConj n p ;   
            Fin (VAor  VOpt)  n p => case <n,p> of {
                          <Dl,P3> => paideyS  + actAorOpt' n p ;     
                          _       => paidey'S + actAorOpt' n p } ;     
            Fin VPlqm n p         => case <n,p> of {
                          <Dl,P3> => dA epepaidey'k + actPlqmInd n p ;
                          _       => epepaidey'k + actPlqmInd n p } ;
            Imp IPres np          => cV (case np of { 
                                           SgP2 => pai'dey ;
                                           PlP2 => paidey';
                                              _ => paidey  }) (actPresImp np) ;
            Imp IAor  np          => case np of { 
                                        SgP2 => pai'deyS ; 
                                        PlP2 => paidey'S;
                                           _ => paideyS  } + actAorImp np ;
            Imp IPerf np          => nonExist ; 

            Inf GPres => cV paidey' "ein" ;             
            Inf GFut  => paidey's + "ein" ;                
            Inf GAor  => case aor of { 
                                weak   => addAccent (Circum 2) (paidey'S + "ai") ;
                                strong => paideyS + "ei~n" } ;    -- BR 109
            Inf GPerf => pepaideyk + "e'nai" ;

            Part GPres af => Ph.contractVowels (partPres.s ! af) ; -- TODO poioyy'shs etc
            Part GFut af  => partFut.s ! af ;
            Part GAor af  => partAor.s ! af ;
            Part GPerf af => partPerf.s ! af 
        } ;

  mkMedW : (MedPresIndSgP1, MedFutSgP1, MedAorSgP1, MedPerfIndSgP1 : Str) -> Vform => Str = 
           \paidey'omai, paidey'somai, epaideysa'mhn, pepai'deymai -> 
     let 
         -- present stem: paidey, used for VPres VInd|VConj|VOpt, 
         --                                VImpf, VImp, VInfPres, partDiathPres
         paidey' : Str = P.tk 4 paidey'omai ; 
         paidey   = dA paidey' ; 
         epaidey' = augment paidey' ;          
         epaidey  = dA epaidey' ;

         -- future stem:  paideys             -- aorist-stem =/= future-stem
         paidey's = P.tk 4 paidey'somai ; 
         paideys  = dA paidey's ;
                                              
         -- act|med aorist stem: paideyS      -- weak/strong: s/-
         aor : tempType =                     -- e-paidey-s-amhn / e-bal-omhn
           case epaideysa'mhn of { stm + "o'mhn" => strong ; _ => weak } ; -- BR 109
         medAorInd' = case aor of { weak => medAorInd ; strong => medImpfInd } ;
         medAorOpt' = case aor of { weak => medAorOpt ; strong => medPresOpt } ;

         epaideyS  = P.tk 5 epaideysa'mhn ;
         epaidey'S = a3 epaideyS ;           
         epai'deyS = case (toWord epaideyS).s of { Multi => a2 epaideyS  ; _ => a3 epaideyS } ;
         pai'deyS  = unaugment epai'deyS ;    
         paidey'S  = a3 pai'deyS ;            
         paideyS   = dA pai'deyS ;

         -- med|pass perfect stem: pepaidey
         pepai'dey = P.tk 3 pepai'deymai ; 
         pepaidey  = dA pepai'dey ;
         pepaidey' = a3 pepaidey ;            -- pepaidey'= reduplicate paidey' ;
         epepaidey'= augment pepaidey';
         epepai'dey = a2 epepaidey' ;

         -- to cover verba contracta ending in -a.'w, -e'w, -o'w,
         -- apply contractVowels to the forms of the present stem:    BR 93
         cV : Str -> Str -> Str = case paidey' of { -- "a'" is short by convention 
                                _ + ("a'" | "e'" | "o'") => Ph.contractVowels ;  -- cV2
                                _                        => \w1,w2 -> w1+w2 } ;

         partPres = (adj2AO (paidey  + "o'menos") (paidey  + "ome'nhs")) ; -- BR 82.2b, 91
         partFut  = (adj2AO (paideys + "o'menos") (paideys + "ome'nhs")) ;
         partAor  = (adj2AO (paideyS + "a'menos") (paideyS + "ame'nhs")) ;
         partPerf = (adj2AO (pepaidey + "me'nos") (pepaidey + "me'nhs")) ; 
     in
         table { -- accents ok 
             Fin (VPres VInd)  n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => cV paidey  (medPresInd n p) ;
                           _       => cV paidey' (medPresInd n p) } ;
             Fin (VPres VConj) n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => cV paidey  (medPresConj n p) ;
                            _      => cV paidey' (medPresConj n p) } ;
             Fin (VPres VOpt)  n p => case <n,p> of {
                  <_,P1> | <Dl,P3> => cV paidey  (medPresOpt n p) ;
                            _      => cV paidey' (medPresOpt n p) } ;
             Fin VImpf n p         => case <n,p> of {
                  <_,P1> | <Dl,P3> => cV epaidey (medImpfInd n p) ;
                            _      => cV epaidey'(medImpfInd n p) } ;
             Fin (VFut FInd)   n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => paideys  + medPresInd n p ;
                           _       => paidey's + medPresInd n p } ;
             Fin (VFut FOpt)   n p => case <n,p> of {
                  <_,P1> | <Dl,P3> => paideys  + medPresOpt n p ;
                                 _ => paidey's + medPresOpt n p } ;
             Fin (VPerf VInd)  n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => pepaidey' + medPerfInd n p ;
                                 _ => pepai'dey + medPerfInd n p } ;
             Fin (VPerf VConj) n p => pepaidey + (menos n) ++ medPerfConj n p ;
             Fin (VPerf VOpt)  n p => pepaidey + (menos n) ++ medPerfOpt n p ;
             Fin (VAor  VInd)  n p => case <n,p> of {
                 <Sg,P1> | <Pl,P1> | 
                 <Dl,P1> | <Dl,P3> => epaideyS  + medAorInd' n p ;
                                 _ => epaidey'S + medAorInd' n p } ;
             Fin (VAor  VConj) n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => paideyS  + medPresConj n p ;
                                 _ => paidey'S + medPresConj n p } ;
             Fin (VAor  VOpt)  n p => case <n,p> of {
                  <_,P1> | <Dl,P3> => paideyS  + medAorOpt' n p ;
                                 _ => paidey'S + medAorOpt' n p } ;
             Fin VPlqm n p         => case <n,p> of {
                  <_,P1> | <Dl,P3> => epepaidey' + medPlqmInd n p ;
                                 _ => epepai'dey + medPlqmInd n p } ; 
             -- imperative accents ok for paideyein
             Imp IPres np          => cV (case np of {
                                            SgP2 | PlP2 => paidey';
                                                      _ => paidey  }) (medPresImp np) ;
             Imp IAor  np          => case np of {
                                           SgP2 => pai'deyS + case aor of { 
                                                      strong => "oy~" ; -- BR 109.1
                                                      weak   => medAorImp np } ;
                                           PlP2 => paidey'S + medAorImp np ;
                                              _ => paideyS  + medAorImp np } ;
             Imp IPerf np           => case np of {
                                           SgP2 | PlP2 => pepai'dey ;
                                                     _ => pepaidey' } + medPerfImp np ;
 
             -- accents ok -- Accents in infinite verb forms: BR 88 
             Inf GPres => cV paidey' "esvai" ;
             Inf GFut  => paidey's + "esvai" ;
             Inf GAor  => case aor of { 
                                 weak   => paidey'S + "asvai"; 
                                 strong => paideyS  + "e'svai" } ; -- BR 109
             Inf GPerf => pepaidey + "~" + "svai" ;  -- verba vocalia only
             -- 
             Part GPres af => partPres.s ! af ;  
             Part GFut  af => partFut.s ! af ;
             Part GAor  af => partAor.s ! af ;
             Part GPerf af => partPerf.s ! af  
          } ;

  mkVerbW7voc : (ActPresIndSgP1, ActFutSgP1, ActAorSgP1, ActPerfSgP1,
                 MedPerfSgP1, PassAorSgP1, VAdj1 : Str) -> Verb = 
                 \paidey'w, paidey'sw, epai'deysa, pepai'deyka, 
                  pepai'deymai, epaidey'vhn, paideyto's ->
     let 
         -- present stem: paidey (used for VPres(VInd|VConj|VOpt), 
         --                                VImpf, VImp, VInfPres, partDiathPres)
         paidey'  = P.tk 1 paidey'w ;
         pai'dey  = a2 paidey';               -- TODO: check syllability, monosyl
         paidey   = dA paidey' ; 

         -- future stem:  paideys
         paidey's : Str = case paidey'sw of { fstem + "somai" => fstem ; _ => P.tk 1 paidey'sw } ;    
         paideys  = dA paidey's ;
                                              -- weak/strong: s/-
         -- act|med aorist stem: paideyS      -- e-paideys-a / e-bal-on
         aor : tempType = 
           case epai'deysa of { stm + "on" => strong ; _ => weak } ; -- BR 109
         epai'deys : Str = case aor of { strong =>  P.tk 2 epai'deysa ;
                                         weak   =>  P.tk 1 epai'deysa } ;
         epaideysa'mhn = case aor of { strong => dA epai'deys + "o'mhn" ; 
                                            _ => dA epai'deys + "a'mhn" } ;
         pai'deyS  = unaugment epai'deys ;    
         paidey'S  = a3 pai'deyS ;            
         paideyS   = dA pai'deyS ;

         -- act perfect stem: pepaideyk       -- weak/strong: k/-
         pepai'deyk = P.tk 1 pepai'deyka ;    -- for VAct (VPerf|VPlqm)
         pepaideyk  = dA pepai'deyk;

         -- med|pass perfect stem: pepaidey
         pepai'dey = P.tk 3 pepai'deymai ; 
         pepaidey  = dA pepai'dey ;
         pepaidey' = a3 pepaidey ;            -- pepaidey'= reduplicate paidey' ;
         epepaidey'= augment pepaidey';
         epepai'dey = a2 epepaidey' ;

         -- pass aorist stem: epaideyv        -- for VPass (VAor (VInd|VConj|VOpt))
         epaidey'v = P.tk 2 epaidey'vhn ;     --     VPass (VFut FInd|FOpt)
         epaideyv  = dA epaidey'v ;           
         paidey'v  = unaugment epaidey'v ;    
         paideyv   = dA paidey'v ;            -- for temporal augments ?
         aorPass : tempType =                 -- weak/strong: v/-  
           case epaidey'v of { _ + "v" => weak ; _ => strong } ;

         -- verbal adjective: paidey-tos              
         paideyte'os : Str = 
            case paideyto's of { x + ("to's"|"to's*") => x + "te'os" ;
                                                    _ => paideyto's } ; -- P.error

         -- to cover verba contracta ending in -a.'w, -e'w, -o'w,
         -- apply contractVowels to the forms of the present stem:    BR 93
         cV : Str -> Str = case paidey' of { -- "a'" is short by convention 
                                _ + ("a'" | "e'" | "o'") => Ph.contractVowels ;  
                                _                        => \w -> w } ;

         med = mkMedW (paidey'+"omai") (paidey's+"omai") epaideysa'mhn pepai'deymai ;

         partPres = (adj2AO (cV (paidey + "o'menos"))  (cV (paidey + "ome'nhs"))) ;
         partFut  = (adj2AO (paideyv + "hso'menos")  (paideyv + "hsome'nhs")) ;
         partAor  = (adj3nt (paideyv + "ei's") (paideyv + "e'ntos")) ;  -- BR 46.b 3
         partPerf = (adj2AO (pepaidey+"me'nos") (pepaidey+"me'nhs")) ;
     in  
        { act = mkActW paidey'w paidey'sw epai'deysa pepai'deyka ;
          med = med ;
          pass = table { -- only the forms differing from medium:
            Fin (VFut FInd)   n p => case <n,p> of {
                 <Dl,P2> |<Dl,P3> => paidey'v + passFutInd n p ;    
                                _ => paideyv  + passFutInd n p } ;  
            Fin (VFut FOpt)   n p => case <n,p> of {
                 <_,P1> | <Dl,P3> => paideyv + "hs"  + medPresOpt n p ;
                                _ => paideyv + "h's" + medPresOpt n p } ;
            Fin (VAor  VInd)  n p => case <n,p> of {
                          <Dl,P3> => epaideyv  + passAorInd n p ;   
                                _ => epaidey'v + passAorInd n p } ; 
            Fin (VAor  VConj) n p => paideyv   + passAorConj n p ;  
            Fin (VAor  VOpt)  n p => paideyv   + passAorOpt n p ;   
            Fin tmpMod        n p => med ! ( Fin tmpMod n p) ;
            Imp IPres np          => cV (case np of {
                                           SgP2 | PlP2 => paidey';
                                                     _ => paidey  } + medPresImp np) ;
            Imp IAor np           => case np of { 
                                       SgP2 => paidey' + (case aorPass of { 
                                                   strong => "vi" ; -- not -ti, BR 111.1
                                                        _ => passAorImp np }) ;
                                       PlP2 => paidey' + passAorImp np ;
                                          _ => paidey  + passAorImp np } ;
            Imp IPerf np          => med ! (Imp IPerf np) ;

            Inf GPres => cV (paidey' + "esvai") ;   -- cV: BR 93
            Inf GFut  => paideyv + "h'sesvai" ; 
            Inf GAor  => paideyv + "h~nai" ;    
            Inf GPerf => pepaidey + "~" + "svai" ;  -- verba vocalia only 

            Part GPres af => partPres.s ! af ;
            Part GFut  af => partFut.s ! af ;
            Part GAor  af => partAor.s ! af ;
            Part GPerf af => partPerf.s ! af
            } ; 
         vadj1 : Adj = case paideyto's of  { x+"e'on" => adjAO (x+"o's") ;   -- pay'w,...,payste'on (not: payst(e)o's)
                                             _        => adjAO paideyto's } ; 
         vadj2 : Adj = case paideyte'os of { x+"e'on" => adjAO (x+"e'os") ;  
                                             _        => adjAO paideyte'os } ;
         vtype = VFull ;
        } ;

-- (a) verba vocalia (and contracta)                                   BR 91

  mkVerbW1voc : Str -> Verb = \paidey'w ->     -- BR 91, 92
     let 
         paidey' : Str = 
           case paidey'w of {                  -- BR 95 (here aw = a.w)
                       x+y@("e"|"i"|"r") + "a'w" => x+y+"a_'" ;
                       x +                 "a'w" => x+  "h'"  ;
                       x +                 "e'w" => x+  "h'"  ;
                       x +                 "o'w" => x+  "w'"  ;
                       _                         => P.tk 1 paidey'w } ;
         epaidey'  = augment paidey' ;
         epai'dey  = a2 epaidey' ;      -- check syllability?
         pepaidey' = reduplicate paidey' ;
         pepai'dey = a2 pepaidey' ;     -- check syllability?
     in  
         mkVerbW7voc paidey'w (paidey'+"sw") (epai'dey+"sa") 
                     (pepai'dey+"ka") (pepai'dey+"mai") (epaidey'+"vhn") 
                     (dA paidey' +"to's*") ;

-- TODO: verba vocalia with ablaut BR 96, with -s stem BR 97 or -eF,aF stem BR 98

--(b) verba muta (labial (p-stem), guttural (k-stem), dental (t-stem)) BR 99

--    Weak tempusstems use the same tempus-consonant as the verba vocalia, but
--    the p-,k-,t- combines with initial consonants of the ending.
--    t-stems have weak perfect -ka; aorist -sa is changed to -ka         
--    p/k-stems have perfect with -fa or -ca. 

--    Examples: (p-stem) tre'pw, gra'fw, tri_'bw   (BR 99.1 pres-stem = verbal stem)
--              (k-stem) diw'kw, a)'rcw, le'gw
--              (t-stem) a(ny'tw, pei'vw, psey'dw
{- not used:
  param vstemType = 
          Vocal | Labial | Dental | Guttural | Liquidal | Nasal ;
  oper 
  vstem : Str -> vstemType = 
      \str -> case str of { _+(#Ph.vowel|#Ph.diphthong)+(#Ph.accent|"")+"w" => Vocal ;
                            _ + #Ph.labial => Labial ;
                            _ + #Ph.dental => Dental ;
                            _ + #Ph.guttural => Guttural ;
                            _ + #Ph.liquid => Liquidal ;
                            _ + #Ph.nasal => Nasal ;
                            _ => P.error "unknown stem type"
      } ;
-}                               

-- mkVerbW1mut is essentially mkVerbW1voc + application of soundlaw mC to the resulting forms.
-- Use only for verbs whose 7 stems can simply be derived from (VPres Ind Sg P1).

  mkVerbW1mut : Str -> Verb = \paidey'w ->     -- BR (99) 100
     let 
         paidey':Str = case paidey'w of {
                       x+(#Ph.diphthong|#Ph.vowel)    -- BR 99.1
                        +(("p"|"k"|"t")|("f"|"c"|"v")|("b"|"g"|"d"))
                        +"w"            => P.tk 1 paidey'w ;    
                       -- the following may guess the wrong verbal stem: P.error "use mkVerbW7mut!"
                       x+"pt" + "w"     => x + "p" ;   -- or x+"f" or x+"b"
                       x+"tt" + "w"     => x + "k" ;   -- or x+"c" or x+"t" or x+"v"
                       x+"z"  + "w"     => x + "d" ;   -- or x+"g" 
                       x + "w"          => x 
                     } ;
         epaidey'  = augment paidey' ;
         epai'dey  = a2 epaidey' ;     
         pepaidey' = reduplicate paidey' ;
         pepai'dey = a2 pepaidey' ;    
         -- BR 100 needs *verbstem* ; we instead take consonant at ending of *present stem*
         -- dental stems: weak VPerf with -ka BR 100.a, labial/guttural stems: strong Perf -fa/-ca BR 112
         pepai'deyka : Str = case pepai'dey of { 
                                    x+("t"|"d"|"v") => pepai'dey+"ka" ;          -- BR 100.a
                                    x+("p"|"b"|"f") => (P.tk 1 pepai'dey)+"fa" ; -- BR 100.b
                                    x+("k"|"c"|"g") => (P.tk 1 pepai'dey)+"ca" ; -- BR 100.b
                                    _               => pepai'dey+"ka" } ;
         epaidey'vhn : Str = case epaidey' of { x+#Ph.consonant => epaidey'+"hn" ; -- BR 111
                                                _ => epaidey'+"vhn" } ;  -- strong/weak pass Aor

         mC : Str -> Str = Ph.mutaSConsonant ; -- BR 101.1 a

         -- the multisyllabic -i'zw verbs are omitted here and should be treated in mkVerbW7mut 
         -- since their verb stem cannot be guessed in general
         verb : Verb = mkVerbW7voc paidey'w (paidey'+"sw") (epai'dey+"sa") pepai'deyka
                       (pepai'dey+"mai") epaidey'vhn (dA paidey' +"to's*") ;
     in { 
          act = table { vform => mC (verb.act ! vform) } ;  -- BR 100, 101.1 a
          med = table { Fin (VPerf VInd) Pl P3 -- BR 101.1 b (TODO gender agreement: Neutr "e)sti'")
                                            => mC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                        Fin VPlqm Pl P3        -- BR 101.1 b (TODO gender agreement, Neutr "h)~n")
                                            => mC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"h)~san" ; 
                        Inf GPerf           => a2 (mC (dA (verb.med ! (Inf GPerf)))) ; -- BR 101.1 a
                        -- TODO Perf VInd: peivw -> pepei(v)ka drop v BR 100 - why?
                        vform => mC (verb.med ! vform) } ;
          pass = table { Fin (VPerf VInd) Pl P3 -- BR 101.1 b (TODO gender agreement: Neutr "e)sti'")
                                            => mC (verb.pass ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                         Fin VPlqm Pl P3        -- BR 101.1 b (TODO gender agreement, Neutr "h)~n")
                                            => mC (verb.pass ! (Part GPerf (AF Masc Pl Nom)))++"h)~san" ; 
                        Inf GPerf           => a2 (mC (dA (verb.pass ! (Inf GPerf)))) ; -- BR 101.1 a
                        -- Imp Sg P2 -vi, not -ti BR 111.1
                        vform => mC (verb.pass ! vform) } ;
          vadj1 = { s = table { af => mC (verb.vadj1.s ! af) } ; adv = mC (verb.vadj1.adv) } ; 
          vadj2 = { s = table { af => mC (verb.vadj2.s ! af) } ; adv = mC (verb.vadj2.adv) } ; 
          vtype = VFull ;
    } ;  

-- Unfinished, 12/2015: TODO: complete mkVerbW7mut for providing tempus stems (how to undo mC-applications?)
-- for example, to specify act VFut -s-omai (middle future), and to do strong tempora.
-- Q: do we need a separate version to specify the verbal stem?

-- cc mkVerbW7mut "kry'ptw" "kry'qw" "e)'kryqa" "ke'kryfa" "ke'krymmai" "e)kry'fvhn" "krypto's" 

  mkVerbW7mut : (ActPresIndSgP1, ActFutSgP1, ActAorSgP1, ActPerfSgP1,
                 MedPerfSgP1, PassAorSgP1, VAdj1 : Str) -> Verb = 
     \kry'ptw, kry'qw, e'kryqa, ke'kryfa,  -- paidey'w, paidey'sw, epai'deysa, pepai'deyka, 
      ke'krymmai, ekry'fvhn, krypto's ->   -- pepai'deymai, epaidey'vhn, paideyto's 
     let
         mC : Str -> Str = Ph.mutaConsonant ;
         -- use mkVerbW7voc with reconstructed stem+endings, and then apply the soundlaws (mC, cV?) 

         -- present stem: BR 99 (no need to undo sound laws)
         paidey' = P.tk 1 kry'ptw ;  

         -- verbal stem (in general undecidable, how the stem _+j ended)
         -- 1. stem+w,  2.a labial stems: _(p|b|f)+j+w > _+pt+w,   2.b guttural|dental stems: _(k|c|t|v)+j+w > _tt+w
         {-
         stemtype : vstemType = 
           case dA paidey' of { _ + "pt" => Labial ;
                                _ + ("i"|"i."|"a"|"a.") + "z" => Dental ; -- BR 99.2b roughly 
                                _ => P.error ("Morpho.mkVerbW7mut: unknown verbstem type" ++ paidey'} ;
         -}
         -- future stem
         paidey's : Str = -- undo soundlaw x+ps+w > x+q+w to get future stem x+p, or just drop +w
           case kry'qw of { stm + "qw" => stm + "p" ; 
                            stm + "w"  => stm ;
                            stm + "w~" => stm ;
                            stm + "omai"  => stm ;
                            stm + "oy~mai"  => stm } ;
         fut : tempType = case kry'qw of { _ + "w~" => strong ; _ => weak } ; -- BR 102.1 (only for -i'zw ?)

         -- BR 102.1 contracted future in multisyllabic words in -izw
         actFut : MoodF -> Number -> Person -> Str = \m,n,p -> 
           case m of { FInd => actFutInd n p ; FOpt => actFutOpt n p } ;
         medFut : MoodF -> Number -> Person -> Str = \m,n,p -> 
           case m of { FInd => medFutInd n p ; FOpt => medFutOpt n p } ;
         -- We omit checking that -i'zw is multisyllabic; use mkVerbW1 for sw'zw e.a.
         -- contracted : Bool = case paidey'w of { 
         --   _ + "i'zw" => case (toWord paidey'w).s of { Multi => True ; _ => False } ;
         --   _ => False } ; 
         medPartFut  = (adj2AO (dA paidey's + "oy'menos") (dA paidey's + "oyme'nhs")) ; -- BR 102.1

         -- act|med aorist stem: paideys      -- e-paideys-a / e-bal-on
         aor : tempType =                     -- e-li(ps)-a / TODO
           case e'kryqa of { _ + ("sa" | "qa" | "xa") => weak ; 
                             _ + ("sa" | "qa" | "xa")+"'mhn" => weak ; -- HL ??
                             _  + ("fa"|"pa"|"on") => strong ;
                             _ => P.error ("MorphoGrc.mkVerbW7mut: unrecognized act|med aorist stem " ++ e'kryqa) } ; 

         actAorInd' = case aor of { weak => actAorInd ; strong => actImpfInd } ;
         actAorOpt' = case aor of { weak => actAorOpt ; strong => actPresOpt } ;

         epai'deys : Str = -- TODO -mhn etc
           case aor of { weak   =>  case e'kryqa of { x+"sa" => x+"s" ;
                                                      x+"qa" => x+"ps" ;
                                                      x+"xa" => x+"ks" ;
                                                      _ => P.tk 1 e'kryqa } ;
                         strong =>  case e'kryqa of { x+"on" => x ; 
                                                      _ => P.tk 1 e'kryqa } 
           } ;

         -- perfect stem
         perf : tempType = case ke'kryfa of { _ + ("fa" | "ca") => strong ; 
                                              _ + "ka" => weak ;
                                              _ => P.error ("Morpho:mkVerb7mut: undefined perfect temp for " ++ ke'kryfa) } ;
         pepai'deyk = P.tk 1 ke'kryfa ;
         epepaidey'k = augment (a3 pepai'deyk) ; -- act Fin VPlqm. TODO ablaut, aspirant? 

         -- med|pass perfect stem: 
         pepai'dey : Str 
           = let ke'krym = P.tk 3 ke'krymmai ; -- undo assimilation
                 p : Str = case kry'ptw of { x+"pt"+"w" => "p" ;  -- | "f" | "b" 
                                             x+"tt"+"w" => "k" ;  -- | "c" 
                                             x+"z"+"w"  => "d" ;  -- | "g" (rare)
                                             x+c@#Ph.consonant+"w" => c ;
                                             _ => P.error ("Morpho.mkVerbW7mut: undefined med-pass perfect stem " ++ ke'krymmai ++ "/" ++ kry'ptw)
                   } ;
           in case ke'krym of { x+"m" => P.tk 1 ke'krym + p ; -- undo assimilation
                                x+"s" => ke'krym ; 
                                x+#Ph.consonant => ke'krym ;
                                _ => P.error ("Morpho.mkVerbW7mut: undefined med-pass perfect stem for " ++ ke'krymmai) } ;
         -- aorist passiv:
         epaidey'v : Str = case ekry'fvhn of { x+"vhn" => x + "v" ; _ => P.tk 2 ekry'fvhn } ; -- weak/strong
         

         -- construct verb = mkVerbW7voc with reconstructed stem+endings, and then apply the soundlaws (mC, cV?) 
                            --  kry'ptw,        kry'qw,          e'kryqa,         ke'kryfa,  
         verb = mkVerbW7voc (paidey' + "w") (paidey's + "sw") (epai'deys + "a") (pepai'deyk +"a") 
                            -- ke'krymmai,        ekry'fvhn,      krypto's 
                          (pepai'dey + "mai") (epaidey'v + "hn")  krypto's  
                                              

     in { act = table { -- verbal stem: how to undo soundlaw in stem+j+w > present-stem+w ???
                        -- dental stems: weak VPerf with -ka BR 100.a, labial/guttural stems: strong Perf -fa/-ca BR 112

                        --               BR 102.1 multisyllabic + -izw => contracted (Act|Med) VFut 
                        Fin (VFut mod) n p  => case fut of { strong => (paidey's + (actFut mod n p) ) ; -- BR 102.1
                                                             weak => mC (verb.act ! (Fin (VFut mod) n p)) } ;
                        Inf GFut            => case fut of { strong => (paidey's + "ei~n") ; 
                                                             _ => mC (verb.act ! (Inf GFut)) } ;
                        -- TODO: Part GFut: -w~n, -ou~sa, -oy~n BR 102.1, BR 104.3
                        Part GFut af        => case fut of { strong => paidey's+"w~n -oy~sa -oy~n 102" ;
                                                             weak => mC (verb.act ! (Part GFut af)) } ;
                        Fin VPlqm n p       => case <n,p> of { <Dl,P3> => dA epepaidey'k + actPlqmInd n p ;
                                                               _       => epepaidey'k + actPlqmInd n p } ;
                        vform               => mC (verb.act ! vform) } ;
          med = table { --               BR 102.1 multisyllabic + -izw => contracted (Act|Med) VFut 
                        Fin (VFut mod) n p  => case fut of { strong => (paidey's + (medFut mod n p) ) ; -- BR 102.1
                                                             weak => mC (verb.med ! (Fin (VFut mod) n p)) } ;
                        Inf GFut            => case fut of { strong => (paidey's + "ei~svai") ; 
                                                             _ => (verb.med ! (Inf GFut)) } ;
                        Part GFut af        => case fut of { strong => medPartFut.s ! af ; --oy'menos BR 102.1, BR 104.3
                                                             weak => mC (verb.med ! (Part GFut af)) } ;
                        -- Perf|Plqm: BR 101.1a apply cV to drop s at endings -s_ between consonants
                        Fin (VPerf VInd) Pl P3 -- BR 101.1 b (TODO gender agreement: Neutr "e)sti'")
                                            => mC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                        Fin (VPerf mod) n p => mC (verb.med ! (Fin (VPerf mod) n p)) ;
                        Fin VPlqm Pl P3        -- BR 101.1 b (TODO gender agreement, Neutr "h)~n")
                                            => mC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"h)~san" ; 
                        Fin VPlqm n p       => mC (verb.med ! (Fin VPlqm n p)) ;
                        Inf GPerf           => a2 (mC (dA (verb.med ! (Inf GPerf)))) ; -- BR 101.1 a
                        Imp IPerf np        => mC (verb.med ! (Imp IPerf np)) ; 
                        -- Perf: BR 102.2 tre'pw,stre'fw,tre'fw change -e- to -a- by BR 28
                        vform               => mC (verb.med ! vform) } ;
          pass = table { -- Fut as in medium ?
                         --               BR 102.1 multisyllabic + -izw => contracted (Act|Med) VFut 
                        Fin (VFut mod) n p  => case fut of { strong => (paidey's + (medFut mod n p) ) ; -- BR 102.1
                                                             weak => mC (verb.med ! (Fin (VFut mod) n p)) } ;
                        Inf GFut            => case fut of { strong => (paidey's + "ei~svai") ; 
                                                             _ => (verb.med ! (Inf GFut)) } ;
                        Part GFut af        => case fut of { strong => medPartFut.s ! af ; --oy'menos BR 102.1, BR 104.3
                                                             weak => mC (verb.med ! (Part GFut af)) } ;
                        -- Perf
                        Fin (VPerf VInd) Pl P3 -- BR 101.1 b (TODO gender agreement: Neutr "e)sti'")
                                            => mC (verb.pass ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                        Fin VPlqm Pl P3        -- BR 101.1 b (TODO gender agreement, Neutr "h)~n")
                                            => mC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"h)~san" ; 
                        Inf GPerf           => mC (verb.pass ! (Inf GPerf)) ;     -- BR 101.1 a
                        vform               => mC (verb.pass ! vform) } ;
          vadj1 = { s = table { af => mC (verb.vadj1.s ! af) } ; adv = mC (verb.vadj1.adv) } ; 
          vadj2 = { s = table { af => mC (verb.vadj2.s ! af) } ; adv = mC (verb.vadj2.adv) } ; 
          vtype = VFull ;
    } ;

--(c) verba liquida: stem ends in l, r, n, m                            BR 103-107
--    BR 103 de'rw, me'nw, ne'mw , -llw, -ai'nw, -ei'nw, -i_'nw, -y_'nw,
--    TODO  BR 104 imp ; (BR 101.b gender agreement)
--          correct accents Act Perf: h)~ggelka > h)'ggelka, in VPass Perf ?
  -- Status: 27.12.2015
  -- Fut|AorI, BR 104.3: ok, except accents in participles and Imp VAct SgP2
  -- Other tempora, BR 105: a+b ok, TODO c: monosyllabic stems
  -- Perf|Plqm, BR 106: ok 
  -- Special stems, BR 107: TODO (skip)

  -- In case Wliq-verbs have weak Pass Aor|Fut (-vhn|-vhsomai), try mkVerbW1liq, 
  -- for strong Pass Aor|Fut (-hn|-hsomai), we need mkVerbW7liq 

  mkVerbW1liq : Str -> Verb = \fai'nw ->     -- BR 
     let 
         fa'n : Str = case fai'nw of { x + "ai'n" + "w" => x + "a'n" ;    -- BR 103
                                      x + "ei'n" + "w" => x + "e'n" ;
                                      x + "i_'n" + "w" => x + "i.'n" ;
                                      x + "y_'n" + "w" => x + "y.'n" ;
                                      x + "ai'r" + "w" => x + "a'r" ;
                                      x + "ei'r" + "w" => x + "e'r" ;
                                      x + "i_'r" + "w" => x + "i.'r" ;
                                      x + "y_'r" + "w" => x + "y.'r" ;
                                      x + "ll"   + "w" => x + "l" ;
                                      _                => P.tk 1 fai'nw 
                                    } ;

         fA'n : Str = case (toWord fa'n).s of {                              -- BR 105.c
                   Mono => case fa'n of { f + "e" + n => f + "a" + n ; _ => fa'n } ;
                   _    => fa'n } ;
         efa'n = augment fA'n ;

         efh'n : Str = case fa'n of { x + v@("a")+a@("'"|"")+c@("n"|"m"|"l"|"r") 
                                        => case x of { _+("e"|"i"|"r") => augment (x+ "a_" + a+c) ;
                                                       _               => augment (x+ "h"  + a+c) } ;
                                      x + v@("e"|"i."|"y.") + a@("'"|"")+c@("n"|"m"|"l"|"r")
                                        =>  augment (x + (Ph.ersatzdehnung v) + a+c) ;
                                      _ =>  augment fa'n } ;                 -- BR 104.2
         pe'fan = a2 (reduplicate fA'n) ; 
 
     in 
         mkVerbW7liq fai'nw (dA fa'n +"w~") (a2 efh'n +"a") (pe'fan+"ka")
                            (pe'fan+"mai") (efa'n+"vhn") (dA fA'n +"to's*") ; -- weak Pass Aor

  -- To generate -Wliq paradigms with strong Pass Aor etc. use mkVerbW7liq: 
  -- expl: (edar+"hn"), not (edar+"vhn")
  -- cc -unqual mkVerbW7liq "a)gge'llw" "a)ggelw~" "h)'ggeila" "h)'ggelka" 
  --                        "h)'ggelmai" "h)gge'lvhn" "a)ggelto's"

  mkVerbW7liq : (ActPresIndSgP1, ActFutSgP1, ActAorSgP1, ActPerfSgP1,
                 MedPerfSgP1, PassAorSgP1, VAdj1 : Str) -> Verb = 
     \fai'nw, fanw', e'fhna, pe'fagka, -- paidey'w, paidey'sw, epai'deysa, pepai'deyka, 
      pe'fasmai, efa'nvhn, fanto's ->  -- pepai'deymai, epaidey'vhn, paideyto's 
     let
         verb = mkVerbW7voc fai'nw fanw' e'fhna pe'fagka pe'fasmai efa'nvhn fanto's ;

         paidey' = P.tk 1 fai'nw ;
         paidey  = dA paidey' ;

         paideys = P.tk 2 fanw' ;
         pe'fan  = P.tk 2 pe'fagka ; 
         pepaidey = dA pe'fan ;

         epai'deys = P.tk 1 e'fhna ; -- a2 efh'n ;
         epaideys  = dA epai'deys ;  -- dA efh'n ;
         epaidey's = a3 epaideys ;   -- efh'n

         paidey'S  = unaugment epaidey's ;
         paideyS   = dA paidey'S ;

         fan : Str = case fai'nw of { x + "ai'n" + "w" => x + "a'n" ;    -- BR 103
                                      x + "ei'n" + "w" => x + "e'n" ;
                                      x + "i_'n" + "w" => x + "i.'n" ;
                                      x + "y_'n" + "w" => x + "y.'n" ;
                                      x + "ai'r" + "w" => x + "a'r" ;
                                      x + "ei'r" + "w" => x + "e'r" ;
                                      x + "i_'r" + "w" => x + "i.'r" ;
                                      x + "y_'r" + "w" => x + "y.'r" ;
                                      x + "ll"   + "w" => x + "l" ;
                                      _                => P.tk 1 fai'nw 
                                    } ;
         nC : Str -> Str = case fan of {
          _ + "n" => \str -> case str of { x + "ns" + c@#Ph.consonant + y 
                                                        => x + "n" + c + y ; -- BR 106.a
                                           x + "nm" + y => x + "sm" + y ;    -- BR 105.b
                                                      _ => Ph.nasalConsonant str } ; -- nk > g
          _       => \str -> case str of { x + c1@("r"|"l"|"m") + "s" + c@#Ph.consonant + y 
                                                        => x + c1 + c + y ;  -- BR 106.a
                                           _            => str }
          } ;   -- BR 105 in tempora other than Pres,Fut

         partMedFut = (adj2AO (paideys + "oy'menos") (paideys + "oyme'nhs")) ;
         partMedAor = (adj2AO (paideyS + "a'menos") (paideyS + "ame'nhs")) ;
         -- modify verb built with mkVerbW7voc by modification with soundlaw nC e.a. where needed:
     in  
        { act = table { Fin (VAor  VInd)  n p => case <n,p> of {
                             <Sg,_> | <Pl,P3> => epai'deys + actAorInd n p ;
                                      <Dl,P3> => epaideys  + actAorInd n p ;
                                      _       => epaidey's + actAorInd n p } ;  
                        Fin (VAor  VConj) n p => paidey'S + actPresConj n p ;   
                        Fin (VAor  VOpt)  n p => case <n,p> of {
                                      <Dl,P3> => paideyS  + actAorOpt n p ;     
                                      _       => paidey'S + actAorOpt n p } ;     
                        Fin (VFut FInd) n p   => paideys + (actFutInd n p) ;     -- BR 104.1
                        Fin (VFut FOpt) n p   => paideys + (actFutOpt n p) ;     -- BR 104.1
                        Fin (VPerf mod) n p => nC (verb.act ! (Fin (VPerf mod) n p)) ; 
                        Fin VPlqm n p       => nC (verb.act ! (Fin VPlqm n p)) ; -- BR 105.a
                        Inf GFut            => paideys + "ei~n" ;    -- BR 104.1
                        Inf GPerf           => nC (verb.act ! (Inf GPerf)) ;     -- BR 105.a
                        -- TODO: Imp GAor Act SgP2 accent a)'ggeil-on|ai, fh~non
                        Part GPerf af       => nC (verb.act ! Part GPerf af) ;   -- nC by BR 105.a 
                        -- TODO: Part GFut: -w~n, -oy~ntos BR 104.3
                        form                => verb.act ! form } ;
          med = table { Fin (VFut FInd) n p => paideys + (medFutInd n p) ;       -- BR 104.1
                        Fin (VFut FOpt) n p => paideys + (medFutOpt n p) ;       -- BR 104.1
                        Fin (VPerf VInd) Pl P3 -- BR 106.1 a (TODO gender agreement: Neutr "e)sti'")
                                            => nC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                        Fin (VPerf mod) n p => nC (verb.med ! (Fin (VPerf mod) n p)) ;
                        Fin VPlqm Pl P3        -- BR 106.1 a (TODO gender agreement, Neutr "h)~n")
                                            => nC (verb.med ! (Part GPerf (AF Masc Pl Nom)))++"h)~san" ; 
                        Fin VPlqm n p       => nC (verb.med ! (Fin VPlqm n p)) ;
                        Imp IPerf np        => nC (verb.med ! (Imp IPerf np)) ; 
                        Inf GFut            => paideys + "ei~svai" ; -- BR 104.1
                        -- Inf GPerf: change Wvoc+~stai to nC(Wliq'+(s)tai):
                        Inf GPerf           => a2 (nC (dA (verb.med ! (Inf GPerf)))) ; -- BR 106.1 a
                        Part GFut af        => partMedFut.s ! af ;
                        Part GAor af        => partMedAor.s ! af ;
                        Part GPerf af       => nC (verb.med ! (Part GPerf af)) ;  -- BR 105.a
                        form                => verb.med ! form } ;   -- BR 104.1,3
          pass = table { Fin (VPerf VInd) Pl P3 -- BR 101 b  (TODO gender agreement: Neutr "e)sti'")
                                             => nC (verb.pass ! (Part GPerf (AF Masc Pl Nom)))++"ei)si'" ; 
                         Fin (VPerf mod) n p => nC (verb.pass ! (Fin (VPerf mod) n p)) ;
                         Fin VPlqm n p       => nC (verb.pass ! (Fin VPlqm n p)) ;
                         Imp IPerf np        => nC (verb.pass ! (Imp IPerf np)) ; 
                         Inf GPerf           => a2 (nC (dA (verb.pass ! (Inf GPerf)))) ; -- BR 106.1 a
                         Part GPerf af       => nC (verb.pass ! (Part GPerf af)) ;  -- BR 105.a
                         form                => verb.pass ! form } ;
          vadj1 : Adj = verb.vadj1 ; 
          vadj2 : Adj = verb.vadj2 ;
          vtype = VFull ;
        } ;
          

-- Deponents: verbs without active forms. 
-- STATUS: partial, some forms missing, no sound laws used yet.

-- Deponentia passiva: the aorist uses the passive forms (-vhn), 
-- the future uses medium (-somai) or passive (-vh-somai) forms                BR 117

   -- We store the forms in the med-field.

   -- cc mkVerbDepPass "ai)de'omai" "ai)de'somai" "h|)de'svhn" "h|)'desmai" 
   -- cc mkVerbDepPass "h('domai" "h(svh'somai" "h('svhn" "h('desmai" 

   mkVerbDepPass : (MedPresInd, MedOrPassFut, PassAorInd, MedPerfInd: Str) -> Verb = 
                   \paidey'omai, paidey'somai, epaidey'vhn, pepai'deymai -> 
      let
          med : Vform => Str = mkMedW paidey'omai paidey'somai epaidey'vhn pepai'deymai ; 
          epaidey'v = P.tk 2 epaidey'vhn ;
          epaideyv  = dA epaidey'v ;
          paidey'v  = unaugment epaidey'v ;
          paideyv   = dA paidey'v ;
          paidey    = dA (P.tk 4 paidey'omai) ;
      in 
         { act = table { _ => nonExist } ; 
           med = med ;
           pass = table { -- only the forms differing from medium: (copy from mkVerbW)
              Fin (VFut FInd)   n p => case <n,p> of {
                   <Dl,P2> |<Dl,P3> => paidey'v + passFutInd n p ;    
                                  _ => paideyv  + passFutInd n p } ;  
              Fin (VFut FOpt)   n p => case <n,p> of {
                   <_,P1> | <Dl,P3> => paideyv + "hs"  + medPresOpt n p ;
                                  _ => paideyv + "h's" + medPresOpt n p } ;
              Fin (VAor  VInd)  n p => case <n,p> of {
                            <Dl,P3> => epaideyv  + passAorInd n p ;   
                                  _ => epaidey'v + passAorInd n p } ; 
              Fin (VAor  VConj) n p => paideyv   + passAorConj n p ;  
              Fin (VAor  VOpt)  n p => paideyv   + passAorOpt n p ;   
              Fin tmpMod        n p => med ! (Fin tmpMod n p) ;
              Imp IPres n_p         => "TODO" ;
              Imp IAor  n_p         => "TODO" ;
              Imp IPerf n_p         => nonExist ;
              Inf GFut => paideyv + "h'sestai" ;
              Inf GAor => paideyv + "h~nai" ; 
              Inf tmp  => med ! (Inf tmp) ; 
              Part GFut af => med ! (Part GFut af) ++ "TODO: -vh-somenos" ;
              Part GAor af => med ! (Part GAor af) ++ "TODO: -eis" ;
              Part tmp af => med ! (Part tmp af) 
            } ;
           vadj1 : Adj = adjAO (paidey + "to's") ; 
           vadj2 : Adj = adjAO (paidey + "te'os") ;
           vtype = DepPass 
         } ; 

-- Deponentia media: the aorist and future use the medium forms (-sa'mhn,-somai).
-- There may additionally be a passive aorist and future (with passive meaning). BR 118 

-- mkVerbDepMed : (MedPresInd, MedFut, MedAorInd, MedPassPerfInd : Str) -> Verb = 
--               \ma'comai, macoy'mai, emacesa'mhn, mema'chmai ->

   mkVerbDepMed : (MedPresInd, MedFut, MedAorInd, MedPerfInd: Str) -> Verb = 
                   \paidey'omai, paidey'somai, epaideysa'mhn, pepai'deymai -> 
-- cc -unqual mkVerbDepMed "vea'omai" "vea_'somai" "e)vea_sa'mhn" "teve'amai" ;
      let
          med : Vform => Str = mkMedW paidey'omai paidey'somai epaideysa'mhn pepai'deymai ; 
          epaidey'vhn = a3 (P.tk 5 epaideysa'mhn) + "vhn" ;
          epaidey'v = P.tk 2 epaidey'vhn ;
          epaideyv  = dA epaidey'v ;
          paidey'v  = unaugment epaidey'v ;
          paideyv   = dA paidey'v ;
          paidey    = dA (P.tk 4 paidey'omai) ;
      in 
         { act = table { _ => "---" } ;
           med = med ; -- TODO: Part Perf af => pe-paidey-me'nos 
           pass = table { -- only the forms differing from medium: (copy from mkVerbW)
              Fin (VFut FInd)   n p => case <n,p> of {
                   <Dl,P2> |<Dl,P3> => paidey'v + passFutInd n p ;    
                                  _ => paideyv  + passFutInd n p } ;  
              Fin (VFut FOpt)   n p => case <n,p> of {
                   <_,P1> | <Dl,P3> => paideyv + "hs"  + medPresOpt n p ;
                                  _ => paideyv + "h's" + medPresOpt n p } ;
              Fin (VAor  VInd)  n p => case <n,p> of {
                            <Dl,P3> => epaideyv  + passAorInd n p ;   
                                  _ => epaidey'v + passAorInd n p } ; 
              Fin (VAor  VConj) n p => paideyv   + passAorConj n p ;  
              Fin (VAor  VOpt)  n p => paideyv   + passAorOpt n p ;   
              Fin tmpMod        n p => med ! (Fin tmpMod n p) ;
              Imp IPres n_p         => "TODO" ;
              Imp IAor  n_p         => "TODO" ;
              Imp IPerf n_p         => nonExist ;
              Inf GFut              => paideyv + "h'sestai" ;
              Inf GAor              => paideyv + "h~nai" ; 
              Inf tmp               => med ! (Inf tmp) ; 
              Part tmp af => med ! (Part tmp af) ++ "TODO" 
            } ;
           vadj1 : Adj = adjAO (paidey + "to's") ; 
           vadj2 : Adj = adjAO (paidey + "te'os") ;
           vtype = DepMed
         } ; 

{- 
--- far too slow: (or makes the machine hang) GF-compiler bug?
   mkVerbDepMed1a : Str -> Verb = \paidey'omai ->  -- sketch only
      case paidey'omai of { 
         stm + v@(#PhonoGrc.vowel) + acnt@("'"|"~"|"") + "omai" 
           => mkVerbDepMed paidey'omai (stm + v + acnt + "somai") 
                           (augment (stm+v) + "sa'mhn") (a2 (reduplicate (stm+v)) + "mai") ;
--         _ => mkVerbDepMed "vea'omai" "vea_'somai" "e)vea_sa'mhn" "teve'amai" 
         _ => P.error "not a dep.med" 
      } ;

-- much faster: 
   mkVerbDepMed1 : Str -> Verb = \paidey'omai ->  
      let mkForms : Str -> Str * Str * Str * Str = \paideyomai ->  -- sketch only, when 
          case paideyomai of {                                     -- stems ends in vowel
            stm + v@(#PhonoGrc.vowel) + acnt@("'"|"~"|"") + "omai" 
              => <paideyomai, (stm + v + acnt + "somai"),
                  (augment (stm+v) + "sa'mhn"),(a2 (reduplicate (stm+v)) + "mai")> ;
            _ => <"vea'omai", "vea_'somai", "e)vea_sa'mhn", "teve'amai"> } ;
--            _ => P.error "not a dep.med" } ;
          forms = mkForms paidey'omai
       in 
          mkVerbDepMed forms.p1 forms.p2 forms.p3 forms.p4 
      ;
-} 

-- TODO: prefix-verbs and reduplication: ap-e'comai 

   mkVerbDep : Str -> VType -> Verb = \paidey'omai,vt -> 
     -- assume given form ends in -omai 
     let paidey' = P.tk 4 paidey'omai ;
         paidey  = dA paidey' ;
         paidey'somai = paidey' + "somai" ; -- TODO: add sound laws 
         aor     = case vt of {DepMed   => (augment paidey)+"sa'mhn" ; 
                               _DepPass => (augment paidey')+"vhn" } ;
         perf    = a2 (reduplicate paidey) + "mai" ;
         fut     = paidey'somai ;
--          fut     = case vt of { DepMed  => paidey'somai ;
--                                _DepPass => paidey'somai 
--                                         | (paidey + "vh'somai") };  -- optionally 2 futs
     in 
     case vt of {DepMed  => mkVerbDepMed paidey'omai fut aor perf ;
                 DepPass => mkVerbDepPass paidey'omai fut aor perf ;
                 VFull   => P.error ("mkVerbDep: provided form does not end in -omai")
     } ;

-- ---------------------------------------------------------------------------------
--3 Mi-conjugation (almost ok for ti'vhmi, but wrong for i('hmi)

-- Smart Mi-conjuation: from P1 Sg Praes Ind, determine whether the verb's present stem
-- a) is formed from the root by reduplication (with i) of the prefix, as in di-dwmi,
-- b) is formed from the root by appending -ny- before the endings, as in deik-ny-mi
-- c) is the same as the verbal root, as in fh-mi, ei~-mi, ei-mi', crhnai=crh'+ei~nai, kei-mai

-- But why am I doing this? Just use the mkVerb*Mi7 function for the few mi-verbs! (and some
-- fiddling with the prefixverbs).

  mkVerbMi1 : Str -> Verb = \dei'knymi ->    
     case dei'knymi of {
       dei'kny + "mi" + ("'"|"") 
         => case dei'kny of { x + "ny" => mkVerbNyMi dei'knymi ;
                                     _ => case (reduplicatedPresent dei'knymi) of 
                                                  { True => mkVerbRedupMi1 dei'knymi ;
                                                       _ => mkVerbRootMi1 dei'knymi }      
                         } ;
       _ => P.error ("Not a -mi verb: " ++ dei'knymi) 
     } ;

  reduplicatedPresent : Str -> Bool = \str -> case str of {
       ("i"|"e") + "("+ (#Ph.accent|"") + "s" + y => True ;
       "i("+ #Ph.accent + "h" + y                 => True ;
       c@#Ph.consonant + "i" + (#Ph.accent|"") + d@#Ph.consonant + y => 
            case <c,d> of { <"p","f"> | <"t","v"> | <"c","k"> => True ; 
                            _ => case P.eqStr c d of {
                                        P.PTrue => True ; _ => False 
                                 }  -- BR 22 (partly)
            } ;
       _ => False } ;

  unreduplicatePresent : Str -> Str = \str -> case str of {
       ("i"|"e") + "("+ (#Ph.accent|"") + "s" + y => "s" + y ; -- i('sthmi
       "i("+ a@#Ph.accent + "h" + y               => "h" + "(" + a + y ; 
       c@#Ph.consonant + "i" + a@(#Ph.accent|"") + d@#Ph.consonant + y => 
           case a of {"~" => addAccent (Circum 2) (d + y) ; 
                      _   => addAccent (Acute 2)  (d + y) } ;
       _ => str } ;


  guessVerbstemsMi : Str -> Str * Str * Str * Str * Str * Str * Str = \dei'knymi ->   
     case dei'knymi of {
       x + "nymi" =>  
         let 
             dei'kny = P.tk 2 dei'knymi ;
             dei'k   = P.tk 2 dei'kny ; 
             e'deik  = a2 (augment (dA dei'k)) ;
             de'deik = a2 (reduplicate dei'k) ;
             mC : Str -> Str = Ph.mutaConsonant ;
         in  
              <dei'knymi, mC(dei'k+"sw"), mC(e'deik+"sa"), de'deik+"a", 
               mC(de'deik+"mai"), mC(e'deik+"vhn"), mC(dA dei'k +"to's*")> ;
       _ => 
       case reduplicatedPresent dei'knymi of {
              True => let 
                           di'dw = P.tk 2 dei'knymi ;
                           dw    = unreduplicatePresent di'dw ;
                           edw   = augment dw ;
                           dedw  = reduplicate dw ;
                           do    = Ph.ablaut dw ;
                           dedo  = Ph.ablaut dedw ;
                           edo   = augment do ;
                       in  <di'dw +"mi", dw+"sw", edw+"ka", dedw+"ka", 
                           dedo+"mai", edo+"vhn", (dA do)+"to's*"> ;
              _ => let 
                       fh : Str = case dei'knymi of { x + "mi" + ("'"|"") => x ; _ => dei'knymi } ;
                       efh  = augment fh ;
                       pefh = reduplicate fh ;
                       efa  = Ph.ablaut efh ;
                       fa   = Ph.ablaut fh ;
                   in <fh+"mi", fh+"sw", efh+"sa", pefh+"ka", 
                       pefh+"mai", efa+"vhn", fa+"to's*"> 
            }
     } ;


-- BR 135 a)
-- cc mkVerbstemsMi "dei'knymi"   -- ok 
-- cc mkVerbstemsMi "zey'gnymi"   -- ok
-- cc mkVerbstemsMi "mei'gnymi"   -- ok
-- cc mkVerbstemsMi "ph'gnymi"    -- Act ok, Med/Pass ph'gnymai
-- cc mkVerbstemsMi "r(h'gnymi"   -- Act ok, Med/Pass r(h'nymai
-- cc mkVerbstemsMi "kera'nnymi"  -- Bad
-- cc mkVerbstemsMi "krema'nnymi" -- Poor
-- cc mkVerbstemsMi "peta'nnymi"  --    Need: soundlaws
-- cc mkVerbstemsMi "skeda'nnymi" --    a'nsw > a_'sw > a_'w > w~

  mkVerbNyMi1 : Str -> Verb = \dei'knymi ->    
     let 
         dei'knu = P.tk 2 dei'knymi ;   
         dei'k : Str = case dei'knu of { x + "ny" => x ; _ => dei'knu } ;
         e'deik  = a3 (augment (dA dei'k)) ;
         de'deik = a2 (reduplicate dei'k) ;
         mC : Str -> Str = Ph.mutaConsonant ;
     in  
         mkVerbNyMi7 (dei'knymi) (mC (dei'k+"sw")) (mC (e'deik+"sa")) (de'deik+"a")   -- de'deica TODO
                     (mC (de'deik+"mai")) (mC (e'deik+"vhn")) (dA dei'k +"to's*") ;

-- 
-- cc -unqual mkVerbNyMi7 "dei'knymi" "dei'xw" "e)'deixa" "de'deica" 
--                        "de'deigmai" "e)dei'cvhn" "deikt'os"


  mkVerbRedupMi1 : Str -> Verb = 
    \di'dwmi -> -- P.error ("Presumably a -mi verb with reduplicated present stem: " ++ didwmi) ;
     let 
          di'dw = P.tk 2 di'dwmi ;
          dw' = unreduplicatePresent di'dw ;
          do' = Ph.ablaut dw' ;
          e'dw = a3 (augment dw') ;
          de'dw = a3 (reduplicate dw') ;
          de'do = Ph.ablaut de'dw ;
          edo' = a3 (Ph.ablaut (P.drop 1 e'dw)) ;
      in mkVerbRedupMi di'dwmi (dw'+"sw") (e'dw+"ka") 
                       (de'dw+"ka") (de'do+"mai") (edo'+"vhn") (dA do'+"to's*") ;


  mkVerbNyMi : Str -> Verb = 
    \dei'knymi -> -- P.error ("Presumably a -nymi verb: " ++ dei'knymi) ;
     let 
         dei'knu : Str = case dei'knymi of { x + "mi'" => x ; _ => P.tk 2 dei'knymi } ;
         dei'k : Str = case dei'knu of { x + "ny" => x ; _ => dei'knu } ;
         e'deik = a3 (augment (dA dei'k)) ;
         de'dei = a2 (reduplicate (P.tk 1 dei'k)) ;
     in  
         mkVerbRedupMi (dei'knymi) (dei'k+"sw") (e'deik+"sa") 
                       (de'dei+"ka") (de'dei+"g"+"mai") (e'deik+"x"+"vhn") 
                       (dA dei'k +"to's*") ;

  mkVerbRootMi1 : Str -> Verb = 
    \fhmi' -> P.error ("Presumably a -mi verb with verbal root as present stem: " ++ fhmi') ;


-- Active endings: (no thematic vowel added to present stem)  
   actPresIndMi = endingsV <"mi", "s*", "si", "men", "te", "a_si", "ton", "ton"> ;
   actPresOptMi = endingsV <"n", "s*", "", "men", "te", "en", "ton", "thn"> ;
   actImpfIndMi = endingsV <"n", "s*", "", "men", "te", "san", "ton", "thn"> ;

   actAorIndMi  = endingsV <"", "s*", "e", "men", "te", "san", "ton", "thn"> ; -- HL
   actPerfIndMi = endingsV <"a", "as*", "e", "amen", "ate", "asi", "aton", "aton"> ;
   actPlqmIndMi = endingsV <"ein", "eis*", "ei", "emen", "ete", "esan", "eton", "e'thn"> ; 

   actPresImpMi = endingsImp <"i","tw","te","ntwn"> ;  -- <""|"vi","tw","te","ntwn"> BR 82 c
   actAorImpMi  = endingsImp <"s*","tw","te","ntwn"> ;

-- Medium endings:
   medPresIndMi = endingsV <"mai", "sai", "tai", "meva", "sve", "ntai", "svon", "svon"> ;
   medPresConjMi= endingsV <"mai", "|", "tai", "meva", "sve", "ntai",   "svon", "svon"> ;
   medPresOptMi = endingsV <"mhn", "o",  "to", "meva", "sve", "nto",  "svon", "svhn"> ;
   medImpfIndMi = endingsV <"mhn", "so", "to", "meva", "sve", "nto",  "svon", "svhn"> ;
   medAorIndMi  = endingsV <"mhn", "",   "to", "meva", "sve", "nto",  "svon", "svhn"> ;

   medPerfIndMi = endingsV <"mai", "sai", "tai", "meva", "sve", "ntai", "svon", "svon"> ;
   medPerfConjMi = 
          endingsV <"w)~", "h|)~s", "h|)~", "w)~men", "h)~te", "w)~si", "svon", "svon"> ;  
   medPerfOptMi = 
    endingsV <"ei)'hn", "ei)'hs", "ei)'h", "ei)~men", "ei)~te", "ei)~en", "svon","svhn"> ; 
   medPlqmIndMi = endingsV <"mhn", "so", "to", "meva", "sve", "nto", "svon", "svhn"> ;

-- Passive endings:
   passFutIndMi = endingsV <"h'somai","h'sh|","h'setai","hso'meva","h'sesve","h'sontai",
                          "h~svon","h~svon"> ; 
   passAorIndMi = endingsV <"hn","hs*","h","hmen","hte","hsan","hton","h'thn"> ;
   passAorConjMi= endingsV <"w~","h|~s*","h|~","w~men","h~te","w~si","h~ton","h'thn"> ;
   passAorOptMi = endingsV <"ei'hn","ei'hs*","ei'h","ei~men","ei~te","ei~en","ei~ton","ei'thn"> ;

--   passAorImp = endingsImp <"vhti","vh'tw","vhte","ve'ntwn"> ;


-- b) Mi-verbs with reduplication in the present tense                      BR 129 

-- cc -unqual mkVerbRedupMi "di'dwmi" "dw'sw" "e)'dwka" "de'dwka" "de'domai" "e)do'vhn" "doto's*" 

   mkVerbRedupMi : (ActPresInd, ActFut, ActAor, ActPerf, 
               MedPerf, PassAor, VAdj1 : Str) -> Verb = 
--   \paideyw, paideysw, epai'deysa, pepai'deyka, pepaideymai, epaideyvhn, paideytos ->
     \di'dwmi, dw'sw,    e'dwka,     de'dwka,     de'domai,    edo'vhn,    doto's    ->
     let 
         mC : Str -> Str = Ph.mutaConsonant ;
         cV : Str -> Str = Ph.contractVowels ;
         dropS : Str -> Str = \str -> 
             case str of { x + "o'so" => x + "oy~" ; 
                           x + "oso"  => x + "oy" ; 
                           x + "e'so" => x + "oy~" ; 
                                    _ => str } ;
         -- verbal stem:
         dw'   = P.tk 2 dw'sw ;     -- VAct (_ VInd) Sg
         dw    = dA dw' ;
         do'   = Ph.ablaut dw' ;    -- VAct (_ VInd) Pl ; VMed|Pass _ _ 
         do    = dA do' ;

         -- present stem: didw, dido   (reduplicated)
         di'dw = P.tk 2 di'dwmi ;   
         didw  = dA di'dw  ;   

         di'do = Ph.ablaut di'dw ;    
         dido  = dA di'do ;
         dido' = a3 dido ;

         edi'do = augment di'do ;
         edido  = dA edi'do ;
         edidw  = augment didw ;

         -- future stem:  dw's
         dw's = P.tk 1 dw'sw ;    
         dws  = dA dw's ;
         do's = Ph.ablaut dw's ;

         -- act|med aorist stem: e'dwk
         e'dwk = P.tk 1 e'dwka ; -- epai'dey
         edwk  = dA e'dwk ;
         edw'k = a3 edwk ;
         edo   = Ph.ablaut(P.tk 1 edwk) ;
         e'do  = a2 edo ;
         edo'  = a3 edo ;

         -- act perfect stem: de'dwk = pepaideyk         -- weak/strong: k/-
         de'dwk = P.tk 1 de'dwka ;
         dedwk  = dA de'dwk ;
         dedw'k = a3 dedwk ;
         ede'dwk = augment de'dwk ;
         ededwk  = augment dedwk ;
         ededw'k = augment dedw'k ;

         -- med|pass perfect stem: dedo = pepaidey
         de'do = P.tk 3 de'domai ;
         dedo  = dA de'do ;
         dedo' = a3 dedo ;
         ededo = augment dedo ;

         -- pass aorist stem: do-v = epaideyv          -- weak/strong: v/-
         dov   = unaspirate (mC (do + "v")) ;          --      strong??
         edov  = augment dov ; 
         edo'v = a3 edov ;

         -- verbal adjective: do-tos = paidey-tos      -
         dote'os : Str = case doto's of { dot + ("o's"|"o's*") => dot + "e'os*" 
                                                           ; _ => doto's } ;    -- Error
         -- participles
         partActPres = (adj3nt (di'dw       + "wn") (di'dw       + "ontos")) ;
         partActFut  = (adj3nt (di'dw + "s" + "wn") (di'dw + "s" + "ontos")) ;
         partActAor  = (adj3nt (di'dw + "sa_s")     (di'dw + "sa" + "ntos")) ;
         partActPerf = (adj3nt (dedwk + "w's")      (dedwk + "o'tos")) ; -- TODO fem kuia

         partMedPres = (adj2AO (dido' + "menos") (dido + "me'nhs")) ; -- check
         partMedFut  = (adj2AO (dws + "o'menos") (dws + "ome'nhs")) ; -- check
         partMedAorPerf = (adj2AO (dws + "o'menos") (dws + "ome'nhs")) ; -- check 

         -- to share most of the medium table with passive:
         med = table { 
             Fin (VPres VInd)  n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => dido' + medPresIndMi n p ;
                           _       => di'do + medPresIndMi n p } ;
             Fin (VPres VConj) n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => cV(dido + medPresConj n p) ;
                                 _ => cV(dido' + medPresConj n p) } ;
             Fin (VPres VOpt)  n p => case <n,p> of {
                 <Sg,P1> | <Pl,P1> 
                         | <Dl,P3> => dido+"i'" + medPresOptMi n p ;
                            _      => dido+"i~" + medPresOptMi n p } ;
             Fin VImpf n p         => case <n,p> of {       -- todo                        
                  <_,P1> | <Dl,P3> => a3 edido + medImpfIndMi n p ;
                            _      => edi'do + medImpfIndMi n p } ;
             Fin (VFut FInd)   n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => dws  + medPresInd n p ;
                                 _ => dw's + medPresInd n p } ;
             Fin (VFut FOpt)   n p => case <n,p> of {
                  <_,P1> | <Dl,P3> => dws  + medPresOpt n p ;
                                 _ => dw's + medPresOpt n p } ;
             Fin (VPerf VInd)  n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => toCircumflex(dedo' + medPerfIndMi n p) ;
                                 _ => mC(de'do + medPerfIndMi n p) } ;
             Fin (VPerf VConj) n p => dedo + (menos n) ++ medPerfConjMi n p ;
             Fin (VPerf VOpt)  n p => dedo + (menos n) ++ medPerfOptMi n p ;
             Fin (VAor  VInd)  n p => case <n,p> of {
                 <Sg,P1> | <Pl,P1> | 
                 <Dl,P1> | <Dl,P3> => a3 edo + medAorIndMi n p ;     -- TODO i/y-stems use thematic conj
                                 _ => a2 edo + medAorIndMi n p } ;   -- BR 128 3 ??
             Fin (VAor  VConj) n p => case <n,p> of {
                 <Pl,P1> | <Dl,P1> => cV(do + medPresConj n p) ;
                                 _ => cV(do' + medPresConj n p) } ;
             Fin (VAor  VOpt)  n p => case <n,p> of {  
                  <_,P1> | <Dl,P3> => do + "i'" + medPresOptMi n p ;
                                 _ => do + "i~" + medPresOptMi n p } ;
             Fin VPlqm n p         => case <n,p> of {
                  <_,P1> | <Dl,P3> => a3 ededo + medPlqmIndMi n p ;  -- TODO accents
                                 _ => mC(a2 ededo + medPlqmIndMi n p) } ;
             Imp IPres np          => case np of {
                       SgP2 | PlP2 => di'do + medPerfImp np ;
                                 _ => dido' + medPerfImp np } ;
             Imp IAor np           => dropS (do' + medPerfImp np) ;
             Imp IPerf np          => case np of { 
                       SgP2 | PlP2 => dropS (mC (a2 dedo + medPerfImp np)) ;  -- dedeigso => xo
                                 _ => a3 dedo + medPerfImp np } ;
             -- infinite forms:
            Inf GPres => di'do + "svai" ;
            Inf GFut  => dw' + "se" + "svai" ;  
            Inf GAor  => do' + "svai"; 
            Inf GPerf => de'do + "svai" ;    -- perfekt-stem keinai?
            --
            Part GPres af => partMedPres.s ! af ;  
            Part GFut  af => partMedFut.s ! af ; 
            Part (GAor | GPerf) af => partMedAorPerf.s ! af 
           } ;
     in  
        { act = table { 
            Fin  (VPres VInd)  n p => case <n,p> of {
                            <Sg,_> => di'dw + actPresIndMi n p ;
                           <Pl,P3> => dido' + actPresIndMi n p ;         
                                 _ => di'do + actPresIndMi n p } ;         
            Fin  (VPres VConj) n p => cV(a3 didw + actPresConj n p) ;  -- cV: BR 128 3      
            Fin  (VPres VOpt)  n p => case <n,p> of { 
                           <Sg,_ > => dido+"i'h" + actPresOptMi n p ; 
                           <Dl,P3> => dido+"i'"  + actPresOptMi n p ; 
                           _       => dido+"i~"  + actPresOptMi n p } ;       
            Fin  VImpf n p         => case <n,p> of {                  -- Sg differs for the
                            <Sg,_> => edi'do + (case P.dp 1 edi'do of  -- 'big' mi-verbs!
                                                 {"e" => "i" ; "o" => "y" ; _ => ""})
                                             + actImpfIndMi n p ;        
                           <Dl,P3> => a3 edido + actImpfIndMi n p ;        
                                 _ => edi'do + actImpfIndMi n p } ;   
            Fin  (VFut FInd) n p   => case n of {                        
                                Sg => dw's + actPresInd n p ;
                                _  => do's + actPresInd n p } ;          -- Pl do' BR 128 2
            Fin  (VFut FOpt) n p   => case <n,p> of {
                           <Dl,P3> => dws  + actPresOpt n p ;   
                           _       => dw's + actPresOpt n p } ;          -- -o-i_ why o?
            Fin  (VPerf VInd)  n p => case n of {
                                Sg => de'dwk + actPerfIndMi n p ;
                                _  => dedw'k + actPerfIndMi n p } ;
            Fin  (VPerf VConj) n p => dedw'k + actPresConj n p ;
            Fin  (VPerf VOpt)  n p => case <n,p> of {
                           <Dl,P3> => dA de'dwk + actPresOpt n p ;
                           _       => dedw'k + "oi" + actPresOptMi n p } ; -- oi-h ??
            Fin  (VAor  VInd)  n p => case <n,p> of {
                           <Sg,P3> => e'dwk + actAorIndMi n p ;
                           <Sg, _> => e'dwk + "a" + actAorIndMi n p ;
                           <Dl,P3> => a3 edo + actAorIndMi n p ;
                           _       => e'do  + actAorIndMi n p } ;  
            Fin  (VAor  VConj) n p => cV(do' + actPresConj n p) ;        -- cV BR 128.3
            Fin  (VAor  VOpt)  n p => case <n,p> of {
                           <Sg,_ > => cV(do + "i'h") + actPresOptMi n p ;  
                           <Dl,P3> => cV(do + "i'")  + actPresOptMi n p ;     
                           _       => cV(do + "i~")  + actPresOptMi n p } ;     
            Fin  VPlqm n p         => case <n,p> of {
                           <Dl,P3> => ededwk  + actPlqmIndMi n p ;
                           _       => ededw'k + actPlqmIndMi n p } ;
            Imp IPres np           => case np of { 
                                        SgP2 | PlP2 => di'do ;
                                                  _ => dido' } + actPresImpMi np ;
            Imp IAor  np           => do' + actAorImpMi np ;        
            Imp IPerf np           => "---" ;
            -- Accents in infinite verb forms: BR 88 
            Inf GPres => dido' + "nai" ;
            Inf  GFut => dw' + "nai" ;
            Inf  GAor => addAccent (Circum 2) (cV (do + "enai")) ; -- BR 130 c
            Inf GPerf => dedwk + "e'nai" ;
            --
            Part GPres af => partActPres.s ! af ;
            Part GFut  af => partActFut.s ! af ;
            Part GAor  af => partActAor.s ! af ;
            Part GPerf af => partActPerf.s ! af  
            } ;
          med = med ;
          pass = table { -- just the difference to the medium
            Fin (VFut FInd)   n p => case <n,p> of {
                <Dl,P2> | <Dl,P3> => dov + passFutIndMi n p ;      
                                _ => dov + passFutIndMi n p } ;    
            Fin (VFut FOpt)   n p => case <n,p> of {
                 <_,P1> | <Dl,P3> => dov + "hs" + medPresOpt n p ;
                                _ => dov + "h's" + medPresOpt n p } ;
            Fin (VAor  VInd)  n p => case <n,p> of {                    
                          <Dl,P3> => edov + passAorIndMi n p ;   
                                _ => edo'v + passAorIndMi n p } ;  
            Fin (VAor  VConj) n p => dov + passAorConjMi n p ;   
            Fin (VAor  VOpt)  n p => dov + passAorOptMi n p ;    
            Fin tmod n p          => med ! (Fin tmod n p) ;
            Imp IAor np           => case np of {
                      SgP2 | PlP2 => di'dw ;
                                _ => didw } + passAorImp np ;
            Imp itmp np           => med ! (Imp itmp np) ;
            Inf GFut => dov + "h'" + "se" + "svai" ;
            Inf GAor => dov + "h~" + "nai" ; 
            Inf tmp  => med ! (Inf tmp) ; -- GPres => di'do + "svai" ;
                                          -- GPerf => de'do + "svai" 
            Part tmp af => med ! (Part tmp af) 
                } ;
         vadj1 : Adj = adjAO doto's ;
         vadj2 : Adj = adjAO dote'os ;
         vtype = VFull 
        } ;

-- TODO: nymi-verbs: combine present stem forms of mi-verbs with other forms of w-verbs

   mkVerbNyMi7 : (s1,_,_,_,_,_,s7 : Str) -> Verb =
     \dei'knymi, dei'xw, e'deixa, de'deica, de'deigmai, edei'cvhn, deikto's ->
     let       -- EXPENSIVE: 
         vmi = mkVerbRedupMi dei'knymi  dei'xw e'deixa de'deica de'deigmai edei'cvhn deikto's ;
         vw  = mkVerbW7voc  dei'knymi  dei'xw e'deixa de'deica de'deigmai edei'cvhn deikto's ;

         dei'kny = P.tk 2 dei'knymi ;             -- present stem
         deikny  = dA dei'kny ;
         deikny' = a3 deikny ;
     in 
       { act = table { Fin  (VPres VOpt) n p => case <n,p> of {
                                     <Dl,P3> => deikny  + actPresOpt n p ;
                                     _       => deikny' + actPresOpt n p } ;
                       Fin  (VPres mod) n p  => vmi.act ! (Fin (VPres mod) n p) ;
                       Fin  VImpf n p        => vmi.act ! (Fin VImpf n p) ;
                       Inf form              => vmi.act ! (Inf form) ;
                       Part GPres af => vmi.act ! (Part GPres af) ;   -- TODO
                       Part GFut  af => vmi.act ! (Part GFut af) ;
                       Part GAor  af => vmi.act ! (Part GAor af) ;
                       Part GPerf af => vw.act  ! (Part GPerf af) ;
                       else => vw.act ! else } ;
         med = table { Fin  (VPres VOpt) n p => case <n,p> of {
                           <Sg,P1> | <Pl,P1> 
                                   | <Dl,P3> => deikny  + medPresOpt n p ;
                                      _      => deikny' + medPresOpt n p } ;
                       Fin  (VPres mod) n p  => vmi.med ! (Fin (VPres mod) n p) ;
                       Fin  VImpf n p        => vmi.med ! (Fin VImpf n p) ;
                       Fin  (VPerf mod) n p  => vmi.med ! (Fin (VPerf mod) n p) ; -- ?
                       Fin  VPlqm n p        => vmi.med ! (Fin VPlqm n p) ;       -- ?
                       Imp itmp np           => vmi.med ! (Imp itmp np) ; -- ?
                       Inf form              => vmi.med ! (Inf form) ;
                       Part tmp af           => vw.med ! (Part tmp af) ; -- guessed, TODO
                       else => vw.med ! else } ;
         pass = table { Part tmp af          => vw.pass ! (Part tmp af) ;-- TODO
                        form                 => vmi.pass ! form } ;      -- GUESSED
         vadj1 = vw.vadj1 ;                  
         vadj2 = vw.vadj2 ;            
         vtype = VFull ;
       } ;      

-- c) Mi-verbs which have the verbal root as present stem: TODO fhmi', ei)~mi, ei)mi'    BR 138

   mkVerbEimi : (s1,_,_,_,_,_,s7 : Str) -> Verb =
     \dei'knymi, dei'xw, e'deixa, de'deica, de'deigmai, edei'cvhn, deikto's ->
     let       -- EXPENSIVE: 
         vw  = mkVerbW7voc  dei'knymi  dei'xw e'deixa de'deica de'deigmai edei'cvhn deikto's ;

         dei'kny = P.tk 2 dei'knymi ;             -- present stem
         deikny  = dA dei'kny ;
         deikny' = a3 deikny ;
     in -- BR 138
       { act = table { Fin  (VPres VInd) Sg P1 => "ei)mi'" ;
                       Fin  (VPres VInd) Sg P2 => "ei)~"   ;
                       Fin  (VPres VInd) Sg P3 => "e)sti'n" ;
                       Fin  (VPres VInd) Pl P1 => "e)sme'n" ;
                       Fin  (VPres VInd) Pl P2 => "e)ste'"  ;
                       Fin  (VPres VInd) Pl P3 => "ei)si'n" ;
                       Fin  (VPres VInd) Dl P1 => "e)sme'n" ;
                       Fin  (VPres VInd) Dl p  => "ei)'eton" ;  -- HL
                       Fin  (VPres VConj) Sg P1 => "w)~" ;
                       Fin  (VPres VConj) Sg P2 => "h|)~s*" ;
                       Fin  (VPres VConj) Sg P3 => "h|)~" ;
                       Fin  (VPres VConj) Pl P1 => "w)~men" ;
                       Fin  (VPres VConj) Pl P2 => "h)~te"  ;
                       Fin  (VPres VConj) Pl P3 => "w)~sin" ;
                       Fin  (VPres VOpt) Sg p => "ei)'h" + actPresOptMi Sg p ;
                       Fin  (VPres VOpt) n p  => "ei)~"  + actPresOptMi n p  ;
                       Fin  VImpf Sg P2       => "h)~"   + "sva" ;
                       Fin  VImpf Sg P3       => "h)~"   + "n" ;
                       Fin  VImpf n p         => "h)~"   + actImpfIndMi n p ;

                       Fin  (VFut FInd) Sg P3 => "e)'s" + "tai" ;
                       Fin  (VFut FInd) Pl P1 => "e)s" + medPresInd Pl P1 ;
                       Fin  (VFut FInd) Dl P1 => "e)s" + medPresInd Dl P1 ;
                       Fin  (VFut FInd) n p   => "e)'s" + medPresInd n p ;
                       Fin  (VFut FOpt) Pl P1 => "e)s" + medPresOpt Pl P1 ;
                       Fin  (VFut FOpt) Dl P1 => "e)s" + medPresOpt Dl P1 ;
                       Fin  (VFut FOpt) n p   => "e)'s" + medPresOpt n p ;
                       Inf GPres              => "ei)~nai" ;
                       Inf GFut               => "e)'sesvai" ;
                       Inf form               => vw.act ! (Inf form) ;
--                       Part GPres af => (adj3nt (cV "w)'n") (cV "o)'ntos*")).s ! af ;  
                       Part GFut  af => (adj3nt ("e)'s" + "wn") ("e)'s" + "ontos")).s ! af ;   
                       Part GAor  af => (adj3nt ("gene's" + "a_s") ("genes" + "a'ntos")).s ! af ;   
                       Part GPerf af => "---" ;
                       Imp IPres SgP2 => "i)'svi" ;
                       Imp IPres SgP3 => "e)'stw" ;
                       Imp IPres PlP2 => "e)'ste" ;
                       Imp IPres PlP3 => "e)'stwn" ;
                       else => vw.act ! else } ;  -- imports wrong forms
         med  = table { _ => "---" } ;
         pass = table { _ => "---" } ;
         vadj1 = { s = table { _ => "---" } ; adv = [] } ;
         vadj2 = { s = table { _ => "---" } ; adv = [] } ;
         vtype = VFull ;
       } ;      

--  vmi = mkVerbMi dei'knymi  dei'xw e'deixa de'deica de'deigmai edei'cvhn deikto's ;
--     eimi_V : Verb = -- just to have something 
--          mkVerbRedupMi "ei)mi'"  "e)'somai" "e)geno'mhn"  -- BR 138
--                  "de'deica" "de'deigmai" "e)dei'cvhn"  -- rubbish
--                  "deicto's*" ;                         -- rubbish

    eimi_V = mkVerbEimi "ei)m'" "e)'swmai" "e)geno'mhn" "ge'gona" "bla" "bla'vhn" "blato's" ;

-- For $Numeral$.

  Digit = {s : DForm => CardOrd => Str} ;

  -- TODO: check if adjAO is the proper inflection for ordinals
  
  cardOne : Gender * Case => Str =             
     table { <Masc, Nom> => "ei(~s*" ;        
             <Masc, Acc> => "e('na" ;
             <Masc|Neutr, Gen> => "e(no's*" ;
             <Masc|Neutr, Dat> => "e(ni'" ;
             < Fem, Nom> => "mi'a" ;
             < Fem, Acc> => "mi'an" ;
             < Fem, Gen> => "mia~s*" ;
             < Fem, Dat> => "mia|~" ;
             <Neutr, Nom|Acc> => "e('n" ;
             <_, Voc> => "e('ne"  -- HL
           } ;

  cardOrd : Str -> Str -> Str -> CardOrd => Str = \pente,pemptos,pentakis ->
    table {                                              -- BR 73                      
      NCard g c => case pente of { 
         -- special inflection for eis, dyo, treis, tettares BR 73.1, HL: Voc guessed 
         "ei(~s" => cardOne ! <g,c> ;
         "dy'o" => table Case ["dy'o" ; "dy'o" ; "dyoi~n" ; "dyoi~n" ; "dy'a" ] ! c ;
         "trei~s" => let forms : (Gender * Case) => Str =
                         table { < Masc|Neutr, Nom|Acc > => "trei~s" ;
                                 < Fem, Nom|Acc >        => "tri'a" ;
                                 < _ , Gen >             => "triw~n" ;
                                 < _ , Dat >             => "trisi'" ;
                                 < _ , Voc >             => "trei~s" } 
                     in forms ! <g,c> ;
         "te'ttares" => let forms : (Gender * Case) => Str =
                         table { < Masc|Neutr, Nom|Acc > => "te'ttares" ;
                                 < Fem, Nom|Acc >        => "te'ttara" ;
                                 < _ , Gen >             => "tetta'rw~n" ;
                                 < _ , Dat >             => "te'ttarsi" ;
                                 < _ , Voc >             => "te'ttare" } 
                     in forms ! <g,c> ;
         adj@(_ + "i") + "oi" 
                => (adjAO (adj+"os")).s ! AF g Pl c ;
         _      => pente 
         } ;  
      NOrd a => (adjAO pemptos).s ! a ;
      NAdv   => canonize pentakis 
    } ;

  cardOrdTeen : Str -> Str -> CardOrd => Str = \pentekaideka,pemptos ->
    let pentekaidekakis : Str  = case pemptos of {
                                   "tri'tos"   => "triskaideka'kis" ;
                                   "te'tartos" => "tetrakaideka'kis" ;
                                    _ => dA (P.tk 2 pentekaideka) + "ka'kis" 
                                 } ;  
        cardO : CardOrd => Str = cardOrd pentekaideka pemptos pentekaidekakis ;
        ordA  : AForm => Str = (adjAO pemptos).s ;
        deka  : AForm => Str = (adjAO "de'katos").s 
     in 
        table { NCard g c => cardO ! NCard g c ;
                NOrd a    => case pentekaideka of {
                               d@("e('n" | "dw'") + _ => (dA d) + deka ! a ;
                               _ => ordA ! a ++ "kai`" ++ deka ! a } ;
                NAdv      => canonize pentekaidekakis  
        } ;

  mkDigit : (x1,_,_,x4,x5 : Str) -> Digit =   
    -- three,thirteen,thirty,third,three-times
    \treis,treis_kai_deka,triakonta,tritos,tris ->  
    let triakostos : Str = 
          case triakonta of { "de'ka" => "de'katos" ;
                              triako + ("si" | "nta") => (dA triako)+"sto's" } ;
        triakontakis : Str = 
          case triakonta of { "de'ka" => "deka'kis" ;
                              eiko + "si" => dA eiko + "sa'kis" ;
                              triako + "nta" => (dA triako)+"nta'kis" } ;
        triakosi : Str = 
          case triakonta of { "de'ka"        => "e(kat" ;
                              eiko + "si"    => "diako'si" ;
                              triako + "nta" => (dA triako)+"'si" } 
     in {s = table {
               DUnit => cardOrd treis tritos tris ;
               DTeen => cardOrdTeen treis_kai_deka tritos;  
               DTen  => cardOrd triakonta triakostos triakontakis ;
               DHundred => case triakonta of {
                    "de'ka" => cardOrd "e(kato'n" "e(katosto's" "e(katonta'kis" ;
                     _      => cardOrd (triakosi + "oi") (dA triakosi + "osto's") 
                                                         (dA triakosi + "a'kis") }
             }
     } ;

  invNum : CardOrd = NCard Masc Nom ;

} ;


