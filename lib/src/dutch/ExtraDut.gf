concrete ExtraDut of ExtraDutAbs = CatDut ** 
  open ResDut, Coordination, Prelude, IrregDut, (P = ParadigmsDut), NounDut in 
{

  flags coding=utf8 ;

  lincat
    VPI   = {s : Bool => Str} ;
    [VPI] = {s1,s2 : Bool => Str} ;
  lin
    BaseVPI = twoTable Bool ;
    ConsVPI = consrTable Bool comma ;

    MkVPI vp = {s = \\b => useInfVP b vp ! agrP3 Sg } ;
    ConjVPI = conjunctDistrTable Bool ;

    ComplVPIVV v vpi = 
        insertInf (vpi.s ! v.isAux) (
           predVGen v.isAux BeforeObjs v) ; ----

lin
    ICompAP ap = {s = \\agr => "hoe" ++ ap.s ! agr ! APred} ; 

    IAdvAdv adv = {s = "hoe" ++ adv.s} ;

  lincat
    VPS   = {s : Order => Agr => Str} ;
    [VPS] = {s1,s2 : Order => Agr => Str} ;

  lin
    BaseVPS = twoTable2 Order Agr ;
    ConsVPS = consrTable2 Order Agr comma ;

    PredVPS np vpi = 
      let
        subj = np.s ! NPNom ;
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

    MkVPS tm p vp = {
      s = \\o,agr =>
        let
          ord   = case o of {
            Sub => True ;  -- glue prefix to verb
            _ => False
            } ;
          subj = [] ;
          t = tm.t ;
          a = tm.a ;
          b = p.p ;
          vform = vForm t agr.g agr.n agr.p o ;
          auxv = (auxVerb vp.s.aux).s ;
          vperf = vp.s.s ! VPerf APred ;
          verb : Str * Str = case <t,a> of {
            <Fut|Cond,Simul>  => <zullen_V.s ! vform, vp.s.s ! VInf> ; --# notpresent
            <Fut|Cond,Anter>  => <zullen_V.s ! vform, vperf ++ auxv ! VInf> ; --# notpresent
            <_,       Anter>  => <auxv ! vform,       vperf> ; --# notpresent
            <_,       Simul>  => <vp.s.s ! vform,     []>
            } ;
          fin   = verb.p1 ;
          neg   = vp.a1 ! b ;
          obj0  = vp.n0 ! agr ;
          obj   = vp.n2 ! agr ;
          compl = obj0 ++ neg ++ obj ++ vp.a2 ++ vp.s.prefix ;
          inf   = 
            case <vp.isAux, vp.inf.p2, a> of {                  --# notpresent
              <True,True,Anter> => vp.s.s ! VInf ++ vp.inf.p1 ; --# notpresent
              _ =>                                              --# notpresent
                 vp.inf.p1 ++ verb.p2
              }                                                 --# notpresent
              ;
          extra = vp.ext ;
          inffin = 
            case <a,vp.isAux> of {                              --# notpresent
              <Anter,True> => fin ++ inf ; -- double inf   --# notpresent
              _ =>                                              --# notpresent
              inf ++ fin              --- or just auxiliary vp
            }                                                   --# notpresent
        in
        tm.s ++ p.s ++
        case o of {
          Main => subj ++ fin ++ compl ++ inf ++ extra ;
          Inv  => fin ++ subj ++ compl ++ inf ++ extra ;
          Sub  => subj ++ compl ++ inffin ++ extra
          }
    } ;

    ConjVPS = conjunctDistrTable2 Order Agr ;

    PassVPSlash vps = 
      insertInf (vps.s.s ! VPerf APred) (predV ResDut.worden_V) ;
    PassAgentVPSlash vps np = 
      insertAdv (appPrep (P.mkPrep "door") np) (insertInf (vps.s.s ! VPerf APred) (predV ResDut.worden_V)) ;

lin
 NominalizeVPSlashNP vpslash np =
           --False for negation place; doesn't matter because vp.a1 ! Pos is chosen
           let  vp : ResDut.VP = insertObjNP np.isPron AfterObjs (\\_ => appPrep vpslash.c2.p1 np) vpslash ;
                agrDef : Agr = agrP3 Sg ; 
                compl : Str = vp.n0 ! agrDef ++ vp.a1 ! Pos ++ vp.n2 ! agrDef ++ vp.s.prefix ; 
                inf : Str = vp.inf.p1 ;
                extra : Str = vp.ext
            in       
            lin NP (mkNP (vp.s.s ! VInf ++ "van" ++ compl ++ inf ++ extra ) Utr Sg) ;  


lin
  zullen_VV = lin VV (zullen_V ** {isAux = True}) ;

  StressedPron pron = UsePron pron ** {
      s = table {NPNom => pron.stressed.nom ; NPAcc => pron.stressed.acc} } ; 

}
