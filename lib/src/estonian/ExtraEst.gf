concrete ExtraEst of ExtraEstAbs = CatEst ** 
  open ResEst, MorphoEst, Coordination, Prelude, NounEst, StructuralEst, (R = ParamX) in {

  lin
    GenNP np = {
      s,sp = \\_,_ => np.s ! NPCase Gen ;
      isNum  = False ;
      isDef  = True ; --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      isNeg = False 
     } ;

    GenCN n1 n2 = {s = \\nf => n1.s ! NPCase Gen ++ n2.s ! nf} ;

  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp InfDa} ;
    ConjVPI = conjunctDistrSS ;
    ComplVPIVV vv vpi = 
      insertObj (\\_,_,_ => vpi.s) (predV vv) ;

  lincat
    VPS = {
      s   : Agr  => Str ; 
      sc  : NPForm ;  --- can be different for diff parts
      } ;

    [VPS] = {
      s1,s2 : Agr  => Str ; 
      sc    : NPForm ;  --- take the first: minä osaan kutoa ja täytyy virkata
      } ;

  lin
    BaseVPS x y = twoTable Agr x y ** {sc = x.sc} ;
    ConsVPS x y = consrTable Agr comma x y ** {sc = x.sc} ;

    ConjVPS conj ss = conjunctDistrTable Agr conj ss ** {
      sc = ss.sc
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
      } ;

    PredVPS np vps = { -- NP -> VPS -> S ;
      s = subjForm np vps.sc Pos ++ vps.s ! np.a
      } ;

    AdvExistNP adv np = 
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlema ** {sc = NPCase Nom}))) ;

    RelExistNP prep rp np = {
      s = \\t,ant,bo,ag => 
      let 
        n = complNumAgr ag ;
        cl = mkClause 
          (\_ -> appCompl True Pos prep (rp2np n rp))
          np.a 
          (insertObj 
            (\\_,b,_ => np.s ! NPCase Nom) 
            (predV (verbOlema ** {sc = NPCase Nom}))) ;
      in 
      cl.s ! t ! ant ! bo ! SDecl ;
      c = NPCase Nom
      } ;

    AdvPredNP  adv v np =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV v)) ;

    ICompExistNP adv np = 
      let cl = mkClause (\_ -> adv.s ! np.a) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlema ** {sc = NPCase Nom}))) ;
      in  {
        s = \\t,a,p => cl.s ! t ! a ! p ! SDecl
      } ;

    IAdvPredNP iadv v np =
      let cl = mkClause (\_ -> iadv.s) np.a (insertObj 
                 (\\_,b,_ => np.s ! v.sc) (predV v)) ;
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
          NPCase Nom | NPAcc => acn.s ! NPCase Part ;
          c => acn.s ! c
          } ; 
        a = acn.a ;
        isPron = False ; isNeg = False
        } ;

    vai_Conj = {s1 = [] ; s2 = "vai" ; n = Sg} ;

    --The reflexive possessive "oma"
    --for "ta näeb oma koera" instead of *"tema koera"
    OmaPoss = {s,sp = \\_,_ => "oma" ; isDef,isNeg,isNum = False} ;
    
    ma_Pron = mkPronoun "ma" "mu" "mind" Sg P1 ;
    sa_Pron = mkPronoun "sa" "su" "sind" Sg P2;
    ta_Pron = mkPronoun "ta" "ta" "teda" Sg P3 ;
    me_Pron = 
    {s = table {
        NPCase Nom => "me" ;
        n => (we_Pron.s) ! n 
        } ;
     a = Ag Pl P1 } ; 

    te_Pron = 
    {s = table {
        NPCase Nom => "te" ;
        n => (youPl_Pron.s) ! n 
        } ;
     a = Ag Pl P2 } ; 

    nad_Pron =
    {s = table {
        NPCase Nom => "nad" ;
        n => (they_Pron.s) ! n 
        } ;
     a = Ag Pl P3 } ; 

---- copied from VerbEst.CompAP, should be shared
    ICompAP ap = {
      s = \\agr => 
          let
            n = complNumAgr agr ;
            c = case n of {
              Sg => Nom ;  -- Fin (Nom): minä olen iso ; te olette iso
              Pl => Nom    -- Fin (Part): me olemme isoja ; te olette isoja
              }            --- definiteness of NP ?
          in "kui" ++ ap.s ! False ! (NCase n c)
      } ;

    IAdvAdv adv = {s = "kui" ++ adv.s} ;

    ProDrop p = {
      s = table {NPCase (Nom | Gen) => [] ; c => p.s ! c} ; 
          ---- drop Gen only works in adjectival position
      a = p.a
      } ;

    ProDropPoss p = {
      s = \\_,_ => "oma" ; --???
      sp = \\_,_ => p.s ! NPCase Gen ;
      isNum = False ;
      isDef = True ;  --- "minun kolme autoani ovat" ; thus "...on" is missing
      isNeg = False
      } ;

  lincat 
    ClPlus, ClPlusObj, ClPlusAdv = ClausePlus ;
    Part = {s : Str} ;

  lin 
    S_SVO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ----
      in
      {s = t.s ++ p.s ++ cl.subj ++ pa ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 

    S_OSV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ----
      in
      {s = t.s ++ p.s ++ cl.compl ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.adv ++ cl.ext} ; 
    S_VSO part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s
      in
      {s = t.s ++ p.s ++ cl.fin ++ pa ++ cl.subj ++ cl.inf ++ cl.compl ++ cl.adv ++ cl.ext} ; 
    S_ASV part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s
      in
      {s = t.s ++ p.s ++ cl.adv ++ pa ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.ext} ; 

    S_OVS part t p clp = 
      let 
         cl = clp.s ! t.t ! t.a ! p.p ;
         pa = part.s ----
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

  noPart     = {s = []} ;
{-han_Part   = mkPart "han" "hän" ;
  pa_Part    = mkPart "pa" "pä" ;
  pas_Part   = mkPart "pas" "päs" ;
  ko_Part    = mkPart "ko" "kö" ;
  kos_Part   = mkPart "kos" "kös" ;
  kohan_Part = mkPart "kohan" "köhän" ;
  pahan_Part = mkPart "pahan" "pähän" ;
-}

} 
