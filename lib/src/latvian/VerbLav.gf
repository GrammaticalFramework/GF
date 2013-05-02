--# -path=.:../abstract:../common:../prelude

-- FIXME: module relations.
-- VerbLav is included in many places because of buildVerb (SentenceLav, QuestionLav, RelativeLav, IdiomLav),
-- and includes ParadigmsVerbsLav because of mkVerb_Irreg_Be -
-- they need to be reallocated somehow to ResLav or something similar ('be' - IrregLav).
-- Not so simple since morphology itself needs ResLav & friends.

concrete VerbLav of Verb = CatLav ** open 
  StructuralLav, 
  ParadigmsVerbsLav, 
  ResLav, -- TODO: get rid of ResLav - include parameters (Pos etc.) in ParadigmsVerbsLav
  ParamX,
  Prelude
in {

flags

  optimize = all_subs ;
  coding = utf8 ;

lin

  UseV v = {
    v = v ;
    compl = \\_ => [] ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;

  ComplVV vv vp = {
    v = vv ;
    compl = \\agr => build_VP vp Pos Infinitive agr ;
    agr = toClAgr_Reg vv.topic ;
    objNeg = Pos
  } ;

  ComplVS vs s = {
    v = vs ;
    compl = \\_ => "," ++ vs.subj.s ++ s.s ;
    agr = toClAgr_Reg vs.topic ;
    objNeg = Pos
  } ;

  ComplVQ vq qs = {
    v = vq ;
    compl = \\_ => "," ++ qs.s ;
    agr = toClAgr_Reg vq.topic ;
    objNeg = Pos
  } ;
  
  ComplVA va ap = {
    v = va ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;

  -- V2 -> VPSlash
  -- The (direct) object is added by ComplSlash
  SlashV2a v2 = {
    v = v2 ;
    compl = \\_ => [] ;
    p = v2.p ;
    agr = toClAgr v2.topic (v2.p.c ! Sg) (AgP3 Sg Masc Pos) Act ; -- overriden in ComplSlash
    objNeg = Pos -- overriden in ComplSlash
  } ;

  -- VPSlash -> NP -> VP
  ComplSlash vp np = 
    let agr : Agr = np.a
    in insertObjPre_Spec
      {-
      (\\agr => case (fromClAgr vp.agr).voice of {
        Act  => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr agr).num) ;
        Pass => np.s ! (fromClAgr vp.agr).c_topic
      })
      -}
      (\\agr => case vp.agr.voice of {
        Act  => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr agr).num) ;
        Pass => case vp.p.c ! (fromAgr agr).num of {
          --Nom => np.s ! vp.agr.c_topic ;
          Nom => np.s ! vp.agr.c_focus ;
          _   => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr agr).num)
        }
      })
      vp 
      np ;

oper
  insertObjPre_Spec : (Agr => Str) -> ResLav.VP -> NP -> ResLav.VP = \obj,vp,obj_np -> {
    v = vp.v ;
    compl = \\agr => obj ! agr ++ vp.compl ! agr ;
    agr = vp.agr ;
    {-
    agr = case vp.agr.voice of {
      Topic      c_topic           voice => Topic      c_topic                  voice ;
      TopicFocus c_topic c_focus _ voice => TopicFocus c_topic c_focus obj_np.a voice
      -- _                          => Topic Nom -- kāpēc ne 'Topic topic_case'? -- TODO: remove
    } ;
    -}
    objNeg = (fromAgr obj_np.a).pol
  } ;

lin
    -- V3 -> NP -> VPSlash ;  -- give it (to her)
    -- FIXME: "vīrietis runā par ābolus ar sievieti" ("a man talks to a woman about apples")
  Slash2V3 v3 np = insertObjC
    (\\_ => v3.p1.s ++ np.s ! (v3.p1.c ! (fromAgr np.a).num))
    {
      v = v3 ;
      compl = \\_ => [] ;
      p = v3.p2 ;
      agr = toClAgr v3.topic (v3.p1.c ! Sg) np.a Act ; -- TESTME: P1, P2 (in the focus)
      objNeg = (fromAgr np.a).pol -- TESTME
    } ;

  -- V3 -> NP -> VPSlash ;  -- give (it) to her
  Slash3V3 v3 np = insertObjC
    (\\_ => v3.p2.s ++ np.s ! (v3.p2.c ! (fromAgr np.a).num))
    {
      v = v3 ;
      compl = \\_ => [] ;
      p = v3.p1 ;
      agr = toClAgr v3.topic (v3.p2.c ! Sg) (AgP3 Sg Masc Pos) Act ; -- FIXME: works only if the focus is P3 (Sg/Pl); TODO: P1, P2 (Sg, Pl)
      objNeg = (fromAgr np.a).pol -- TESTME
    } ;

  SlashV2V v2v vp = {
    v = v2v ;
    compl = \\agr => build_VP vp Pos Infinitive agr ;
    p = v2v.p ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;
  
  SlashV2S v2s s = {
    v = v2s ;
    compl = \\_ => "," ++ v2s.subj.s ++ s.s ;
    p = v2s.p ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;

  SlashV2Q v2q qs = {
    v = v2q ;
    compl = \\_ => "," ++ qs.s ;
    p = v2q.p ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;
  
  SlashV2A v2a ap = {
    v = v2a ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom ;
    p = v2a.p ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;

  SlashVV vv vpslash = {
    v = vv ;
    compl = \\agr => build_VP vpslash Pos Infinitive agr ;
    p = vpslash.p ;
    agr = toClAgr_Reg vv.topic ;
    objNeg = Pos
  } ;

  SlashV2VNP v2v np vpslash = insertObjC
    (\\_ => v2v.p.s ++ np.s ! (v2v.p.c ! (fromAgr np.a).num))
    {
      v = v2v ;
      compl = \\agr => build_VP vpslash Pos Infinitive agr ;
      p = vpslash.p ;
      agr = toClAgr_Reg Nom ;
      objNeg = Pos
    } ;

  ReflVP vpslash = insertObjPre
    (\\agr => vpslash.p.s ++ reflPron ! (vpslash.p.c ! (fromAgr agr).num))
    vpslash ;

  UseComp comp = {
    v = lin V mkVerb_Irreg_Be ;
    compl = \\agr => comp.s ! agr ;
    agr = toClAgr_Reg Nom ;
    objNeg = Pos
  } ;

  -- V2 -> VP
  -- TODO: vai VP nevajag papildlauku isPass? Izskatās, ka vajag - jau/tikai ComplSlash (objekta locījumam)
  PassV2 v2 = {
    v      = v2 ;
    compl  = \\_ => [] ;
    --agr    = toClAgr v2.topic (v2.p.c ! Sg) (AgP3 Sg Masc) Pass ; -- FIXME(?): should not be overriden in ComplSlash; P3 restriction - never used?
    agr    = toClAgr (v2.p.c ! Sg) v2.topic (AgP3 Sg Masc Pos) Pass ; -- FIXME(?): should not be overriden in ComplSlash; P3 restriction - never used?
    objNeg = Pos -- overriden in ComplSlash
  } ;

  -- VP -> Prep -> VPSlash
  -- TODO: šajā brīdī ir jāignorē prep (by8agent_Prep); tas jāaizstāj ar v2.topic
  -- Tad varēs dzēst ārā komentāru pie StructuralLav.by8agent_Prep
  VPSlashPrep vp prep = vp ** {p = prep} ;

  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).gend ! (fromAgr agr).num ! Nom } ;

  CompNP np = { s = \\_ => np.s ! Nom } ;
  
  CompAdv a = { s = \\_ => a.s } ;
  
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).num ! Nom } ;

oper
  build_VP : ResLav.VP -> Polarity -> VerbForm -> Agr -> Str = \vp,pol,vf,agr ->
    vp.v.s ! pol ! vf ++ vp.compl ! agr ;

  -- VPSlash = { v : Verb ; topic : Case ; compl : Agr => Str ; p : Prep }
  insertObjC : (Agr => Str) -> ResLav.VPSlash -> ResLav.VPSlash = \obj,vp ->
    insertObj obj vp ** { p = vp.p } ;

  -- VP = { v : Verb ; topic : Case ; compl : Agr => Str }
  insertObj : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    compl = \\agr => vp.compl ! agr ++ obj ! agr ;
    agr = vp.agr ;
    objNeg = vp.objNeg
  } ;

  -- VP = { v : Verb ; topic : Case ; compl : Agr => Str }
  insertObjPre : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    compl = \\agr => obj ! agr ++ vp.compl ! agr ;
    agr = vp.agr ;
    objNeg = vp.objNeg
  } ;

  -- FIXME: the type of the participle form - depending on what?! (currently fixed)
  buildVerb : Verb -> VerbMood -> Polarity -> Agr -> Polarity -> Polarity -> Str = 
  \v,mood,pol,subjAgr,subjNeg,objNeg ->
    let
      pol_prim : Polarity = case <subjNeg, objNeg> of {
        <Neg, _> => Neg ;
        <_, Neg> => Neg ;
        _        => pol
      } ;
      agr = fromAgr subjAgr
      ;  --# notpresent
      part = v.s ! ResLav.Pos ! (Participle TsTa agr.gend agr.num Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! pol_prim ! (Indicative agr.pers agr.num tense)
      ;  --# notpresent
      Ind Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative agr.pers agr.num tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => ResLav.NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! pol_prim ! (Relative tense) ;  --# notpresent
      Rel Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Relative tense) ++ part ;  --# notpresent

      Deb Simul tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative P3 Sg tense) ++  --# notpresent
      	v.s ! ResLav.Pos ! Debitive ;  --# notpresent
      Deb Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative P3 Sg tense) ++  --# notpresent
        mkVerb_Irreg_Be.s ! ResLav.Pos ! (Participle TsTa Masc Sg Nom) ++  --# notpresent
        v.s ! ResLav.Pos ! Debitive ;  --# notpresent

      Condit Simul => v.s ! pol_prim ! (Indicative agr.pers agr.num ParamX.Cond) ;  --# notpresent
      Condit Anter => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative agr.pers agr.num ParamX.Cond) ++ part  --# notpresent
    } ;
}
