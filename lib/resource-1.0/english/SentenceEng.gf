concrete SentenceEng of Sentence = CatEng ** open ResEng in {

  flags optimize=all_subs ;

  lin
    PredVP np vp = mkS (np.s ! Nom) np.a vp.s vp.s2 ;

    PredSCVP sc vp = mkS sc.s (agrP3 Sg) vp.s vp.s2 ;

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

    SlashV2 np v2 = mkS (np.s ! Nom) np.a (predV v2).s (\\_ => []) **
      {c2 = v2.c2} ;

    SlashVVV2 np vv v2 = 
      mkS (np.s ! Nom) np.a (predV vv).s (\\_ => "to" ++ v2.s ! VInf) **
      {c2 = v2.c2} ;

    AdvSlash slash adv = {
      s  = \\t,a,b,o => slash.s ! t ! a ! b ! o ++ adv.s ;
      c2 = slash.c2
    } ;

    SlashPrep cl prep = cl ** {c2 = prep.s} ;

}
