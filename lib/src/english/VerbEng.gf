concrete VerbEng of Verb = CatEng ** open ResEng, Prelude in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    SlashV2a v = predVc v ** {c2 = v.c2 ; gapInMiddle = False} ;
    Slash2V3 v np = 
      insertObjc (\\_ => v.c2 ++ np.s ! NPAcc) (predVc v ** {c2 = v.c3 ; gapInMiddle = False}) ;
    Slash3V3 v np = 
      insertObjc (\\_ => v.c3 ++ np.s ! NPAcc) (predVc v) ; ----

    ComplVV v vp = insertObj (\\a => infVP v.typ vp False Simul CPos a) (predVV v) ;  ---- insertExtra?
    ComplVS v s  = insertExtra (conjThat ++ s.s) (predV v) ; 
---    ComplVS v s  = insertObj (variants {\\_ => conjThat ++ s.s; \\_ => s.s}) (predV v) ;
    ComplVQ v q  = insertExtra (q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (ap.s) (predV v) ;

    SlashV2V v vp = insertObjc (\\a => v.c3 ++ infVP v.typ vp False Simul CPos a) (predVc v) ;
    SlashV2S v s  = insertExtrac (conjThat ++ s.s) (predVc v) ;   ---- insertExtra?
---    SlashV2S v s  = insertObjc (variants {\\_ => conjThat ++ s.s; \\_ => s.s}) (predVc v) ;
    SlashV2Q v q  = insertExtrac (q.s ! QIndir) (predVc v) ;
    SlashV2A v ap = insertObjc (\\a => ap.s ! a) (predVc v) ; ----

    ComplSlash vp np =
      let vp' = case vp.gapInMiddle of {
                  True  => insertObjPre (\\_ => vp.c2 ++ np.s ! NPAcc) vp ;
                  False => insertObj    (\\_ => vp.c2 ++ np.s ! NPAcc) vp } ;

          -- IL 24/04/2018
          -- If the missing argument is not an adverbial, make previous object
          -- agree with the argument of ComplSlash.
          -- Example: "you help /me/ like /myself/", not "*you help me like yourself".
          -- Different order of ReflVP and ComplSlash produces "you /yourself/ help me like me".
            f = case vp.missingAdv of {
                  True => id VP ;
                  False => objAgr np } ;
      in f vp' ;

    SlashVV vv vp = vp **
      insertObj (\\a => infVP vv.typ vp False Simul CPos a) (predVV vv) ;
    SlashV2VNP vv np vp = vp **
      insertObjPre (\\_ => vv.c2 ++ np.s ! NPAcc)
      (insertObjc (\\a => vv.c3 ++ infVP vv.typ vp False Simul CPos a) (predVc vv)) ;

    UseComp comp = insertObj comp.s (predAux auxBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;
    ExtAdvVP vp adv = insertObj (\\_ => frontComma ++ adv.s ++ finalComma) vp ;
    AdVVP adv vp = insertAdV adv.s vp ;

    AdvVPSlash vp adv = vp ** insertObj (\\_ => adv.s) vp ;
    AdVVPSlash adv vp = vp ** insertAdV adv.s vp ;

    ReflVP v = insertObjPre (\\a => v.c2 ++ reflPron ! a) v ;

    PassV2 v = insertObj (\\_ => v.s ! VPPart ++ v.p) (predAux auxBe) ;

---b    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = [] ; isRefl = vv.isRefl} ; -- no "to"

    CompAP ap = ap ;
    CompNP np = {s = \\_ => np.s ! NPAcc} ;
    CompAdv a = {s = \\_ => a.s} ;
    CompCN cn = {s = \\a => case (fromAgr a).n of { 
      Sg => artIndef ++ cn.s ! Sg ! Nom ;
      Pl => cn.s ! Pl ! Nom
      }
    } ;

    UseCopula = predAux auxBe ;

    VPSlashPrep vp p = vp ** {c2 = p.s ; gapInMiddle = False; missingAdv = True } ;

}
