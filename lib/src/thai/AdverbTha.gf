concrete AdverbTha of Adverb = CatTha ** 
  open ResTha, StringsTha, Prelude in {

  lin
    PositAdvAdj a = a ;

    PrepNP prep np = thbind prep np ;

    ComparAdvAdj cadv a np = ss (thbind a.s cadv.s cadv.p np.s) ;

    ComparAdvAdjS cadv a s = ss (thbind a.s cadv.s cadv.p s.s) ;

    AdAdv adv ad = thbind ad adv ;

    SubjS x y = thbind x y ;

    AdnCAdv cadv = ss (thbind cadv.s conjThat) ; -----

}
