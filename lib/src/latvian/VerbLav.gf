--# -path=.:../abstract:../common:../prelude

-- FIXME: module relations. VerbLav is included in many places because of buildVerb,
-- and includes ParadigmsVerbsLav because of mkVerb_toBe -
-- they need to be reallocated somehow to ResLav or something similar.
-- Not so simple since morphology itself needs ResLav & friends.

concrete VerbLav of Verb = CatLav ** open
  ParamX,
  ResLav,
  ParadigmsVerbsLav,
  StructuralLav
  in {

flags
    optimize = all_subs ;
    coding = utf8 ;

lin
  -- TODO: rewrite šo uz valencēm, lai ir semantiskās saites
  UseV v = { v = v ; s2 = \\_ => [] } ;

  ComplVV v vp = { v = v ; s2 = \\agr => build_VP vp Pos Infinitive agr } ;
  ComplVS v s  = { v = v ; s2 = \\_ => "," ++ v.subj.s ++ s.s } ;
  ComplVQ v q  = { v = v ; s2 = \\_ => "," ++ q.s } ;
  ComplVA v ap = { v = v ; s2 = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom } ;

  SlashV2a v = { v = v ; s2 = \\_ => [] ; p = v.p } ;

  Slash2V3 v np =
    insertObjc (\\_ => v.p1.s ++ np.s ! (v.p1.c ! (fromAgr np.a).n))
      { v = v ; s2 = \\_ => [] ; p = v.p2 } ;

  Slash3V3 v np =
    insertObjc (\\_ => v.p2.s ++ np.s ! (v.p2.c ! (fromAgr np.a).n))
      { v = v ; s2 = \\_ => [] ; p = v.p1 } ;

  SlashV2V v vp = { v = v ; s2 = \\agr => build_VP vp Pos Infinitive agr ; p = v.p } ;
  SlashV2S v s  = { v = v ; s2 = \\_ => "," ++ v.subj.s ++ s.s ; p = v.p } ;
  SlashV2Q v q  = { v = v ; s2 = \\_ => "," ++ q.s ; p = v.p } ;
  SlashV2A v ap = { v = v ; s2 = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom ; p = v.p } ;

  ComplSlash vp np = insertObjPre (\\_ => vp.p.s ++ np.s ! (vp.p.c ! (fromAgr np.a).n)) vp ;

  CompAP ap = { s = \\agr => ap.s ! Indef ! (fromAgr agr).g ! (fromAgr agr).n ! Nom } ;
  CompNP np = { s = \\_ => np.s ! Nom } ;
  CompAdv a = { s = \\_ => a.s } ;
  CompCN cn = { s = \\agr => cn.s ! Indef ! (fromAgr agr).n ! Nom } ;

  ReflVP vp = insertObjPre (\\a => vp.p.s ++ reflPron ! (vp.p.c ! (fromAgr a).n)) vp ;

  UseComp comp = { v = lin V mkVerb_toBe ; s2 = \\agr => comp.s ! agr } ;

  AdvVP vp adv = insertObj (\\_ => adv.s) vp ;
  AdVVP adv vp = insertObjPre (\\_ => adv.s) vp ;

oper
  build_VP : ResLav.VP -> Polarity -> VerbForm -> Agr -> Str = \vp,p,vf,agr ->
    vp.v.s ! p ! vf ++ vp.s2 ! agr ;

  insertObj : (Agr => Str) -> { v : Verb ; s2 : Agr => Str } -> { v : Verb ; s2 : Agr => Str } =
    \obj,vp -> {
      v = vp.v ;
      s2 = \\a => vp.s2 ! a ++ obj ! a
    } ;

  insertObjPre : (Agr => Str) -> { v : Verb ; s2 : Agr => Str } -> { v : Verb ; s2 : Agr => Str } =
    \obj,vp -> {
      v = vp.v ;
      s2 = \\a => obj ! a ++ vp.s2 ! a
    } ;

  insertObjc : (Agr => Str) -> { v : Verb ; s2 : Agr => Str ; p : Prep } -> { v : Verb ; s2 : Agr => Str ; p : Prep } =
    \obj,vp -> insertObj obj vp ** { p = vp.p } ;

  buildVerb : Verb -> VerbMood -> Polarity -> Agr -> Str = \v,mood,pol,ag ->
    let
      ag = fromAgr ag
      ;																							--# notpresent
      part = v.s ! ResLav.Pos ! (Participle ag.g ag.n Nom)										--# notpresent
    in case mood of {
      Ind Simul tense => v.s ! pol ! (Indicative ag.p ag.n tense)
      ;																							--# notpresent
      Ind Anter tense => mkVerb_toBe.s ! pol ! (Indicative ag.p ag.n tense) ++ part ;			--# notpresent

      -- FIXME(?): Rel _ Past => ...
      Rel _     Past  => ResLav.NON_EXISTENT ;													--# notpresent
      Rel Simul tense => v.s ! pol ! (Relative tense) ;											--# notpresent
      Rel Anter tense => mkVerb_toBe.s ! pol ! (Relative tense) ++ part ;						--# notpresent

      Deb Simul tense => mkVerb_toBe.s ! pol ! (Indicative P3 Sg tense) ++						--# notpresent
      	v.s ! ResLav.Pos ! Debitive ;															--# notpresent
      Deb Anter tense => mkVerb_toBe.s ! pol ! (Indicative P3 Sg tense) ++						--# notpresent
        mkVerb_toBe.s ! ResLav.Pos ! (Participle Masc Sg Nom) ++								--# notpresent
        v.s ! ResLav.Pos ! Debitive ;															--# notpresent

      Condit Simul => v.s ! pol ! (Indicative ag.p ag.n ParamX.Cond) ;							--# notpresent
      Condit Anter => mkVerb_toBe.s ! pol ! (Indicative ag.p ag.n ParamX.Cond) ++ part			--# notpresent
    } ;

-- TODO: nav testēts
lin
  SlashVV vv vp = { v = vv ; s2 = \\agr => build_VP vp Pos Infinitive agr ; p = vp.p } ;
  SlashV2VNP vv np vp =
    insertObjc (\\_ => vv.p.s ++ np.s ! (vv.p.c ! (fromAgr np.a).n))
      { v = vv ; s2 = \\agr => build_VP vp Pos Infinitive agr ; p = vp.p } ;

  -- FIXME: placeholder
  PassV2 v = { v = v ; s2 = \\_ => NON_EXISTENT } ;

}
