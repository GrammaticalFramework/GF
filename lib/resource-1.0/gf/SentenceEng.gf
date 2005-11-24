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

}
