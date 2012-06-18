--# -path=alltenses:../abstract
concrete ParseUrd of ParseAbs = 
  TenseX - [AdN,Adv,SC],
  TextX - [AdN,Adv,SC],
  CatUrd,
  NounUrd,
  AdjectiveUrd,
  NumeralUrd,
  SymbolUrd,
  ConjunctionUrd,
  VerbUrd - [SlashV2V, PassV2],
  AdverbUrd,
  PhraseUrd,
  SentenceUrd,
  RelativeUrd,
--  StructuralUrd,
  IdiomUrd [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraUrd [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash],
  DictUrd **
--  UNDictUrd ** 
open MorphoUrd, ResUrd, ParadigmsUrd, ParamX, CommonHindustani, Prelude in {

flags
  literal=Symb ;

lin
{-  myself_NP = regNP "myself" singular ;
  yourselfSg_NP = regNP "yourself" singular ;
  himself_NP = regNP "himself" singular ;
  herself_NP = regNP "herself" singular ;
  itself_NP = regNP "itself" singular ;
  ourself_NP = regNP "ourself" plural ;
  yourselfPl_NP = regNP "yourself" plural ;
  themself_NP = regNP "themself" plural ;
-}
  CompoundCN num noun cn = {
    s = \\n,c => num.s ++ noun.s ! num.n ! Dir ++ cn.s ! n ! c ;
    g = cn.g
  } ;
  
  DashCN noun1 noun2 = {
    s = \\n,c => noun1.s ! n ! Dir ++ "-" ++ noun2.s ! n ! c ;
    g = noun2.g
  } ;

  GerundN v = {
    s = \\n,c => v.cvp ++ v.s ! Inf ; --the main verb of compound verbs
    g = Masc
  } ;
  
  GerundAP v = {
    s = \\_,_,_,_ => v.cvp ++ v.s ! Inf  --the main verb of compound verbs
  } ;

  PastPartAP v = {
    s = \\_,_,_,_ => v.cvp ++ v.s ! Inf -- the main verb of compound versb needs to be attached here
  } ;

--  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;

  PositAdVAdj a = {s = a.s ! Sg ! Masc ! Dir ! Posit} ;
---------------
SlashV2V v p vp = insertVV (infV2V v.isAux vp) (predV v) vp.embComp  ** {c2 = {s = sE ; c = VTrans}}; -- changed from VTransPost
---------------
  

--  UseQuantPN q pn = {s = \\c => q.s ! Sg ! Masc ! Dir ++ pn.s ! c ; a = agrP3 Sg pn.g} ;
{-
  SlashV2V v p vp = insertObjc (\\a => p.s ++ case p.p of {CPos => ""; _ => "not"} ++ 
                                       v.c3 ++ 
                                       infVP v.typ vp a)
                               (predVc v) ;

  ComplPredVP np vp = {
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
  that_RP = {
    s = \\_,_ => "kh" ;
    a = RNoAg
    } ;
  no_RP = {
    s = \\_,_ => "" ;
    a = RNoAg
    } ;

  CompS s = {s = \\_ => "kh" ++ s.s} ;
--  CompVP vp = {s = \\a => infVP VVInf vp a} ;

--lin
--  PPos = {s = [] ; p = CPos} ;
--  PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't
    
}
