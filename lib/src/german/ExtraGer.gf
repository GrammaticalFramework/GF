concrete ExtraGer of ExtraGerAbs = CatGer ** 
  open ResGer, Coordination, Prelude, IrregGer in {

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

    ICompAP ap = {s = \\_ => "wie" ++ ap.s ! APred} ; 

    CompIQuant iq = {s = table {Ag g n p => iq.s ! n ! g ! Nom}} ;

    IAdvAdv adv = {s = "wie" ++ adv.s} ;

    DetNPMasc det = {
      s = \\c => det.sp ! Masc ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False
      } ;

    DetNPFem det = {
      s = \\c => det.sp ! Fem ! c ; ---- genders
      a = agrP3 det.n ;
      isPron = False
      } ;

    EmptyRelSlash slash = {
      s = \\m,t,a,p,gn => 
          appPrep slash.c2 (\\k => usePrepC k (\c -> relPron ! gn ! c)) ++ 
          slash.s ! m ! t ! a ! p ! Sub ;
      c = (prepC slash.c2.c).c
      } ;

    PassVPSlash vps = 
      insertInf (vps.s.s ! VPastPart APred) (predV werdenPass);

  lincat
    VPS   = {s : Order => Agr => Str} ;
    [VPS] = {s1,s2 : Order => Agr => Str} ;

  lin
    BaseVPS = twoTable2 Order Agr ;
    ConsVPS = consrTable2 Order Agr comma ;

    PredVPS np vpi = 
      let
        subj = np.s ! NPC Nom ;
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
          neg   = vp.a1 ! b ;
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


} 
