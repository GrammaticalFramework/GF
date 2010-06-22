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

-- for VP conjunction

  param
    VPIForm = VPIInf | VPIPPart ;

  lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;

    PredVPS np vpi = {s = np.s ! Nom ++ vpi.s ! np.a} ;

    MkVPS t p vp = {
      s = \\a => 
            let 
              verb = vp.s ! t.t ! t.a ! contrNeg True p.p ! ODir ! a ;
              verbf = verb.aux ++ verb.adv ++ verb.fin ++ verb.inf ;
            in t.s ++ p.s ++ vp.ad ++ verbf ++ vp.s2 ! a
      } ;

    ConjVPS = conjunctDistrTable Agr ;

    ICompAP ap = {s = "how" ++ ap.s ! agrP3 Sg} ; ---- IComp should have agr!

    IAdvAdv adv = {s = "how" ++ adv.s} ;

  lincat
    [CN] = {s1,s2 : Number => Case => Str} ;

  lin
    BaseCN = twoTable2 Number Case ;
    ConsCN = consrTable2 Number Case comma ;
    ConjCN co ns = conjunctDistrTable2 Number Case co ns ** {g = Neutr} ; --- gender?

    PartVP vp = {
      s = \\a => vp.ad ++ vp.prp ++ vp.s2 ! a ;
      isPre = False ---- depends on whether there are complements
      } ;

  lincat 
    QVP = ResEng.VP ;
    [IAdv] = {s1,s2 : Str} ;
  lin
    ComplSlashIP vp np = insertObjPre (\\_ => vp.c2 ++ np.s ! Acc) vp ;
    AdvQVP vp adv = insertObj (\\_ => adv.s) vp ;
    AddAdvQVP vp adv = insertObj (\\_ => adv.s) vp ;

    QuestQVP qp vp = 
      let cl = mkClause (qp.s ! Nom) (agrP3 qp.n) vp
      in {s = \\t,a,b,_ => cl.s ! t ! a ! b ! ODir} ;

    BaseIAdv = twoSS ;
    ConsIAdv = consrSS comma ;
    ConjIAdv = conjunctDistrSS ;   

    AdvAP ap adv = {s = \\a => ap.s ! a ++ adv.s ; isPre = False} ;

    UseCopula = predAux auxBe ;

    UttVPShort vp = {s = infVP True vp (agrP3 Sg)} ;
} 
