concrete ExtraNor of ExtraNorAbs = ExtraScandNor ** open CommonScand, ResNor in {

  lin
    PossNP np pro = {
      s = \\c => np.s ! NPNom ++ pro.s ! NPPoss np.a.gn ; ---- c 
      a = np.a
      } ;
}
