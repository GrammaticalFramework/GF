--# -path=alltenses
concrete ParseEng of ParseEngAbs = 
  TenseX - [Pol, PNeg, PPos],
  CatEng,
  NounEng - [PPartNP],
  AdjectiveEng,
  NumeralEng,
  SymbolEng [PN, Symb, MkSymb, SymbPN],
  ConjunctionEng,
  VerbEng - [SlashV2V, PassV2, UseCopula],
  AdverbEng,
  PhraseEng,
  SentenceEng,
  QuestionEng,
  RelativeEng,
  IdiomEng [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraEng [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV],

  DictEng ** 
open MorphoEng, ResEng, ParadigmsEng, Prelude in {

flags
  literal=Symb ;

lin
  myself_NP = regNP "myself" singular ;
  yourselfSg_NP = regNP "yourself" singular ;
  himself_NP = regNP "himself" singular ;
  herself_NP = regNP "herself" singular ;
  itself_NP = regNP "itself" singular ;
  ourself_NP = regNP "ourself" plural ;
  yourselfPl_NP = regNP "yourself" plural ;
  themself_NP = regNP "themself" plural ;
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

  SlashVPIV2V v p vpi = insertObjc (\\a => p.s ++ 
                                           v.c3 ++ 
                                           vpi.s ! VVAux ! a)
                                   (predVc v) ;

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
  no_RP = {
    s = \\_ => "" ;
    a = RNoAg
    } ;

  CompS s = {s = \\_ => "that" ++ s.s} ;
  CompVP ant p vp = {s = \\a => ant.s ++ p.s ++ 
                                infVP VVInf vp ant.a p.p a} ;

  PassVS vs vp = 
    let
      vps = insertObj (\\a => infVP VVInf vp Simul CPos a) (predV vs) ;
      be  = predAux auxBe ;
      ppt = vps.ptp
    in {
    s = be.s ;
    prp = be.prp ;
    ptp = be.ptp ;
    inf = be.inf ;
    ad = vps.ad ;
    s2 = \\a => ppt ++ vps.s2 ! a
    } ;

  PPartNP np vps = {
    s = let
          be = predAux auxBe ;
          ppt = vps.ptp
        in \\c => np.s ! c ++ vps.ad ++ vps.ptp ++ vps.s2 ! np.a ;
    a = np.a
  } ;

{-  GerundRS rp vp = {
    s = \\t,ant,b,ag => 
        let 
          agr = case rp.a of {
            RNoAg => ag ;
            RAg a => a
            } ;
          cl = mkClause (rp.s ! RC (fromAgr agr).g npNom) agr vp
        in
        cl.s ! t ! ant ! b ! ODir ;
      c = npNom
  } ;
-}

lin
  PPos = {s = [] ; p = CPos} ;
  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't
  UncNeg = {s = [] ; p = CNeg False} ;
    
}
