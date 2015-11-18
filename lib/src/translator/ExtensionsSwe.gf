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
  CompoundN noun cn = {
      s = \\n,d,c => noun.co ++ BIND ++ cn.s ! n ! d ! c ; 
      co = noun.co ++ BIND ++ cn.s ! Sg ! Indef ! Gen   -- (last+bil)s + chaufför 
        | noun.co ++ cn.co ;
      g = cn.g
      } ;

  CompoundAP noun adj = {
      s = \\ap => noun.co ++ BIND ++ adj.s ! AF (APosit ap) Nom ; 
      isPre = True
      } ;

  GerundNP vp = {  -- infinitive: att dricka öl, att vara glad
    s = \\_ => "att" ++ infVP vp {g = Utr ; n = Sg ; p = P3} ; 
    a = {g = Neutr ; n = Sg ; p = P3}
    } ;

  GerundAdv vp = {
    s = partVPPlusPost vp (PartPres Sg Indef (Nom|Gen)) {g = Utr ; n = Sg ; p = P3} Pos -- sovande(s) i sängen
    } ;

  WithoutVP vp = {  -- utan att dricka öl, utan att vara glad
    s = "utan att" ++ infVP vp {g = Utr ; n = Sg ; p = P3}
    } ;

  InOrderToVP vp = {  -- för att dricka öl, för att vara glad
    s = "för att" ++ infVP vp {g = Utr ; n = Sg ; p = P3}
    } ;

  ByVP vp = {  -- genom att dricka öl, genom att vara glad
    s = "genom att" ++ infVP vp {g = Utr ; n = Sg ; p = P3}
    } ;

  PresPartAP vp = {
    s = \\af => partVPPlus vp (PartPres Sg Indef Nom) (aformpos2agr af) Pos ;
    isPre = True
    } ;

  PastPartAP vp = {
    s = \\af => partVPPlus vp (PartPret af Nom) (aformpos2agr af) Pos ;
    isPre = True
    } ;

  PastPartAgentAP vp np = {
    s = \\af => "av" ++ np.s ! accusative ++ partVPPlus vp (PartPret af Nom) (aformpos2agr af) Pos ; ---- agent and other advs before; 
    isPre = True               ---- the right choice in attributive but not predicative position
    } ;


----  PastPartAP vp

  OrdCompar a = {
      s = case a.isComp of {
        True => "mera" ++ a.s ! AF (APosit (Weak Sg)) Nom ;
        _    => a.s ! AF ACompar Nom
        }  ; 
      isDet = True
      } ;

  PositAdVAdj a = {s = a.s ! AAdv} ;

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

  DirectComplVS t np vs utt = 
    mkS (lin Adv (optCommaSS utt)) (mkS t positivePol (mkCl np (lin V vs))) ;

  DirectComplVQ t np vs q = 
    mkS (lin Adv (optCommaSS (mkUtt q))) (mkS t positivePol (mkCl np (lin V vs))) ;

  FocusObjS np sslash = 
    mkS (lin Adv (ss (sslash.c2.s ++ np.s ! NPAcc))) <lin S sslash : S> ;


}
