concrete ExtraEng of ExtraEngAbs = CatEng ** open ResEng in {

  lin
    GenNP np = {s = \\_ => np.s ! Gen} ;
    EmbedBareS s = s ;
    ComplBareVS v s  = insertObj (\\_ => s.s) (predV v) ;

} 
