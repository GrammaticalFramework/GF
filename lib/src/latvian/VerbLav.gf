--# -path=.:../abstract:../common:../prelude

-- FIXME: module relations.
-- VerbLav is included in many places because of buildVerb,
-- and includes ParadigmsVerbsLav because of mkVerb_Irreg_Be -
-- they need to be reallocated somehow to ResLav or something similar.
-- Not so simple since morphology itself needs ResLav & friends.

concrete VerbLav of Verb = CatLav **
open
  ParadigmsVerbsLav,
  ParamX,
  ResLav,
  StructuralLav
in {

flags
  optimize = all_subs ;
  coding = utf8 ;

lin
  UseV v = { v = v ; topic = Nom ; focus = \\_ => [] } ;

  ComplVV vv vp = { v = vv ; topic = vv.topic ; focus = \\agr => build_VP vp Pos Infinitive agr } ;
  ComplVS vs s = { v = vs ; topic = vs.topic ; focus = \\_ => "," ++ vs.subj.s ++ s.s } ;
  ComplVQ vq qs = { v = vq ; topic = vq.topic ; focus = \\_ => "," ++ qs.s } ;
  ComplVA va ap = { v = va ; topic = Nom ; focus = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom } ;

  SlashV2a v2 = { v = v2 ; topic = v2.topic ; focus = \\_ => [] ; p = v2.p } ;

  Slash2V3 v3 np = insertObjC
    (\\_ => v3.p1.s ++ np.s ! (v3.p1.c ! (fromAgr np.a).n))
    { v = v3 ; topic = Nom ; focus = \\_ => [] ; p = v3.p2 } ;

  Slash3V3 v3 np = insertObjC
    (\\_ => v3.p2.s ++ np.s ! (v3.p2.c ! (fromAgr np.a).n))
    { v = v3 ; topic = Nom ; focus = \\_ => [] ; p = v3.p1 } ;

  SlashV2V v2v vp = { v = v2v ; topic = Nom ; focus = \\agr => build_VP vp Pos Infinitive agr ; p = v2v.p } ;
  SlashV2S v2s s = { v = v2s ; topic = Nom ; focus = \\_ => "," ++ v2s.subj.s ++ s.s ; p = v2s.p } ;
  SlashV2Q v2q qs = { v = v2q ; topic = Nom ; focus = \\_ => "," ++ qs.s ; p = v2q.p } ;
  SlashV2A v2a ap = { v = v2a ; topic = Nom ; focus = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom ; p = v2a.p } ;

  ComplSlash vpslash np = insertObjPre
    (\\_ => vpslash.p.s ++ np.s ! (vpslash.p.c ! (fromAgr np.a).n))
    vpslash ;

  SlashVV vv vpslash = { v = vv ; topic = vv.topic ; focus = \\agr => build_VP vpslash Pos Infinitive agr ; p = vpslash.p } ;

  SlashV2VNP v2v np vpslash = insertObjC
    (\\_ => v2v.p.s ++ np.s ! (v2v.p.c ! (fromAgr np.a).n))
    { v = v2v ; topic = Nom ; focus = \\agr => build_VP vpslash Pos Infinitive agr ; p = vpslash.p } ;

  ReflVP vpslash = insertObjPre
    (\\agr => vpslash.p.s ++ reflPron ! (vpslash.p.c ! (fromAgr agr).n))
    vpslash ;

  UseComp comp = { v = lin V mkVerb_Irreg_Be ; topic = Nom ; focus = \\agr => comp.s ! agr } ;

  PassV2 v2 = { v = v2 ; topic = v2.topic ; focus = \\_ => NON_EXISTENT } ; -- FIXME: placeholder

  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;
  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom } ;
  CompNP np = { s = \\_ => np.s ! Nom } ;
  CompAdv a = { s = \\_ => a.s } ;
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).n ! Nom } ;

oper
  build_VP : ResLav.VP -> Polarity -> VerbForm -> Agr -> Str = \vp,pol,vf,agr ->
    vp.v.s ! pol ! vf ++ vp.focus ! agr ;

  -- VPSlash = { v : Verb ; topic : Case ; focus : Agr => Str ; p : Prep }
  insertObjC : (Agr => Str) -> ResLav.VPSlash -> ResLav.VPSlash = \obj,vp ->
    insertObj obj vp ** { p = vp.p } ;

  -- VP = { v : Verb ; topic : Case ; focus : Agr => Str }
  insertObj : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    topic = vp.topic ;
    focus = \\agr => vp.focus ! agr ++ obj ! agr
  } ;

  -- VP = { v : Verb ; topic : Case ; focus : Agr => Str }
  -- TODO: šo jāmet ārā un jāpieliek insertObj parametrs isPre
  -- Bet kas šis vispār ir par gadījumu?!
  insertObjPre : (Agr => Str) -> ResLav.VP -> ResLav.VP = \obj,vp -> {
    v = vp.v ;
    topic = vp.topic ;
    focus = \\agr => obj ! agr ++ vp.focus ! agr
  } ;

  buildVerb : Verb -> VerbMood -> Polarity -> Agr -> Str = \v,mood,pol,ag ->
    let
      ag = fromAgr ag
      ;  --# notpresent
      part = v.s ! ResLav.Pos ! (Participle ag.g ag.n Nom)  --# notpresent
    in case mood of {
      Ind Simul tense => v.s ! pol ! (Indicative ag.p ag.n tense)
      ;  --# notpresent
      Ind Anter tense => mkVerb_Irreg_Be.s ! pol ! (Indicative ag.p ag.n tense) ++ part ;  --# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => ResLav.NON_EXISTENT ;  --# notpresent
      Rel Simul tense => v.s ! pol ! (Relative tense) ;  --# notpresent
      Rel Anter tense => mkVerb_Irreg_Be.s ! pol ! (Relative tense) ++ part ;  --# notpresent

      Deb Simul tense => mkVerb_Irreg_Be.s ! pol ! (Indicative P3 Sg tense) ++  --# notpresent
      	v.s ! ResLav.Pos ! Debitive ;  --# notpresent
      Deb Anter tense => mkVerb_Irreg_Be.s ! pol ! (Indicative P3 Sg tense) ++  --# notpresent
        mkVerb_Irreg_Be.s ! ResLav.Pos ! (Participle Masc Sg Nom) ++  --# notpresent
        v.s ! ResLav.Pos ! Debitive ;  --# notpresent

      Condit Simul => v.s ! pol ! (Indicative ag.p ag.n ParamX.Cond) ;  --# notpresent
      Condit Anter => mkVerb_Irreg_Be.s ! pol ! (Indicative ag.p ag.n ParamX.Cond) ++ part  --# notpresent
    } ;
}
