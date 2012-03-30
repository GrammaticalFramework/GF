--# -path=alltenses
concrete ParseHun of ParseHunAbs = 
  TenseX - [Pol, PNeg, PPos],
  CatHun,
  NounHun,
  AdjectiveHun,
  NumeralHun,
  SymbolHun,
  ConjunctionHun,
  VerbHun - [SlashV2V, PassV2],
  AdverbHun,
  PhraseHun,
  SentenceHun,
  RelativeHun,
  IdiomHun [VP, Tense, ProgrVP],
  ExtraHun [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash],
  DictHun ** 
open MorphoHun, ResHun, ParadigmsHun, Prelude in 
{
--{
--
--flags
--  literal=Symb ;
--
--lin
--  myself_NP = regNP "myself" singular ;
--  yourselfSg_NP = regNP "yourself" singular ;
--  himself_NP = regNP "himself" singular ;
--  herself_NP = regNP "herself" singular ;
--  itself_NP = regNP "itself" singular ;
--  ourself_NP = regNP "ourself" plural ;
--  yourselfPl_NP = regNP "yourself" plural ;
--  themself_NP = regNP "themself" plural ;
--
--  CompoundCN num noun cn = {
--    s = \\n,c => num.s ! Nom ++ noun.s ! num.n ! Nom ++ cn.s ! n ! c ;
--    g = cn.g
--  } ;
--  
--  DashCN noun1 noun2 = {
--    s = \\n,c => noun1.s ! Sg ! Nom ++ "-" ++ noun2.s ! n ! c ;
--    g = noun2.g
--  } ;
--
--  GerundN v = {
--    s = \\n,c => v.s ! VPresPart ;
--    g = Neutr
--  } ;
--  
--  GerundAP v = {
--    s = \\agr => v.s ! VPresPart ;
--    isPre = True
--  } ;
--
--  PastPartAP v = {
--    s = \\agr => v.s ! VPPart ;
--    isPre = True
--  } ;
--
--  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;
--
--  PositAdVAdj a = {s = a.s ! AAdv} ;
--
--  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;
--
--  SlashV2V v p vp = insertObjc (\\a => p.s ++ case p.p of {CPos => ""; _ => "not"} ++ 
--                                       v.c3 ++ 
--                                       infVP v.typ vp a)
--                               (predVc v) ;
--
--  ComplPredVP np vp = {
--      s = \\t,a,b,o => 
--        let 
--          verb  = vp.s ! t ! a ! b ! o ! np.a ;
--          compl = vp.s2 ! np.a
--        in
--        case o of {
--          ODir => compl ++ "," ++ np.s ! npNom ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ;
--          OQuest => verb.aux ++ compl ++ "," ++ np.s ! npNom ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf 
--          }
--    } ;
--
--  that_RP = {
--    s = \\_ => "that" ;
--    a = RNoAg
--    } ;
--  no_RP = {
--    s = \\_ => "" ;
--    a = RNoAg
--    } ;
--
--  CompS s = {s = \\_ => "that" ++ s.s} ;
--  CompVP vp = {s = \\a => infVP VVInf vp a} ;
--
--lin
--  PPos = {s = [] ; p = CPos} ;
--  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't
--    
--}

}
