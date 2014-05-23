--# -path=.:../abstract

concrete ExtensionsGer of Extensions = 
  CatGer ** open MorphoGer, ResGer, ParadigmsGer, SyntaxGer, (E = ExtraGer), (G = GrammarGer), Prelude in {

flags literal=Symb ; coding = utf8 ;

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
    ComplVV v ant p vp = 
      let 
        vpi = infVP v.isAux vp 
      in
       insertExtrapos vpi.p4 (
        insertInfExt vpi.p3 (
          insertInf vpi.p2 (
            insertObj vpi.p1 (
              predVGen v.isAux v)))) ;

    PastPartRS ant pol sl = {   -- guessed by KA, some fields in sl are ignored!!
      s = \\gn => let agr = agrgP3 Masc (numGenNum gn)
                  in sl.s.s ! VPastPart APred ++ 
                     (sl.nn ! agr).p1 ++ (sl.nn ! agr).p2 ++ sl.a2;
      c = Nom
      } ;

    PresPartRS ant pol vp = {   -- guessed by KA!!
      s = \\gn => let agr = agrgP3 Masc (numGenNum gn)
                  in vp.s.s ! VPresPart APred ++ 
                     (vp.nn ! agr).p1 ++ (vp.nn ! agr).p2;
      c = Nom
      } ;

    PredVPosv = G.PredVP;
    PredVPovs = G.PredVP;

  CompoundCN noun cn = {
    s = \\a,n,c => glue (noun.s ! Sg ! Nom) (cn.s ! a ! n ! c) ;
    g = cn.g
  } ;

    CompoundAP noun adj = {
      s = \\af => glue (noun.s ! Sg ! Nom) (adj.s ! Posit ! af) ;
      isPre = True
      } ;

  GerundN v = { -- parsing
    s = \\n,c => v.s ! VInf False ; --- formalisieren, not formalisierung
    g = Neutr
  } ;

{-  
  GerundAP v = {  -- beckoning
    s = \\agr => v.s ! VPresPart ;
    isPre = True
  } ;

  PastPartAP v = {   -- broken
    s = \\agr => v.s ! VPPart ;
    isPre = True
  } ;

  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;  -- higher

  PositAdVAdj a = {s = a.s ! AAdv} ;  -- really

  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;  -- this London

  SlashV2V v p vp = insertObjc (\\a => p.s ++ case p.p of {CPos => ""; _ => "nicht"} ++  -- force not to sleep
                                       v.c3 ++ 
                                       infVP v.typ vp a)
                               (predVc v) ;

  ComplPredVP np vp = { -- ?
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir => compl ++ "," ++ np.s ! npNom ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ;
          OQuest => verb.aux ++ compl ++ "," ++ np.s ! npNom ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf 
          }
    } ;
-}
  CompS s = {s = \\_ => "dass" ++ s.s ! Main} ;  -- S -> Comp
  CompVP ant p vp = {s = \\_ => useInfVP True vp} ; -- VP -> Comp

lin
  that_RP = which_RP ;

  UttAdV adv = adv;

  DirectComplVS t np vs utt = 
    mkS (lin Adv (optCommaSS utt)) (mkS t positivePol (mkCl np (lin V vs))) ;

  DirectComplVQ t np vs q = 
    mkS (lin Adv (optCommaSS (mkUtt q))) (mkS t positivePol (mkCl np (lin V vs))) ;

  FocusObjS np sslash = 
    mkS (lin Adv (ss (appPrep sslash.c2 np.s))) <lin S sslash : S> ;



}
