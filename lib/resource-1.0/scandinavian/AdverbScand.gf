incomplete concrete AdverbScand of Adverb = CatScand ** open CommonScand, ResScand, Prelude in {

  lin
    PositAdvAdj a = {
      s = a.s ! adverbForm
      } ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s ! adverbForm ++ conjThan ++ np.s ! nominative
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s ! adverbForm ++ conjThan ++ s.s ! Sub
      } ;

    PrepNP prep np = {s = prep.s ++ np.s ! accusative} ;

    AdAdv = cc2 ;

    SubjS subj s = {
      s = subj.s ++ s.s ! Sub
      }  ;
    AdvSC s = s ;

    AdnCAdv cadv = {s = cadv.s ++ conjThan} ;

  oper
    adverbForm : AForm = AF (APosit (Strong SgNeutr)) Nom ;

}
