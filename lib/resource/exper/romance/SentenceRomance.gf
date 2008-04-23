incomplete concrete SentenceRomance of Sentence = 
  CatRomance ** open Prelude, CommonRomance, ResRomance in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! Aton Nom) np.hasClit np.a vp ;

    PredSCVP sc vp = mkClause sc.s False (agrP3 Masc Sg) vp ;

    ImpVP vp = {
      s = \\p,i,g => case i of {
        ImpF n b => (mkImperative b P2 vp).s ! p ! (aagr g n)
        }
      } ;

    SlashVP np v2 = 
      {s = \\d,ag =>case <v2.c2.c,v2.c2.isDir> of {
          <Acc,True> => 
               (mkClause (np.s ! Aton Nom) np.hasClit np.a 
                                 (insertAgr ag v2)).s ! d ;
          _ => (mkClause (np.s ! Aton Nom) np.hasClit np.a v2).s ! d
          } ;
       c2 = v2.c2
      } ;

{---b
    SlashV2 np v2 = 
      {s = \\d,ag =>case <v2.c2.c,v2.c2.isDir> of {
          <Acc,True> => 
               (mkClause (np.s ! Aton Nom) np.hasClit np.a 
                                 (insertAgr ag (predV v2))).s ! d ;
          _ => (mkClause (np.s ! Aton Nom) np.hasClit np.a (predV v2)).s ! d
          } ;
       c2 = v2.c2
      } ;

    SlashVVV2 np vv v2 = 
      {s = \\d,_ =>
        (mkClause
         (np.s ! Aton Nom) np.hasClit np.a
         (insertComplement 
           (\\a => prepCase vv.c2.c ++ v2.s ! VInfin False) (predV vv))).s ! d;
       c2 = v2.c2
      } ;
-}
    AdvSlash slash adv = {
      s  = \\d,ag,t,a,b,m => slash.s ! d! ag ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;

    SlashPrep cl prep = {
      s  = \\d,_ => cl.s ! d ; 
      c2 = {s = prep.s ; c = prep.c ; isDir = False}
      } ;

    SlashVS np vs slash = 
      {s = \\d,ag =>
        (mkClause
          (np.s ! Aton Nom) np.hasClit np.a
          (insertExtrapos (\\b => conjThat ++ slash.s ! ag ! (vs.m ! b)) --- ag?
            (predV vs))
        ).s ! d ;
       c2 = slash.c2
      } ;

    EmbedS  s  = {s = conjThat ++ s.s ! Indic} ; --- mood
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t a p cl = {
      s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! DDir ! t.t ! a.a ! p.p ! o
    } ;
    UseQCl t a p cl = {
      s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q
    } ;
    UseRCl t a p cl = {
      s = \\r,ag => t.s ++ a.s ++ p.s ++ cl.s ! ag ! t.t ! a.a ! p.p ! r ; 
      c = cl.c
      } ;
    UseSlash t a p cl = {
      s = \\agr,mo => 
          t.s ++ a.s ++ p.s ++ cl.s ! DDir ! agr ! t.t ! a.a ! p.p ! mo ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ "," ++ s.s ! o} ;

}
