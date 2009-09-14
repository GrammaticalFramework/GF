concrete AdverbRon of Adverb = 
  CatRon ** open ResRon, Prelude in {

  lin
    PositAdvAdj a = {
      s = a.s ! AA
      } ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! AA ++ cadv.p ++ (np.s ! No).comp 
                 
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! AA ++ cadv.p ++ s.s ! Indic
      } ;
   
    PrepNP prep np = {s = case prep.needIndef of
                              {False => prep.s ++ (np.s ! prep.c).comp;
                               _     => prep.s ++ np.indForm}
                      };

    AdAdv ada adv = {s = ada.s ++ adv.s }  ;
    
    SubjS subj s = {
      s = subj.s ++ s.s ! Indic
      }  ;
    
    AdnCAdv cadv = {s = cadv.s ++ conjThan} ; 
-- doesn't yield to a correct form for more_CAdv

}
