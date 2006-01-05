concrete SentenceGer of Sentence = CatGer ** open ResGer in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

--    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;
--
--    ImpVP vp = {
--      s = \\pol,n => 
--        let 
--          agr   = {n = n ; p = P2} ;
--          verb  = infVP vp agr ;
--          dont  = case pol of {
--            Neg => "don't" ;
--            _ => []
--            }
--        in
--        dont ++ verb
--    } ;
--
--    SlashV2 np v2 = 
--      mkClause (np.s ! Nom) np.a (predV v2) ** {c2 = v2.c2} ;
--
--    SlashVVV2 np vv v2 = 
--      mkClause (np.s ! Nom) np.a (insertObj (\\_ => "to" ++ v2.s ! VInf) (predV vv))  **
--      {c2 = v2.c2} ;
--
--    AdvSlash slash adv = {
--      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
--      c2 = slash.c2
--    } ;
--
--    SlashPrep cl prep = cl ** {c2 = prep.s} ;
--
}
