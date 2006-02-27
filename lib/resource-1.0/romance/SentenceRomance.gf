incomplete concrete SentenceRomance of Sentence = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! Aton Nom) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 Masc Sg) vp ;

    ImpVP = mkImperative ;

    SlashV2 np v2 = 
      mkClause 
        (np.s ! Aton Nom) np.a 
        (predV v2) **
      {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = 
      mkClause
        (np.s ! Aton Nom) np.a
        (insertComplement (\\a => prepCase vv.c2.c ++ v2.s ! VInfin) (predV v2)) **
      {c2 = v2.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,m => slash.s ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;

    SlashPrep cl prep = cl ** {c2 = {s = prep.s ; c = prep.c ; isDir = False}} ;

    EmbedS  s  = {s = conjThat ++ s.s ! Indic} ; --- mood
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q} ;
    UseRCl t a p cl = 
      {s = \\r,ag => t.s ++ a.s ++ p.s ++ cl.s ! ag ! t.t ! a.a ! p.p ! r} ;

}
