--# -path=.:../common:../abstract

concrete ExtendEng of Extend =
  CatEng ** ExtendFunctor [ProDrop]
  with
    (Grammar = GrammarEng) **

  open
    ResEng,
    Coordination,
    Prelude,
    MorphoEng,
    ParadigmsEng in {

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

{- -----
  lincat
    VPI   = {s : VVType => Agr => Str} ;
    [VPI] = {s1,s2 : VVType => Agr => Str} ;

  lin
    BaseVPI = twoTable2 VVType Agr ;
    ConsVPI = consrTable2 VVType Agr comma ;

    MkVPI vp = {
      s = table {
            VVAux      => \\a => vp.ad ! a ++ vp.inf ++ vp.p ++ vp.s2 ! a;
            VVInf      => \\a => "to" ++ vp.ad ! a ++ vp.inf ++ vp.p ++ vp.s2 ! a;
            VVPresPart => \\a => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a
          }
      } ;
    ConjVPI = conjunctDistrTable2 VVType Agr ;
    ComplVPIVV vv vpi = 
      insertObj (\\a => vpi.s ! vv.typ ! a) (predVV vv) ;
----}


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
              verb = vp.s ! t.t ! t.a ! p.p ! oDir ! a ;
              verbf = verb.aux ++ verb.adv ++ verb.fin ++ verb.inf ;
            in t.s ++ p.s ++ vp.ad ! a ++ verbf ++ vp.p ++ vp.s2 ! a ++ vp.ext
      } ;

    ConjVPS = conjunctDistrTable Agr ;

    ICompAP ap = {s = "how" ++ ap.s ! agrP3 Sg} ; ---- IComp should have agr!

    IAdvAdv adv = {s = "how" ++ adv.s} ;

    PartVP vp = {
      s = \\a => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext ;
      isPre = vp.isSimple                 -- depends on whether there are complements
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
      VVPresNeg => "shan't" 
      } ;
    p = [] ;
    typ = VVAux
    } ;

   ought_VV = lin VV {
     s = table { 
      VVF VInf => ["be obliged to"] ; ---
      VVF VPres => "ought to" ;
      VVF VPPart => ["been obliged to"] ;
      VVF VPresPart => ["being obliged to"] ;
      VVF VPast => "ought to" ; --# notpresent
      VVPastNeg => "oughtn't to" ; --# notpresent
      VVPresNeg => "oughtn't to"  --- shan't
      } ;
    p = [] ;
    typ = VVAux
    } ;

   used_VV = lin VV {
     s = table { 
      VVF VInf => Predef.nonExist ; ---
      VVF VPres => Predef.nonExist ;
      VVF VPPart => ["used to"] ;
      VVF VPresPart => ["being used to"] ;
      VVF VPast => "used to" ; --# notpresent
      VVPastNeg => "used not to" ; --# notpresent
      VVPresNeg => Predef.nonExist 
      } ;
    p = [] ;
    typ = VVAux
    } ;


   NominalizeVPSlashNP vpslash np = 
     let vp : ResEng.VP = insertObjPre (\\_ => vpslash.c2 ++ np.s ! NPAcc) vpslash ;
         a = AgP3Sg Neutr
     in 
     lin NP {s = \\_ => vp.ad ! a ++ vp.prp ++ vp.s2 ! a ; a = a} ;  

lin
  UncNeg = {s = [] ; p = CNeg False} ; 

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
    PassVPSlash vps = passVPSlash vps [] ;
    PassAgentVPSlash vps np = passVPSlash vps ("by" ++ np.s ! NPAcc) ;

   --- AR 7/3/2013
   ComplSlashPartLast vps np = case vps.gapInMiddle of {
     _  => insertObjPartLast (\\_ => vps.c2 ++ np.s ! NPAcc) vps  ---
     } ;

   --- AR 22/5/2013
   ExistsNP np = 
      mkClause "there" (agrP3 (fromAgr np.a).n) 
        (insertObj (\\_ => np.s ! NPAcc) (predV (regV "exist"))) ;

   PurposeVP vp = {s = infVP VVInf vp Simul CPos (agrP3 Sg)} ; --- agr


   ComplBareVS  v s = insertExtra s.s (predV v) ;
   SlashBareV2S v s = insertExtrac s.s (predVc v) ;

   ContractedUseCl  t p cl = {
      s = t.s ++ p.s ++ cl.s ! t.t ! t.a ! p.p ! ODir True
      } ;



    CompoundCN a b = {s = \\n,c => a.s ! Sg ! Nom ++ b.s ! n ! c ; g = b.g} ;

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
    AdjAsCN ap = let cn = mkNoun "one" "one's" "ones" "ones'" ** {g = Neutr}
      in {
        s = \\n,c => preOrPost ap.isPre (ap.s ! agrgP3 n cn.g) (cn.s ! n ! c) ;
        g = cn.g
        } ;

  lincat
    RNP     = {s : Agr => Str} ;
    RNPList = {s1,s2 : Agr => Str} ;

  lin 
    ReflRNP vps rnp = insertObjPre (\\a => vps.c2 ++ rnp.s ! a) vps ;
    ReflPron = {s = reflPron} ;
    ReflPoss num cn = {s = \\a => possPron ! a ++ num.s ! Nom ++ cn.s ! num.n ! Nom} ;
    PredetRNP predet rnp = {s = \\a => predet.s ++ rnp.s ! a} ;

    ConjRNP conj rpns = conjunctDistrTable Agr conj rpns ;

    Base_rr_RNP x y = twoTable Agr x y ;
    Base_nr_RNP x y = twoTable Agr {s = \\a => x.s ! NPAcc} y ;
    Base_rn_RNP x y = twoTable Agr x {s = \\a => y.s ! NPAcc} ;
    Cons_rr_RNP x xs = consrTable Agr comma x xs ;
    Cons_nr_RNP x xs = consrTable Agr comma {s = \\a => x.s ! NPAcc} xs ;

    
---- TODO: RNPList construction




}