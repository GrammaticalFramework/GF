--# -path=alltenses
concrete ParseSpa of ParseEngAbs = 
  TenseSpa,
--  CatSpa,
  NounSpa - [PPartNP],
  AdjectiveSpa,
  NumeralSpa,
  SymbolSpa [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionSpa,
  VerbSpa - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbSpa,
  PhraseSpa,
  SentenceSpa,
  QuestionSpa,
  RelativeSpa,
  IdiomSpa [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraSpa [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, Num, CN, RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,
            ClSlash, RCl, EmptyRelSlash],

  DictEngSpa ** 
open MorphoSpa, ResSpa, ParadigmsSpa, SyntaxSpa, Prelude in {

flags
  literal=Symb ;
  beam_size=0.95 ;
  coding = utf8 ;


lin
-- missing from ExtraSpa; should not really be there either

  GenNP np = 
    let denp = (np.s ! ResSpa.genitive).ton in {
      s = \\_,_,_,_ => [] ; 
      sp = \\_,_,_ => denp ;
      s2 = denp ; 
      isNeg = False ;
    } ;

  EmptyRelSlash slash = mkRCl which_RP (lin ClSlash slash) ;

  that_RP = which_RP ;

  UncNeg = negativePol ;

-- lexical entries

  another_Quant = mkQuantifier "otro" "otra" "otros" "otras" ;
  some_Quant = mkQuantifier "algún" "alguna" "algunos" "algunas" ;
  anySg_Det = mkDeterminer "algún" "alguna" Sg False ; ---- also meaning "whichever" ? 
  each_Det = SyntaxSpa.every_Det ;

  but_Subj = {s = "pero" ; m = Indic} ; ---- strange to have this as Subj

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
    s = \\n => cn.s ! n ++ "de" ++ noun.s ! num.n ;
    g = cn.g
  } ;

{-  
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
-}

  PastPartAP v = {
    s = table {
      AF g n => v.s ! VPart g n ;
      _ => v.s ! VPart Masc Sg  ---- the adverb form
      } ;
    isPre = True
  } ;

{-
  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;
-}

  PositAdVAdj a = {s = a.s ! Posit ! AA} ;

{-
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
-}

---- TODO: find proper expressions for OSV and OVS in Spa
  PredVPosv np vp = mkCl (lin NP np) (lin VP vp) ;
  PredVPovs np vp = mkCl (lin NP np) (lin VP vp) ;


  CompS s = {s = \\_ => "de" ++ "que" ++ s.s ! Indic} ; ---- de ?

{-
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

  ApposNP np1 np2 = {
    s = \\c => np1.s ! c ++ "," ++ np2.s ! npNom ;
    a = np1.a
  } ;
  
  AdAdV = cc2 ;
  
  UttAdV adv = adv;

-}    

}
