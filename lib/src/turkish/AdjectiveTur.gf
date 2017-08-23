concrete AdjectiveTur of Adjective =
  CatTur ** open ResTur, ParadigmsTur, Prelude in {

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

    -- TODO: Whether this is correct or not requires further examination.
    ReflA2 a = {
      s =
        let
          kendi : N = mkN "kendi"
        in
          \\n, c => kendi.s ! n ! c ++ a.c.s ++ a.s ! n ! Nom
    } ;

}
