concrete SentenceEng of Sentence = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = {
      s = \\t,a,b,o => 
        let 
          agr   = np.a ;
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          subj  = np.s ! Nom ;
          compl = vp.s2 ! agr 
        in
        case o of {
          ODir   => subj ++ verb.fin ++ verb.inf ++ compl ;
          OQuest => verb.fin ++ subj ++ verb.inf ++ compl
          }
    } ;

    PredSCVP sc vp = {
      s = \\t,a,b,o => 
        let 
          agr   = (agrP3 Sg).a ;
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          subj  = sc.s ;
          compl = vp.s2 ! agr 
        in
        case o of {
          ODir   => subj ++ verb.fin ++ verb.inf ++ compl ;
          OQuest => verb.fin ++ subj ++ verb.inf ++ compl
          }
    } ;

    ImpVP vp = {
      s = \\pol,n => 
        let 
          agr   = {n = n ; p = P2} ;
          verb  = infVP vp agr ;
          dont  = case pol of {
            Neg => "don't" ;
            _ => []
            }
        in
        dont ++ verb
    } ;

    SlashV2 np v2 = {
      s = \\t,a,b,o => 
        let 
          agr   = np.a ;
          verb  = (predV v2).s ! t ! a ! b ! o ! agr ;
          subj  = np.s ! Nom
        in
        case o of {
          ODir   => subj ++ verb.fin ++ verb.inf ;
          OQuest => verb.fin ++ subj ++ verb.inf
          } ;
      c2 = v2.c2 
    } ;
    --- not possible:
    --- PredVP (np ** {lock_NP =<>}) (UseV (v2 ** {lock_V = <>})) ** {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = {
      s = \\t,a,b,o => 
        let 
          agr   = np.a ;
          verb  = (predV vv).s ! t ! a ! b ! o ! agr ;
          inf   = "to" ++ v2.s ! VInf ;
          subj  = np.s ! Nom
        in
        case o of {
          ODir   => subj ++ verb.fin ++ verb.inf ++ inf ;
          OQuest => verb.fin ++ subj ++ verb.inf ++ inf
          } ;
      c2 = v2.c2 
    } ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep.s} ;

}
