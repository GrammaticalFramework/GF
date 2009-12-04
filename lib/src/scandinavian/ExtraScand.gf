incomplete concrete ExtraScand of ExtraScandAbs = CatScand ** 
   open CommonScand,Coordination,ResScand in {
  lin
    GenNP np = {
      s,sp = \\n,_,_,g => np.s ! NPPoss (gennum g n) ; 
      det = DDef Indef
      } ;

    ComplBareVS v s  = insertObj (\\_ => s.s ! Sub) (predV v) ;

    StrandRelSlash rp slash  = {
      s = \\t,a,p,ag => 
          rp.s ! ag.gn ! RNom ++ slash.s ! t ! a ! p ! Sub ++ slash.c2.s ;
      c = NPAcc
      } ;
    EmptyRelSlash slash = {
      s = \\t,a,p,ag => 
          slash.s ! t ! a ! p ! Sub ++ slash.c2.s ;
      c = NPAcc
      } ;

    StrandQuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = ip.s ! accusative
            in table {
              QDir   => who ++ cls ! Inv ++ slash.c2.s ;
              QIndir => who ++ cls ! Sub ++ slash.c2.s
              }
      } ;

  lincat
    VPI   = {s : VPIForm => Agr => Str} ;
    [VPI] = {s1,s2 : VPIForm => Agr => Str} ;

  lin
    BaseVPI = twoTable2 VPIForm Agr ;
    ConsVPI = consrTable2 VPIForm Agr comma ;

    MkVPI vp = {
      s = \\v,a => infVP vp a ---- no sup
      } ;
    ConjVPI = conjunctDistrTable2 VPIForm Agr ;
    ComplVPIVV vv vpi = insertObj (\\a => vv.c2.s ++ vpi.s ! VPIInf ! a) (predV vv) ;

  lincat
    VPS   = {s : Order => Agr => Str} ;
    [VPS] = {s1,s2 : Order => Agr => Str} ;

  lin
    BaseVPS = twoTable2 Order Agr ;
    ConsVPS = consrTable2 Order Agr comma ;

    PredVPS np vpi = 
      let
        subj = np.s ! nominative ;
        agr  = np.a ;
      in {
        s = \\o => 
          let verb = vpi.s ! o ! agr 
          in case o of {
            Main => subj ++ verb ;
            Inv  => verb ++ subj ;   ---- älskar henne och sover jag
            Sub  => subj ++ verb 
            }
        } ;

    MkVPS t p vp = {
      s = \\o,a => 
            let 
              neg = vp.a1 ! p.p ;
              verb = vp.s ! VPFinite t.t t.a ;
              compl = verb.inf ++ vp.n2 ! a ++ vp.a2 ++ vp.ext ;
            in t.s ++ p.s ++ case o of {
              Main => verb.fin ++ neg ++ compl ;
              Inv  => verb.fin ++ neg ++ compl ; ----
              Sub  => neg ++ verb.fin ++ compl
              }
      } ;

    ConjVPS = conjunctDistrTable2 Order Agr ;
} 
