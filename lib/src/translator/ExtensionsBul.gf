--# -path=.:../abstract

concrete ExtensionsBul of Extensions = 
  CatBul ** open ResBul, (E = ExtraBul), Prelude in {

flags 
  coding = utf8 ;

lincat
  VPI = E.VPI ;
  ListVPI = E.ListVPI ;
  VPS = E.VPS ;
  ListVPS = E.ListVPS ;
  
lin
  MkVPI = E.MkVPI ;
  ConjVPI = E.ConjVPI ;
  ComplVPIVV = E.ComplVPIVV ;

  MkVPS = E.MkVPS ;
  ConjVPS = E.ConjVPS ;
  PredVPS = E.PredVPS ;

  BaseVPI = E.BaseVPI ;
  ConsVPI = E.ConsVPI ;
  BaseVPS = E.BaseVPS ;
  ConsVPS = E.ConsVPS ;

----  GenNP = E.GenNP ;
----  GenIP = E.GenIP ;
----  GenRP = E.GenRP ;

----  PassVPSlash = E.PassVPSlash ;
----  PassAgentVPSlash = E.PassAgentVPSlash ;

  EmptyRelSlash = E.EmptyRelSlash ;

lin
  CompoundCN num noun cn = {
    s = \\nf => num.s ! CFNeut Indef ++ (noun.rel ! nform2aform nf cn.g) ++ (cn.s ! (indefNForm nf)) ;
    g = cn.g
  } ;

  GerundN v = {
    s   = \\nform => v.s ! Imperf ! VNoun nform ;
    rel = \\aform => v.s ! Imperf ! VPresPart aform ++
                     case v.vtype of {
                       VMedial c => reflClitics ! c;
                       _         => []
                     };
    g = ANeut
  } ;
  
  GerundAP v = {
    s = \\aform => v.s ! Imperf ! VPresPart aform ++
                   case v.vtype of {
                     VMedial c => reflClitics ! c;
                     _         => []
                   };
    adv = v.s ! Imperf ! VPresPart (ASg Neut Indef);
    isPre = True
  } ;

  PastPartAP v = {
    s = \\aform => v.s ! Perf ! VPassive aform ;
    adv = v.s ! Perf ! VPassive (ASg Neut Indef);
    isPre = True
  } ;

  PositAdVAdj a = {s = a.adv} ;
  
  that_RP = {
    s = whichRP
  } ;

  UseQuantPN q pn = { s = table {
                            RObj Dat => "на" ++ pn.s; 
                            _        => pn.s
                          } ;
                      a = {gn = GSg pn.g; p = P3};
                      p = q.p
                    } ;

  PastPartRS ant pol vp = {
      s = \\agr => 
             ant.s ++ pol.s ++
             vp.ad.s ++
             case pol.p of {Pos   => ""; Neg => "не"} ++
             case ant.a of {Simul => ""; Anter => auxBe ! VPerfect (aform agr.gn Indef (RObj Acc))} ++
             vp.s ! Perf ! VPassive (aform agr.gn Indef (RObj Acc)) ++
             case vp.vtype of {
               VMedial c => reflClitics ! c;
               _         => []
             } ++
             vp.compl1 ! agr ++ vp.compl2 ! agr ;
  } ;

  PresPartRS ant pol vp = {
      s = \\agr => 
             ant.s ++ pol.s ++
             vp.ad.s ++
             case pol.p of {Pos   => ""; Neg => "не"} ++
             case ant.a of {Simul => ""; Anter => auxBe ! VPerfect (aform agr.gn Indef (RObj Acc))} ++
             vp.s ! Imperf ! VPresPart (aform agr.gn Indef (RObj Acc)) ++
             case vp.vtype of {
               VMedial c => reflClitics ! c;
               _         => []
             } ++
             vp.compl ! agr ;
  } ;

  SlashV2V vv ant p vp =
      insertSlashObj2 (\\agr => ant.s ++ p.s ++ vv.c3.s ++
                                daComplex ant.a (orPol p.p vp.p) vp ! Perf ! agr)
                      Pos
                      (slashV vv vv.c2) ;

  ComplVV vv ant p vp =
      insertObj (\\agr => ant.s ++ p.s ++
                          case vv.typ of {
                            VVInf    => daComplex ant.a p.p vp ! Perf ! agr;
                            VVGerund => gerund vp ! Imperf ! agr
                          }) vp.p
                (predV vv) ;

  PredVPosv np vp = {
      s = \\t,a,p,o => 
        let
          subj = np.s ! (case vp.vtype of {
                                        VNormal    => RSubj ;
                                        VMedial  _ => RSubj ;
                                        VPhrasal c => RObj c}) ;
          verb  : Bool => Str
                = \\q => vpTenses vp ! t ! a ! p ! np.a ! q ! Perf ;
          compl = vp.compl ! np.a
        in case o of {
             Main  => compl ++ subj ++ verb ! False  ;
             Inv   => verb ! False ++ compl ++ subj ;
             Quest => compl ++ subj ++ verb ! True
           }
    } ;

  CompS s = {s = \\_ => "че" ++ s.s; p = Pos} ;
  CompQS qs = {s = \\_ => qs.s ! QIndir; p = Pos} ;
  CompVP ant p vp = {s = let p' = case vp.p of {
                                    Neg => Neg;
                                    Pos => p.p
                                  }
                         in \\agr => ant.s ++ p.s ++
                                     daComplex ant.a p' vp ! Perf ! agr;
                     p = Pos
                    } ;

  VPSlashVS vs vp = 
    let vp = insertObj (daComplex Simul Pos vp ! Perf) vp.p (predV vs)
    in { s  = vp.s;
         ad = vp.ad;
         compl1 = \\_ => "";
         compl2 = vp.compl;
         vtype  = vp.vtype;
         p      = vp.p;
         c2     = {s=""; c=Acc}
       } ;

  ApposNP np1 np2 = {
    s = \\role => np1.s ! role ++ comma ++ np2.s ! RSubj ;
    a = np1.a ;
    p = np1.p
  } ;

  UttAdV adv = adv;

}
