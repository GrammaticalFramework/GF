concrete VerbBul of Verb = CatBul ** open ResBul in {

  flags optimize=all_subs ;

  lin
    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.c2 ++ np.s ! Acc) (predV v) ;
    ComplV3 v np np2 = 
      insertObj (\\_ => v.c2 ++ np.s ! Acc ++ v.c3 ++ np2.s ! Acc) (predV v) ;

    UseComp comp = insertObj comp.s (predV auxBe) ;

    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    ReflV2 v = insertObj (\\_ => v.c2 ++ ["себе си"]) (predV v) ;

    PassV2 v = insertObj (\\a => v.s ! VPassive (aform a.gn Indef Acc)) (predV auxBe) ;

    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;
}
