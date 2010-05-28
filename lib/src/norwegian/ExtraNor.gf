concrete ExtraNor of ExtraNorAbs = ExtraScandNor ** open CommonScand, ResNor, Prelude in {

  lin
    PossNP np pro = {
      s = table {
            NPPoss _ => np.s ! NPNom ++ pro.s ! NPPoss (gennumAgr np.a) ++ BIND ++ "s" ; ----
            _ => np.s ! NPNom ++ pro.s ! NPPoss (gennumAgr np.a)
            } ;
      a = np.a
      } ;
}
