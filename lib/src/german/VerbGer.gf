concrete VerbGer of Verb = CatGer ** open Prelude, ResGer, Coordination in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
       insertExtrapos vpi.p4 (
        insertInfExt vpi.p3 (
          insertInf vpi.p2 (
            insertObj vpi.p1 (
              predVGen v.isAux v)))) ;

    ComplVS v s = 
      insertExtrapos (comma ++ conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q = 
      insertExtrapos (comma ++ q.s ! QIndir) (predV v) ;
    ComplVA  v ap = insertObj (\\ _ => ap.s ! APred) (predV v) ;

    SlashV2a v = predV v ** {c2 = v.c2} ; 
      
    Slash2V3 v np =
      insertObj (\\_ => appPrep v.c2 np.s) (predV v) ** {c2 = v.c3} ;
    Slash3V3 v np =
      insertObj (\\_ => appPrep v.c3 np.s) (predV v) ** {c2 = v.c2} ;

    SlashV2S v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ** {c2 = v.c2} ;
    SlashV2Q v q = 
      insertExtrapos (q.s ! QIndir) (predV v) ** {c2 = v.c2} ;
    SlashV2V v vp = 
      let 
        vpi = infVP False vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 ((predV v)))) ** {c2 = v.c2} ;

    SlashV2A v ap = 
      insertObj (\\_ => ap.s ! APred) (predV v) ** {c2 = v.c2} ;

    ComplSlash vp np = insertObjNP (isLightComplement np.isPron vp.c2) (\\_ => appPrep vp.c2 np.s) vp ;

    SlashVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux v))) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      let 
        vpi = infVP False vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            insertObj (\\_ => appPrep v.c2 np.s) (
              predV v)))) ** {c2 = v.c2} ;

    UseComp comp = insertObj comp.s (predV sein_V) ; -- agr not used
    -- we want to say "ich liebe sie nicht" but not "ich bin alt nicht"
    UseCopula = predV sein_V ;

    CompAP ap = {s = \\_ => ap.s ! APred} ;
    CompNP np = {s = \\_ => np.s ! NPC Nom} ;
    CompAdv a = {s = \\_ => a.s} ;

    CompCN cn = {s = \\a => case numberAgr a of {
        Sg => "ein" + pronEnding ! GSg cn.g ! Nom ++ cn.s ! Strong ! Sg ! Nom ;
        Pl => cn.s ! Strong ! Pl ! Nom
        }
      } ;

    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdv adv.s vp ; -- not AdV 27/5/2012: nicht immer

    AdvVPSlash vp adv = insertAdv adv.s vp ** {c2 = vp.c2} ;
    AdVVPSlash adv vp = insertAdv adv.s vp ** {c2 = vp.c2} ;

    ReflVP vp = insertObj (\\a => appPrep vp.c2 
      (\\k => usePrepC k (\c -> reflPron ! a ! c))) vp ;

    PassV2 v = insertInf (v.s ! VPastPart APred) (predV werdenPass) ;

    VPSlashPrep vp prep = vp ** {c2 = prep} ;

}
