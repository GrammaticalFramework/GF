--# -path=.:../abstract

concrete ExtensionsSwe of Extensions = 
  CatSwe ** open MorphoSwe, ResSwe, ParadigmsSwe, (E = ExtraSwe), (G = GrammarSwe), SyntaxSwe, CommonScand, Prelude in {

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
----  GenIP = E.GenIP ;
----  GenRP = E.GenRP ;

  PassVPSlash = E.PassVPSlash ;
  PassAgentVPSlash = E.PassAgentVPSlash ;

  EmptyRelSlash = E.EmptyRelSlash ;



lin
  CompoundCN num noun cn = {
      s = \\n,d,c => num.s ! cn.g ++ noun.co ++ BIND ++ cn.s ! n ! d ! c ; 
      g = cn.g ;
      isMod = False
      } ;

  DashCN noun1 noun2 = {
      s = \\n,d,c => noun1.co ++ BIND ++ noun2.s ! n ! d ! c ; 
      g = noun2.g ;
      co = noun1.co ++ BIND ++ noun2.co ---- add s if not already there
      } ;

  GerundN v = {
    s = \\n,d,c => v.s ! VI (VPtPres n d c) ;
    g = Neutr ;
    co = v.s ! VI (VPtPres Sg Indef Nom) ;
  } ;
  
  GerundAP v = {
    s = \\_ => v.s ! VI (VPtPres Sg Indef Nom) ;
    isPre = True
  } ;

  PastPartAP v = {
    s = \\afpos => v.s ! VI (VPtPret afpos Nom) ;
    isPre = True
  } ;


  OrdCompar a = {
      s = case a.isComp of {
        True => "mera" ++ a.s ! AF (APosit (Weak Sg)) Nom ;
        _    => a.s ! AF ACompar Nom
        }  ; 
      isDet = True
      } ;

  PositAdVAdj a = {s = a.s ! G.adverbForm} ;

  UseQuantPN q pn = {
      s = \\c => q.s ! Sg ! True ! False ! pn.g ++ pn.s ! caseNP c ; 
      a = agrP3 pn.g Sg
      } ;

  SlashV2V v ant p vp = predV v ** {
      n3 = \\a => v.c3.s ++ ant.s ++ p.s ++ infVPPlus vp a ant.a p.p ; 
      c2 = v.c2
      } ;

  SlashVPIV2V v p vpi = predV v ** {
      n3 = \\a => v.c3.s ++ p.s ++ negation ! p.p ++ vpi.s ! VPIInf ! a ; 
      c2 = v.c2
      } ;

  ComplVV v ant pol vp = insertObjPost (\\a => v.c2.s ++ ant.s ++ pol.s ++ infVPPlus vp a ant.a pol.p) (predV v) ;


  PredVPosv np vp = mkCl np vp ; ---- TODO restructure all this using Extra.Foc
  PredVPovs np vp = mkCl np vp ; ---- 

  that_RP = which_RP ; -- som
  who_RP = which_RP ;

  CompS s = {s = \\_ => "att" ++ s.s ! Sub} ;
  CompQS qs = {s = \\_ => qs.s ! QIndir} ;
  CompVP ant p vp = {s = \\a => ant.s ++ p.s ++ infVPPlus vp a ant.a p.p} ;

  -- VPSlashVS : VS -> VP -> VPSlash
  ---VPSlashVS vs vp = 
  ---   insertObj (\\a => infVP VVInf vp Simul CPos a) (predV vs) **
  ---  {c2 = ""; gapInMiddle = False} ;

  PastPartRS ant pol vps = mkRS ant pol (mkRCl which_RP <lin VP vps : VP> ) ; ---- maybe as participle construction?

  PresPartRS ant pol vp = mkRS ant pol (mkRCl which_RP vp) ; --- probably not as participle construction

  ApposNP np1 np2 = {
    s = \\c => np1.s ! c ++ comma ++ np2.s ! NPNom ;
    a = np1.a
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

}
