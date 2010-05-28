concrete ExtraNor of ExtraNorAbs = ExtraScandNor ** open CommonScand, ResNor, Prelude in {

  lin
    PossNP np pro = {
      s = \\c => np.s ! NPNom ++ pro.s ! NPPoss (gennumAgr np.a) (caseNP c) ;
      a = np.a
      } ;

}
