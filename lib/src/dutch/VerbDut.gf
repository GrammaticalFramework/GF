concrete VerbDut of Verb = CatDut ** open Prelude, ResDut in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;

    ComplVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux vp.negPos (v2v v)))) ; ---- subtyp

    ComplVS v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predV v) ;
    ComplVQ v q = 
      insertExtrapos (q.s ! QIndir) (predV v) ;
    ComplVA v ap = insertObj (\\ _ => ap.s ! APred) (predVGen False BetweenObjs v) ;

    SlashV2a v = predV (v2v v) ** {c2 = v.c2} ; 
      
    Slash2V3 v np =
      insertObj (\\_ => appPrep v.c2.p1 np.s) (predVv v) ** {c2 = v.c3} ;
    Slash3V3 v np =
      insertObj (\\_ => appPrep v.c3.p1 np.s) (predVv v) ** {c2 = v.c2} ;

    SlashV2S v s = 
      insertExtrapos (conjThat ++ s.s ! Sub) (predVv v) ** {c2 = v.c2} ;
    SlashV2Q v q = 
      insertExtrapos (q.s ! QIndir) (predVv v) ** {c2 = v.c2} ;
    SlashV2V v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 ((predVGen v.isAux vp.negPos v)))) ** {c2 = v.c2} ;

    SlashV2A v ap = 
      insertObj (\\_ => ap.s ! APred) (predVGen False BetweenObjs (v2v v)) ** {c2 = v.c2} ;

    --vp.c2.p2: if the verb has a preposition or not
    ComplSlash vp np = insertObjNP np.isPron (case vp.c2.p2 of {True => BeforeObjs; False => vp.negPos}) (\\_ => appPrep vp.c2.p1 np.s) vp ;

    SlashVV v vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux vp.negPos (v2v v)))) ** {c2 = vp.c2} ;

    SlashV2VNP v np vp = 
      let 
        vpi = infVP v.isAux vp 
      in
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            insertObj (\\_ => appPrep v.c2.p1 np.s) (
              predVGen v.isAux vp.negPos v)))) ** {c2 = v.c2} ;

    -- BeforeObjs, because negation comes before copula complement 
    -- "ik ben niet groot" but "ik begrijp hem niet"
    UseComp comp = insertObjNP False BeforeObjs comp.s (predV zijn_V) ; -- agr not used

    UseCopula = predV zijn_V; 

    CompCN cn = {s = \\a => cn.s ! Strong ! NF a.n Nom} ;
    CompAP ap = {s = \\_ => ap.s ! APred} ;
    CompNP np = {s = \\_ => np.s ! NPNom} ;
    CompAdv a = {s = \\_ => a.s} ;

    AdvVP vp adv = insertAdv adv.s vp ;
    ExtAdvVP vp adv = insertAdv (embedInCommas adv.s) vp ;

    AdVVP adv vp = insertAdV adv.s vp ;

    ReflVP vp = insertObj (\\a => appPrep vp.c2.p1 (\\_ => reflPron ! a)) vp ;

    PassV2 v = insertInf (v.s ! VPerf) (predV worden_V) ;

    VPSlashPrep vp prep = vp ** {c2 = <prep.s,True>} ;

---- workaround for a subtyping bug
  oper
    v2v : VVerb -> VVerb = \v -> 
      {s = v.s ; aux = v.aux ; prefix = v.prefix ; particle = v.particle ; vtype = v.vtype} ;
    predVv : VVerb -> ResDut.VP = \v -> predV (v2v v) ;

}
