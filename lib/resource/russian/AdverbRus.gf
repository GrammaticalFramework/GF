--# -path=.:../abstract:../common:../../prelude

concrete AdverbRus of Adverb = CatRus ** open ResRus, Prelude in {
flags  coding=utf8 ;

  lin
    PositAdvAdj a = {s = a.s !Posit! AdvF} ;
    ComparAdvAdj cadv a np = {
      s = cadv.s ++ a.s !Posit! AdvF ++ "чем" ++ np.s ! PF Nom No NonPoss
      } ;
    ComparAdvAdjS cadv a s = {
      s = cadv.s ++ a.s !Posit! AdvF ++ "чем" ++ s.s
      } ;

    PrepNP na stol = ss (na.s ++ stol.s ! PF na.c Yes NonPoss) ;

    AdAdv = cc2 ;

    SubjS = cc2 ;
    AdvSC s = s ; --- this rule give stack overflow in ordinary parsing

    AdnCAdv cadv = {s = cadv.s ++ "чем"} ;

}

