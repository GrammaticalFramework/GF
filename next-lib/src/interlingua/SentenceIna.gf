concrete SentenceIna of Sentence = CatIna ** open Prelude, ResIna in {

flags optimize=all_subs ;

lin

  PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

  PredSCVP sc vp = mkClause sc.s Sp3 vp ;

  ImpVP vp = {s = \\pol,n=> (mkClause [] {n = n; p = P2} vp).s!Pres!Simul!pol!ODir};

  SlashVP np vp = mkClause (np.s ! Nom) np.a vp ** {c2 = vp.c2; p2 = vp.p2} ;

  SlashVS np vs slash = 
      mkClause (np.s ! Nom) np.a 
        (insertInvarObj ("que" ++ slash.s) (predV vs))  **
        {c2 = slash.c2; p2 = slash.p2} ;
  
  AdvSlash slash adv = {
    s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
    c2 = slash.c2;
    p2 = slash.p2
    } ;
  
  SlashPrep cl prep = cl ** {c2 = prep.c; p2 = prep.s} ;



    EmbedS  s  = {s = "que" ++ s.s} ;
    EmbedQS qs = {s = qs.s ! ODir} ;
    EmbedVP vp = {s = infVP vp} ;

    UseCl  t p cl = {s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! ODir} ;
    UseQCl t p cl = {s = \\o => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! o} ;
    UseRCl t p cl = {s = \\agr => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! agr};
    UseSlash t p cl = {s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! ODir;
		       c2 = cl.c2;
		       p2 = cl.p2} ;

    AdvS a s = {s = a.s ++ "," ++ s.s} ;

    RelS s r = {s = s.s ++ "," ++ r.s ! agrP3 Sg} ;

}
