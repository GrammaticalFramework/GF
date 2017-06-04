--# -path=.:abstract:common:prelude

concrete ExtraFin of ExtraFinAbs = CatFin ** 
  open ResFin, MorphoFin, Coordination, Prelude, NounFin, VerbFin, StructuralFin, StemFin, (R = ParamX) in {

  flags coding=utf8 ;
  lin
    GenNP np = {
      s1,sp = \\_,_ => np.s ! NPCase Gen ;
      s2 = case np.isPron of { -- "isän auto", "hänen autonsa"  
             True => table {Front => BIND ++ possSuffixFront np.a ; 
                            Back  => BIND ++ possSuffix np.a } ;
             False => \\_ => []
             } ;
      isNum  = False ;
      isPoss = np.isPron ; --- also gives "sen autonsa"
      isDef  = True ; --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      isNeg = False 
     } ;

    GenIP ip = {s = \\_,_ => ip.s ! NPCase Gen} ;

    GenCN n1 n2 = {s = \\nf => n1.s ! NPCase Gen ++ n2.s ! nf ;
                   h = n2.h } ;

    GenRP num cn = {
      s = \\n,c => let k = npform2case num.n c in relPron ! n ! Gen ++ cn.s ! NCase num.n k ; 
      a = RNoAg 
---      a = RAg (agrP3 num.n)
      } ;

  lincat
    VPI   = {s : VVType => Str} ;
    [VPI] = {s1,s2 : VVType => Str} ;
  lin
    BaseVPI = twoTable VVType ;
    ConsVPI = consrTable VVType comma ;

    MkVPI vp = {s = \\i => infVP SCNom Pos (agrP3 Sg) vp (vvtype2infform i)} ;
    ConjVPI = conjunctDistrTable VVType ;
    ComplVPIVV vv vpi = 
      insertObj (\\_,_,_ => vpi.s ! vv.vi) (predSV vv) ;

  lincat
    VPS = {
      s   : Agr  => Str ; 
      sc  : SubjCase ;  --- can be different for diff parts
      h   : Harmony   --- can be different for diff parts
      } ;

    [VPS] = {
      s1,s2 : Agr  => Str ; 
      sc    : SubjCase ;   --- take the first: minä osaan kutoa ja täytyy virkata
      h     : Harmony    --- take the first: osaanko minä kutoa ja käyn koulua
      } ;

  lin
    BaseVPS x y = twoTable Agr x y ** {sc = x.sc ; h = x.h} ;
    ConsVPS x y = consrTable Agr comma x y ** {sc = x.sc ; h = x.h} ;

    ConjVPS conj ss = conjunctDistrTable Agr conj ss ** {
      sc = ss.sc ; h = ss.h
      } ;

    MkVPS t p vp0 = let vp = vp2old_vp vp0 in

    { --  Temp -> Pol -> VP -> VPS ;
      s = \\a =>
        let
	  agrfin = case vp.sc of {
                     SCNom => <a,True> ;
                     _ => <agrP3 Sg,False>      -- minun täytyy, minulla on
                     } ;
	  vps = vp.s ! VIFin t.t ! t.a ! p.p ! agrfin.p1
        in
        t.s ++ p.s ++
        vps.fin ++ vps.inf ++
        vp.s2 ! agrfin.p2 ! p.p ! a ++
        vp.adv ! p.p ++
        vp.ext ;
      sc = vp.sc ;
      h = vp.h
      } ;

    PredVPS np vps = { -- NP -> VPS -> S ;
      s = subjForm np vps.sc Pos ++ vps.s ! np.a
      } ;

    AdvExistNP adv np = 
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPSep) (predV vpVerbOlla)) ;

    RelExistNP prep rp np = {
      s = \\t,ant,bo,ag => 
      let 
        n = complNumAgr ag ;
        cl = mkClause 
          (\_ -> appCompl True Pos prep (rp2np n rp))
          np.a 
          (insertObj 
            (\\_,b,_ => np.s ! NPSep) 
            (predV vpVerbOlla)) ;
      in 
      cl.s ! t ! ant ! bo ! SDecl ;
      c = NPCase Nom
      } ;

    AdvPredNP  adv v np =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => subjForm np v.sc b) (predSV v)) ;

    ICompExistNP adv np = 
      let cl = mkClause (\_ -> adv.s ! np.a) np.a (insertObj 
        (\\_,b,_ => np.s ! NPSep) (predV vpVerbOlla)) ;
      in  {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
      } ;

    IAdvPredNP iadv v np =
      let cl = mkClause (\_ -> iadv.s) np.a (insertObj 
                 (\\_,b,_ => np.s ! subjcase2npform v.sc) (predSV v)) ;
      in  {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
      } ;

--    i_implicPron = mkPronoun [] "minun" "minua" "minuna" "minuun" Sg P1 ;
    whatPart_IP = {
      s = table {
        NPCase Nom | NPAcc => "mitä" ;
        c => whatSg_IP.s ! c
        } ;
      n = Sg
    } ;

    PartCN cn = 
      let 
        acn = DetCN (DetQuant IndefArt NumSg) cn
      in {
        s = table {
          NPCase Nom | NPAcc => acn.s ! NPCase ResFin.Part ;
          c => acn.s ! c
          } ; 
        a = acn.a ;
        isPron = False ; isNeg = False
        } ;
	
    PartPlCN cn = 
      let 
        acn = DetCN (DetQuant IndefArt NumPl) cn
      in {
        s = table {
          NPCase Nom | NPAcc => acn.s ! NPCase ResFin.Part ;
          c => acn.s ! c
          } ; 
        a = acn.a ;
        isPron = False ; isNeg = False
        } ;

    vai_Conj = {s1 = [] ; s2 = "vai" ; n = Sg} ;

    CompPartAP ap = {
      s = \\agr => ap.s ! False ! NCase (complNumAgr agr) ResFin.Part
      } ;

---- copied from VerbFin.CompAP, should be shared
    ICompAP ap = {
      s = \\agr => 
          let
            n = complNumAgr agr ;
            c = case n of {
              Sg => Nom ;  -- minä olen iso ; te olette iso
              Pl => ResFin.Part   -- me olemme isoja ; te olette isoja
              }            --- definiteness of NP ?
          in "kuinka" ++ ap.s ! False ! (NCase n c)
      } ;

    IAdvAdv adv = {s = "kuinka" ++ adv.s} ;

    ProDrop p = {
      s = table {NPCase Nom => [] ; c => p.s ! c} ;
      poss = [] ; 
          -- drop Gen only works in adjectival position: "autoni", but not in "ø täytyy mennä"
      a = p.a ;
      hasPoss = p.hasPoss ;
      } ;

    ProDropPoss p = {
      s1 = \\_,_ => case p.a of {Ag _ P3 => p.s ! NPCase Gen ; _ => []} ;  -- hänen nimensä ; (minun) nimeni
      sp = \\_,_ => p.s ! NPCase Gen ;
      s2 = case p.hasPoss of {
             True => table {Front => BIND ++ possSuffixFront p.a ; 
                            Back  => BIND ++ possSuffix p.a } ;
             False => \\_ => []                                         -- sen nimi
             } ;
      isNum = False ;
      isPoss = True ;
      isDef = True ;  --- "minun kolme autoani ovat" ; thus "...on" is missing
      isNeg = False
      } ;

  lincat 
    ClPlus, ClPlusObj, ClPlusAdv = ClausePlus ;
    Part = {s : Harmony => Str} ;

  lin 
    S_SVO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! Back ----
      in
      {s = t.s ++ p.s ++ cl.subj ++ pa ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 
    S_OSV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! Back ----
      in
      {s = t.s ++ p.s ++ cl.compl ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.adv ++ cl.ext} ; 
    S_VSO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! cl.h
      in
      {s = t.s ++ p.s ++ cl.fin ++ pa ++ cl.subj ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 
    S_ASV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! cl.h
      in
      {s = t.s ++ p.s ++ cl.adv ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.ext} ; 

    S_OVS part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! Back ----
      in
      {s = t.s ++ p.s ++ cl.compl ++ pa ++ cl.fin ++ cl.inf ++ cl.subj ++ cl.adv ++ cl.ext} ; 

    PredClPlus np vp = mkClausePlus (subjForm np vp.s.sc) np.a vp ;
    PredClPlusFocSubj np vp = insertKinClausePlus 0 (mkClausePlus (subjForm np vp.s.sc) np.a vp) ;
    PredClPlusFocVerb np vp = insertKinClausePlus 1 (mkClausePlus (subjForm np vp.s.sc) np.a vp) ;
    PredClPlusObj  np vps obj = 
      insertObjClausePlus 0 False (\\b => appCompl True b vps.c2 obj) (mkClausePlus (subjForm np vps.s.sc) np.a vps) ;
    PredClPlusFocObj  np vps obj = 
      insertObjClausePlus 0 True (\\b => appCompl True b vps.c2 obj) (mkClausePlus (subjForm np vps.s.sc) np.a vps) ;
    PredClPlusAdv  np vp  adv = 
      insertObjClausePlus 1 False (\\_ => adv.s) (mkClausePlus (subjForm np vp.s.sc) np.a vp) ;
    PredClPlusFocAdv  np vp  adv = 
      insertObjClausePlus 1 True (\\_ => adv.s) (mkClausePlus (subjForm np vp.s.sc) np.a vp) ;

    ClPlusWithObj c = c ;
    ClPlusWithAdv c = c ;

  noPart     = {s = \\_ => []} ;
  han_Part   = mkPart "han" "hän" ;
  pa_Part    = mkPart "pa" "pä" ;
  pas_Part   = mkPart "pas" "päs" ;
  ko_Part    = mkPart "ko" "kö" ;
  kos_Part   = mkPart "kos" "kös" ;
  kohan_Part = mkPart "kohan" "köhän" ;
  pahan_Part = mkPart "pahan" "pähän" ;

  PassVPSlash vp = passVP vp vp.c2 ;

{- -----
      s = \\vif,ant,pol,agr => case vif of {
        VIFin t  => vp.s ! VIPass t ! ant ! pol ! agr ;
        _ => vp.s ! vif ! ant ! pol ! agr 
        } ;
-}

---- uses inversion of active: Guernican maalasi Picasso. TODO: use the agent participle
---- TODO maybe squeeze s2 between the fin and inf (but this is subtle)
----   sinua olen rakastanut minä -> sinua olen minä rakastanus
-- advantage though: works for all V2 verbs, need not be transitive
---- TODO: agr should be to the agent

  PassAgentVPSlash vp np = {
      s = {s = vp.s.s ; h = vp.s.h ; p = vp.s.p ; sc = npform2subjcase vp.c2.c} ; 
      s2 = \\b,p,a => np.s ! NPSep ++ vp.s2 ! b ! p ! a ;
      adv = vp.adv ;
      ext = vp.ext ;
      vptyp = vp.vptyp ;
      } ; 


  AdjAsCN ap = {
      s = \\nf => ap.s ! True ! (n2nform nf) ;
      h = Back ; ---- TODO should be ap.h, which does not exist
      } ;

  lincat
    RNP = {s : Agr => NPForm => Str ; isPron : Bool} ;
  lin
    ReflRNP vps rnp = insertObjPre False
      (\fin,b,agr -> appCompl fin b vps.c2
                    {s = \\npf => rnp.s ! agr ! npf ; a = agr ; isPron = rnp.isPron})
      vps ;

    ReflPoss num cn = {
      s = \\agr, npf =>
        let
          quant : NounFin.Quant = lin Quant {  -- possessive pronoun with suffix only
    	    s2 : Harmony => Str = \\harm => possSuffixGen harm agr ;
	    s1,sp = \\_,_ => [] ; isNum,isNeg = False ; isPoss,isDef = True
	    } ; 
          det = NounFin.DetQuant quant num
        in
        (NounFin.DetCN det cn).s ! npf ;
     isPron = False
     } ;

 

} 
