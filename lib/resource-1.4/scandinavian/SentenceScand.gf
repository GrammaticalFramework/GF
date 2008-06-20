incomplete concrete SentenceScand of Sentence = 
  CatScand ** open CommonScand, ResScand, Prelude in {

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

    SlashVP np vp = 
      mkClause 
        (np.s ! nominative) np.a 
        vp **
      {c2 = vp.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = {s = prep.s ; hasPrep = True}} ;

    SlashVS np vs slash = 
      mkClause
        (np.s ! nominative) np.a 
        (insertObj (\\_ => conjThat ++ slash.s ! Sub) (predV vs)) **
      {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infMark ++ infVP vp (agrP3 utrum Sg)} ; --- agr

    UseCl t a p cl = {
      s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o
    } ;
    UseQCl t a p cl = {
      s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q
    } ;
    UseRCl t a p cl = {
      s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ;
      c = cl.c
    } ;
    UseSlash t a p cl = {
      s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! Inv} ;

    RelS s r = {s = \\o => s.s ! o ++ "," ++ r.s ! agrP3 Neutr Sg} ; --- vilket

}
