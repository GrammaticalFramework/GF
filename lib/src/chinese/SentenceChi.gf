concrete SentenceChi of Sentence = CatChi ** 
  open Prelude, ResChi in {

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
      mkClauseCompl np.s vp []
      ** {c2 = vp.c2} ;

    SlashVS np vs sslash = <mkClause np.s vs sslash.s : Clause> ** {c2 = sslash.c2} ;
      

    -- yet another reason for discontinuity of clauses
    AdvSlash slash adv = slash ** {vp = insertAdv adv slash.vp} ;
---- parser loops with unknown tokens if this version is used AR 20/4/2014
----      mkClauseCompl slash.np <insertAdv adv slash.vp : VP> []
----         ** {c2 = slash.c2} ;
  
    SlashPrep cl prep = cl ** {c2 = prep} ;
  
    EmbedS  s  = ss (conjThat ++ s.s) ;
    EmbedQS qs = qs ;
    EmbedVP vp = ss (infVP vp) ;

    UseCl  t p cl = {s = t.s ++ p.s ++ cl.s ! p.p ! t.t} ; 
    UseQCl t p cl = {s = t.s ++ p.s ++ cl.s ! p.p ! t.t} ; 
    UseRCl t p cl = {s = t.s ++ p.s ++ cl.s ! p.p ! t.t} ; 
    UseSlash t p cl = {s = t.s ++ p.s ++ cl.s ! p.p ! t.t ; c2 = cl.c2} ;

    AdvS a s = ss (a.s ++ s.s) ;
    ExtAdvS a s = ss (a.s ++ chcomma ++ s.s) ;

    RelS s r = ss (s.s ++ r.s) ;

    SSubjS a subj b = ss (a.s ++ subj.prePart ++ b.s ++ subj.sufPart) ;

}
