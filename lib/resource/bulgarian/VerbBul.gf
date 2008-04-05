concrete VerbBul of Verb = CatBul ** open Prelude, ResBul, ParadigmsBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c ++ v.c3.s ++ np2.s ! RObj v.c3.c) (predV v) ;

    ComplVV vv vp = {
      s   = \\t,a,p,agr,q,asp => let vv_verb = (predV vv).s ! t ! a ! p ! agr ! q ! asp ;
                                     vp_verb = vp.s ! Pres ! Simul ! Pos ! agr ! False ! Perf ;
                                 in vv_verb ++ vp.ad ! False ++ "да" ++ vp_verb ;
      imp = vp.imp ;
      ad = \\_ => [] ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

    ComplVS v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ;
    ComplVQ v q  = insertObj (\\_ => q.s ! QIndir) (predV v) ;

    ComplVA  v    ap = insertObj (\\agr => ap.s ! aform agr.gn Indef (RObj Acc)) (predV v) ;
    ComplV2A v np ap = 
      insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c ++ ap.s ! aform np.a.gn Indef (RObj Acc)) (predV v) ;

    UseComp comp = insertObj comp.s (predV verbBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    AdVVP adv vp = {
      s   = \\t,a,p,agr,q,asp => vp.s ! t ! a ! p ! agr ! False ! asp ;
      imp = vp.imp ;
      ad  = \\q => vp.ad ! q ++ adv.s ++ case q of {True => "ли"; False => []} ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

    ReflV2 v = predV (reflV (v ** {lock_V=<>}) v.c2.c) ;

    PassV2 v = insertObj (\\a => v.s ! Perf ! VPassive (aform a.gn Indef (RObj Acc))) (predV verbWould) ;

    UseVS, UseVQ = \vv -> {s = vv.s; c2 = noPrep; vtype = vv.vtype} ; -- no "to"

    CompAP ap = {s = \\agr => ap.s ! aform agr.gn Indef (RObj Acc)} ;
    CompNP np = {s = \\_ => np.s ! RObj Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
