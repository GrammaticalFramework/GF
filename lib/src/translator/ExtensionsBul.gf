--# -path=.:../abstract

concrete ExtensionsBul of Extensions = 
  CatBul ** open ResBul, (E = ExtraBul), Prelude, SyntaxBul in {

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

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

  EmptyRelSlash = E.EmptyRelSlash ;

lin
  CompoundN noun cn = {
    s = \\nf => (noun.rel ! nform2aform nf cn.g) ++ (cn.s ! (indefNForm nf)) ;
    rel = \\af => (noun.rel ! af) ++ (cn.rel ! af) ; ---- is this correct? AR 29/5/2014
    g = cn.g
  } ;

  CompoundAP n a =
    let ap : AForm => Str
           = \\aform => n.rel ! (ASg Neut Indef) ++ a.s ! aform
    in {s = ap; adv = ap ! (ASg Neut Indef); isPre = True} ;

  GerundCN vp = {
    s   = \\nform => vp.ad.s ++
                     vp.s ! Imperf ! VNoun nform ++
                     vp.compl ! {gn=GSg Neut; p=P3} ;
    g = ANeut
  } ;
  
  GerundNP vp = {
    s = \\_ => daComplex Simul Pos vp ! Imperf ! {gn=GSg Neut; p=P1};
    a = {gn=GSg Neut; p=P3};
    p = Pos
  } ;

  GerundAdv vp =
    {s = vp.ad.s ++
         vp.s ! Imperf ! VGerund ++
         vp.compl ! {gn=GSg Neut; p=P3}} ;

  PresPartAP vp =
    let ap : AForm => Str
           = \\aform => vp.ad.s ++
                        vp.s ! Imperf ! VPresPart aform ++
                        case vp.vtype of {
                          VMedial c => reflClitics ! c;
                          _         => []
                        } ++
                        vp.compl ! {gn=aform2gennum aform; p=P3} ;
    in {s = ap; adv = ap ! (ASg Neut Indef); isPre = True} ;

  PastPartAP vp =
    let ap : AForm => Str
           = \\aform => vp.ad.s ++
                        vp.s ! Perf ! VPassive aform ++
                        vp.compl1 ! {gn=aform2gennum aform; p=P3} ++
                        vp.compl2 ! {gn=aform2gennum aform; p=P3}
    in {s = ap; adv = ap ! ASg Neut Indef; isPre = True} ;

  PastPartAgentAP vp np =
    let ap : AForm => Str
           = \\aform => vp.ad.s ++
                        vp.s ! Perf ! VPassive aform ++
                        vp.compl1 ! {gn=aform2gennum aform; p=P3} ++
                        vp.compl2 ! {gn=aform2gennum aform; p=P3} ++
                        "от" ++ np.s ! RObj Acc
    in {s = ap; adv = ap ! ASg Neut Indef; isPre = True} ;

  ByVP vp =
    {s = vp.ad.s ++
         vp.s ! Imperf ! VGerund ++
         vp.compl ! {gn=GSg Neut; p=P3}} ;

  InOrderToVP vp =
    {s = "за" ++ daComplex Simul Pos (vp**{vtype=VMedial Acc}) ! Imperf ! {gn=GSg Neut; p=P3}};

  WithoutVP vp =
    {s = "без" ++ daComplex Simul Pos (vp**{vtype=VMedial Acc}) ! Imperf ! {gn=GSg Neut; p=P3}};

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
  AdAdV = cc2 ;
  
  DirectComplVS t np vs utt = 
    mkS (lin Adv (optCommaSS utt)) (mkS t positivePol (mkCl np (lin V vs))) ;

  DirectComplVQ t np vs q = 
    mkS (lin Adv (optCommaSS (mkUtt q))) (mkS t positivePol (mkCl np (lin V vs))) ;

  FocusObjS np sslash = 
    mkS (lin Adv (optCommaSS (ss (sslash.c2.s ++ np.s ! RObj sslash.c2.c)))) (lin S {s=sslash.s ! np.a}) ;

}
