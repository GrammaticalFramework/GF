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
    agr = Topic Nom ;
    objNeg = False
  } ;

  ComplVV vv vp = {
    v = vv ;
    compl = \\agr => build_VP vp Pos Infinitive agr ;
    agr = Topic vv.topic ;
    objNeg = False
  } ;

  ComplVS vs s = {
    v = vs ;
    compl = \\_ => "," ++ vs.subj.s ++ s.s ;
    agr = Topic vs.topic ;
    objNeg = False
  } ;

  ComplVQ vq qs = {
    v = vq ;
    compl = \\_ => "," ++ qs.s ;
    agr = Topic vq.topic ;
    objNeg = False
  } ;
  
  ComplVA va ap = {
    v = va ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom ;
    agr = Topic Nom ;
    objNeg = False
  } ;

  -- SlashV2a : V2 -> VPSlash ;  -- love (it)
  -- The (direct) object is added by ComplSlash
  SlashV2a v2 = {
    v = v2 ;
    compl = \\_ => [] ;
    p = v2.p ;
    agr = TopicFocus v2.topic (AgP3 Sg Masc) ; -- overriden in ComplSlash
    objNeg = False -- overriden in ComplSlash
  } ;

  -- VPSlash = { v : Verb ; compl : Agr => Str ; agr : ClAgr ; objNeg : Bool ; p : ResLav.Prep }
  -- Agr = AgP1 Number Gender | AgP2 Number Gender | AgP3 Number Gender
  ComplSlash vpslash np = 
    let agr : Agr = np.a
    in insertObjPre_Spec
      (\\agr => vpslash.p.s ++ np.s ! (vpslash.p.c ! (fromAgr agr).n))
      vpslash 
      np ;

oper
  insertObjPre_Spec : (Agr => Str) -> ResLav.VP -> NP -> ResLav.VP = \obj,vp,obj_np -> {
    v = vp.v ;
    compl = \\agr => obj ! agr ++ vp.compl ! agr ;
    agr = case vp.agr of {
      TopicFocus topic _ => TopicFocus topic obj_np.a ;
      _                  => Topic Nom
    } ;
    objNeg = obj_np.isNeg
  } ;

lin
    -- Slash2V3 : V3 -> NP -> VPSlash ;  -- give it (to her)
  Slash2V3 v3 np = insertObjC
    (\\_ => v3.p1.s ++ np.s ! (v3.p1.c ! (fromAgr np.a).n))
    {
      v = v3 ;
      compl = \\_ => [] ;
      p = v3.p2 ;
      agr = TopicFocus v3.topic np.a ; -- TESTME: P1, P2 (in the focus)
      objNeg = np.isNeg -- TESTME
    } ;

  -- Slash3V3 : V3 -> NP -> VPSlash ;  -- give (it) to her
  Slash3V3 v3 np = insertObjC
    (\\_ => v3.p2.s ++ np.s ! (v3.p2.c ! (fromAgr np.a).n))
    {
      v = v3 ;
      compl = \\_ => [] ;
      p = v3.p1 ;
      agr = TopicFocus v3.topic (AgP3 Sg Masc) ; -- FIXME: works only if the focus is P3 (Sg/Pl); TODO: P1, P2 (Sg, Pl)
      objNeg = np.isNeg -- TESTME
    } ;

  SlashV2V v2v vp = {
    v = v2v ;
    compl = \\agr => build_VP vp Pos Infinitive agr ;
    p = v2v.p ;
    agr = Topic Nom ;
    objNeg = False
  } ;
  
  SlashV2S v2s s = {
    v = v2s ;
    compl = \\_ => "," ++ v2s.subj.s ++ s.s ;
    p = v2s.p ;
    agr = Topic Nom ;
    objNeg = False
  } ;

  SlashV2Q v2q qs = {
    v = v2q ;
    compl = \\_ => "," ++ qs.s ;
    p = v2q.p ;
    agr = Topic Nom ;
    objNeg = False
  } ;
  
  SlashV2A v2a ap = {
    v = v2a ;
    compl = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom ;
    p = v2a.p ;
    agr = Topic Nom ;
    objNeg = False
  } ;

  SlashVV vv vpslash = {
    v = vv ;
    compl = \\agr => build_VP vpslash Pos Infinitive agr ;
    p = vpslash.p ;
    agr = Topic vv.topic ;
    objNeg = False
  } ;

  SlashV2VNP v2v np vpslash = insertObjC
    (\\_ => v2v.p.s ++ np.s ! (v2v.p.c ! (fromAgr np.a).n))
    {
      v = v2v ;
      compl = \\agr => build_VP vpslash Pos Infinitive agr ;
      p = vpslash.p ;
      agr = Topic Nom ;
      objNeg = False
    } ;

  ReflVP vpslash = insertObjPre
    (\\agr => vpslash.p.s ++ reflPron ! (vpslash.p.c ! (fromAgr agr).n))
    vpslash ;

  UseComp comp = {
    v = lin V mkVerb_Irreg_Be ;
    compl = \\agr => comp.s ! agr ;
    agr = Topic Nom ;
    objNeg = False
  } ;

  PassV2 v2 = {
    v = v2 ;
    compl = \\_ => [] ;
    agr = Topic v2.topic ;
    objNeg = False -- FIXME: inherit from the object
  } ;

  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom } ;

  CompNP np = { s = \\_ => np.s ! Nom } ;
  
  CompAdv a = { s = \\_ => a.s } ;
  
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).n ! Nom } ;

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
  buildVerb : Verb -> VerbMood -> Polarity -> Agr -> Bool -> Bool -> Str = 
  \v,mood,pol,agr,subjNeg,objNeg ->
    let
      pol_prim : Polarity = case <subjNeg, objNeg> of {
        <True, _> => Neg ;
        <_, True> => Neg ;
        _         => pol
      } ;
      agr = fromAgr agr
      ;  --# notpresent
      part = v.s ! ResLav.Pos ! (Participle TsTa agr.g agr.n Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! pol_prim ! (Indicative agr.p agr.n tense)
      ;  --# notpresent
      Ind Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative agr.p agr.n tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => ResLav.NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! pol_prim ! (Relative tense) ;  --# notpresent
      Rel Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Relative tense) ++ part ;  --# notpresent

      Deb Simul tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative P3 Sg tense) ++  --# notpresent
      	v.s ! ResLav.Pos ! Debitive ;  --# notpresent
      Deb Anter tense => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative P3 Sg tense) ++  --# notpresent
        mkVerb_Irreg_Be.s ! ResLav.Pos ! (Participle TsTa Masc Sg Nom) ++  --# notpresent
        v.s ! ResLav.Pos ! Debitive ;  --# notpresent

      Condit Simul => v.s ! pol_prim ! (Indicative agr.p agr.n ParamX.Cond) ;  --# notpresent
      Condit Anter => mkVerb_Irreg_Be.s ! pol_prim ! (Indicative agr.p agr.n ParamX.Cond) ++ part  --# notpresent
    } ;
}
