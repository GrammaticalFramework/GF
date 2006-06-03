incomplete concrete ExtraScand of ExtraScandAbs = CatScand ** open CommonScand,ResScand in {

  lin
    GenNP np = {
      s = \\n,_,g => np.s ! NPPoss (gennum g n) ; 
      det = DDef Indef
      } ;

    EmbedBareS s = {s = s.s ! Sub} ;
    ComplBareVS v s  = insertObj (\\_ => s.s ! Sub) (predV v) ;

} 
