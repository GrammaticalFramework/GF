incomplete concrete SentenceScand of Sentence = 
  CatScand ** open CommonScand, ResScand in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! nominative) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 neutrum Sg) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = {gn = gennum utrum n ; p = P2} ;
          verb  = vp.s ! VPImperat ;
        in
        verb.fin ++ vp.a1 ! pol ++ verb.inf ++ vp.n2 ! agr ++ vp.a2 ++ vp.ext
    } ;

    SlashV2 np v2 = 
      mkClause 
        (np.s ! nominative) np.a 
        (predV v2) **
      {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = 
      mkClause
        (np.s ! nominative) np.a 
        (insertObj (\\_ => vv.c2 ++ infVP (predV v2) np.a) (predV vv)) ** 
      {c2 = v2.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep.s} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infMark ++ infVP vp (agrP3 utrum Sg)} ; --- agr

    UseCl  t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q} ;
    UseRCl t a p cl = {
      s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ;
      c = cl.c
      } ;

}
