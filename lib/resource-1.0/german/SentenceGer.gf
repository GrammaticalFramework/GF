concrete SentenceGer of Sentence = CatGer ** open ResGer, Prelude in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          ps = case n of {
            ImpF _ True => <P3,"Sie",True> ; -- setzen Sie sich
            _ => <P2,[],False>
            } ;
          agr  = {g = Fem ; n = numImp n ; p = ps.p1} ; --- g does not matter
          verb = vp.s ! agr ! VPImperat ps.p3 ;
          inf  = vp.inf ++ verb.inf ;
        in
        verb.fin ++ ps.p2 ++ 
        vp.n2 ! agr ++ vp.a1 ! pol ++ vp.a2 ++ inf ++ vp.ext
    } ;

    SlashV2 np v2 = 
      mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = 
        mkClause (np.s ! Nom) np.a 
          (insertInf (v2.prefix ++ infPart vv.isAux  ++ v2.s ! VInf) 
             (predVGen vv.isAux vv)) **
        {c2 = v2.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = useInfVP False vp} ;

    UseCl  t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q} ;
    UseRCl t a p cl = {
      s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ;
      c = cl.c
      } ;

    AdvS a s = {s = \\o => a.s ++ "," ++ s.s ! o} ;

}
