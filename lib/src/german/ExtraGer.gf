concrete ExtraGer of ExtraGerAbs = CatGer ** 
  open ResGer, Coordination, Prelude, IrregGer, (P = ParadigmsGer) in {
  flags coding=utf8 ;

  lincat
    VPI   = {s : Bool => Str} ;
    [VPI] = {s1,s2 : Bool => Str} ;
  lin
    BaseVPI = twoTable Bool ;
    ConsVPI = consrTable Bool comma ;

    MkVPI vp = {s = \\b => useInfVP b vp} ;
    ConjVPI = conjunctDistrTable Bool ;

    ComplVPIVV v vpi = 
        insertInf (vpi.s ! v.isAux) (
            predVGen v.isAux v) ; ----
{-
      insertExtrapos vpi.p3 (
        insertInf vpi.p2 (
          insertObj vpi.p1 (
            predVGen v.isAux v))) ;
-}

    PPzuAdv cn = {s = case cn.g of {
      Masc | Neutr => "zum" ;
      Fem => "zur"
      } ++ cn.s ! adjfCase Weak Dat ! Sg ! Dat 
    } ;

    TImpfSubj  = {s = [] ; t = Past ; m = MConjunct} ;   --# notpresent

    moegen_VV = auxVV mögen_V ;

    ICompAP ap = {s = \\_ => "wie" ++ ap.s ! APred ; 
				  ext = ap.c.p1 ++ ap.c.p2 ++ ap.ext} ; 

    CompIQuant iq = {s = table {Ag g n p => iq.s ! n ! g ! Nom} ; ext = ""} ;

    IAdvAdv adv = {s = "wie" ++ adv.s} ;

    DetNPMasc det = {
      s = \\c => det.sp ! Masc ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False ;
      ext, adv, rc = []
      } ;

    DetNPFem det = {
      s = \\c => det.sp ! Fem ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False ;
      ext, adv, rc = []
      } ;

    EmptyRelSlash slash = {
      s = \\m,t,a,p,gn => 
          appPrep slash.c2 (\\k => usePrepC k (\c -> relPron ! gn ! c)) ++ 
          slash.s ! m ! t ! a ! p ! Sub ;
      c = (prepC slash.c2.c).c
      } ;

    PassVPSlash vp = 
		let c = case <vp.c2.c,vp.c2.isPrep> of {
               <NPC Acc,False> => NPC Nom ;
                                    _ => vp.c2.c}
			in insertObj (\\_ => (PastPartAP vp).s ! APred) (predV werdenPass) **
				{subjc = vp.c2 ** {c= c}} ;
		-- regulates passivised object: accusative objects -> nom; all others: same case
		-- this also gives "mit dir wird gerechnet" ;
		-- the alternative linearisation ("es wird mit dir gerechnet") is not implemented

    PassAgentVPSlash vp np = ---- "von" here, "durch" in StructuralGer
      insertObj (\\_ => (PastPartAgentAP (lin VPSlash vp) (lin NP np)).s ! APred) (predV werdenPass) ;

    PastPartAP vp = {
      s = \\af => (vp.nn ! agrP3 Sg).p1 ++ (vp.nn ! agrP3 Sg).p2 ++ vp.a2 ++ vp.inf ++ 
                  vp.ext ++ vp.infExt ++ vp.s.s ! VPastPart af ;
      isPre = True ;
      c = <[],[]> ;
      ext = [] 
      } ;

    PastPartAgentAP vp np = 
    let agent = appPrepNP P.von_Prep np
    in {
      s = \\af => (vp.nn ! agrP3 Sg).p1 ++ (vp.nn ! agrP3 Sg).p2 ++ vp.a2 ++ agent ++ vp.inf ++ 
                   vp.c2.s ++ --- junk if not TV
                   vp.ext ++ vp.infExt ++ vp.s.s ! VPastPart af ;
      isPre = True ;
      c = <[],[]> ;
      ext = [] 
      } ;

  lincat
    VPS   = {s : Order => Agr => Str} ;
    [VPS] = {s1,s2 : Order => Agr => Str} ;

  lin
    BaseVPS = twoTable2 Order Agr ;
    ConsVPS = consrTable2 Order Agr comma ;

    PredVPS np vpi = 
      let
        subj = np.s ! NPC Nom ++ bigNP np ;
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

    MkVPS tm p vp = 
      let vps = useVP vp in {
        s = \\o,agr => 
         let 
          ord   = case o of {
            Sub => True ;  -- glue prefix to verb
            _ => False
            } ;
          b = p.p ;
          a = tm.a ;
          t = tm.t ;
          m = tm.m ;
          subj  = [] ;
          verb  = vps.s  ! ord ! agr ! VPFinite m t a ;
          neg   = tm.s ++ p.s ++ vp.a1 ! b ;
          obj0  = (vp.nn ! agr).p1 ;
          obj   = (vp.nn ! agr).p2 ;
          compl = obj0 ++ neg ++ obj ++ vp.a2 ; -- from EG 15/5
          inf   = vp.inf ++ verb.inf ;
          extra = vp.ext ;
          inffin : Str = 
            case <a,vp.isAux> of {                       
	           <Anter,True> => verb.fin ++ inf ; -- double inf   --# notpresent
             _            => inf ++ verb.fin              --- or just auxiliary vp
            }                                            
        in
        case o of {
	    Main => subj ++ verb.fin ++ compl ++ vp.infExt ++ inf ++ extra ;
	    Inv  => verb.fin ++ subj ++ compl ++ vp.infExt ++ inf ++ extra ;
	    Sub  => subj ++ compl ++ vp.infExt ++ inffin ++ extra
          }
    } ;

    ConjVPS = conjunctDistrTable2 Order Agr ;


-- implementation of some of the relevant Foc rules from Extra

  lincat 
	Foc = {s : Mood => ResGer.Tense => Anteriority => Polarity => Str} ;
	
  lin 
    FocObj np cl =
		let n = appPrepNP cl.c2 np
		in mkFoc n cl ; 

	FocAdv adv cl = mkFoc adv.s cl ;

	FocAP ap np =
		let adj = ap.s ! APred ;
		    vp = predV sein_V ** {ext = ap.c.p1 ++ ap.c.p2 ++ ap.ext}; 
				-- potentially not correct analysis for all examples
				-- works for:
				-- "treu ist sie ihm"
				-- "froh ist sie dass er da ist"
				-- "stolz ist sie auf ihn"
		    subj = mkSubj np vp.subjc ;
			cl = mkClause subj.p1 subj.p2 vp
		in mkFoc adj cl ;

	UseFoc t p f = {s = t.s ++ p.s ++ f.s ! t.m ! t.t ! t.a ! p.p} ;


-- extra rules to get some of the "es" alternative linearisations

  lin
	EsVV vv vp = predV vv ** {
		nn = \\a => let n = vp.nn ! a in <"es" ++ n.p1 , n.p2 > ;
		inf = vp.s.s ! (VInf True) ++ vp.inf ;  -- ich genieße es zu versuchen zu gehen; alternative word order could be produced by vp.inf ++ vp.s.s... (zu gehen zu versuchen)
		a1 = vp.a1 ;
		a2 = vp.a2 ;
		ext = vp.ext ;
		infExt = vp.infExt ;
		adj = vp.adj } ;
		
	EsV2A v2a ap s = predV v2a ** {
		nn = \\_ => <"es",[]> ; 
		adj = ap.s ! APred ; 
		ext = "," ++ "dass" ++ s.s ! Sub} ;

-- "es wird gelacht"; generating formal sentences

  lincat
	FClause = VP ** {subj : NP} ;


  lin
	VPass v = 
  		let vp = predV werdenPass ;
		in vp ** {
			subj = esSubj ; 
			inf = v.s ! VPastPart APred } ; -- construct the formal clause

	AdvFor adv fcl = fcl ** {a2 = adv.s} ;
	
	FtoCl cl = 
		let subj = mkSubj cl.subj cl.subjc 
		in DisToCl subj.p1 subj.p2 cl ;


  oper -- extra operations for ExtraGer

    mkFoc : Str -> Cl -> Foc = \focus, cl ->
		lin Foc {s = \\m,t,a,p => focus ++ cl.s ! m ! t ! a ! p ! Inv} ;

	esSubj : NP = lin NP {
		s = \\_ => "es" ; 
		rc, ext, adv = [] ;
		a = Ag Neutr Sg P3 ;
		isPron = True} ;

	DisToCl : Str -> Agr -> FClause -> Clause = \subj,agr,vp ->  
	  let vps = useVP vp in {
      s = \\m,t,a,b,o =>
        let
          ord   = case o of {
            Sub => True ;  -- glue prefix to verb
            _ => False
            } ;
          verb  = vps.s  ! ord ! agr ! VPFinite m t a ;
          neg   = vp.a1 ! b ;
          obj0  = (vp.nn ! agr).p1 ;
          obj   = (vp.nn ! agr).p2 ;
          compl = obj0 ++ neg  ++ vp.adj ++ obj ++ vp.a2 ; -- adj added
          inf   = vp.inf ++ verb.inf ; -- not used for linearisation of Main/Inv
          extra = vp.ext ;
          inffin : Str = 
            case <a,vp.isAux> of {                       
	           <Anter,True> => verb.fin ++ inf ; -- double inf   --# notpresent
             _            => inf ++ verb.fin              --- or just auxiliary vp
            }                                            
        in
        case o of {
	    Main => subj ++ verb.fin ++ compl ++ vp.infExt ++ verb.inf ++ extra ++ vp.inf ;
	    Inv  => verb.fin ++ compl ++ vp.infExt ++ verb.inf ++ extra ++ vp.inf ;
	    Sub  => compl ++ vp.infExt ++ inffin ++ extra }
    		} ; 
		
		-- this function is not entirely satisfactory as largely 
		-- though not entirely duplicating mkClause in ResGer
} 
