incomplete concrete SentenceRon of Sentence = 
  CatRon ** open Prelude, ResRon in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! No).comp np.hasClit np.a vp ;

    PredSCVP sc vp = mkClause sc.s False (agrP3 Masc Sg) vp ;

    ImpVP vpr = let agSg = {n = Sg ; g = Masc ; p = P2 } ;
                    agPl = {n = Pl ; g = Masc ; p = P2 } ;
                    clDirSg = vpr.clDat.s ! Vocative ++ (vpr.isRefl ! agSg).s ! Vocative  ++ vpr.clAcc.s ! Vocative ;
                    clDirPl = vpr.clDat.s ! Vocative ++ (vpr.isRefl ! agPl).s ! Vocative  ++ vpr.clAcc.s ! Vocative ;
                    clNegSg = flattenSimpleClitics vpr.nrClit vpr.clAcc vpr.clDat (vpr.isRefl ! agSg) ;
                    clNegPl = flattenSimpleClitics vpr.nrClit vpr.clAcc vpr.clDat (vpr.isRefl ! agPl) 
                    in 
     {
      s = \\p,f,g => 
           case <p,f> of {
                   <Pos,ImpF n False>  => case n of 
                                  { Sg => vpr.s ! Imper SgP2  ++ vpr.comp ! agSg ++ vpr.ext ! Pos;
                                    _  => vpr.s ! Imper PlP2  ++ vpr.comp ! agPl ++ vpr.ext ! Pos 
                                    };
                   <Pos, ImpF n True> => case n of 
                                    {Sg => "sã"  ++ clNegSg ++ conjVP vpr agSg ++ vpr.comp ! agSg ++ vpr.ext ! Pos;
                                     Pl => "sã"  ++  clNegPl ++ conjVP vpr agPl ++ vpr.comp ! agPl ++ vpr.ext ! Pos
                                     };
                    <Neg, ImpF n b> => case n of 
                                    {Sg => "nu" ++ clNegSg ++ vpr.s ! Inf ++ vpr.comp ! agSg ++ vpr.ext ! Pos;
                                     Pl => "nu" ++ clNegPl ++ vpr.s ! Inf ++ vpr.comp ! agPl ++ vpr.ext ! Pos
                                     }
                                }
      } ;

    SlashVP np v2 = 
      {s = \\ag => 
          let 
            vp = v2
          in (mkClause (np.s ! No).comp np.hasClit np.a vp).s ;
       c2 = v2.c2
      } ;

    AdvSlash slash adv = {
      s  = \\ag,d,t,a,b,m => slash.s ! ag ! d ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;
-- potentially overgenerating !! since the complements have a preposition already 

    SlashPrep cl prep = {
      s  = \\_ => cl.s ; 
      c2 = {s = prep.s ; c = prep.c ; isDir = NoDir; needIndef = prep.needIndef; prepDir = ""}
      } ;

    SlashVS np vs slash = 
      {s = \\ag =>
        (mkClause
          (np.s ! No).comp np.hasClit np.a
          (insertExtrapos (\\b => conjThat ++ slash.s ! ag ! (vs.m ! b))
            (predV vs))
        ).s ;
       c2 = slash.c2
      } ;

    EmbedS  s  = {s = conjThat ++ s.s ! Indic} ; 

    EmbedQS qs = {s = qs.s ! QIndir} ;
--    EmbedVP vp = {s = infVP vp (agrP3 Masc Sg)} ; --- agr ---- compl

    UseCl  t p cl = {
      s = \\o => t.s ++ p.s ++ cl.s ! DDir ! t.t ! t.a ! p.p ! o
    } ;

    UseQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! q
    } ;
 
 UseRCl t p cl = {
      s = \\r,ag => t.s ++ p.s ++ cl.s ! ag ! t.t ! t.a ! p.p ! r ; 
      c = cl.c
      } ;
   UseSlash t p cl = {
      s = \\ag,mo => 
          t.s ++ p.s ++ cl.s ! ag ! DDir ! t.t ! t.a ! p.p ! mo ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! o} ;

    RelS s r = {
      s = \\o => s.s ! o ++ "," ++ r.s ! Indic ! agrP3 Masc Sg
      } ;

}
