concrete ExtraEng of ExtraEngAbs = CatEng ** open ResEng, Prelude in {

  lin
    GenNP np = {s = \\_ => np.s ! Gen} ;
    ComplBareVS v s  = insertObj (\\_ => s.s) (predV v) ;

    UncNegCl  t a cl = {s = t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg ! ODir} ;
    UncNegQCl t a cl = {s = \\q => t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg !q} ;
    UncNegRCl t a cl = {
      s = \\r => t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg ! r ;
      c = cl.c
      } ;
    UncNegImpSg imp = {s = imp.s ! neg ! Sg} ;
    UncNegImpPl imp = {s = imp.s ! neg ! Pl} ;


  oper
    neg = CNeg False ; 

} 
