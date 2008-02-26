concrete VerbBul of Verb = CatBul ** open ResBul, ParadigmsBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2.s ++ np.s ! RObj v.c2.c ++ v.c3.s ++ np2.s ! RObj v.c3.c) (predV v) ;

    ComplVS v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ;

    UseComp comp = insertObj comp.s (predV verbBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    ReflV2 v = predV (reflV v v.c2.c) ;

    PassV2 v = insertObj (\\a => v.s ! VPassive (aform a.gn Indef (RObj Acc))) (predV verbBe) ;

    UseVS, UseVQ = \vv -> {s = vv.s; c2 = noPrep; vtype = vv.vtype} ; -- no "to"

    CompAP ap = {s = \\agr => ap.s ! aform agr.gn Indef (RObj Acc)} ;
    CompNP np = {s = \\_ => np.s ! RObj Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
