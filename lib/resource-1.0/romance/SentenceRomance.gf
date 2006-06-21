incomplete concrete SentenceRomance of Sentence = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! Aton Nom) np.a vp ;

    PredSCVP sc vp = mkClause sc.s (agrP3 Masc Sg) vp ;

    ImpVP = mkImperative P2 ;

    SlashV2 np v2 = 
      {s = \\ag =>case <v2.c2.c,v2.c2.isDir> of {
          <Acc,True> => 
               (mkClause (np.s ! Aton Nom) np.a 
                                 (insertAgr ag (predV v2))).s ;
          _ => (mkClause (np.s ! Aton Nom) np.a (predV v2)).s
          } ;
       c2 = v2.c2
      } ;

    SlashVVV2 np vv v2 = 
      {s = \\_ =>
        (mkClause
         (np.s ! Aton Nom) np.a
         (insertComplement 
           (\\a => prepCase vv.c2.c ++ v2.s ! VInfin) (predV vv))).s ;
       c2 = v2.c2
      } ;

    AdvSlash slash adv = {
      s  = \\ag,t,a,b,m => slash.s ! ag ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;

    SlashPrep cl prep = {
      s  = \\_ => cl.s ; 
      c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;

    EmbedS  s  = {s = conjThat ++ s.s ! Indic} ; --- mood
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q} ;
    UseRCl t a p cl = {
      s = \\r,ag => t.s ++ a.s ++ p.s ++ cl.s ! ag ! t.t ! a.a ! p.p ! r ; 
      c = cl.c
      } ;

}
