concrete SentenceDut of Sentence = CatDut ** open ResDut, Prelude in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (np.s ! NPNom) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = {
      s = \\pol,im => 
        let 
          ps = case im of {
            ImpF Pl _     => <VImpPl,[],Pl> ;
            ImpF Sg True  => <VImp3,"u",Sg> ;
            ImpF Sg False => <VImp2,[],Sg>
            } ;
          agr  = {g = Utr ; n = ps.p3 ; p = P2} ; ---- P2? -- g does not matter
          verb = vp.s.s ! ps.p1 ;
          inf  = vp.inf.p1 ;
        in
        verb ++ ps.p2 ++ 
        vp.n2 ! agr ++ vp.a1 ! pol ++ vp.a2 ++ inf ++ vp.ext
    } ;

    SlashVP np vp = 
      mkClause 
        (np.s ! NPNom) np.a 
        vp **
      {c2 = vp.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep.s} ;

    SlashVS np vs slash = 
        mkClause (np.s ! NPNom) np.a 
          (insertExtrapos (conjThat ++ slash.s ! Sub) (predV vs)) **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = useInfVP False vp} ;

    UseCl t p cl = {
      s = \\o => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! o
      } ;
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
      } ;
    UseRCl t p cl = {
      s = \\g,n => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! g ! n
      } ;
    UseSlash t p cl = {
      s = \\o => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! o ;
      c2 = cl.c2
      } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! Inv} ;

    RelS s r = {s = \\o => s.s ! o ++ "," ++ r.s ! Neutr ! Sg} ;

}
