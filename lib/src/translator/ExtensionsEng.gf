--# -path=.:../abstract

concrete ExtensionsEng of Extensions = 
  CatEng ** open MorphoEng, ResEng, ParadigmsEng, (S = SentenceEng), (E = ExtraEng), SyntaxEng, Prelude in {

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

  GenNP = E.GenNP ;
  GenIP = E.GenIP ;
  GenRP = E.GenRP ;

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

  EmptyRelSlash = E.EmptyRelSlash ;

lin
  CompoundN noun cn = {
    s = (\\n,c => noun.s ! Sg ! Nom ++ cn.s ! n ! c) 
      | (\\n,c => noun.s ! Pl ! Nom ++ cn.s ! n ! c)
      | (\\n,c => noun.s ! Sg ! Nom ++ Predef.BIND ++ "-" ++ Predef.BIND ++ cn.s ! n ! c) 
      | (\\n,c => noun.s ! Pl ! Nom ++ Predef.BIND ++ "-" ++ Predef.BIND ++ cn.s ! n ! c) 
      ;
    g = cn.g
  } ;
  
  CompoundAP noun adj = {
    s = (\\_ => noun.s ! Sg ! Nom ++ Predef.BIND ++ "-" ++ Predef.BIND ++ adj.s ! AAdj Posit Nom)
      | (\\_ => noun.s ! Sg ! Nom ++ adj.s ! AAdj Posit Nom)
      ;
    isPre = True
    } ;

   GerundCN vp = {
     s = \\n,c => vp.ad ! AgP3Sg Neutr ++ vp.prp ++
                  case <n,c> of {
                    <Sg,Nom> => "" ;
                    <Sg,Gen> => Predef.BIND ++ "'s" ;
                    <Pl,Nom> => Predef.BIND ++ "s" ;
                    <Pl,Gen> => Predef.BIND ++ "s'"
                    } ++ 
                  vp.p ++ vp.s2 ! AgP3Sg Neutr ++ vp.ext ; 
     g = Neutr
     } ;

   GerundNP vp = 
     let a = AgP3Sg Neutr ---- agr
     in 
     {s = \\_ => vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext ; a = a} ;

   GerundAdv vp = 
     let a = AgP3Sg Neutr
     in 
     {s = vp.ad ! a ++ vp.prp ++ vp.p ++ vp.s2 ! a ++ vp.ext} ;

   WithoutVP vp = {s = "without" ++ (GerundAdv (lin VP vp)).s} ; 

   InOrderToVP vp = {s = ("in order" | []) ++ infVP VVInf vp Simul CPos (AgP3Sg Neutr)} ;

   ByVP vp = {s = "by" ++ (GerundAdv (lin VP vp)).s} ; 

   PresPartAP = E.PartVP ;

   PastPartAP vp = { 
      s = \\a => vp.ad ! a ++ vp.ptp ++ vp.p ++ vp.c2 ++ vp.s2 ! a ++ vp.ext ;
      isPre = vp.isSimple                 -- depends on whether there are complements
      } ;
   PastPartAgentAP vp np = { 
      s = \\a => vp.ad ! a ++ vp.ptp ++ vp.p ++ vp.c2 ++ vp.s2 ! a ++ "by" ++ np.s ! NPAcc ++ vp.ext ;
      isPre = False
      } ;

  PositAdVAdj a = {s = a.s ! AAdv} ;

  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;

  SlashV2V v ant p vp = insertObjc (\\a => v.c3 ++ ant.s ++ p.s ++
                                           infVP v.typ vp ant.a p.p a)
                                   (predVc v) ;

  SlashSlashV2V v ant p vp = insertObjc (\\a => v.c3 ++ ant.s ++ p.s ++
                                           infVP v.typ vp ant.a p.p a)
                                   (predVc v) ;

  SlashVPIV2V v p vpi = insertObjc (\\a => p.s ++ 
                                           v.c3 ++ 
                                           vpi.s ! VVAux ! a)
                                   (predVc v) ;
  ComplVV v a p vp = insertObj (\\agr => a.s ++ p.s ++ 
                                         infVP v.typ vp a.a p.p agr)
                               (predVV v) ;

  PredFrontVS t np vs s = 
    let 
      cl = mkClause (np.s ! npNom) np.a (predV vs) | E.InvFrontExtPredVP np (predV vs)
    in {
      s = s.s ++ frontComma ++ t.s ++ t.s ++ cl.s ! t.t ! t.a ! CPos ! oDir
    } ;

  PredFrontVQ t np vs s = 
    let 
      cl = mkClause (np.s ! npNom) np.a (predV vs) | E.InvFrontExtPredVP np (predV vs)
    in {
      s = s.s ! QDir ++ frontComma ++ t.s ++ cl.s ! t.t ! t.a ! CPos ! oDir
    } ;

  that_RP = {
    s = \\_ => "that" ;
    a = RNoAg
    } ;

  who_RP = {
    s = \\_ => "who" ;
    a = RNoAg
    } ;

  CompS s = {s = \\_ => "that" ++ s.s} ;
  CompQS qs = {s = \\_ => qs.s ! QIndir} ;
  CompVP ant p vp = {s = \\a => ant.s ++ p.s ++ 
                                infVP VVInf vp ant.a p.p a} ;

  VPSlashVS vs vp = 
    insertObj (\\a => infVP VVInf vp Simul CPos a) (predV vs) **
    {c2 = ""; gapInMiddle = False} ;

  PastPartRS ant pol vps = {
    s = \\agr => vps.ad ! agr ++ vps.ptp ++ vps.p ++ vps.s2 ! agr ;
    c = npNom
    } ;

  PresPartRS ant pol vp = {
    s = \\agr => vp.ad ! agr ++ vp.prp ++ vp.p ++ vp.s2 ! agr;
    c = npNom
  } ;

  ApposNP np1 np2 = {
    s = \\c => np1.s ! c ++ frontComma ++ np2.s ! npNom ++ finalComma ;
    a = np1.a
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

  DirectComplVS t np vs utt = 
    mkS (lin Adv (optCommaSS utt)) (mkS t positivePol (mkCl np (lin V vs))) ;

  DirectComplVQ t np vs q = 
    mkS (lin Adv (optCommaSS (mkUtt q))) (mkS t positivePol (mkCl np (lin V vs))) ;

  FocusObjS np sslash = 
    mkS (lin Adv (optCommaSS (ss (sslash.c2 ++ np.s ! NPAcc)))) <lin S sslash : S> ;

}
