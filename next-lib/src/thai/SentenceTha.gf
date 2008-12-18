concrete SentenceTha of Sentence = CatTha ** 
  open Prelude, StringsTha, ResTha in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = {s = \\p => np.s ++ vp.s ! p} ;

--    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = {
      s = table {
        Pos => vp.s ! Pos ++ si_s ;
        Neg => yaa_s ++ vp.s ! Pos
        }
      } ;
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
    UseCl  t p cl = {s = t.s ++ p.s ++ cl.s ! p.p} ;
    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++
                 case q of {QIndir => waa_s ; _ => []} ++ 
                 cl.s ! p.p
      } ;
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
