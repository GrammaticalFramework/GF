--# -path=.:abstract:common:prelude

concrete ExtraFin of ExtraFinAbs = CatFin ** 
  open ResFin, MorphoFin, Coordination, Prelude, NounFin, StructuralFin, StemFin, (R = ParamX) in {

  lin
    GenNP np = {
      s1,sp = \\_,_ => np.s ! NPCase Gen ;
      s2 = \\_ => [] ;
      isNum  = False ;
      isPoss = False ;
      isDef  = True ; --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      isNeg = False 
     } ;

    GenIP ip = {s = \\_,_ => ip.s ! NPCase Gen} ;

    GenCN n1 n2 = {s = \\nf => n1.s ! NPCase Gen ++ n2.s ! nf ;
                   h = n2.h } ;

    GenRP num cn = {
      s = \\n,c => let k = (npform2case num.n c) in "jonka" ++ num.s ! Sg ! k ++ cn.s ! NCase num.n k ;
      a = RAg (agrP3 num.n) ;
      } ;

  lincat
    VPI   = {s : InfForm => Str} ;
    [VPI] = {s1,s2 : InfForm => Str} ;
  lin
    BaseVPI = twoTable InfForm ;
    ConsVPI = consrTable InfForm comma ;

    MkVPI vp = {s = \\i => infVP (NPCase Nom) Pos (agrP3 Sg) vp i} ;
    ConjVPI = conjunctDistrTable InfForm ;
    ComplVPIVV vv vpi = 
      insertObj (\\_,_,_ => vpi.s ! vv.vi) (predSV vv) ;

  lincat
    VPS = {
      s   : Agr  => Str ; 
      sc  : NPForm ;  --- can be different for diff parts
      qp  : Bool -- True = back vowel --- can be different for diff parts
      } ;

    [VPS] = {
      s1,s2 : Agr  => Str ; 
      sc    : NPForm ;  --- take the first: minä osaan kutoa ja täytyy virkata
      qp    : Bool      --- take the first: osaanko minä kutoa ja käyn koulua
      } ;

  lin
    BaseVPS x y = twoTable Agr x y ** {sc = x.sc ; qp = x.qp} ;
    ConsVPS x y = consrTable Agr comma x y ** {sc = x.sc ; qp = x.qp} ;

    ConjVPS conj ss = conjunctDistrTable Agr conj ss ** {
      sc = ss.sc ; qp = ss.qp
      } ;

    MkVPS t p vp = { --  Temp -> Pol -> VP -> VPS ;
      s = \\a => let vps = vp.s ! VIFin t.t ! t.a ! p.p ! a
                 in
                 t.s ++ p.s ++
                 vps.fin ++ vps.inf ++
                 vp.s2 ! True ! p.p ! a ++
                 vp.adv ! p.p ++
                 vp.ext ;
      sc = vp.sc ;
      qp = vp.qp
      } ;

    PredVPS np vps = { -- NP -> VPS -> S ;
      s = subjForm np vps.sc Pos ++ vps.s ! np.a
      } ;

    AdvExistNP adv np = 
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlla ** {sc = NPCase Nom ; qp = True ; p = []}))) ;

    RelExistNP prep rp np = {
      s = \\t,ant,bo,ag => 
      let 
        n = complNumAgr ag ;
        cl = mkClause 
          (\_ -> appCompl True Pos prep (rp2np n rp))
          np.a 
          (insertObj 
            (\\_,b,_ => np.s ! NPCase Nom) 
            (predV (verbOlla ** {sc = NPCase Nom ; qp = True ; p = []}))) ;
      in 
      cl.s ! t ! ant ! bo ! SDecl ;
      c = NPCase Nom
      } ;

    AdvPredNP  adv v np =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => subjForm np v.sc b) (predSV v)) ;

    ICompExistNP adv np = 
      let cl = mkClause (\_ -> adv.s ! np.a) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlla ** {sc = NPCase Nom ; qp = True ; p = []}))) ;
      in  {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
      } ;

    IAdvPredNP iadv v np =
      let cl = mkClause (\_ -> iadv.s) np.a (insertObj 
                 (\\_,b,_ => np.s ! v.sc) (predSV v)) ;
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
      s = table {NPCase (Nom) => [] ; c => p.s ! c} ; 
          ---- drop Gen only works in adjectival position: "autoni", but not in "ø täytyy mennä"
      a = p.a ;
      hasPoss = p.hasPoss ;
      } ;

    ProDropPoss p = {
      s1 = \\_,_ => [] ;
      sp = \\_,_ => p.s ! NPCase Gen ;
      s2 = table {Front => BIND ++ possSuffixFront p.a ;
                  Back  => BIND ++ possSuffix p.a } ;
      isNum = False ;
      isPoss = True ;
      isDef = True ;  --- "minun kolme autoani ovat" ; thus "...on" is missing
      isNeg = False
      } ;

  lincat 
    ClPlus, ClPlusObj, ClPlusAdv = ClausePlus ;
    Part = {s : Bool => Str} ;

  lin 
    S_SVO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! True ----
      in
      {s = t.s ++ p.s ++ cl.subj ++ pa ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 
    S_OSV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! True ----
      in
      {s = t.s ++ p.s ++ cl.compl ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.adv ++ cl.ext} ; 
    S_VSO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! cl.qp
      in
      {s = t.s ++ p.s ++ cl.fin ++ pa ++ cl.subj ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 
    S_ASV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! cl.qp
      in
      {s = t.s ++ p.s ++ cl.adv ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.ext} ; 

    S_OVS part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ! True ----
      in
      {s = t.s ++ p.s ++ cl.compl ++ pa ++ cl.fin ++ cl.inf ++ cl.subj ++ cl.adv ++ cl.ext} ; 

    PredClPlus np vp = mkClausePlus (subjForm np vp.sc) np.a vp ;
    PredClPlusFocSubj np vp = insertKinClausePlus 0 (mkClausePlus (subjForm np vp.sc) np.a vp) ;
    PredClPlusFocVerb np vp = insertKinClausePlus 1 (mkClausePlus (subjForm np vp.sc) np.a vp) ;
    PredClPlusObj  np vps obj = 
      insertObjClausePlus 0 False (\\b => appCompl True b vps.c2 obj) (mkClausePlus (subjForm np vps.sc) np.a vps) ;
    PredClPlusFocObj  np vps obj = 
      insertObjClausePlus 0 True (\\b => appCompl True b vps.c2 obj) (mkClausePlus (subjForm np vps.sc) np.a vps) ;
    PredClPlusAdv  np vp  adv = 
      insertObjClausePlus 1 False (\\_ => adv.s) (mkClausePlus (subjForm np vp.sc) np.a vp) ;
    PredClPlusFocAdv  np vp  adv = 
      insertObjClausePlus 1 True (\\_ => adv.s) (mkClausePlus (subjForm np vp.sc) np.a vp) ;

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

} 
