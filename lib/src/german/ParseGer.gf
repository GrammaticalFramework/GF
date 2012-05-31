--# -path=alltenses:.:../english
concrete ParseGer of ParseEngAbs = 
--  TenseX  - [Tense,Temp],
  TenseGer,
  NounGer,
  AdjectiveGer,
  NumeralGer,
  SymbolGer [PN, Symb, MkSymb, SymbPN],
  ConjunctionGer,
  VerbGer - [SlashV2V, PassV2, UseCopula],
  AdverbGer,
  PhraseGer,
  SentenceGer,
  RelativeGer,
--  LexiconGer,
--  StructuralGer,
  IdiomGer [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraGer [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,
            Temp, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
            VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV]
 , DictEngGer 
** 
open MorphoGer, ResGer, ParadigmsGer, SyntaxGer, Prelude in {

flags literal=Symb ; coding = utf8 ;

{-
lin
  myself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Sg P1) ;
  yourselfSg_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Sg P2) ;
  himself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3) ;
  herself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3) ;
  itself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3) ;
  ourself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Pl P1) ;
  yourselfPl_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Pl P2) ;
  themself_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Pl P3) ;
  themselves_NP = mkNP (mkPronoun "itse" "itsen" "itseä" "itsenä" "itseen" Pl P3) ;


  CompoundCN num noun cn = {
    s = \\n,c => num.s ! Nom ++ noun.s ! num.n ! Nom ++ cn.s ! n ! c ;
    g = cn.g
  } ;

  
  DashCN noun1 noun2 = { -- type-checking
    s = \\n,c => noun1.s ! Sg ! Nom ++ "-" ++ noun2.s ! n ! c ;
    g = noun2.g
  } ;

  GerundN v = { -- parsing
    s = \\n,c => v.s ! VPresPart ;
    g = Neutr
  } ;
  
  GerundAP v = {  -- beckoning
    s = \\agr => v.s ! VPresPart ;
    isPre = True
  } ;

  PastPartAP v = {   -- broken
    s = \\agr => v.s ! VPPart ;
    isPre = True
  } ;

  OrdCompar a = {s = \\c => a.s ! AAdj Compar c } ;  -- higher

  PositAdVAdj a = {s = a.s ! AAdv} ;  -- really

  UseQuantPN q pn = {s = \\c => q.s ! False ! Sg ++ pn.s ! npcase2case c ; a = agrgP3 Sg pn.g} ;  -- this London

  SlashV2V v p vp = insertObjc (\\a => p.s ++ case p.p of {CPos => ""; _ => "not"} ++  -- force not to sleep
                                       v.c3 ++ 
                                       infVP v.typ vp a)
                               (predVc v) ;

  ComplPredVP np vp = { -- ?
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

  CompS s = {s = \\_ => "that" ++ s.s} ;  -- S -> Comp
  CompVP vp = {s = \\a => infVP VVInf vp a} ; -- VP -> Comp
-}
lin
  that_RP = which_RP ;
  no_RP = which_RP ;


}
