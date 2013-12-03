--# -path=alltenses
concrete ParseEng of ParseEngAbs = 
  TenseX - [Pol, PNeg, PPos],
  CatEng,
  NounEng - [PPartNP],
  AdjectiveEng,
  NumeralEng,
  SymbolEng [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionEng,
  VerbEng - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbEng,
  PhraseEng,
  SentenceEng - [UseCl], -- replaced by UseCl | ContractedUseCl
  QuestionEng,
  RelativeEng,
  IdiomEng [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ExtraEng [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ComplSlashPartLast,
            ClSlash, RCl, EmptyRelSlash, VS, V2S, ComplBareVS, SlashBareV2S],

  DictEng ** 
open MorphoEng, ResEng, ParadigmsEng, (S = SentenceEng), (E = ExtraEng), Prelude in {

flags
  literal=Symb ;

-- exceptional linearizations
lin
  UseCl t p cl = S.UseCl t p cl | E.ContractedUseCl t p cl ;

lin
  myself_NP = regNP "myself" singular ;
  yourselfSg_NP = regNP "yourself" singular ;
  himself_NP = regNP "himself" singular ;
  herself_NP = regNP "herself" singular ;
  itself_NP = regNP "itself" singular ;
  ourselves_NP = regNP "ourselves" plural ;
  yourselfPl_NP = regNP "yourself" plural ;
  themselves_NP = regNP "themselves" plural ;

  CompoundCN num noun cn = {
    s = \\n,c => num.s ! Nom ++ noun.s ! num.n ! Nom ++ cn.s ! n ! c ;
    g = cn.g
  } ;
  
  DashCN noun1 noun2 = {
    s = \\n,c => noun1.s ! Sg ! Nom ++ "-" ++ noun2.s ! n ! c ;
    g = noun2.g
  } ;

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

  PredVPosv np vp = {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir _ => compl ++ frontComma ++ np.s ! npNom ++ verb.aux ++ vp.ad ! np.a ++ verb.fin ++ verb.adv ++ verb.inf ;
          OQuest => verb.aux ++ compl ++ frontComma ++ np.s ! npNom ++ verb.adv ++ vp.ad ! np.a ++ verb.fin ++ verb.inf 
          }
    } ;
    
  PredVPovs np vp = {
      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir _ => compl ++ frontComma ++ verb.aux ++ verb.adv ++ vp.ad ! np.a ++ verb.fin ++ verb.inf ++ np.s ! npNom ;
          OQuest => verb.aux ++ compl ++ verb.adv ++ vp.ad ! np.a ++ verb.fin ++ verb.inf ++ np.s ! npNom
          }
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
    s = \\agr => vps.ad ! agr ++ vps.ptp ++ vps.s2 ! agr ;
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

lin
  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} | {s = [] ; p = CNeg False} ;

lincat
    Feat = Str;
lin FeatN, FeatN2 = \n -> 
      case n.g of {
        Neutr => "";
        Masc  => "(masc)";
        Fem   => "(fem)"
      };
    FeatV = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ;
    FeatV2 = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++ v.c2 ++
      "<object>";
    FeatV3 = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      v.c2 ++ "<arg1>" ++
      v.c3 ++ "<arg2>";
    FeatV2V = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      v.c2 ++ "<object>" ++
      v.c3 ++ case v.typ of {
                VVAux => "<verb>" ;
                VVInf => "to" ++ "<verb>" ;
                VVPresPart => "<verb+ing>"
              };
    FeatV2S = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      v.c2 ++ "<object>" ++
      "that" ++ "<sentence>";
    FeatV2Q = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      v.c2 ++ "<object>" ++
      "that" ++ "<question>";
    FeatV2A = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      v.c2 ++ "<object>" ++
      "<adjective>";
    FeatVV = \v ->
      "<subject>" ++
      v.s ! VVF VInf ++ v.p ++
      case v.typ of {
        VVAux => "<verb>" ;
        VVInf => "to" ++ "<verb>" ;
        VVPresPart => "<verb+ing>"
      };
    FeatVS = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      "that" ++ "<sentence>";
    FeatVQ = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      "<question>";
    FeatVA = \v ->
      "<subject>" ++
      v.s ! VInf ++ v.p ++
      "<adjective>";
}
