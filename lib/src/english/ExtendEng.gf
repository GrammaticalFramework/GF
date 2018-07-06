--# -path=.:../common:../abstract

concrete ExtendEng of Extend =
  CatEng ** ExtendFunctor -
  [
    VPS, ListVPS, VPI, ListVPI, VPS2, ListVPS2, VPI2, ListVPI2, RNP, RNPList, 
    AdAdV, AdjAsCN, AdjAsNP, ApposNP,
    BaseVPS, ConsVPS, BaseVPI, ConsVPI, BaseVPS2, ConsVPS2, BaseVPI2, ConsVPI2,
    MkVPS, ConjVPS, PredVPS, MkVPI, ConjVPI, ComplVPIVV,
    MkVPS2, ConjVPS2, ComplVPS2, MkVPI2, ConjVPI2, ComplVPI2,
    Base_nr_RNP, Base_rn_RNP, Base_rr_RNP, ByVP, CompBareCN,
    CompIQuant, CompQS, CompS, CompVP, ComplBareVS, ComplGenVV, ComplSlashPartLast, ComplVPSVV, CompoundAP,
    CompoundN, ConjRNP, ConjVPS, ConsVPS, Cons_nr_RNP, Cons_rr_RNP, DetNPMasc, DetNPFem, EmbedPresPart, EmptyRelSlash,
    ExistsNP, ExistCN, ExistMassCN, ExistPluralCN,
    FocusAP, FocusAdV, FocusAdv, FocusObj, GenIP, GenModIP, GenModNP, GenNP, GenRP,
    GerundAdv, GerundCN, GerundNP, IAdvAdv, ICompAP, InOrderToVP, MkVPS, NominalizeVPSlashNP,
    PassAgentVPSlash, PassVPSlash, PastPartAP, PastPartAgentAP, PositAdVAdj, PredVPS, PredVPSVV, PredetRNP, PrepCN,
    PresPartAP, PurposeVP, ReflPoss, ReflPron, ReflRNP, SlashBareV2S, SlashV2V, StrandQuestSlash, StrandRelSlash,
    UncontractedNeg, UttAccIP, UttAccNP, UttAdV, UttDatIP, UttDatNP, UttVPShort, WithoutVP, BaseVPS2, ConsVPS2, ConjVPS2, ComplVPS2, MkVPS2
   ]
  with
    (Grammar = GrammarEng) **

  open
    GrammarEng,
    ResEng,
    Coordination,
    Prelude,
    MorphoEng,
    ParadigmsEng in {

  lin
    GenNP np = {s = \\_,_ => np.s ! npGen ; sp = \\_,_,_,_ => np.s ! npGen ; isDef = True} ;
    GenIP ip = {s = \\_ => ip.s ! NCase Gen} ;
    GenRP nu cn = {
      s = \\c => "whose" ++ nu.s ! False ! Nom ++ 
                 case c of {
                   RC _ (NCase Gen) => cn.s ! nu.n ! Gen ;
                   _ => cn.s ! nu.n ! Nom
                   } ;
      a = RAg (agrP3 nu.n)
      } ;
      
    GenModNP num np cn = DetCN (DetQuant (GenNP (lin NP np)) num) cn ;
    GenModIP num ip cn = IdetCN (IdetQuant (GenIP (lin IP ip)) num) cn ;

    StrandQuestSlash ip slash = 
      {s = \\t,a,b,q => 
         (mkQuestion (ss (ip.s ! NPAcc)) slash).s ! t ! a ! b ! q ++ slash.c2
      };
    StrandRelSlash rp slash = {
      s = \\t,a,p,ag => 
        rp.s ! RC (fromAgr ag).g NPAcc ++ slash.s ! t ! a ! p ! oDir ++ slash.c2 ;
      c = NPAcc
      } ;
    EmptyRelSlash slash = {
      s = \\t,a,p,_ => slash.s ! t ! a ! p ! oDir ++ slash.c2 ;
      c = NPAcc
      } ;

    DetNPMasc det = {
      s = det.sp ! Masc ! False ;
      a = agrgP3 det.n Masc
      } ;

    DetNPFem det = {
      s = det.sp ! Fem ! False ;
      a = agrgP3 det.n Fem
      } ;

  lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ; 
    VPI   = {s : VVType => Agr => Str} ;
    [VPI] = {s1,s2 : VVType => Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;
    
    BaseVPI = twoTable2 VVType Agr ;
    ConsVPI = consrTable2 VVType Agr comma ;

    MkVPS t p vp = mkVPS (lin Temp t) (lin Pol p) (lin VP vp) ;
    ConjVPS c xs = conjunctDistrTable Agr c xs ;
    PredVPS np vps = {s = np.s ! npNom ++ vps.s ! np.a} ;

    
    MkVPI vp = mkVPI (lin VP vp) ;
    ConjVPI c xs = conjunctDistrTable2 VVType Agr c xs ;
    ComplVPIVV vv vpi = insertObj (\\a => vpi.s ! vv.typ ! a) (predVV vv) ;


-------- two-place verb conjunction

  lincat
    VPS2   = {s : Agr => Str ; c2 : Str} ; 
    [VPS2] = {s1,s2 : Agr => Str ; c2 : Str} ; 
    VPI2   = {s : VVType => Agr => Str ; c2 : Str} ;
    [VPI2] = {s1,s2 : VVType => Agr => Str ; c2 : Str} ;

  lin
    MkVPS2 t p vpsl = mkVPS (lin Temp t) (lin Pol p) (lin VP vpsl) ** {c2 = vpsl.c2} ;
    MkVPI2 vpsl = mkVPI (lin VP vpsl) ** {c2 = vpsl.c2} ;

    BaseVPS2 x y = twoTable Agr x y ** {c2 = y.c2} ; ---- just remembering the prep of the latter verb
    ConsVPS2 x xs = consrTable Agr comma x xs ** {c2 = xs.c2} ;
	
    BaseVPI2 x y = twoTable2 VVType Agr x y ** {c2 = y.c2} ; ---- just remembering the prep of the latter verb
    ConsVPI2 x xs = consrTable2 VVType Agr comma x xs ** {c2 = xs.c2} ;


    ConjVPS2 c xs = conjunctDistrTable Agr c xs ** {c2 = xs.c2} ;
    ConjVPI2 c xs = conjunctDistrTable2 VVType Agr c xs ** {c2 = xs.c2} ;


    ComplVPS2 vps2 np = {
        s = \\a => vps2.s ! a ++ vps2.c2 ++ np.s ! NPAcc
        } ;
    ComplVPI2 vpi2 np = {
        s = \\t,a => vpi2.s ! t ! a ++ vpi2.c2 ++  np.s ! NPAcc
        } ;

  oper 
    mkVPS : Temp -> Pol -> VP -> VPS = \t,p,vp -> lin VPS {
      s = \\a => 
            let 
              verb = vp.s ! t.t ! t.a ! p.p ! oDir ! a ;
              verbf = verb.aux ++ verb.adv ++ verb.fin ++ verb.inf ;
            in t.s ++ p.s ++ vp.ad ! a ++ verbf ++ vp.p ++ vp.s2 ! a ++ vp.ext
      } ;
      
    mkVPI : VP -> VPI = \vp -> lin VPI {
      s = table {
            VVAux      => \\a =>         vp.ad ! a ++ vp.inf ++ vp.p ++ vp.s2 ! a ;
            VVInf      => \\a => "to" ++ vp.ad ! a ++ vp.inf ++ vp.p ++ vp.s2 ! a ;
            VVPresPart => \\a =>         vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a
            }
      } ;

-----

  lin
    ICompAP ap = {s = "how" ++ ap.s ! agrP3 Sg} ; ---- IComp should have agr!

    IAdvAdv adv = {s = "how" ++ adv.s} ;

    PresPartAP vp = {
      s = \\a => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext ;
      isPre = vp.isSimple                 -- depends on whether there are complements
      } ;

    EmbedPresPart vp = {s = \\a => infVP VVPresPart vp False Simul CPos a} ;

   PastPartAP vp = { 
      s = \\a => vp.ad ! a ++ vp.ptp ++ vp.p ++ vp.c2 ++ vp.s2 ! a ++ vp.ext ;
      isPre = vp.isSimple                 -- depends on whether there are complements
      } ;
   PastPartAgentAP vp np = { 
      s = \\a => vp.ad ! a ++ vp.ptp ++ vp.p ++ vp.c2 ++ vp.s2 ! a ++ "by" ++ np.s ! NPAcc ++ vp.ext ;
      isPre = False
      } ;

   GerundCN vp = {
     s = \\n,c => vp.ad ! AgP3Sg Neutr ++ vp.prp ++
                  case <n,c> of {
                    <Sg,Nom> => "" ;
                    <Sg,Gen> => Predef.BIND ++ "'s" ;
                    <Pl,Nom> => Predef.BIND ++ "s" ;
                    <Pl,Gen> => Predef.BIND ++ "s'"
                    } ++ 
                  vp.p ++ vp.s2 ! AgP3Sg Neutr ++ vp.ext ; 
     g = Neutr
     } ;

   GerundNP vp = 
     let a = AgP3Sg Neutr ---- agr
     in 
     {s = \\_ => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext ; a = a} ;

   GerundAdv vp = 
     let a = AgP3Sg Neutr
     in 
     {s = vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext} ;

   WithoutVP vp = {s = "without" ++ (GerundAdv (lin VP vp)).s} ; 

   InOrderToVP vp = {s = ("in order" | []) ++ infVP VVInf vp False Simul CPos (AgP3Sg Neutr)} ;

   PurposeVP vp = {s = infVP VVInf vp False Simul CPos (agrP3 Sg)} ; --- agr

   ByVP vp = {s = "by" ++ (GerundAdv (lin VP vp)).s} ; 


   NominalizeVPSlashNP vpslash np = 
     let vp : ResEng.VP = insertObjPre (\\_ => vpslash.c2 ++ np.s ! NPAcc) vpslash ;
         a = AgP3Sg Neutr
     in 
     lin NP {s = \\_ => vp.ad ! a ++ vp.prp ++ vp.s2 ! a ; a = a} ;  


  oper passVPSlash : VPSlash -> Str -> ResEng.VP = 
   \vps,ag -> 
    let 
      be = predAux auxBe ;
      ppt = vps.ptp
    in {
    s = be.s ;
    p = [] ; 
    prp = be.prp ;
    ptp = be.ptp ;
    inf = be.inf ;
    ad = \\_ => [] ;
    s2 = \\a => vps.ad ! a ++ ppt ++ vps.p ++ ag ++ vps.s2 ! a ++ vps.c2 ; ---- place of agent
    isSimple = False ;
    ext = vps.ext
    } ;

  lin 
    PassVPSlash vps = passVPSlash (lin VPS vps) [] ;
    PassAgentVPSlash vps np = passVPSlash (lin VPS vps) ("by" ++ np.s ! NPAcc) ;

   --- AR 7/3/2013
   ComplSlashPartLast vps np = case vps.gapInMiddle of {
     _  => insertObjPartLast (\\_ => vps.c2 ++ np.s ! NPAcc) vps  ---
     } ;

   --- AR 22/5/2013
   ExistsNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPAcc) (predV (regV "exist"))) ;

   ExistCN cn =
      let
         pos = ExistNP (DetCN (DetQuant IndefArt NumSg) cn) ;
         neg = ExistNP (DetCN (DetQuant no_Quant NumSg) cn) ;
      in posNegClause pos neg ;
   ExistMassCN cn =
      let
         pos = ExistNP (MassNP cn) ;
         neg = ExistNP (DetCN (DetQuant no_Quant NumSg) cn) ;
      in posNegClause pos neg ;
   ExistPluralCN cn =
      let
         pos = ExistNP (DetCN (DetQuant IndefArt NumPl) cn) ;
         neg = ExistNP (DetCN (DetQuant no_Quant NumPl) cn) ;
      in posNegClause pos neg ;


   ComplBareVS  v s = insertExtra s.s (predV v) ;
   SlashBareV2S v s = insertExtrac s.s (predVc v) ;

  CompoundN noun cn = {
    s = \\n,c => noun.s ! Sg ! Nom ++ cn.s ! n ! c ;
    g = cn.g
  } ;
  
  CompoundAP noun adj = {
    s = variants {\\_ => noun.s ! Sg ! Nom ++                    adj.s ! AAdj Posit Nom ;
                  \\_ => noun.s ! Sg ! Nom ++ BIND++"-"++BIND ++ adj.s ! AAdj Posit Nom} ;
    isPre = True
    } ;

    FrontExtPredVP np vp = {
      s = \\t,a,b,o => 
        let 
          subj  = np.s ! npNom ;
          agr   = np.a ;
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          compl = vp.s2 ! agr
        in
        case o of {
          ODir _ => vp.ext ++ frontComma ++ subj ++ verb.aux ++ verb.adv ++ vp.ad ! agr ++ verb.fin ++ verb.inf ++ vp.p ++ compl ;
          OQuest => verb.aux ++ subj ++ verb.adv ++ vp.ad ! agr ++ verb.fin ++ verb.inf ++ vp.p ++ compl ++ vp.ext
          }
    } ;

    InvFrontExtPredVP np vp = {
      s = \\t,a,b,o => 
        let 
          subj  = np.s ! npNom ;
          agr   = np.a ;
          verb  = vp.s ! t ! a ! b ! o ! agr ;
          compl = vp.s2 ! agr
        in
        case o of {
          ODir _ => vp.ext ++ verb.aux ++ verb.adv ++ vp.ad ! agr ++ verb.fin ++ subj ++ verb.inf ++ vp.p ++ compl ;
          OQuest => verb.aux ++ subj ++ verb.adv ++ vp.ad ! agr ++ verb.fin ++ verb.inf ++ vp.p ++ compl ++ vp.ext
          }
    } ;



  lin
    AdAdV = cc2 ;

    AdjAsCN ap = let cn = mkNoun "one" "one's" "ones" "ones'" ** {g = Neutr}
      in {
        s = \\n,c => preOrPost ap.isPre (ap.s ! agrgP3 n cn.g) (cn.s ! n ! c) ;
        g = cn.g
        } ;
    AdjAsNP ap = {
      s = \\c => ap.s ! agrgP3 Sg nonhuman ; ---- genitive case?
      a = agrgP3 Sg nonhuman
      } ;

    PositAdVAdj a = {s = a.s ! AAdv} ;

  lincat
    RNP     = {s : Agr => Str} ;
    RNPList = {s1,s2 : Agr => Str} ;

  lin 
    ReflRNP vps rnp = insertObjPre (\\a => vps.c2 ++ rnp.s ! a) vps ;
    ReflPron = {s = reflPron} ;
    ReflPoss num cn = {s = \\a => possPron ! a ++ num.s ! True ! Nom ++ cn.s ! num.n ! Nom} ;
    PredetRNP predet rnp = {s = \\a => predet.s ++ rnp.s ! a} ;

    ConjRNP conj rpns = conjunctDistrTable Agr conj rpns ;

    Base_rr_RNP x y = twoTable Agr x y ;
    Base_nr_RNP x y = twoTable Agr {s = \\a => x.s ! NPAcc} y ;
    Base_rn_RNP x y = twoTable Agr x {s = \\a => y.s ! NPAcc} ;
    Cons_rr_RNP x xs = consrTable Agr comma x xs ;
    Cons_nr_RNP x xs = consrTable Agr comma {s = \\a => x.s ! NPAcc} xs ;

  lin
    ApposNP np1 np2 = {s = \\c => np1.s ! c ++ comma ++ np2.s ! c; a = np1.a} ;

---- TODO: RNPList construction

  lin
    ComplGenVV v a p vp = insertObj (\\agr => a.s ++ p.s ++ 
                                         infVP v.typ vp False a.a p.p agr)
                               (predVV v) ;

    CompS s = {s = \\_ => "that" ++ s.s} ;
    CompQS qs = {s = \\_ => qs.s ! QIndir} ;
    CompVP ant p vp = {s = \\a => ant.s ++ p.s ++ 
                                infVP VVInf vp False ant.a p.p a} ;

-- quite specific for English anyway

    UncontractedNeg = {s = [] ; p = CNeg False} ; 
    UttVPShort vp = {s = infVP VVAux vp False Simul CPos (agrP3 Sg)} ;




}
