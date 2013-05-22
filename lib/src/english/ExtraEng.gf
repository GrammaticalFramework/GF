concrete ExtraEng of ExtraEngAbs = CatEng ** 
  open ResEng, Coordination, Prelude, MorphoEng, ParadigmsEng in {

  lin
    GenNP np = {s = \\_,_ => np.s ! npGen ; sp = \\_,_,_ => np.s ! npGen} ;
    GenIP ip = {s = \\_ => ip.s ! NCase Gen} ;
    GenRP nu cn = {
      s = \\c => "whose" ++ nu.s ! Nom ++ 
                 case c of {
                   RC _ (NCase Gen) => cn.s ! nu.n ! Gen ;
                   _ => cn.s ! nu.n ! Nom
                   } ;
      a = RAg (agrP3 nu.n)
      } ;

    ComplBareVS v s  = insertObj (\\_ => s.s) (predV v) ;

    StrandRelSlash rp slash = {
      s = \\t,a,p,ag => 
        rp.s ! RC (fromAgr ag).g NPAcc ++ slash.s ! t ! a ! p ! ODir ++ slash.c2 ;
      c = NPAcc
      } ;
    EmptyRelSlash slash = {
      s = \\t,a,p,_ => slash.s ! t ! a ! p ! ODir ++ slash.c2 ;
      c = NPAcc
      } ;

    StrandQuestSlash ip slash = 
      {s = \\t,a,b,q => 
         (mkQuestion (ss (ip.s ! NPAcc)) slash).s ! t ! a ! b ! q ++ slash.c2
      };

  lincat
    VPI   = {s : VVType => Agr => Str} ;
    [VPI] = {s1,s2 : VVType => Agr => Str} ;

  lin
    BaseVPI = twoTable2 VVType Agr ;
    ConsVPI = consrTable2 VVType Agr comma ;

    MkVPI vp = {
      s = table {
            VVAux      => \\a => vp.ad ++ vp.inf ++ vp.p ++ vp.s2 ! a;
            VVInf      => \\a => "to" ++ vp.ad ++ vp.inf ++ vp.p ++ vp.s2 ! a;
            VVPresPart => \\a => vp.ad ++ vp.prp ++ vp.p ++ vp.s2 ! a
          }
      } ;
    ConjVPI = conjunctDistrTable2 VVType Agr ;
    ComplVPIVV vv vpi = 
      insertObj (\\a => vpi.s ! vv.typ ! a) (predVV vv) ;

  lin
    that_RP = 
    { s = table {
        RC _ (NCase Gen)    => "whose" ; 
        RC _ _      => "that" ;
        _           => "that"   ---- "in that" ?
--        RPrep Neutr => "which" ;
--        RPrep _     => "whom"
        } ;
      a = RNoAg
      } ;

    each_Det = mkDeterminer Sg "each" ;
    any_Quant = mkQuant "any" "any" ;

-- for VP conjunction

  lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;

    PredVPS np vpi = {s = np.s ! npNom ++ vpi.s ! np.a} ;

    MkVPS t p vp = {
      s = \\a => 
            let 
              verb = vp.s ! t.t ! t.a ! p.p ! ODir ! a ;
              verbf = verb.aux ++ verb.adv ++ verb.fin ++ verb.inf ;
            in t.s ++ p.s ++ vp.ad ++ verbf ++ vp.p ++ vp.s2 ! a
      } ;

    ConjVPS = conjunctDistrTable Agr ;

    ICompAP ap = {s = "how" ++ ap.s ! agrP3 Sg} ; ---- IComp should have agr!

    IAdvAdv adv = {s = "how" ++ adv.s} ;

    PartVP vp = {
      s = \\a => vp.ad ++ vp.prp ++ vp.s2 ! a ;
      isPre = False ---- depends on whether there are complements
      } ;

    EmbedPresPart vp = {s = infVP VVPresPart vp Simul CPos (agrP3 Sg)} ; --- agr

    UttVPShort vp = {s = infVP VVAux vp Simul CPos (agrP3 Sg)} ;

  do_VV = {
    s = table {
      VVF VInf => ["do"] ;
      VVF VPres => "does" ;
      VVF VPPart => ["done"] ; ----
      VVF VPresPart => ["doing"] ;
      VVF VPast => ["did"] ;      --# notpresent
      VVPastNeg => ["didn't"] ;      --# notpresent
      VVPresNeg => "doesn't"
      } ;
    p = [] ;
    typ = VVAux
    } ;

   may_VV = lin VV {
     s = table { 
      VVF VInf => ["be allowed to"] ;
      VVF VPres => "may" ;
      VVF VPPart => ["been allowed to"] ;
      VVF VPresPart => ["being allowed to"] ;
      VVF VPast => "might" ; --# notpresent
      VVPastNeg => "mightn't" ; --# notpresent
      VVPresNeg => "may not"
      } ;
    p = [] ;
    typ = VVAux
    } ;

   shall_VV = lin VV {
     s = table { 
      VVF VInf => ["be obliged to"] ; ---
      VVF VPres => "shall" ;
      VVF VPPart => ["been obliged to"] ;
      VVF VPresPart => ["being obliged to"] ;
      VVF VPast => "should" ; --# notpresent
      VVPastNeg => "shouldn't" ; --# notpresent
      VVPresNeg => "shall not"  --- shan't
      } ;
    p = [] ;
    typ = VVAux
    } ;


   NominalizeVPSlashNP vpslash np = 
     let vp : ResEng.VP = insertObjPre (\\_ => vpslash.c2 ++ np.s ! NPAcc) vpslash 
     in 
     lin NP {s=\\_=>vp.ad ++ vp.prp ++ vp.s2! (AgP3Sg Neutr); a=AgP3Sg Neutr } ;  

lin
  UncNeg = {s = [] ; p = CNeg False} ; 

  PassVPSlash vps = 
    let 
      be = predAux auxBe ;
      ppt = vps.ptp
    in {
    s = be.s ;
    p = [] ; 
    prp = be.prp ;
    ptp = be.ptp ;
    inf = be.inf ;
    ad = vps.ad ;
    s2 = \\a => ppt ++ vps.p ++ vps.s2 ! a ---- order
    } ;

   --- AR 7/3/2013
   ComplSlashPartLast vps np = case vps.gapInMiddle of {
     _  => insertObjPartLast (\\_ => vps.c2 ++ np.s ! NPAcc) vps  ---
     } ;

   --- AR 22/5/2013
   ExistsNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPAcc) (predV (regV "exist"))) ;

------------
--- obsolete: use UncNeg : Pol

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
    unc : CPolarity -> CPolarity = \x -> case x of {
      CNeg _ => CNeg False ; 
      _ => x
      } ;
-------


} 
