--# -path=.:alltenses:../abstract:../english:../hindustani
concrete ParseHin of ParseEngAbs = 
  TenseX - [AdN,Adv,SC,PPos,PNeg],
--  TextX - [AdN,Adv,SC],
  CatHin,
  NounHin - [PPartNP],
  AdjectiveHin,
  NumeralHin,
  ConjunctionHin,
  VerbHin - [PassV2, UseCopula, ComplVV, VPSlashPrep],
  AdverbHin,
  PhraseHin,
  SentenceHin,
  RelativeHin,
  QuestionHin,
  SymbolHin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
--  StructuralHin,
  IdiomHin [NP, VP, Tense, Cl, ProgrVP, ExistNP],
  ExtraHin [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash,Temp,Pol,Conj,VPS,ListVPS,S,Num, CN,
  RP, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS, GenRP,VPI, VPIForm, VPIInf, VPIPresPart, ListVPI,
  VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV,ClSlash, RCl, EmptyRelSlash],
--  DictHinMath **
  DictHin ** 
open MorphoHin, ResHin, ParadigmsHin,CommonX, CommonHindustani, Prelude in {

flags
  literal=Symb ;
  coding=utf8 ;

lin
  myself_NP = {s = \\_ => kwd ; a  = Ag Masc Sg Pers1 };
  yourselfSg_NP = {s = \\_ => kwd ; a  = Ag Masc Sg Pers2_Respect }; --regNP "yourself" singular ;
  himself_NP = {s = \\_ => kwd ; a  = Ag Masc Sg Pers3_Distant }; --regNP "himself" singular ;
  herself_NP = {s = \\_ => kwd ; a  = Ag Fem Sg Pers3_Distant }; --regNP "herself" singular ;
  itself_NP = {s = \\_ => kwd ; a  = Ag Masc Sg Pers3_Near }; --regNP "itself" singular ;
  ourself_NP = {s = \\_ => kwd ; a  = Ag Masc Pl Pers1 }; --regNP "ourself" plural ;
  yourselfPl_NP = {s = \\_ => kwd ; a  = Ag Masc Pl Pers2_Respect }; --regNP "yourself" plural ;
  themselves_NP = {s = \\_ => kwd ; a  = Ag Masc Pl Pers3_Distant }; --regNP "themself" plural ;
  themself_NP = {s = \\_ => kwd ; a  = Ag Masc Sg Pers3_Distant }; --regNP "themself" plural ;

  CompoundCN num noun cn = {
    s = \\n,c => num.s  ++ cn.s ! n ! c ++ noun.s ! num.n ! Dir;
    g = cn.g
  } ;
  
  DashCN noun1 noun2 = {
    s = \\n,c => noun1.s ! n ! Dir ++ "-" ++ noun2.s ! n ! c ;
    g = noun2.g
  } ;

  GerundN v = {
    s = \\n,c => v.cvp ++ v.s ! Inf ; -- v.s ! VF Imperf Pers2_Casual n Masc ++ hwa (Ag Masc n Pers2_Casual) ; --the main verb of compound verbs
    g = Masc
  } ;
  
  GerundAP v = {
    s = \\n,g,_,_ => v.cvp ++ v.s ! VF Imperf Pers2_Casual n g ++ hwa (Ag g n Pers2_Casual) ;   
  } ;

  PastPartAP v = {
    s = \\n,g,_,_ => v.cvp ++ v.s ! VF Imperf Pers2_Casual n g ; -- the main verb of compound versb needs to be attached here
  } ;

  OrdCompar a = {s = a.s ! Sg ! Masc ! Dir ! Compar ; n = Sg } ;

  PositAdVAdj a = {s = a.s ! Sg ! Masc ! Dir ! Posit} ;
---------------
--SlashV2V v p vp = insertVV (infV2V v.isAux vp) (predV v) vp.embComp  ** {c2 = {s = sE ; c = VTrans}}; -- changed from VTransPost
ComplVV v a p vp = insertTrans (insertVV (infVV v.isAux vp) (predV v) vp.embComp ) VTrans; -- changed from VTransPost
---------------
  

  UseQuantPN q pn = {s = \\c => q.s ! Sg ! pn.g ! Dir ++ pn.s ! Dir ; a = agrP3 pn.g Sg} ;

PredVPosv np vp = mkClause np vp ; --{
{-      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir => compl ++ "," ++ np.s ! npNom ++ verb.aux ++ vp.ad ++ verb.fin ++ verb.adv ++ verb.inf ;
          OQuest => verb.aux ++ compl ++ "," ++ np.s ! npNom ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf 
          }
    } ;
-}    
  PredVPovs np vp = mkClause np vp ; --{
{-      s = \\t,a,b,o => 
        let 
          verb  = vp.s ! t ! a ! b ! o ! np.a ;
          compl = vp.s2 ! np.a
        in
        case o of {
          ODir => compl ++ verb.aux ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ np.s ! npNom ;
          OQuest => verb.aux ++ compl ++ verb.adv ++ vp.ad ++ verb.fin ++ verb.inf ++ np.s ! npNom
          }
    } ;
-}

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
CompVP ant p vp = {s = \\a => ant.s ++ p.s ++ 
                                infVP False vp a} ; -- check for vp.isAux

  that_RP = {
    s = \\_,_ => "कि" ;
    a = RNoAg
    } ;
  --no_RP = {
   -- s = \\_,_ => "" ;
   -- a = RNoAg
   -- } ;

  CompS s = {s = \\_ => "कि" ++ s.s} ;
--  CompVP vp = {s = \\a => infVP VVInf vp a} ;

lin
  PPos = {s = [] ; p = Pos} ;
  PNeg = {s = [] ; p = Neg} ; -- contracted: don't
  UncNeg = {s = [] ; p = Neg} ;
  
  VPSlashPrep vp p = vp ** {c2 = {s = p.s!Masc ; c = VTrans}} ;

  PastPartRS ant pol vps = {
    s = \\agr => (vps.s!VPTense VPPast agr).inf ;
    c = Dir
    } ;

  PresPartRS ant pol vp = {
    s = \\agr => (vp.s!VPTense VPPres agr).inf ;
    c = Dir
  } ;
  
  ApposNP np1 np2 = {
      s = \\c => np1.s!NPC Dir ++ "," ++ np2.s ! c ;
      a = np2.a
      } ;
      
  AdAdV = cc2 ;
  
  UttAdV adv = adv;
    
}
