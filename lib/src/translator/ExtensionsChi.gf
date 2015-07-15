--# -path=.:../abstract

concrete ExtensionsChi of Extensions = 
  CatChi ** open ResChi, ParadigmsChi, SyntaxChi, (G = GrammarChi), (E = ExtraChi), Prelude in {

lincat
  VPI = E.VPI ;
  ListVPI = E.ListVPI ;
  VPS = E.VPS ;
  ListVPS = E.ListVPS ;
  
lin
  MkVPI = E.MkVPI ;
  ConjVPI = E.ConjVPI ;
----  ComplVPIVV = E.ComplVPIVV ;

  MkVPS = E.MkVPS ;
  ConjVPS = E.ConjVPS ;
  PredVPS = E.PredVPS ;

  BaseVPI = E.BaseVPI ;
  ConsVPI = E.ConsVPI ;
  BaseVPS = E.BaseVPS ;
  ConsVPS = E.ConsVPS ;

  GenNP = E.GenNP ;
----  GenIP = E.GenIP ;
  GenRP = E.GenRP ;

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

----  EmptyRelSlash = E.EmptyRelSlash ;

lin
  that_RP = which_RP ;

-- lexical entries

--  another_Quant = mkQuantifier "otro" "otra" "otros" "otras" ;
--  some_Quant = mkQuantifier "algún" "alguna" "algunos" "algunas" ;
--  anySg_Det = mkDeterminer "algún" "alguna" Sg False ; ---- also meaning "whichever" ? 
--  each_Det = SyntaxChi.every_Det ;

--  but_Subj = {s = "pero" ; m = Indic} ; ---- strange to have this as Subj

  CompoundN noun cn  = {s = noun.s ++ cn.s ; c = cn.c} ; ----
  CompoundAP noun adj = complexAP (noun.s ++ possessive_s ++ adj.s) ; ----

  GerundN v = {
    s = v.s ;
    c = ge_s ---- ge
  } ;

  GerundNP vp = {
    s = infVP vp ; ---- ?
  } ;

  GerundAdv vp = {
    s = infVP vp ++ "地" ; ---- ?
    advType = ATManner ;
  } ;
  
  PastPartAP v = {
    s = v.verb.s ++ de_s ; ----
    monoSyl = False ;
    hasAdA = True ; --- 
  } ;


----  PastPartAP v = v ; ----

{-
  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;
-}

  PositAdVAdj a = {s = a.s} ;


  UseQuantPN q pn = {s = q.s ++ ge_s ++ pn.s} ; ---- ge

  SlashV2V v a p vp = 
    insertObj (ResChi.mkNP (a.s ++ p.s ++ useVerb vp.verb ! p.p ! APlain ++ vp.compl))   
              (predV v v.part) ** {c2 = v.c2 ; isPre = v.hasPrep} ; ---- aspect

{-
  SlashVPIV2V v p vpi = insertObjc (\\a => p.s ++ 
                                           v.c3 ++ 
                                           vpi.s ! VVAux ! a)
                                   (predVc v) ;
-}

---- TODO: find proper expressions for OSV and OVS in Chi
  PredVPosv np vp = G.PredVP np vp ; ---- (lin NP np) (lin VP vp) ; ----
  PredVPovs np vp = G.PredVP np vp ; ----  (lin NP np) (lin VP vp) ; ----


  CompS s = insertObj s (predV copula []) ; ----


  CompQS qs = insertObj (ss (qs.s ! False)) (predV copula []) ; ----
  CompVP ant p vp = insertObj (ss (infVP vp)) (predV copula []) ; ----

{-
  VPSlashVS vs vp = 
    insertObj (\\a => infVP VVInf vp Simul CPos a) (predV vs []) **
    {c2 = ""; gapInMiddle = False} ;

-}

  PastPartRS ant pol vp = { ---- copied from PresPartRS
       s = ant.s ++ pol.s ++ vp.prePart ++ useVerb vp.verb ! pol.p ! APlain ++ vp.compl ++ which_RP.s  ---- aspect
       } ; ---- ??


  PresPartRS ant pol vp = { ---- copied from RelVP
       s = ant.s ++ pol.s ++ vp.prePart ++ useVerb vp.verb ! pol.p ! APlain ++ vp.compl ++ which_RP.s  ---- aspect
       } ; ---- ??

  PresPartAP vp = { ---- copied from RelVP
       s = vp.prePart ++ useVerb vp.verb ! Pos ! APlain ++ vp.compl ; -- ++ which_RP.s ;
       monoSyl = False ;
       hasAdA = False
       } ; ---- ??

    ComplVV v a p vp = {
      verb = v ;
      compl = a.s ++ p.s ++ vp.topic ++ vp.prePart ++ useVerb vp.verb ! p.p ! APlain ++ vp.compl ; ---- aspect
      prePart, topic = []
      } ;

  ApposNP np1 np2 = {
    s = np1.s ++ chcomma ++ np2.s
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

}
