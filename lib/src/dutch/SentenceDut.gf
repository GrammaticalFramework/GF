concrete SentenceDut of Sentence = CatDut ** open ResDut, Prelude in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (np.s ! NPNom) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = {
      s = \\pol,im => 
        let 
          ps = case im of {
            ImpF Pl _     => <VImp2,[],Pl,P2> ;
            ImpF Sg True  => <VImp3,"u",Sg,P3> ;
            ImpF Sg False => <VImp2,[],Sg,P2>
            } ;
          agr  = {g = Utr ; n = ps.p3 ; p = ps.p4 } ; -- g does not matter
          verb = vp.s.s ! ps.p1 ;
	  part = vp.s.particle ++ vp.a2 ++ vp.s.prefix ; -- as in mkClause
          inf  = vp.inf.p1 ;
        in
          case vp.negPos of {
             BeforeObjs => verb ++ ps.p2 ++ vp.a1 ! pol ++ vp.n0 ! agr ++ 
                     vp.n2 ! agr ++ part ++ inf ++ vp.ext ;
             AfterObjs => verb ++ ps.p2 ++ vp.n0 ! agr ++ vp.n2 ! agr ++ 
                     vp.a1 ! pol ++ part ++ inf ++ vp.ext ;
             BetweenObjs => verb ++ ps.p2 ++ vp.n0 ! agr ++ vp.a1 ! pol ++ vp.n2 ! agr ++ 
                     part ++ inf ++ vp.ext 
	  } ;
    } ;

    SlashVP np vp = 
      mkClause 
        (np.s ! NPNom) np.a 
        vp **
      {c2 = vp.c2.p1} ; --ClSlash has just Preposition, not Prep * Bool

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep} ;

    SlashVS np vs slash = 
        mkClause (np.s ! NPNom) np.a 
          (insertExtrapos (conjThat ++ slash.s ! Sub) (predV vs)) **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Sub} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = useInfVP False vp ! agrP3 Sg } ;

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
    ExtAdvS a s = {s = \\o => a.s ++ bindComma ++ s.s ! Inv} ;

    RelS s r = {s = \\o => s.s ! o ++ bindComma ++ r.s ! Neutr ! Sg} ;

    SSubjS a s b = {s = \\o => a.s ! o ++ bindComma ++ s.s ++ b.s ! Sub} ;

}
