-- VerbMlt.gf: verb phrases
--
-- Maltese GF Resource Grammar
-- John J. Camilleri 2011 -- 2013
-- Angelo Zammit 2012
-- Licensed under LGPL

concrete VerbMlt of Verb = CatMlt ** open Prelude, ResMlt in {
  flags optimize=all_subs ;

  lin
    -- V -> VP
    UseV = predV ;

    -- V2 -> VPSlash
    -- love (it)
    -- SlashV2a = predVc ;
    SlashV2a v2 = (predV v2) ** { c2 = noCompl } ; -- gets rid of the V2's prep

    -- V3 -> NP -> VPSlash
    -- give it (to her)
    Slash2V3 v np =
      insertObjc (\\_ => v.c2.s ! Definite ++ np.s ! NPAcc) (predV v ** {c2 = v.c3}) ;

    -- V3  -> NP -> VPSlash
    -- give (it) to her
    Slash3V3 v np =
      insertObjc (\\_ => v.c3.s ! Definite ++ np.s ! NPAcc) (predVc v) ;

    -- VV -> VP -> VP
    -- want to run
    ComplVV vv vp = insertObj (\\agr => infVP vp Simul Pos agr) (predV vv) ;

    -- VS -> S -> VP
    -- say that she runs
    ComplVS v s = insertObj (\\_ => conjLi ++ s.s) (predV v) ;

    -- VQ -> QS -> VP
    -- wonder who runs
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    -- VA -> AP -> VP
    -- they become red
    ComplVA v ap = insertObj (\\agr => ap.s ! toGenNum agr) (predV v) ;

    -- V2V -> VP -> VPSlash
    -- beg (her) to go
    SlashV2V v vp = insertObjc (\\agr => v.c3.s ! Definite ++ infVP vp Simul Pos agr) (predVc v) ;

    -- V2S -> S  -> VPSlash
    -- answer (to him) that it is good
    SlashV2S v s  = insertObjc (\\_ => conjThat ++ s.s) (predVc v) ;

    -- V2Q -> QS -> VPSlash
    -- ask (him) who came
    SlashV2Q v q  = insertObjc (\\_ => q.s ! QIndir) (predVc v) ;

    -- V2A -> AP -> VPSlash
    -- paint (it) red
    SlashV2A v ap = insertObjc (\\a => ap.s ! toGenNum a) (predVc v) ;

    -- VPSlash -> NP -> VP
    -- love it
    ComplSlash vp np =
      case <np.isPron, vp.c2.isPresent> of {

        -- Get enclitic version of c2
        <True,True> => {
            s = vp.s ;
            s2 = \\agr => vp.s2 ! agr ++ vp.c2.enclitic ! np.a ;
            dir = NullAgr ;
            ind = NullAgr ;
          } ;

        -- Add dir pron to verb
        <True,False> => insertDirObj np.a vp ;

        -- <False,False> => {
        --     s = vp.s ;
        --     s2 = \\agr => vp.c2.enclitic ! agr ;
        --     dir = NullVariants3 ;
        --     ind = NullVariants3 ;
        --   } ;

        -- Insert obj to VP
        -- _ => insertObj (\\agr => vp.c2.s ! bool2definiteness np.isDefn ++ np.s ! NPNom) vp
        _ => insertObj (\\agr => case <vp.c2.isPresent,np.isDefn> of {
                          <True,True>  => vp.c2.s ! Definite ++ np.s ! NPCPrep ; -- mal-qattus
                          <True,False> => vp.c2.s ! Indefinite ++ np.s ! NPNom ; -- ma' qattus
                          _            => np.s ! NPNom                           -- il-qattus
                          }) vp
      } ;

    -- VV -> VPSlash -> VPSlash
    -- want to buy
    SlashVV vv vp =
      insertObj (\\agr => infVP vp Simul Pos agr) (predV vv) **
        {c2 = vp.c2} ;

    -- V2V -> NP -> VPSlash -> VPSlash
    -- beg me to buy
    SlashV2VNP vv np vp =
      insertObjPre (\\_ => vv.c2.s ! Definite ++ np.s ! NPAcc)
        (insertObjc (\\agr => vv.c3.s ! Definite ++ infVP vp Simul Pos agr) (predVc vv)) **
          {c2 = vp.c2} ;

    -- Comp -> VP
    -- be warm
    UseComp comp = insertObj comp.s CopulaVP ;

    -- VP -> Adv -> VP
    -- sleep here
    AdvVP vp adv = case adv.joinsVerb of {
      True  => insertIndObj adv.a vp ;
      False => insertObj (\\_ => adv.s) vp
      } ;

    -- AdV -> VP -> VP
    -- always sleep
    AdVVP adv vp = insertAdV adv.s vp ;

    -- VPSlash -> Adv -> VPSlash
    -- use (it) here
    AdvVPSlash vp adv = case adv.joinsVerb of {
      True  => insertIndObj adv.a vp ;
      False => insertObj (\\_ => adv.s) vp
      }  ** {c2 = vp.c2} ;

    -- AdV -> VPSlash -> VPSlash
    -- always use (it)
    AdVVPSlash adv vp = insertAdV adv.s vp ** {c2 = vp.c2} ;

    -- VPSlash -> VP
    -- love himself
    ReflVP vpslash = insertObjPre (\\agr => vpslash.s2 ! agr ++ reflPron ! toVAgr agr) vpslash ;

    -- V2 -> VP
    -- be loved
    PassV2 v2 = insertObj (\\agr => (v2.s ! VPassivePart (toGenNum agr)).s1 ++ v2.c2.s ! Definite) CopulaVP ;

    -- AP -> Comp
    -- (be) small
    CompAP ap = {
      s = \\agr => ap.s ! toGenNum agr ;
      } ;

    -- NP -> Comp
    -- (be) the man
    CompNP np = {
      s = \\_ => np.s ! NPAcc ;
      } ;

    -- Adv -> Comp
    -- (be) here
    CompAdv adv = {
      s = \\_ => adv.s ;
      } ;

    -- CN -> Comp
    -- (be) a man/men
    CompCN cn = {
      s = \\agr => case agr.n of {
        Sg => artIndef ++ cn.s ! Singulative ;
        Pl => cn.s ! Plural
        } ;
    } ;

    -- VP
    -- be
    UseCopula = CopulaVP ;

    -- VP -> Prep -> VPSlash
    -- live in (it)
    VPSlashPrep vp p = vp ** {
      -- c2 = lin Compl (p ** {isPresent = True}) ;
      c2 = {
        s = p.s ;
        enclitic = p.enclitic ;
        takesDet = p.takesDet ;
        joinsVerb = p.joinsVerb ;
        isPresent = True ;
        } ;
      } ;

}
