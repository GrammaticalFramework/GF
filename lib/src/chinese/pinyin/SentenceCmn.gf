concrete SentenceCmn of Sentence = CatCmn ** 
  open Prelude, ResCmn in {

  flags optimize=all_subs ;

  lin

    PredVP np vp = mkClause np.s vp ;

    PredSCVP sc vp = mkClause sc.s vp ;

    ImpVP vp = {
      s = table {
        Pos =>          infVP vp ;
        Neg => neg_s ++ infVP vp 
        }
      } ;

    SlashVP np vp = 
      mkClauseCompl np.s (\\p,a => vp.prePart ++ useVerb vp.verb ! p ! a) vp.compl 
      ** {c2 = vp.c2} ;

    SlashVS np vs sslash = <mkClause np.s vs sslash.s : Clause> ** {c2 = sslash.c2} ;
      

    -- yet another reason for discontinuity of clauses
    AdvSlash slash adv = 
      mkClause slash.np (<\\p,a => adv.s ++ slash.vp ! p ! a : Polarity => Aspect => Str>) [] 
         ** {c2 = slash.c2} ;
  
    SlashPrep cl prep = cl ** {c2 = prep} ;
  
    EmbedS  s  = ss (conjThat ++ s.s) ;
    EmbedQS qs = qs ;
    EmbedVP vp = ss (infVP vp) ;

    UseCl  t p cl = {s = cl.s ! p.p ! t.t} ; 
    UseQCl t p cl = {s = cl.s ! p.p ! t.t} ; 
    UseRCl t p cl = {s = cl.s ! p.p ! t.t} ; 
    UseSlash t p cl = {s = cl.s ! p.p ! t.t ; c2 = cl.c2} ;

    AdvS a s = ss (a.s ++ s.s) ;

    RelS s r = ss (s.s ++ r.s) ;
}
