concrete AdjectiveTur of Adjective = CatTur ** open ResTur, Prelude in {

  lin
    PositA  a = {s=a.s} ;
    ComparA a np = {
      s = \\n,c => np.s ! Ablat ++ a.s ! n ! c ; 
      } ;
    UseComparA a = {
      s = \\n,c => "daha" ++ a.s ! n ! c
      } ;

    AdjOrd v = v ;

}
