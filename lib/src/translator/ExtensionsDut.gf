--# -path=.:../abstract

concrete ExtensionsDut of Extensions = 
  CatDut ** open ResDut, ParadigmsDut, SyntaxDut, (E = ExtraDut), ExtendDut, (G = GrammarDut), Prelude in {

flags literal=Symb ; coding = utf8 ;

lincat
  VPI = E.VPI ;
  ListVPI = E.ListVPI ;
  VPS = E.VPS ;
  ListVPS = E.ListVPS ;
  
lin
  MkVPI = E.MkVPI ;
----  ConjVPI = E.ConjVPI ;
----  ComplVPIVV = E.ComplVPIVV ;

  MkVPS = E.MkVPS ;
----  ConjVPS = E.ConjVPS ;
  PredVPS = E.PredVPS ;

----  BaseVPI = E.BaseVPI ;
----  ConsVPI = E.ConsVPI ;
----  BaseVPS = E.BaseVPS ;
----  ConsVPS = E.ConsVPS ;

----  GenNP = E.GenNP ;
----  GenIP = E.GenIP ;
----  GenRP = E.GenRP ;

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

----  EmptyRelSlash = E.EmptyRelSlash ;


lin
{-
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
-}
    PredVPosv = G.PredVP;
    PredVPovs = G.PredVP;

  CompoundN noun cn = {
    s = \\nf => glue (noun.s ! NF Sg Nom) (cn.s ! nf) ; ---- TODO: introduce compound form
    g = cn.g
    } ;

  CompoundAP noun adj = {
      s = \\agr,af => glue (noun.s ! NF Sg Nom) (adj.s ! Posit ! af) ;
      isPre = True
      } ;

  GerundNP vp = heavyNP {  -- infinitive: Bier zu trinken
    s = \\c => useInfVP False vp ! agrP3 Sg ; 
    a = agrP3 Sg
    } ;

  GerundAdv vp = {  -- Bier trinkend
    s = vp.n0 ! agrP3 Sg ++ vp.n2 ! agrP3 Sg ++ vp.a2 ++ vp.a1 ! Pos ++ vp.inf.p1 ++ vp.ext ++ vp.s.s ! VGer
    } ;

  WithoutVP vp = {  -- ohne Bier zu trinken
    s = "zonder" ++ useInfVP False vp ! agrP3 Sg
    } ;

  InOrderToVP vp = {  -- um Bier zu trinken
    s = "om" ++ useInfVP False vp ! agrP3 Sg
    } ;

  ByVP vp = {  ---- durch Bier zu drinken
    s = "door" ++ useInfVP False vp ! agrP3 Sg ----
    } ;

  PastPartAP = ExtendDut.PastPartAP ;
  
  PresPartAP vp = { --# notpresent
    s = \\agr,af => let aForm = case vp.isHeavy of { --# notpresent
                          True  => APred ; --# notpresent
                          False => af } ; --# notpresent
                     in (infClause [] agr vp aForm).s ! Pres ! Simul ! Pos ! Sub ; --# notpresent
    isPre = notB vp.isHeavy ; --# notpresent
   } ; --# notpresent

  PastPartAgentAP vp np = 
    let agent = (SyntaxDut.mkAdv (mkPrep "door") (lin NP np)).s ;
        ap = ExtendDut.PastPartAP vp ;
    in ap ** { s = \\agr,af => ap.s ! agr ! af ++ agent } ;

{-  

  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;  -- higher

  PositAdVAdj a = {s = a.s ! AAdv} ;  -- really

  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;  -- this London

  SlashV2V v p vp = insertObjc (\\a => p.s ++ case p.p of {CPos => ""; _ => "niet"} ++  -- force not to sleep
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
  CompS s = {s = \\_ => "dat" ++ s.s ! Main} ;  -- S -> Comp
  CompVP ant p vp = {s = useInfVP True vp} ; -- VP -> Comp

lin
  that_RP = which_RP ;

  UttAdV adv = adv ;

  ApposNP np1 np2 = np1 ** {
    s = \\c => np1.s ! c ++ SOFT_BIND ++ "," ++ np2.s ! NPNom ;
    isPron = False
  } ;
  
  AdAdV = cc2 ;

}
