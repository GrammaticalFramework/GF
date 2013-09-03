concrete SentenceLat of Sentence = CatLat,TenseX ** open Prelude, ResLat in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = -- NP -> VP -> Cl
      {
	s = \\tense,anter,pol,order => 
	  case order of {
	    SVO => np.s ! Nom ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ++ vp.obj ;
	    VSO => negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ++ np.s ! Nom ++ vp.obj ;
	    VOS => negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ++ vp.obj ++ np.s ! Nom ;
	    OSV => vp.obj ++ np.s ! Nom ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ;
	    OVS => vp.obj ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p ++ np.s ! Nom ;
	    SOV => np.s ! Nom ++ vp.obj ++ negation pol ++ vp.adj ! Ag np.g Sg Nom ++ vp.fin ! VAct ( anteriorityToVAnter anter ) ( tenseToVTense tense ) np.n np.p 
	  } 
      } ;
--
--    PredSCVP sc vp = mkClause sc.s (agrP3 Sg) vp ;
--
--    ImpVP vp = {
--      s = \\pol,n => 
--        let 
--          agr   = AgP2 (numImp n) ;
--          verb  = infVP True vp agr ;
--          dont  = case pol of {
--            CNeg True => "don't" ;
--            CNeg False => "do" ++ "not" ;
--            _ => []
--            }
--        in
--        dont ++ verb
--    } ;
--
--    SlashVP np vp = 
--      mkClause (np.s ! Nom) np.a vp ** {c2 = vp.c2} ;
--
--    AdvSlash slash adv = {
--      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
--      c2 = slash.c2
--    } ;
--
--    SlashPrep cl prep = cl ** {c2 = prep.s} ;
--
--    SlashVS np vs slash = 
--      mkClause (np.s ! Nom) np.a 
--        (insertObj (\\_ => conjThat ++ slash.s) (predV vs))  **
--        {c2 = slash.c2} ;
--
--    EmbedS  s  = {s = conjThat ++ s.s} ;
--    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP False vp (agrP3 Sg)} ; --- agr
--
    UseCl  t p cl = -- Temp -> Pol-> Cl -> S
      {
	s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! SOV 
    } ;
--    UseQCl t p cl = {
--      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p ! q
--    } ;
--    UseRCl t p cl = {
--      s = \\r => t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p ! r ;
--      c = cl.c
--    } ;
--    UseSlash t p cl = {
--      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! ctr p.p  ! ODir ;
--      c2 = cl.c2
--    } ;
--
--    AdvS a s = {s = a.s ++ "," ++ s.s} ;
--
--    RelS s r = {s = s.s ++ "," ++ r.s ! agrP3 Sg} ;
--
--  oper
--    ctr = contrNeg True ;  -- contracted negations
--
}

