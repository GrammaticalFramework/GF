concrete FunEng of Fun = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    Pred np vp = {
      s = \\t,a,o,b => 
        let 
          agr   = np.a ;
          verb  = vp.s ! t ! a ! o ! b ! agr ;
          subj  = np.s ! Nom ;
          compl = vp.s2 ! agr
        in
        case o of {
          ODir   => subj ++ verb.fin ++ verb.inf ++ compl ;
          OQuest => verb.fin ++ subj ++ verb.inf ++ compl
          }
    } ;

    UseV = predV ;
    ComplV2 v np = insertObj (\\_ => v.s2 ++ np.s ! Acc) (predV v) ;
    ComplVV v vp = insertObj (\\a => v.s2 ++ infVP vp a) (predV v) ;
    UseComp comp = insertObj comp.s (predAux auxBe) ;
    AdvVP vp adv = insertObj (\\_ => adv.s) vp ;

    UseVV vv = {s = vv.s ; s2 = []} ; -- no "to"

    CompAP ap = {s = \\_ => ap.s} ;
    CompNP np = {s = \\_ => np.s ! Acc} ;
    CompAdv a = {s = \\_ => a.s} ;

}
