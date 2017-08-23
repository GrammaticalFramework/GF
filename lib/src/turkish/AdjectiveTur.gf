concrete AdjectiveTur of Adjective = CatTur ** open ResTur, Prelude in {

  lin

    PositA  a = {s = a.s} ;

    ComparA a np = {
      s = \\n,c => np.s ! Ablat ++ a.s ! n ! c ;
    } ;

    UseComparA a = {
      s = \\n,c => "daha" ++ a.s ! n ! c
    } ;

    AdjOrd v = v ;

    AdvAP ap adv = {
      s = \\n, c => adv.s ++ ap.s ! n ! c
    } ;

    UseA2 a = {s = a.s} ;

    ComplA2 a np = {
      s = \\n, c => np.s ! a.c.c ++ a.c.s ++ a.s ! n ! c
    } ;

}
