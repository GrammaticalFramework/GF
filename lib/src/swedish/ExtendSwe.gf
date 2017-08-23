--# -path=.:../scandinavian:../abstract:../common:prelude
concrete ExtendSwe of Extend = CatSwe **
  ExtendFunctor -
  [
    GenNP, ComplBareVS, CompBareCN,
    StrandRelSlash, EmptyRelSlash, StrandQuestSlash,
    MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
    MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
    ICompAP,
    RNP, RNPList, ReflRNP, ReflPron, ReflPoss, PredetRNP, ConjRNP,
    Base_rr_RNP, Base_nr_RNP, Base_rn_RNP, Cons_rr_RNP, Cons_nr_RNP
  ]
  with (Grammar = GrammarSwe)
    **
 open CommonScand, ResSwe, ParamX, VerbSwe, Prelude, DiffSwe, StructuralSwe, MorphoSwe,
      NounSwe, Coordination, AdjectiveSwe, SentenceSwe, AdverbSwe, RelativeSwe, (P = ParadigmsSwe) in {

  flags coding=utf8 ;

  lin
    GenNP np = {
      s,sp = \\n,_,_,g  => np.s ! NPPoss (gennum (ngen2gen g) n) Nom ; 
      det = DDef Indef
      } ;


    ComplBareVS v s  = insertObj (\\_ => s.s ! Sub) (predV v) ;

    CompBareCN cn = {s = \\a => case a.n of { 
      Sg => cn.s ! Sg ! DIndef ! Nom ;
      Pl => cn.s ! Pl ! DIndef ! Nom
      }
    } ;

    StrandRelSlash rp slash  = {
      s = \\t,a,p,ag,_ => 
          rp.s ! ag.g ! ag.n ! RNom ++ slash.s ! t ! a ! p ! Sub ++ slash.n3 ! ag ++ slash.c2.s ;
      c = NPAcc
      } ;
    EmptyRelSlash slash = {
      s = \\t,a,p,ag,_ => 
          slash.s ! t ! a ! p ! Sub ++ slash.c2.s ;
      c = NPAcc
      } ;

    StrandQuestSlash ip slash = {
      s = \\t,a,p => 
            let 
              cls = slash.s ! t ! a ! p ;
              who = ip.s ! accusative ;
	      agr = agrP3 ip.g ip.n ;
            in table {
              QDir   => who ++ cls ! Inv ++ slash.n3 ! agr ++ slash.c2.s ;
              QIndir => who ++ cls ! Sub ++ slash.n3 ! agr ++ slash.c2.s
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
              verb  = vp.s ! Act ! VPFinite t.t t.a ;
	      neg   = verb.a1 ! p.p ! a ;
              compl = vp.n2 ! a ++ vp.a2 ++ vp.ext ;
	      pron  = vp.n1 ! a
            in t.s ++ p.s ++ case o of {
              Main => verb.fin ++ neg.p1 ++ verb.inf ++ pron ++ neg.p2 ++ compl ;
              Inv  => verb.fin ++ neg.p1 ++ verb.inf ++ pron ++ neg.p2 ++ compl ; ----
              Sub  => neg.p1 ++ neg.p2 ++ verb.fin ++ verb.inf ++ pron ++ compl
              }
      } ;

    ConjVPS = conjunctDistrTable2 Order Agr ;

    ICompAP ap = {s = \\a => hur_IAdv.s ++ ap.s ! a} ;



  lincat
    RNP     = {s : Agr => Str ; isPron : Bool} ;   ---- inherent Agr needed: han färgar sitt hår vitt. But also depends on subject
    RNPList = {s1,s2 : Agr => Str} ;

  lin 
    ReflRNP vps rnp = 
      insertObjPron
        (andB (notB vps.c2.hasPrep) rnp.isPron)
        rnp.s
	(insertObj (\\a => vps.c2.s ++ vps.n3 ! a) vps) ;
	
    ReflPron = {s = \\a => reflPron a ; isPron = True} ; ---- agr ??
    ReflPoss num cn = {
      s = \\a => possPron a.n a.p num.n (ngen2gen cn.g) ++ num.s ! cn.g ++ cn.s ! num.n ! DDef Indef ! Nom ;
      isPron = False
      } ;
    PredetRNP predet rnp = {
      s = \\a => predet.s ! Utr ! Pl ++ predet.p ++ rnp.s ! a ;  ---- agr needed here as well
----      s = \\a => predet.s ! np.a.g ! np.a.n ++ predet.p ++ np.s ! a ;
----      a = case pred.a of {PAg n => agrP3 np.a.g n ; _ => np.a} ;
      isPron = False
      } ;

    ConjRNP conj rpns = conjunctDistrTable Agr conj rpns ** {isPron = False} ;

    Base_rr_RNP x y = twoTable Agr x y ;
    Base_nr_RNP x y = twoTable Agr {s = \\a => x.s ! NPAcc} y ;
    Base_rn_RNP x y = twoTable Agr x {s = \\a => y.s ! NPAcc} ;
    Cons_rr_RNP x xs = consrTable Agr comma x xs ;
    Cons_nr_RNP x xs = consrTable Agr comma {s = \\a => x.s ! NPAcc} xs ;


}

