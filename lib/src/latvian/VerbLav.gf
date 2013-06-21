--# -path=.:abstract:common:prelude

-- TODO: module relations.
-- VerbLav is included in many modules because of buildVerb.
-- It needs to be reallocated somehow to ResLav.or something similar.
-- Not so simple since morphology itself needs ResLav & friends.

concrete VerbLav of Verb = CatLav ** open
  StructuralLav,
  ParadigmsLav,
  ResLav,
  ParamX,
  Prelude
in {

flags

  optimize = all_subs ;
  coding = utf8 ;

lin

  -- Complementization rules

  -- V -> VP
  -- e.g. 'sleep'
  UseV v = {
    v        = v ;
    compl    = \\_ => [] ;
    voice    = Act ;
    leftVal  = v.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- VV -> VP -> VP
  -- e.g. 'want to run'
  ComplVV vv vp = {
    v        = vv ;
    compl    = \\agr => buildVP vp Pos VInf agr ;
    voice    = Act ;
    leftVal  = vv.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- VS -> S -> VP
  -- e.g. 'say that she runs'
  ComplVS vs s = {
    v        = vs ;
    compl    = \\_ => "," ++ vs.conj.s ++ s.s ;
    voice    = Act ;
    leftVal  = vs.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- VQ -> QS -> VP
  -- e.g. 'wonder who runs'
  ComplVQ vq qs = {
    v        = vq ;
    compl    = \\_ => "," ++ qs.s ;
    voice    = Act ;
    leftVal  = vq.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- VA -> AP -> VP
  -- e.g. '(they) become red'
  ComplVA va ap = {
    v        = va ;
    compl    = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    voice    = Act ;
    leftVal  = va.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- V2 -> VPSlash
  -- e.g. 'love (it)'
  SlashV2a v2 = {
    v        = v2 ;
    compl    = \\_ => [] ;   -- will be overriden
    voice    = Act ;
    leftVal  = v2.leftVal ;
    rightAgr = AgrP3 Sg Masc ;  -- will be overriden
    rightPol = Pos ;         -- will be overriden
    rightVal = v2.rightVal
  } ;

  -- V3 -> NP -> VPSlash
  -- e.g. 'give it (to her)'
  Slash2V3 v3 np = insertObjSlash
    (\\_ => v3.rightVal2.s ++ np.s ! (v3.rightVal2.c ! (fromAgr np.agr).num))
    {
      v        = v3 ;
      compl    = \\_ => [] ;  -- will be overriden
      voice    = Act ;
      leftVal  = v3.leftVal ;
      rightAgr = np.agr ;
      rightPol = np.pol ;
      rightVal = v3.rightVal1
    } ;
  -- FIXME: "vīrietis runā par ābolus ar sievieti" ("a man talks to a woman about apples")
  -- FIXME: the order of objects (?)
  -- FIXME: Slash2V3 = Slash3V3 (?)

  -- V3 -> NP -> VPSlash
  -- e.g. 'give (it) to her'
  Slash3V3 v3 np = insertObjSlash
    (\\_ => v3.rightVal2.s ++ np.s ! (v3.rightVal2.c ! (fromAgr np.agr).num))
    {
      v        = v3 ;
      compl    = \\_ => [] ;  -- will be overriden
      voice    = Act ;
      leftVal  = v3.leftVal ;
      rightAgr = np.agr ;
      rightPol = np.pol ;
      rightVal = v3.rightVal1
    } ;

  -- V2V -> VP -> VPSlash
  -- e.g. 'beg (her) to go'
  SlashV2V v2v vp = {
    v        = v2v ;
    compl    = \\agr => buildVP vp Pos VInf agr ;
    voice    = Act ;
    leftVal  = v2v.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos ;
    rightVal = v2v.rightVal
  } ;

  -- V2S -> S -> VPSlash
  -- e.g. 'answer (to him) that it is good'
  SlashV2S v2s s = {
    v        = v2s ;
    compl    = \\_ => "," ++ v2s.conj.s ++ s.s ;
    voice    = Act ;
    leftVal  = v2s.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos ;
    rightVal = v2s.rightVal
  } ;

  -- V2Q -> QS -> VPSlash
  -- e.g. 'ask (him) who came'
  SlashV2Q v2q qs = {
    v        = v2q ;
    compl    = \\_ => "," ++ qs.s ;
    voice    = Act ;
    leftVal  = v2q.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos ;
    rightVal = v2q.rightVal
  } ;

  -- V2A -> AP -> VPSlash
  -- e.g. 'paint (it) red'
  SlashV2A v2a ap = {
    v        = v2a ;
    compl    = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    voice    = Act ;
    leftVal  = v2a.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos ;
    rightVal = v2a.rightVal
  } ;

  -- VPSlash -> NP -> VP
  -- e.g. 'love it'
  ComplSlash vpslash np =
    let agr : Agreement = np.agr in {
      v        = vpslash.v ;
      {-
      compl    = \\agr => case vpslash.voice of {
        Act  => vpslash.rightVal.s ++ np.s ! (vpslash.rightVal.c ! (fromAgr agr).num) ;
        Pass => case vpslash.rightVal.c ! (fromAgr agr).num of {
          Nom => np.s ! (vpslash.rightVal.c ! Sg) ;
          _   => vpslash.rightVal.s ++ np.s ! (vpslash.rightVal.c ! (fromAgr agr).num)
        }
      } ++ vpslash.compl ! agr ;
      -}
      compl    = \\agr => vpslash.rightVal.s ++ 
                          np.s ! (vpslash.rightVal.c ! (fromAgr agr).num) ++ 
                          vpslash.compl ! agr ;
      voice    = vpslash.voice ;
      leftVal  = vpslash.leftVal ;
      rightAgr = np.agr ;
      rightPol = np.pol ;
      rightVal = vpslash.rightVal ;
    } ;

  -- VV -> VPSlash -> VPSlash
  -- e.g. 'want to buy'
  SlashVV vv vpslash = {
    v        = vv ;
    compl    = \\agr => buildVP vpslash Pos VInf agr ;
    voice    = Act ;
    leftVal  = vv.leftVal ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos ;
    rightVal = nom_Prep
  } ;

  -- V2V -> NP -> VPSlash -> VPSlash
  -- e.g. '-- beg me to buy'
  SlashV2VNP v2v np vpslash = insertObjSlash
    (\\_ => v2v.rightVal.s ++ np.s ! (v2v.rightVal.c ! (fromAgr np.agr).num))
    {
      v        = v2v ;
      compl    = \\agr => buildVP vpslash Pos VInf agr ;
      voice    = Act ;
      leftVal  = v2v.leftVal ;
      rightAgr = np.agr ;
      rightPol = np.pol ;
      rightVal = v2v.rightVal
    } ;

  -- Other ways of forming verb phrases

  -- VPSlash -> VP
  -- e.g. 'love himself'
  ReflVP vpslash = insertObjPre
    (\\agr => vpslash.rightVal.s ++ reflPron ! (vpslash.rightVal.c ! (fromAgr agr).num))
    vpslash ;

  -- Comp -> VP
  -- e.g. 'be warm'
  UseComp comp = {
    v        = mkV "būt" ;
    compl    = \\agr => comp.s ! agr ;
    voice    = Act ;
    leftVal  = Nom ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
  } ;

  -- V2 -> VP
  -- e.g. 'be loved'
  PassV2 v2 = {
    v        = v2 ;
    compl    = \\_ => [] ;
    voice    = Pass ;
    leftVal  = v2.rightVal.c ! Sg ;
    rightAgr = AgrP3 Sg Masc ;
    rightPol = Pos
    --rightVal = mkPrep v2.leftVal
  } ;
  -- TODO: val - should not be overriden in ComplSlash etc.?
  -- TODO: val - P3 Sg Masc restriction - never used?
  -- TODO: notestēt objNeg (kur tas tiek pārrakstīts - ComplSlash, AdvVP u.c.?)

  -- VP -> Adv -> VP
  -- e.g. 'sleep here'
  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

  -- AdV -> VP -> VP
  -- e.g. 'always sleep'
  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

  -- TODO: AdvVPSlash : VPSlash -> Adv -> VPSlash
  -- e.g. 'use (it) here'

  -- TODO: AdVVPSlash : AdV -> VPSlash -> VPSlash
  -- e.g. 'always use (it)'

  -- VP -> Prep -> VPSlash
  -- e.g. 'live in (it)'
  VPSlashPrep vp prep = vp ** { rightVal = prep } ;
  -- TODO: šajā brīdī ir jāignorē prep (by8agent_Prep); tas jāaizstāj ar v2.left (?)
  -- Tad varēs dzēst ārā komentāru pie StructuralLav.by8agent_Prep (?)

  -- Complements to copula

  -- AP -> Comp
  -- e.g. '(be) small'
  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom } ;

  -- NP -> Comp
  -- e.g. '(be) the man'
  CompNP np = { s = \\_ => np.s ! Nom } ;

  -- Adv -> Comp
  -- e.g. '(be) here'
  CompAdv a = { s = \\_ => a.s } ;

  -- CN -> Comp
  -- e.g. '(be) a man/men'
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).num ! Nom } ;

  -- TODO: UseCopula : VP
  -- e.g. 'be'

oper

  -- FIXME: the type of the participle form - depending on what?! (currently fixed)
  buildVerb : Verb -> VMood -> Polarity -> Agreement -> Polarity -> Polarity -> Str = 
  \v,mood,pol,agr,leftPol,rightPol ->
    let
      finalPol : Polarity = case <leftPol, rightPol> of {
        <Neg, _> => Neg ;  -- double negation, if the left/right NP has a negated determiner
        <_, Neg> => Neg ;
        _        => pol
      } ;
      agr = fromAgr agr
      ;  --# notpresent
      part = v.s ! Pos ! (VPart Pass agr.gend agr.num Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! finalPol ! (VInd agr.pers agr.num tense)
      ;  --# notpresent
      Ind Anter tense => (mkV "būt").s ! finalPol ! (VInd agr.pers agr.num tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! finalPol ! (VRel tense) ;  --# notpresent
      Rel Anter tense => (mkV "būt").s ! finalPol ! (VRel tense) ++ part ;  --# notpresent

      Deb Simul tense => (mkV "būt").s ! finalPol ! (VInd P3 Sg tense) ++  --# notpresent
        v.s ! Pos ! VDeb ;  --# notpresent
      Deb Anter tense => (mkV "būt").s ! finalPol ! (VInd P3 Sg tense) ++  --# notpresent
        (mkV "būt").s ! Pos ! (VPart Pass Masc Sg Nom) ++  --# notpresent
        v.s ! Pos ! VDeb ;  --# notpresent

      Condit Simul => v.s ! finalPol ! (VInd agr.pers agr.num ParamX.Cond) ;  --# notpresent
      Condit Anter => (mkV "būt").s ! finalPol ! (VInd agr.pers agr.num ParamX.Cond) ++ part  --# notpresent
    } ;

}
