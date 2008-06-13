concrete SentenceBul of Sentence = CatBul ** open Prelude, ResBul in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! vp.subjRole) np.a vp ;

    PredSCVP sc vp = mkClause sc.s {gn=GSg Masc; p=P3} vp ;

    ImpVP vp = {
      s = \\p,gn => 
        let agr = {gn = gn ; p = P2} ;
            verb = vp.imp ! p ! numGenNum gn ! Perf ;
            compl = vp.compl ! agr
        in
        verb ++ compl
    } ;

    SlashVP np slash =  {
      s = \\agr => (mkClSlash (np.s ! RSubj) np.a agr slash).s ;
      c2 = slash.c2
    } ;

    AdvSlash slash adv = {
      s  = \\agr,t,a,b,o => slash.s ! agr ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = {s = \\_ => cl.s; c2 = prep} ;
    
    SlashVS np vs slash = {
      s = \\agr => (mkClause (np.s ! RSubj) np.a 
                             (insertObj (\\_ => "че" ++ slash.s ! agr) (predV vs))).s ;
      c2 = slash.c2
    } ;

    EmbedS  s  = {s = "," ++ "че" ++ s.s} ;
    EmbedQS qs = {s = qs.s ! QIndir} ;
    EmbedVP vp = {s = vp.ad ! False ++ "да" ++ vp.s ! Pres ! Simul ! Pos ! {gn=GSg Masc; p=P1} ! False ! Perf} ;

    UseCl t a p cl = {
      s = t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! Main
    } ;
    UseQCl t a p cl = {
      s = \\q => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! q
    } ;
    UseRCl t a p cl = {
      s    = \\r => t.s ++ a.s ++ p.s ++ cl.s ! t.t ! a.a ! p.p ! r ;
      role = cl.role
    } ;
    UseSlash t a p cl = {
      s = \\agr => t.s ++ a.s ++ p.s ++ cl.s ! agr ! t.t ! a.a ! p.p ! Main ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = a.s ++ "," ++ s.s} ;

---- FIXME: guessed by AR
-- test: she walks , which is good

    RelS s r = {s = s.s ++ "," ++ r.s ! gennum DNeut Sg} ;

}
