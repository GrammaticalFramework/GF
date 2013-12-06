--# -path=alltenses:.:sysu:../english
concrete ParseChi of ParseEngAbs = 
  TenseChi,
---  CatChi,
  NounChi - [PPartNP],
  AdjectiveChi,
  NumeralChi,
  SymbolChi [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionChi,
  VerbChi - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbChi,
  PhraseChi,
  SentenceChi,
  QuestionChi,
  RelativeChi,
  IdiomChi [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ExtraChi [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash, PassAgentVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash, ListCN, ConjCN, BaseCN, ConsCN],

  DictEngChi

   ** 
open ResChi, ParadigmsChi, SyntaxChi, Prelude in {

flags
  literal=Symb ;
  coding = utf8 ;


lin

  EmptyRelSlash slash = mkRCl <which_RP : RP> <lin ClSlash slash : ClSlash> ; 

  that_RP = which_RP ;

-- lexical entries

--  another_Quant = mkQuantifier "otro" "otra" "otros" "otras" ;
--  some_Quant = mkQuantifier "algún" "alguna" "algunos" "algunas" ;
--  anySg_Det = mkDeterminer "algún" "alguna" Sg False ; ---- also meaning "whichever" ? 
--  each_Det = SyntaxChi.every_Det ;

--  but_Subj = {s = "pero" ; m = Indic} ; ---- strange to have this as Subj

{-
  myself_NP = regNP "myself" singular ;
  yourselfSg_NP = regNP "yourself" singular ;
  himself_NP = regNP "himself" singular ;
  herself_NP = regNP "herself" singular ;
  itself_NP = regNP "itself" singular ;
  ourself_NP = regNP "ourself" plural ;
  yourselfPl_NP = regNP "yourself" plural ;
  themself_NP = regNP "themself" plural ;
  themselves_NP = regNP "themselves" plural ;
-}

CompoundCN num noun cn = {s = num.s ++ noun.s ++ cn.s ; c = cn.c} ; ----
DashCN noun cn = {s = noun.s ++ cn.s ; c = cn.c} ; ----

{-  
  DashCN noun1 noun2 = {
    s = \\n,c => noun1.s ! Sg ! Nom ++ "-" ++ noun2.s ! n ! c ;
    g = noun2.g
  } ;
-}

  GerundN v = {
    s = v.s ;
    c = ge_s ---- ge
  } ;
  
  GerundAP v = {
    s = v.s ++ de_s ; ----
    monoSyl = False ;
    hasAdA = True ; --- 
  } ;

  PastPartAP v = {
    s = v.s ++ de_s ;
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
  PredVPosv np vp = PredVP np vp ; ---- (lin NP np) (lin VP vp) ; ----
  PredVPovs np vp = PredVP np vp ; ----  (lin NP np) (lin VP vp) ; ----


  CompS s = insertObj s (predV copula []) ; ----


  CompQS qs = insertObj qs (predV copula []) ; ----
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

    ComplVV v a p vp = {
      verb = v ;
      compl = a.s ++ p.s ++ useVerb vp.verb ! p.p ! APlain ++ vp.compl ; ---- aspect
      prePart = vp.prePart
      } ;

  ApposNP np1 np2 = {
    s = np1.s ++ chcomma ++ np2.s
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

}
