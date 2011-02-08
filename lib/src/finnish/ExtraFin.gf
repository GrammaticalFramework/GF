--# -path=.:abstract:common:prelude

concrete ExtraFin of ExtraFinAbs = CatFin ** 
  open ResFin, MorphoFin, Coordination, Prelude, NounFin, StructuralFin in {

  lin
    GenNP np = {
      s1,sp = \\_,_ => np.s ! NPCase Gen ;
      s2 = [] ;
      isNum  = False ;
      isPoss = False ;
      isDef  = True  --- "Jussin kolme autoa ovat" ; thus "...on" is missing
      } ;


  lincat
    VPI   = {s : Str} ;
    [VPI] = {s1,s2 : Str} ;
  lin
    BaseVPI = twoSS ;
    ConsVPI = consrSS comma ;

    MkVPI vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp Inf1} ;
    ConjVPI = conjunctDistrSS ;
    ComplVPIVV vv vpi = 
      insertObj (\\_,_,_ => vpi.s) (predV vv) ;

    AdvExistNP adv np = 
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV (verbOlla ** {sc = NPCase Nom ; qp = True}))) ;

    RelExistNP prep rp np = {
      s = \\t,ant,bo,ag => 
      let 
        n = complNumAgr ag ;
        cl = mkClause 
          (\_ -> appCompl True Pos prep (rp2np n rp))
          np.a 
          (insertObj 
            (\\_,b,_ => np.s ! NPCase Nom) 
            (predV (verbOlla ** {sc = NPCase Nom ; qp = True}))) ;
      in 
      cl.s ! t ! ant ! bo ! SDecl ;
      c = NPCase Nom
      } ;

    AdvPredNP  adv v np =
      mkClause (\_ -> adv.s) np.a (insertObj 
        (\\_,b,_ => np.s ! NPCase Nom) (predV v)) ;

    i_implicPron = mkPronoun [] "minun" "minua" "minuna" "minuun" Sg P1 ;
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
        isPron = False
        } ;

    vai_Conj = {s1 = [] ; s2 = "vai" ; n = Sg} ;

    CompPartAP ap = {
      s = \\agr => ap.s ! False ! NCase (complNumAgr agr) Part
      } ;

---- copied from VerbFin.CompAP, should be shared
    ICompAP ap = {
      s = \\agr => 
          let
            n = complNumAgr agr ;
            c = case n of {
              Sg => Nom ;  -- minä olen iso ; te olette iso
              Pl => Part   -- me olemme isoja ; te olette isoja
              }            --- definiteness of NP ?
          in "kuinka" ++ ap.s ! False ! (NCase n c)
      } ;

    IAdvAdv adv = {s = "kuinka" ++ adv.s} ;

    ProDrop p = {
      s = table {NPCase (Nom | Gen) => [] ; c => p.s ! c} ; 
          ---- drop Gen only works in adjectival position
      a = p.a
      } ;

    ProDropPoss p = {
      s1 = \\_,_ => [] ;
      sp = \\_,_ => p.s ! NPCase Gen ;
      s2 = BIND ++ possSuffix p.a ;
      isNum = False ;
      isPoss = True ;
      isDef = True  --- "minun kolme autoani ovat" ; thus "...on" is missing
      } ;

  lincat ClPlus = ClausePlus ;

  lin 
    S_SVO t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.ext} ; 
    S_SOV t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.subj ++ cl.compl ++ cl.fin ++ cl.inf ++ cl.ext} ; 
    S_OSV t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.compl ++ cl.subj ++ cl.fin ++ cl.inf ++ cl.ext} ; 
    S_OVS t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.compl ++ cl.fin ++ cl.inf ++ cl.subj ++ cl.ext} ; 
    S_VSO t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.fin ++ cl.subj ++ cl.inf ++ cl.compl ++ cl.ext} ; 
    S_VOS t p clp = 
      let cl = clp.s ! t.t ! t.a ! p.p
      in
      {s = t.s ++ p.s ++ cl.fin ++ cl.inf ++ cl.compl ++ cl.subj ++ cl.ext} ; 

    PredClPlus np vp = mkClausePlus (subjForm np vp.sc) np.a vp ;


} 
