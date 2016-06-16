concrete ExtraNno of ExtraNnoAbs = ExtraScandNno ** open CommonScand, ResNno, Prelude in {

  lin
    PossNPPron np pro = {
      s = \\c => np.s ! NPNom ++ pro.s ! NPPoss (gennumAgr np.a) (caseNP c) ;
      a = np.a ;
      isPron = False ;
      } ;

    TFutKommer = {s = []} ** {t = SFutKommer} ;   --# notpresent

}
