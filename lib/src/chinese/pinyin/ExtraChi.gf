concrete ExtraChi of ExtraChiAbs = CatChi ** 
  open ResChi, Coordination, (S = StructuralChi), Prelude in {

  flags coding = utf8 ;

  lincat 
    VPS   = {s : Str} ;
    [VPS] = {s1,s2 : Str} ;
    VPI   = {s : Str} ;  --- ???
    [VPI] = {s1,s2 : Str} ; --- ???

  lin
    PassVPSlash vps = insertAdv (mkNP passive_s) vps ;
    PassAgentVPSlash vps np = insertAdv (ss (appPrep S.by8agent_Prep np.s)) (insertAdv (mkNP passive_s) vps) ;

    MkVPS t p vp = {s = t.s ++ p.s ++ (mkClause [] vp).s ! p.p ! t.t} ;
    ConjVPS c = conjunctDistrSS (c.s ! CSent) ;
    BaseVPS = twoSS ;
    ConsVPS = consrSS duncomma ;

    PredVPS np vps = {s = np.s ++ vps.s} ;

    MkVPI vp = {s = (mkClause [] vp).s ! Pos ! APlain} ; --- ?? almost just a copy of VPS
    ConjVPI c = conjunctDistrSS (c.s ! CSent) ;
    BaseVPI = twoSS ;
    ConsVPI = consrSS duncomma ;

    GenNP np =  {s,pl = np.s ++ possessive_s ; detType = DTPoss} ;

    GenRP nu cn = {s = cn.s ++ relative_s} ; ---- ??


-----------------------
-- Chinese-only extras

  lincat
    Aspect = {s : Str ; a : ResChi.Aspect} ;
  lin
    CompBareAP ap = case ap.hasAdA of {
      True  => insertObj (mkNP ap.s) (predV nocopula []) ; 
      False => insertObj (mkNP ap.s) (predV hen_copula [])
      } ; 
    QuestRepV cl = {
      s = \\_,p,a =>  ---- also for indirect questions?
          let
          v = cl.vp.verb ; 
          verb = case a of {
            APlain   => v.s  ++ v.neg ++ v.sn ; 
            APerf    => v.s  ++ "bù"  ++ v.sn ++ v.pp ;
            ADurStat => v.s  ++ "bù"  ++ v.sn ;
            ADurProg => v.dp ++ v.neg ++ v.dp ++ v.sn ;  -- mei or bu
            AExper   => v.s  ++ v.neg ++ v.sn ++ v.ep
            }
          in
          cl.np ++ cl.vp.prePart ++ verb ++ cl.vp.compl
      } ;

  TopicAdvVP vp adv = insertTopic adv vp ;

} 
