concrete VerbBul of Verb = CatBul ** open ResBul, ParadigmsBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2.s ++ np.s ! v.c2.c) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2.s ++ np.s ! v.c2.c ++ v.c3.s ++ np2.s ! v.c3.c) (predV v) ;

    ComplVS v s  = insertObj (\\_ => "," ++ "че" ++ s.s) (predV v) ;

    UseComp comp = insertObj comp.s (predV auxBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    ReflV2 v = insertObj (\\_ => v.c2.s ++ case v.c2.c of {Dat => "си"; _ => "се"}) (predV v) ;

    PassV2 v = insertObj (\\a => v.s ! VPassive (aform a.gn Indef Acc)) (predV auxBe) ;

    UseVS, UseVQ = \vv -> {s = vv.s ; c2 = noPrep ; isRefl = vv.isRefl} ; -- no "to"

    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
