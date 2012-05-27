concrete SentenceHeb of Sentence = CatHeb ** open ResHeb, Prelude in {

  flags optimize=all_subs ; coding=utf8 ;
        
 lin

  PredVP np vp = mkClause (np.s ! Nom).obj (agr2png np.a) vp ;

   UseCl t p cl =  {
      s = \\_ => t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p  
    } ;

 --UseSlash
 -- SlashVP

}
