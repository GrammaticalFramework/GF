concrete AdverbGre of Adverb = CatGre ** open ResGre, Prelude in {
flags coding = utf8 ;
  lin


    PositAdvAdj a = {s = a.adv ! Posit} ;


    ComparAdvAdj cadv a np = {
     s = cadv.s ++ a.adv ! Posit ++ cadv.p ++ (np.s ! cadv.c).comp
    } ;


    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.adv ! Posit ++ cadv.p ++ "οτι" ++ s.s ! Ind    
    } ;

   
   PrepNP prep np = {
      s = prep.s ++ (np.s ! prep.c).comp 
    } ;

    AdAdv = cc2 ;

    PositAdAAdj a = {s = a.adv ! Posit} ;

  

   SubjS subj s = {
      s = subj.s ++ s.s ! subj.m
    }  ;

    AdnCAdv cadv = {s = cadv.s2 ++ cadv.p} ;

}
