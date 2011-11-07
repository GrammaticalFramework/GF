concrete AdverbTha of Adverb = CatTha ** 
  open ResTha, StringsTha, Prelude in {

  lin
    PositAdvAdj a = a ;

    PrepNP prep np = thbind prep np ;

    ComparAdvAdj cadv a np = ss (thbind a.s cadv.s np.s) ;

    ComparAdvAdjS cadv a s = ss (thbind a.s cadv.s s.s) ;

    AdAdv adv ad = thbind ad adv ;

    SubjS = thbind ;

    AdnCAdv cadv = ss (thbind cadv.s conjThat) ; -----

}
