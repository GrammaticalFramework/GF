concrete ExtraEng of ExtraEngAbs = CatEng ** 
  open ResEng, Coordination, Prelude, MorphoEng in {

  lin
    GenNP np = {s = \\_,_ => np.s ! Gen ; sp = \\_,_,_ => np.s ! Gen} ;
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

    UncNegCl t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! unc p.p ! ODir
    } ;
    UncNegQCl t p cl = {
      s = \\q => t.s ++ p.s ++ cl.s ! t.t ! t.a ! unc p.p ! q
    } ;
    UncNegRCl t p cl = {
      s = \\r => t.s ++ p.s ++ cl.s ! t.t ! t.a ! unc p.p ! r ;
      c = cl.c
    } ;

    UncNegImpSg p imp = {s = p.s ++ imp.s ! unc p.p ! ImpF Sg False} ;
    UncNegImpPl p imp = {s = p.s ++ imp.s ! unc p.p ! ImpF Pl False} ;

    CompoundCN a b = {s = \\n,c => a.s ! Sg ! Nom ++ b.s ! n ! c ; g = b.g} ;

  oper
    unc = contrNeg False ; 


  lin
    that_RP = 
    { s = table {
        RC _ Gen    => "whose" ; 
        RC _ _      => "that" ;
        RPrep Neutr => "which" ;
        RPrep _     => "whom"
        } ;
      a = RNoAg
      } ;

    each_Det = mkDeterminer Sg "each" ;

} 
