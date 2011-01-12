concrete SentenceSwa of Sentence = CatSwa ** open Prelude, ResSwa in {
  
 flags optimize=all_subs ;

 lin 
   PredVP np vp = mkClause (np.s ! Nom) np.a vp ;

}

