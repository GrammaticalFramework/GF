concrete ExtraLat of ExtraLatAbs = CatLat ** 
  open ResLat, Coordination, Prelude in {

  lin
    GenNP np = {s,sp = \\_,_ => np.s ! Gen} ;
    ComplBareVS v s  = insertObj (\\_ => s.s) (predV v) ;

    StrandRelSlash rp slash = {
      s = \\t,a,p,ag => 
        rp.s ! RC (fromAgr ag).g Acc ++ slash.s ! t ! a ! p ! ODir ++ slash.c2 ;
      c = Acc
      } ;
    EmptyRelSlash rp slash = {
      s = \\t,a,p,_ => slash.s ! t ! a ! p ! ODir ++ slash.c2 ;
      c = Acc
      } ;

    StrandQuestSlash ip slash = 
      {s = \\t,a,b,q => 
         (mkQuestion (ss (ip.s ! Acc)) slash).s ! t ! a ! b ! q ++ slash.c2
      };

  lincat
    VPI   = {s : VPIForm => Agr => Str} ;
    [VPI] = {s1,s2 : VPIForm => Agr => Str} ;

  lin
    BaseVPI = twoTable2 VPIForm Agr ;
    ConsVPI = consrTable2 VPIForm Agr comma ;

    MkVPI vp = {
      s = \\v,a => vp.ad ++ vp.inf ++ vp.s2 ! a
      } ;
    ConjVPI = conjunctDistrTable2 VPIForm Agr ;
    ComplVPIVV vv vpi = 
      insertObj (\\a => (if_then_Str vv.isAux [] "to") ++ vpi.s ! VPIInf ! a) (predVV vv) ;

    UncNegCl  t a cl = {s = t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg ! ODir} ;
    UncNegQCl t a cl = {s = \\q => t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg !q} ;
    UncNegRCl t a cl = {
      s = \\r => t.s ++ a.s ++ cl.s ! t.t ! a.a ! neg ! r ;
      c = cl.c
      } ;
    UncNegImpSg imp = {s = imp.s ! neg ! ImpF Sg False} ;
    UncNegImpPl imp = {s = imp.s ! neg ! ImpF Pl False} ;

    CompoundCN a b = {s = \\n,c => a.s ! Sg ! Nom ++ b.s ! n ! c ; g = b.g} ;


  oper
    neg = CNeg False ; 

} 
