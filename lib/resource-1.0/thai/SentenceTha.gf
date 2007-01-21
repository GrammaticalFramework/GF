concrete SentenceTha of Sentence = CatTha ** open Prelude, ResTha in {

  flags optimize=all_subs ;

  lin

    PredVP = cc2 ;

--    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = vp ;

--    SlashV2 np v2 = 
--      mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2} ;
--
--    SlashVVV2 np vv v2 = 
--      mkClause (np.s ! Nom) np.a 
--        (insertObj (\\a => infVP vv.isAux (predV v2) a) (predVV vv))  **
--        {c2 = v2.c2} ;
--
--    AdvSlash slash adv = {
--      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
--      c2 = slash.c2
--    } ;
--
--    SlashPrep cl prep = cl ** {c2 = prep.s} ;
--
--    EmbedS  s  = {s = conjThat ++ s.s} ;
--    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP False vp (agrP3 Sg)} ; --- agr
--
--    UseCl  t a p cl = {s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! ctr p.p ! ODir} ;
--    UseQCl t a p cl = {s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! ctr p.p ! q} ;
--    UseRCl t a p cl = {
--      s = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! ctr p.p ! r ;
--      c = cl.c
--      } ;
--
--    AdvS a s = {s = a.s ++ "," ++ s.s} ;
--
--  oper
--    ctr = contrNeg True ;  -- contracted negations
--}
--
--{-
----- todo: tense of embedded Slash
--
--    SlashVSS np vs s = 
--      mkClause (np.s ! Nom) np.a 
--        (insertObj (\\_ => conjThat ++ s.s) (predV vs)) **
--        {c2 = s.c2} ;
}
