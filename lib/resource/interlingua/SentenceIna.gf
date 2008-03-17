concrete SentenceIna of Sentence = CatIna ** open Prelude, ResIna in {

flags optimize=all_subs ;

lin

  PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

  PredSCVP sc vp = mkClause sc.s Sp3 vp ;

  ImpVP vp = {s = \\pol,n=> (mkClause [] {n = n; p = P2} vp).s!Pres!Simul!pol!ODir};
  
  SlashV2 np v2 = mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2; p2 = v2.p2} ;


  SlashVVV2 np vv v2 = 
    mkClause (np.s ! Nom) np.a
    (insertInvarObj (infVP (predV v2)) (predV vv)) **
    {c2 = v2.c2; p2 = v2.p2} ;
  
  AdvSlash slash adv = {
    s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
    c2 = slash.c2;
    p2 = slash.p2
    } ;
  
  SlashPrep cl prep = cl ** {c2 = prep.c; p2 = prep.s} ;

  SlashVS np vs slash = 
      mkClause (np.s ! Nom) np.a 
        (insertInvarObj ("que" ++ slash.s) (predV vs))  **
        {c2 = slash.c2; p2 = slash.p2} ;


    EmbedS  s  = {s = "que" ++ s.s} ;
    EmbedQS qs = {s = qs.s ! ODir} ;
    EmbedVP vp = {s = infVP vp} ;

    UseCl  t a p cl = {s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! ODir} ;
    UseQCl t a p cl = {s = \\o => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! o} ;
    UseRCl t a p cl = {s = \\agr => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! agr};
    UseSlash t a p cl={s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! ODir;
		       c2 = cl.c2;
		       p2 = cl.p2} ;

    AdvS a s = {s = a.s ++ "," ++ s.s} ;

}

{-
--- todo: tense of embedded Slash

    SlashVSS np vs s = 
      mkClause (np.s ! Nom) np.a 
        (insertObj (\\_ => conjThat ++ s.s) (predV vs)) **
        {c2 = s.c2} ;
-}