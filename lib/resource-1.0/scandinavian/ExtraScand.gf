incomplete concrete ExtraScand of ExtraScandAbs = CatScand ** open CommonScand,ResScand in {

  lin
    GenNP np = {
      s = \\n,_,g => np.s ! NPPoss (gennum g n) ; 
      det = DDef Indef
      } ;

    ComplBareVS v s  = insertObj (\\_ => s.s ! Sub) (predV v) ;

    StrandRelSlash rp slash  = {
      s = \\t,a,p,ag => 
          rp.s ! ag.gn ! RNom ++ slash.s ! t ! a ! p ! Sub ++ slash.c2 ;
      c = NPAcc
      } ;
    EmptyRelSlash rp slash = {
      s = \\t,a,p,ag => 
          slash.s ! t ! a ! p ! Sub ++ slash.c2 ;
      c = NPAcc
      } ;

    StrandQuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ++ slash.c2 ;
              QIndir => who ++ cls ! Sub ++ slash.c2
              }
      } ;

} 
