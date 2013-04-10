--# -path=.:folketslexikon:alltenses
concrete ParseSwe of ParseEngAbs = 
  TenseSwe,
  NounSwe - [PPartNP],
  AdjectiveSwe,
  NumeralSwe,
  SymbolSwe [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionSwe,
  VerbSwe - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbSwe,
  PhraseSwe,
  SentenceSwe,
  QuestionSwe,
  RelativeSwe,
  IdiomSwe [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraSwe [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash],

  DictEngSwe ** 
open MorphoSwe, ResSwe, ParadigmsSwe, Prelude in {

flags
  literal=Symb ;
  beam_size=0.95 ;

lin
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

  CompoundCN num noun cn = {
      s = \\n,d,c => noun.s ! num.n ! Indef ! Nom ++ BIND ++ cn.s ! n ! d ! c ; 
      g = cn.g ;
      isMod = False
      } ;

  DashCN noun1 noun2 = {
    s = \\n,d,c => noun1.s ! Sg ! Indef ! Nom ++ BIND ++ noun2.s ! n ! d ! c ;
    g = noun2.g ;
    isMod = False ;
  } ;

{-
  GerundN v = {
    s = \\n,c => v.s ! VPresPart ;
    g = Neutr
  } ;
  
  GerundAP v = {
    s = \\agr => v.s ! VPresPart ;
    isPre = True
  } ;

  PastPartAP v = {
    s = \\agr => v.s ! VPPart ;
    isPre = True
  } ;

  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;

  PositAdVAdj a = {s = a.s ! AAdv} ;

  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;

  SlashV2V v ant p vp = insertObjc (\\a => v.c3 ++ ant.s ++ p.s ++
                                           infVP v.typ vp ant.a p.p a)
                                   (predVc v) ;

  SlashVPIV2V v p vpi = insertObjc (\\a => p.s ++ 
                                           v.c3 ++ 
                                           vpi.s ! VVAux ! a)
                                   (predVc v) ;
  ComplVV v a p vp = insertObj (\\agr => a.s ++ p.s ++ 
                                         infVP v.typ vp a.a p.p agr)
                               (predVV v) ;

  PredVPosv np vp = {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir => compl ++ "," ++ np.s ! npNom ++ verb.aux ++ vp.ad ++ verb.fin ++ verb.adv ++ verb.inf ;
          OQuest => verb.aux ++ compl ++ "," ++ np.s ! npNom ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf 
          }
    } ;
    
  PredVPovs np vp = {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir => compl ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ np.s ! npNom ;
          OQuest => verb.aux ++ compl ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ np.s ! npNom
          }
    } ;

  that_RP = {
    s = \\_ => "that" ;
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
    s = \\agr => vps.ad ++ vps.ptp ++ vps.s2 ! agr ;
    c = npNom
    } ;

  PresPartRS ant pol vp = {
    s = \\agr => vp.ad ++ vp.prp ++ vp.s2 ! agr ;
    c = npNom
  } ;
-}
  ApposNP np1 np2 = {
    s = \\c => np1.s ! c ++ "," ++ np2.s ! NPNom ;
    a = np1.a
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

lin
  UncNeg = {s = [] ; p = Neg} ;
    
}
