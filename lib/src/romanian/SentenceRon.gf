 concrete SentenceRon of Sentence = 
  CatRon ** open Prelude, ResRon in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkClause (np.s ! No).comp np.isPol np.a vp ;

    PredSCVP sc vp = mkClause sc.s False (agrP3 Masc Sg) vp ;

    ImpVP vpr = let agSg = {n = Sg ; g = Masc ; p = P2 } ;
                    agPl = {n = Pl ; g = Masc ; p = P2 } ;
                    clDirSg = vpr.clDat.s ! Imperative ++ (vpr.isRefl ! agSg).s ! Imperative  ++ vpr.clAcc.s ! Imperative ;
                    clDirPl = vpr.clDat.s ! Imperative ++ (vpr.isRefl ! agPl).s ! Imperative  ++ vpr.clAcc.s ! Imperative ;
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
                                     Pl => "nu" ++ clNegPl ++ vpr.s ! Indi Presn Pl P2 ++ vpr.comp ! agPl ++ vpr.ext ! Pos
                                     }
                                }
      } ;

    SlashVP np v2 = 
      {s = \\bb,ag=> 
          let 
            vp = v2 ** {lock_VP = <>};
            bcond = andB vp.needClit bb
            in
            case <bcond,v2.c2.isDir> of
             {<True, Dir pc> => (mkClause (np.s ! No).comp np.isPol np.a (putClit (agrP3 ag.g ag.n) pc vp)).s ;
              _      => (mkClause (np.s ! No).comp np.isPol np.a vp).s
              };
              c2 = v2.c2
      } ;

    AdvSlash slash adv = {
      s  = \\bb,ag,d,t,a,b,m => slash.s ! bb ! ag ! d ! t ! a ! b ! m ++ adv.s ;
      c2 = slash.c2
      } ;
-- potentially overgenerating !! since the complements have a preposition already 

    SlashPrep cl prep = {
      s  = \\bb => \\_ => cl.s ; 
      c2 = {s = prep.s ; c = prep.c ; isDir = NoDir; needIndef = prep.needIndef; prepDir = ""}
      } ;

    SlashVS np vs slash = 
      {s = \\bb,ag =>
        (mkClause
          (np.s ! No).comp np.isPol np.a
          (insertExtrapos (\\b => conjThat ++ slash.s !  ag ! (vs.m ! b))
            (predV vs))
        ).s ;
       c2 = slash.c2
      } ;

    EmbedS  s  = {s = conjThat ++ s.s ! Indic} ; 

    EmbedQS qs = {s = qs.s ! QIndir} ;
   EmbedVP vp = let a = agrP3 Masc Sg in 
      { s= "sã" ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++vp.comp ! a ++ vp.ext ! Pos };

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
          t.s ++ p.s ++ cl.s ! False ! ag ! DDir ! t.t ! t.a ! p.p ! mo ;
      c2 = cl.c2
    } ;

    AdvS a s = {s = \\o => a.s ++ s.s ! o} ;

    RelS s r = {
      s = \\o => s.s ! o ++ "," ++ r.s ! Indic ! agrP3 Masc Sg
      } ;

 oper putClit : Agr -> ParClit -> VP -> VP = \ag, pc, vp -> let nrC = nextClit vp.nrClit pc 
   in
 case pc of
 {PAcc => {s = vp.s; isRefl = vp.isRefl; clDat = vp.clDat; clAcc = cliticsAc ag.g ag.n ag.p; isFemSg = isAgrFSg ag;
           comp = vp.comp; ext = vp.ext; neg = vp.neg; nrClit = nrC ; vpre = vp.vpre ; clitPre = vp.clitPre ; pReflClit = vp.pReflClit ;lock_VP = <>};
  PDat => {s = vp.s; isRefl = vp.isRefl; clDat = cliticsDa ag.g ag.n ag.p; clAcc = vp.clAcc; isFemSg = vp.isFemSg;
           comp = vp.comp; ext = vp.ext; neg = vp.neg; nrClit = nrC ; vpre = vp.vpre ; pReflClit = vp.pReflClit ;clitPre = vp.clitPre ;lock_VP = <>}          
 };
      
      
}
