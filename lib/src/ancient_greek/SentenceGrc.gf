concrete SentenceGrc of Sentence = CatGrc ** open Prelude, ResGrc, (T=TenseGrc) in {

  flags 
    optimize=all_subs ;

  lin

    PredVP np vp = let agr = np.a in mkClause (np.s ! Nom) agr vp ; 

    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;

    ImpVP vp = { -- Sketch only TODO
      s = \\pol,f => 
             let 
                imp   = vp.s ! (VPImp f) ;
                dont  = case pol of { Pos => [] ; Neg => "mh'" } ;
                pn    = case f of {ImpF IPres SgP2 => <Sg, P2> ;
                                   ImpF IPres SgP3 => <Sg, P3> ;
                                   ImpF IPres PlP2 => <Pl, P2> ;
                                   ImpF IPres PlP3 => <Pl, P3> ;
                                   ImpF IAor  SgP2 => <Sg, P2> ;
                                   ImpF IAor  SgP3 => <Sg, P3> ;
                                   ImpF IAor  PlP2 => <Pl, P2> ;
                                   ImpF IAor  PlP3 => <Pl, P3> ;
                                   ImpF IPerf SgP2 => <Sg, P2> ;
                                   ImpF IPerf SgP3 => <Sg, P3> ;
                                   ImpF IPerf PlP2 => <Pl, P2> ;
                                   ImpF IPerf PlP3 => <Pl, P3> } ;
                n = pn.p1 ;
                p = pn.p2
             in
                dont ++ imp ++ vp.obj ! (Ag Masc n p) ++ vp.adj ! Masc ! n;
    } ;

    SlashVP np vp = -- : NP -> VPSlash -> ClSlash ;      -- (whom) he sees
       mkClause (np.s ! Nom) np.a vp ** {c2 = vp.c2} ; 

--    AdvSlash slash adv = {
--      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
--      c2 = slash.c2
--    } ;

    SlashPrep cl prep = cl ** {c2 = prep} ;

    SlashVS np vs slash =  -- TODO: Check with Greek grammar
      mkClause (np.s ! Nom) np.a 
        (insertObj (\\_ => conjThat ++ slash.s) (predV vs))  **
        {c2 = slash.c2} ;

    EmbedS  s  = {s = conjThat ++ s.s} ;
--    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP False vp (agrP3 Sg)} ; --- agr

    UseCl t p cl = 
      let ta = antTense t.t t.a 
       in lin S { s = t.s ++ p.s ++ cl.s ! ta ! p.p ! SVO } ; -- TODO: Order 

    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! (antTense t.t t.a) ! p.p ! q 
    } ;

    UseRCl temp p cl = let ta = antTense temp.t temp.a in {
      s = \\agr => temp.s ++ p.s ++ cl.s ! ta ! p.p ! agr ; 
      c = cl.c
    } ;

    UseSlash t p cl = let ta = antTense t.t t.a in {
      s = t.s ++ p.s ++ cl.s ! ta ! p.p ! OSV ; -- TODO: Order 
      c2 = cl.c2
    } ;

    AdvS a s = {s = a.s ++ s.s} ;              -- TODO: check with Greek grammar

    RelS s r = {s = s.s ++ "," ++ r.s ! agrP3 Sg} ;  -- TODO: check with Greek grammar


}

