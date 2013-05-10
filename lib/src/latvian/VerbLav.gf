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
    v     = v ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => [] ;
    voice = Act ;
    topic = v.topic
  } ;

  -- VV -> VP -> VP
  -- e.g. 'want to run'
  ComplVV vv vp = {
    v     = vv ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => buildVP vp Pos VInf agr ;
    voice = Act ;
    topic = vv.topic
  } ;

  -- VS -> S -> VP
  -- e.g. 'say that she runs'
  ComplVS vs s = {
    v     = vs ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => "," ++ vs.conj.s ++ s.s ;
    voice = Act ;
    topic = vs.topic
  } ;

  -- VQ -> QS -> VP
  -- e.g. 'wonder who runs'
  ComplVQ vq qs = {
    v     = vq ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => "," ++ qs.s ;
    voice = Act ;
    topic = vq.topic
  } ;

  -- VA -> AP -> VP
  -- e.g. '(they) become red'
  ComplVA va ap = {
    v     = va ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    voice = Act ;
    topic = va.topic
  } ;

  -- V2 -> VPSlash
  -- e.g. 'love (it)'
  SlashV2a v2 = {
    v     = v2 ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => [] ;
    voice = Act ;
    topic = v2.topic ;
    focus = v2.focus
  } ;

  -- V3 -> NP -> VPSlash
  -- e.g. 'give it (to her)'
  Slash2V3 v3 np = insertObjC
    (\\_ => v3.focus2.s ++ np.s ! (v3.focus2.c ! (fromAgr np.agr).num))
    {
      v     = v3 ;
      agr   = { subj = np.agr ; focus = np.pol } ;
      compl = \\_ => [] ;
      voice = Act ;
      topic = v3.topic ;
      focus = v3.focus1
    } ;
  -- FIXME: "vīrietis runā par ābolus ar sievieti" ("a man talks to a woman about apples")
  -- FIXME: the order of objects (?)
  -- TODO: test val (P1 un P2) un objNeg

  -- V3 -> NP -> VPSlash
  -- e.g. 'give (it) to her'
  Slash3V3 v3 np = insertObjC
    (\\_ => v3.focus2.s ++ np.s ! (v3.focus2.c ! (fromAgr np.agr).num))
    {
      v     = v3 ;
      agr   = { subj = np.agr ; focus = np.pol } ;
      compl = \\_ => [] ;
      voice = Act ;
      topic = v3.topic ;
      focus = v3.focus1
    } ;
  -- TODO: val other than P3 Sg Masc
  -- TODO: test objNeg

  -- V2V -> VP -> VPSlash
  -- e.g. 'beg (her) to go'
  SlashV2V v2v vp = {
    v     = v2v ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => buildVP vp Pos VInf agr ;
    voice = Act ;
    topic = v2v.topic ;
    focus = v2v.focus
  } ;

  -- V2S -> S -> VPSlash
  -- e.g. 'answer (to him) that it is good'
  SlashV2S v2s s = {
    v     = v2s ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => "," ++ v2s.conj.s ++ s.s ;
    voice = Act ;
    topic = v2s.topic ;
    focus = v2s.focus
  } ;

  -- V2Q -> QS -> VPSlash
  -- e.g. 'ask (him) who came'
  SlashV2Q v2q qs = {
    v     = v2q ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => "," ++ qs.s ;
    voice = Act ;
    topic = v2q.topic ;
    focus = v2q.focus
  } ;

  -- V2A -> AP -> VPSlash
  -- e.g. 'paint (it) red'
  SlashV2A v2a ap = {
    v     = v2a ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    voice = Act ;
    topic = v2a.topic ;
    focus = v2a.focus
  } ;

  -- VPSlash -> NP -> VP
  -- e.g. 'love it'
  ComplSlash vpslash np =
    let agr : Agreement = np.agr in {
      v     = vpslash.v ;
      agr   = { subj = agr ; focus = np.pol } ;
      compl = \\agr => case vpslash.voice of {
        Act  => vpslash.focus.s ++ np.s ! (vpslash.focus.c ! (fromAgr agr).num) ;
        Pass => case vpslash.focus.c ! (fromAgr agr).num of {
          Nom => np.s ! (vpslash.focus.c ! Sg) ;
          _   => vpslash.focus.s ++ np.s ! (vpslash.focus.c ! (fromAgr agr).num)
        }
      } ++ vpslash.compl ! agr ;
      voice = vpslash.voice ;
      topic = vpslash.topic ;
      focus = vpslash.focus
    } ;

  -- VV -> VPSlash -> VPSlash
  -- e.g. 'want to buy'
  SlashVV vv vpslash = {
    v     = vv ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => buildVP vpslash Pos VInf agr ;
    voice = Act ;
    topic = vv.topic ;
    focus = defaultPrep
  } ;

  -- V2V -> NP -> VPSlash -> VPSlash
  -- e.g. '-- beg me to buy'
  SlashV2VNP v2v np vpslash = insertObjC
    (\\_ => v2v.focus.s ++ np.s ! (v2v.focus.c ! (fromAgr np.agr).num))
    {
      v     = v2v ;
      agr   = { subj = np.agr ; focus = np.pol } ;
      compl = \\agr => buildVP vpslash Pos VInf agr ;
      voice = Act ;
      topic = v2v.topic ;
      focus = v2v.focus
    } ;

  -- Other ways of forming verb phrases

  -- VPSlash -> VP
  -- e.g. 'love himself'
  ReflVP vpslash = insertObjPre
    (\\agr => vpslash.focus.s ++ reflPron ! (vpslash.focus.c ! (fromAgr agr).num))
    vpslash ;

  -- Comp -> VP
  -- e.g. 'be warm'
  UseComp comp = {
    v     = mkV "būt" ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\agr => comp.s ! agr ;
    voice = Act ;
    topic = Nom
  } ;

  -- V2 -> VP
  -- e.g. 'be loved'
  PassV2 v2 = {
    v     = v2 ;
    agr   = { subj = defaultAgr ; focus = Pos } ;
    compl = \\_ => [] ;
    voice = Pass ;
    topic = v2.focus.c ! Sg ;
    focus = mkPrep v2.topic
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
  VPSlashPrep vp prep = vp ** { focus = prep } ;
  -- TODO: šajā brīdī ir jāignorē prep (by8agent_Prep); tas jāaizstāj ar v2.topic (?)
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

  defaultAgr : Agreement = AgrP3 Sg Masc ; -- variants {}
  defaultPrep : Preposition = nom_Prep ;

  -- FIXME: the type of the participle form - depending on what?! (currently fixed)
  buildVerb : Verb -> VMood -> Polarity -> Agreement -> Polarity -> Polarity -> Str = 
  \v,mood,pol,agr,polTopic,polFocus ->
    let
      polFinal : Polarity = case <polTopic, polFocus> of {
        -- double negation, if the topic/focus NP has a negated determiner
        <Neg, _> => Neg ;
        <_, Neg> => Neg ;
        _        => pol
      } ;
      agr = fromAgr agr
      ;  --# notpresent
      part = v.s ! Pos ! (VPart Pass agr.gend agr.num Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! polFinal ! (VInd agr.pers agr.num tense)
      ;  --# notpresent
      Ind Anter tense => (mkV "būt").s ! polFinal ! (VInd agr.pers agr.num tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! polFinal ! (VRel tense) ;  --# notpresent
      Rel Anter tense => (mkV "būt").s ! polFinal ! (VRel tense) ++ part ;  --# notpresent

      Deb Simul tense => (mkV "būt").s ! polFinal ! (VInd P3 Sg tense) ++  --# notpresent
        v.s ! Pos ! VDeb ;  --# notpresent
      Deb Anter tense => (mkV "būt").s ! polFinal ! (VInd P3 Sg tense) ++  --# notpresent
        (mkV "būt").s ! Pos ! (VPart Pass Masc Sg Nom) ++  --# notpresent
        v.s ! Pos ! VDeb ;  --# notpresent

      Condit Simul => v.s ! polFinal ! (VInd agr.pers agr.num ParamX.Cond) ;  --# notpresent
      Condit Anter => (mkV "būt").s ! polFinal ! (VInd agr.pers agr.num ParamX.Cond) ++ part  --# notpresent
    } ;

}
