concrete ExtraEng of ExtraEngAbs = CatEng ** 
  open ResEng, Coordination, Prelude in {

  lin
    GenNP np = {s,sp = \\_,_ => np.s ! Gen} ;
    ComplBareVS v s  = insertObj (\\_ => s.s) (predV v) ;

    StrandRelSlash rp slash = {
      s = \\t,a,p,ag => 
        rp.s ! RC (fromAgr ag).g Acc ++ slash.s ! t ! a ! p ! ODir ++ slash.c2 ;
      c = Acc
      } ;
    EmptyRelSlash slash = {
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

    UncNegCl  t cl = {s = t.s ++ cl.s ! t.t ! t.a ! neg ! ODir} ;
    UncNegQCl t cl = {s = \\q => t.s ++ cl.s ! t.t ! t.a ! neg !q} ;
    UncNegRCl t cl = {
      s = \\r => t.s ++ cl.s ! t.t ! t.a ! neg ! r ;
      c = cl.c
      } ;
    UncNegImpSg imp = {s = imp.s ! neg ! ImpF Sg False} ;
    UncNegImpPl imp = {s = imp.s ! neg ! ImpF Pl False} ;

    CompoundCN a b = {s = \\n,c => a.s ! Sg ! Nom ++ b.s ! n ! c ; g = b.g} ;


  oper
    neg = CNeg False ; 

} 
