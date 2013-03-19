--# -path=.:..:../../abstract:../../common:../../english:../kotus

concrete ParseFin of ParseEngAbs = 
  TenseX, ---- - [Pol, PNeg, PPos],
  CatFin,
  NounFin - [PPartNP],
  AdjectiveFin,
  NumeralFin,
  SymbolFin [PN, Symb, MkSymb, SymbPN],
  ConjunctionFin,
  VerbFin - [SlashV2V, PassV2, UseCopula, ComplVV],
  AdverbFin,
  PhraseFin,
  SentenceFin,
  RelativeFin,
  IdiomFin [NP, VP, Tense, Cl, ProgrVP, ExistNP]
  , ExtraFin [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash, Voc,
      Temp, Tense, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
      VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV]
 , DictEngFin 
** 
open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, StemFin, Prelude in {

flags literal=Symb ; coding = utf8 ;

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
    s = \\nf => num.s ! Sg ! Nom ++ noun.s ! 0 ++ BIND ++ cn.s ! nf ;
    h = cn.h
    } ;

  PassVPSlash = passVPSlash ;

oper  
  passVPSlash : VPSlash -> VP = \vp -> lin VP {
      s = \\_ => vp.s ! VIPass ;
      s2 = vp.s2 ;
      adv = vp.adv ;
      ext = vp.ext ;
      qp = vp.qp ;
      isNeg = vp.isNeg ;
      sc = vp.c2.c
      } ; 

lin
  DashCN noun1 noun2 = {
    s = \\nf => noun1.s ! 0 ++ BIND ++ noun2.s ! nf ;
    h = noun2.h
    } ;

  PastPartAP v = {s = \\_,nf => (sverb2verbSep v).s ! PastPartPass (AN nf)} ;

  PredVPosv np vp = mkCl np vp ; ----

  -- Ant -> Pol -> VPSlash -> RS ; --- here replaced by a relative clause 
  PastPartRS ant pol vps = mkRS ant pol (mkRCl which_RP (passVPSlash (lin VPSlash vps))) ;

  ApposNP np1 np2 = {
      s = \\c => np1.s ! c ++ "," ++ np2.s ! c ;
      a = np1.a ;
      isPron = np1.isPron ; isNeg = np1.isNeg
      } ;


{-
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

  that_RP = which_RP ;
  no_RP = which_RP ;


}
