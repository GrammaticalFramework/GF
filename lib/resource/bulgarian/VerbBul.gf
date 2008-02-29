concrete VerbBul of Verb = CatBul ** open Prelude, ResBul, ParadigmsBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c ++ v.c3.s ++ np2.s ! RObj v.c3.c) (predV v) ;

    ComplVV vv vp = {
      s   = \\t,a,p,agr,q => (predV vv).s ! t ! a ! p ! agr ! q ++ vp.ad ! False ++ "да" ++ vp.s ! Pres ! Simul ! Pos ! agr ! False ;
      imp = vp.imp ;
      ad = \\_ => [] ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

    ComplVS v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ;

    UseComp comp = insertObj comp.s (predV verbBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    AdVVP adv vp = {
      s   = \\t,a,p,agr,q => vp.s ! t ! a ! p ! agr ! False ;
      imp = vp.imp ;
      ad  = \\q => vp.ad ! q ++ adv.s ++ case q of {True => "ли"; False => []} ;
      s2 = vp.s2 ;
      subjRole = vp.subjRole
      } ;

    ReflV2 v = predV (reflV (v ** {lock_V=<>}) v.c2.c) ;

    PassV2 v = insertObj (\\a => v.s ! VPassive (aform a.gn Indef (RObj Acc))) (predV verbBe) ;

    UseVS, UseVQ = \vv -> {s = vv.s; c2 = noPrep; vtype = vv.vtype} ; -- no "to"

    CompAP ap = {s = \\agr => ap.s ! aform agr.gn Indef (RObj Acc)} ;
    CompNP np = {s = \\_ => np.s ! RObj Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
