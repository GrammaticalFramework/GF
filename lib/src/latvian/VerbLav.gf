--# -path=.:../abstract:../common:../prelude

-- TODO: module relations.
-- VerbLav is included in many places because of buildVerb (SentenceLav, QuestionLav, RelativeLav, IdiomLav),
-- and includes ParadigmsVerbsLav because of mkVerb_Irreg_Be.
-- They need to be reallocated somehow to ResLav.or something similar (e.g. 'be' => IrregLav).
-- Not so simple since morphology itself needs ResLav & friends.

concrete VerbLav of Verb = CatLav ** open 
  StructuralLav, 
  ParadigmsVerbsLav, 
  ResLav,
  ParamX,
  Prelude
in {

flags

  optimize = all_subs ;
  coding = utf8 ;

lin

  -- V -> VP
  UseV v = {
    v      = v ;
    compl  = \\_ => [] ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- VV -> VP -> VP
  ComplVV vv vp = {
    v      = vv ;
    compl  = \\agr => build_VP vp Pos VInf agr ;
    val    = toVal_Reg vv.topic ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- VS -> S -> VP
  ComplVS vs s = {
    v      = vs ;
    compl  = \\_ => "," ++ vs.subj.s ++ s.s ;
    val    = toVal_Reg vs.topic ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- VQ -> QS -> VP
  ComplVQ vq qs = {
    v      = vq ;
    compl  = \\_ => "," ++ qs.s ;
    val    = toVal_Reg vq.topic ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- VA -> AP -> VP
  ComplVA va ap = {
    v      = va ;
    compl  = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- V2 -> VPSlash
  -- e.g. 'love (it)'
  SlashV2a v2 = {
    v      = v2 ;
    compl  = \\_ => [] ;  -- overriden in ComplSlash
    val    = toVal v2.topic (v2.p.c ! Sg) (AgP3 Sg Masc Pos) ;
    objNeg = Pos ;  -- overriden in ComplSlash
    voice  = Act ;
    p      = v2.p ;
  } ;
  -- TODO: val other than P3 Sg Masc

  -- V3 -> NP -> VPSlash
  -- e.g. 'give it (to her)'
  Slash2V3 v3 np = insertObjC
    (\\_ => v3.p1.s ++ np.s ! (v3.p1.c ! (fromAgr np.a).num))
    {
      v      = v3 ;
      compl  = \\_ => [] ;
      val    = toVal v3.topic (v3.p1.c ! Sg) np.a ;
      objNeg = (fromAgr np.a).pol ;
      voice  = Act ;
      p      = v3.p2
    } ;
  -- FIXME: "vīrietis runā par ābolus ar sievieti" ("a man talks to a woman about apples")
  -- FIXME: the order of objects (?)
  -- TODO: test val (P1 un P2) un objNeg

  -- V3 -> NP -> VPSlash
  -- e.g. 'give (it) to her'
  Slash3V3 v3 np = insertObjC
    (\\_ => v3.p2.s ++ np.s ! (v3.p2.c ! (fromAgr np.a).num))
    {
      v      = v3 ;
      compl  = \\_ => [] ;
      val    = toVal v3.topic (v3.p2.c ! Sg) (AgP3 Sg Masc Pos) ;
      objNeg = (fromAgr np.a).pol ;
      voice  = Act ;
      p      = v3.p1
    } ;
  -- TODO: val other than P3 Sg Masc
  -- TODO: test objNeg

  -- V2V -> VP -> VPSlash
  SlashV2V v2v vp = {
    v      = v2v ;
    compl  = \\agr => build_VP vp Pos VInf agr ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act ;
    p      = v2v.p
  } ;

  -- V2S -> S -> VPSlash
  SlashV2S v2s s = {
    v      = v2s ;
    compl  = \\_ => "," ++ v2s.subj.s ++ s.s ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act ;
    p      = v2s.p
  } ;

  -- V2Q -> QS -> VPSlash
  SlashV2Q v2q qs = {
    v      = v2q ;
    compl  = \\_ => "," ++ qs.s ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act ;
    p      = v2q.p
  } ;

  -- V2A -> AP -> VPSlash
  SlashV2A v2a ap = {
    v      = v2a ;
    compl  = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act ;
    p      = v2a.p
  } ;

  -- VV -> VPSlash -> VPSlash
  SlashVV vv vp = {
    v      = vv ;
    compl  = \\agr => build_VP vp Pos VInf agr ;
    val    = toVal_Reg vv.topic ;
    objNeg = Pos ;
    voice  = Act ;
    p      = vp.p
  } ;

  -- V2V -> NP -> VPSlash -> VPSlash
  SlashV2VNP v2v np vp = insertObjC
    (\\_ => v2v.p.s ++ np.s ! (v2v.p.c ! (fromAgr np.a).num))
    {
      v      = v2v ;
      compl  = \\agr => build_VP vp Pos VInf agr ;
      val    = toVal_Reg Nom ;
      objNeg = Pos ;
      voice  = Act ;
      p      = vp.p
    } ;

  -- VP -> Prep -> VPSlash
  VPSlashPrep vp prep = vp ** {p = prep} ;
  -- TODO: šajā brīdī ir jāignorē prep (by8agent_Prep); tas jāaizstāj ar v2.topic (?)
  -- Tad varēs dzēst ārā komentāru pie StructuralLav.by8agent_Prep (?)

  -- VPSlash -> NP -> VP
  ComplSlash vp np = let agr : Agr = np.a in {
    v     = vp.v ;
    compl = \\agr => case vp.voice of {
      Act  => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr agr).num) ;
      Pass => case vp.p.c ! (fromAgr agr).num of {
        Nom => np.s ! vp.val.obj ;
        _   => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr agr).num)
      }
    } ++ vp.compl ! agr ;
    val    = vp.val ;
    objNeg = (fromAgr np.a).pol ;
    voice  = vp.voice
  } ;

  -- V2 -> VP
  PassV2 v2 = {
    v      = v2 ;
    compl  = \\_ => [] ;
    val    = toVal (v2.p.c ! Sg) v2.topic (AgP3 Sg Masc Pos) ;
    objNeg = Pos ;
    voice  = Pass
  } ;
  -- TODO: val - should not be overriden in ComplSlash etc.?
  -- TODO: val - P3 Sg Masc restriction - never used?
  -- TODO: notestēt objNeg (kur tas tiek pārrakstīts - ComplSlash, AdvVP u.c.?)

  -- VP -> Adv -> VP
  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

  -- AdV -> VP -> VP
  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

  -- VPSlash -> VP
  ReflVP vp = insertObjPre (\\agr => vp.p.s ++ reflPron ! (vp.p.c ! (fromAgr agr).num)) vp ;

  -- Comp -> VP
  UseComp comp = {
    v      = lin V mkVerb_Irreg_Be ;
    compl  = \\agr => comp.s ! agr ;
    val    = toVal_Reg Nom ;
    objNeg = Pos ;
    voice  = Act
  } ;

  -- AP -> Comp
  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom } ;

  -- NP -> Comp
  CompNP np = { s = \\_ => np.s ! Nom } ;

  -- Adv -> Comp
  CompAdv a = { s = \\_ => a.s } ;

  -- CN -> Comp
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).num ! Nom } ;

oper
  build_VP : ResLav.VP -> Polarity -> VForm -> Agr -> Str = \vp,pol,vf,agr ->
    vp.v.s ! pol ! vf ++ vp.compl ! agr ;

  insertObjC : (Agr => Str) -> ResLav.VPSlash -> ResLav.VPSlash = \obj,vp ->
    insertObj obj vp ** { p = vp.p } ;

  insertObj : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    compl = \\agr => vp.compl ! agr ++ obj ! agr ;
    val = vp.val ;
    objNeg = vp.objNeg ;
    voice = vp.voice
  } ;

  insertObjPre : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    compl = \\agr => obj ! agr ++ vp.compl ! agr ;
    val = vp.val ;
    objNeg = vp.objNeg ;
    voice = vp.voice
  } ;

  -- FIXME: the type of the participle form - depending on what?! (currently fixed)
  buildVerb : Verb -> VMood -> Polarity -> Agr -> Polarity -> Polarity -> Str = 
  \v,mood,pol,subjAgr,subjNeg,objNeg ->
    let
      pol_prim : Polarity = case <subjNeg, objNeg> of {
        <Neg, _> => Neg ;
        <_, Neg> => Neg ;
        _        => pol
      } ;
      agr = fromAgr subjAgr
      ;  --# notpresent
      part = v.s ! ResLav.Pos ! (VPart Pass agr.gend agr.num Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! pol_prim ! (VInd agr.pers agr.num tense)
      ;  --# notpresent
      Ind Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (VInd agr.pers agr.num tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => ResLav.NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! pol_prim ! (VRel tense) ;  --# notpresent
      Rel Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (VRel tense) ++ part ;  --# notpresent

      Deb Simul tense => mkVerb_Irreg_Be.s ! pol_prim ! (VInd P3 Sg tense) ++  --# notpresent
      	v.s ! ResLav.Pos ! VDeb ;  --# notpresent
      Deb Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (VInd P3 Sg tense) ++  --# notpresent
        mkVerb_Irreg_Be.s ! ResLav.Pos ! (VPart Pass Masc Sg Nom) ++  --# notpresent
        v.s ! ResLav.Pos ! VDeb ;  --# notpresent

      Condit Simul => v.s ! pol_prim ! (VInd agr.pers agr.num ParamX.Cond) ;  --# notpresent
      Condit Anter => mkVerb_Irreg_Be.s ! pol_prim ! (VInd agr.pers agr.num ParamX.Cond) ++ part  --# notpresent
    } ;
}
