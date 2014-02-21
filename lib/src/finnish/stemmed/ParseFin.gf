--# -path=.:..:../../abstract:../../common:../../api:../../english:../kotus:../../translator

concrete ParseFin of ParseEngAbs = 
  TenseX,  ---- TODO add potential forms 
  CatFin,
  NounFin - [PPartNP,
    UsePron, PossPron  -- replaced by variants with prodrop
    ],
  AdjectiveFin,
  NumeralFin,
  SymbolFin [PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP],
  ConjunctionFin,
  VerbFin - [SlashV2V, PassV2, UseCopula, ComplVV,
             VPSlashPrep],  -- with empty prepositions, a cyclic rule that leads to overgeneration
  AdverbFin,
  PhraseFin,
  SentenceFin,
  QuestionFin,
  RelativeFin,
  IdiomFin [NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP],
  ConstructionFin,
  DocumentationFin,  
  ExtraFin [NP, Quant, VPSlash, VP, Tense, GenNP, PassVPSlash, Voc, RP, GenRP, PassVPSlash, PassAgentVPSlash,
      Temp, Tense, Pol, Conj, VPS, ListVPS, S, MkVPS, BaseVPS, ConsVPS, ConjVPS, PredVPS,
      VPI, VPIForm, VPIInf, VPIPresPart, ListVPI, VV, MkVPI, BaseVPI, ConsVPI, ConjVPI, ComplVPIVV]
 , DictionaryFin
** 
open MorphoFin, ResFin, ParadigmsFin, SyntaxFin, StemFin, (E = ExtraFin), (G = GrammarFin), Prelude in {

flags literal=Symb ; coding = utf8 ;

-- the overrides -----
lin

 UsePron p = G.UsePron (E.ProDrop p) | G.UsePron p ;
 PossPron p = E.ProDropPoss p | G.PossPron p ;

----------------------

lin
   {- ComplVV v ant pol vp = 
      insertObj 
        (\\_,b,a => infVPGen pol.p v.sc b a vp v.vi) 
        (predSV {s = v.s ; 
                sc = case vp.s.sc of {
                  NPCase Nom => v.sc ;   -- minun täytyy pestä auto
                  c => c                 -- minulla täytyy olla auto
                  } ;
                h = v.h ; p = v.p
               }
         ) ;
-}

  ---- what is this...
  myself_NP = mkPronounGen False "itse" "itsen" "itseä" "itsenä" "itseen" Sg P1  ** {isPron = True ; isNeg = False} ;
  yourselfSg_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Sg P2** {isPron = True ; isNeg = False} ;
  himself_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3** {isPron = True ; isNeg = False} ;
  herself_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3** {isPron = True ; isNeg = False} ;
  itself_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Sg P3** {isPron = True ; isNeg = False} ;
  ourself_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Pl P1** {isPron = True ; isNeg = False} ;
  yourselfPl_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Pl P2** {isPron = True ; isNeg = False} ;
  themself_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Pl P3** {isPron = True ; isNeg = False} ;
  themselves_NP = mkPronounGen False  "itse" "itsen" "itseä" "itsenä" "itseen" Pl P3** {isPron = True ; isNeg = False} ;


  CompoundCN num noun cn = {
    s = \\nf => num.s ! Sg ! Nom ++ noun.s ! 10 ++ BIND ++ cn.s ! nf ;
    h = cn.h
    } ;


lin
  DashCN noun1 noun2 = {
    s = \\nf => noun1.s ! 10 ++ BIND ++ noun2.s ! nf ;
    h = noun2.h
    } ;

  PastPartAP v = {s = \\_,nf => (sverb2verbSep v).s ! PastPartPass (AN nf)} ;

  PredVPosv np vp = mkCl np vp ; ----

  -- Ant -> Pol -> VPSlash -> RS ; --- here replaced by a relative clause 
  PastPartRS ant pol vps = mkRS ant pol (mkRCl which_RP (E.PassVPSlash (lin VPSlash vps))) ;

  ApposNP np1 np2 = {
      s = \\c => np1.s ! c ++ "," ++ np2.s ! c ;
      a = np1.a ;
      isPron = np1.isPron ; isNeg = np1.isNeg
      } ;

  GerundN v = mkN (lin V v) ;
  
  GerundAP v = {s = \\_ => (snoun2nounSep (sverb2nounPresPartAct v)).s} ;

  OrdCompar a = snoun2nounSep {s = \\nc => a.s ! Compar ! SAN nc ; h = a.h} ; 

  PositAdVAdj a = {s = a.s ! Posit ! SAAdv} ;  -- A -> AdV really

  UseQuantPN quant pn = {
      s = \\c => let k = (npform2case Sg c) in
                 quant.s1 ! Sg ! k ++ snoun2np Sg pn ! c ++ quant.s2 ! pn.h ; 
      a = agrP3 Sg ;
      isPron = False ; 
      isNeg = quant.isNeg
      } ;

{-  SlashV2V v ant p vp = 
      insertObj (\\_,b,a => infVP v.sc b a vp v.vi) (predSV v) ** {c2 = v.c2} ; ----
      ---- insertObj (\\_,b,a => infVPGen p.p v.sc b a vp v.vi) (predSV v) ** {c2 = v.c2} ;
-}
  CompS s = {s = \\_ => "että" ++ s.s} ;  -- S -> Comp            ---- what are these expected to do ? 29/3/2013
  CompVP ant pol vp = {s = \\a => infVPGen pol.p vp.s.sc Pos a vp Inf1} ; -- VP -> Comp


  that_RP = which_RP ;
  no_RP = which_RP ;

  UttAdV a = a ;

  UncNeg = negativePol ;

  PresPartRS ant pol vp = mkRS ant pol (mkRCl which_RP vp) ;  ---- present participle attr "teräviä ottava"

     PredVPosv np vp = mkCl np vp ; ---- OSV yes, but not for Cl
     PredVPovs np vp = mkCl np vp ; ---- SVO

    EmptyRelSlash cls = mkRCl which_RP cls ;

  CompQS qs = {s = \\_ => qs.s} ;


  AdAdV ada adv = {s = ada.s ++ adv.s} ;

   SlashVPIV2V v pol vpi = -- : V2V -> Pol -> VPI -> VPSlash ;
      insertObj (\\_,b,a => vpi.s ! v.vi) (predSV v) ** {c2 = v.c2} ;

 {-  VPSlashVS v vp = -- : VS -> VP -> VPSlash ; -- hän sanoo (minun) menevän (!) ---- menneen ?
      insertObj (\\_,b,a => infVP v.sc b a vp InfPresPart) (predSV v) ** 
                   {c2 = {c = NPCase Gen ; s = \\_ => [] ; h = Back ; isPre = True}} ;
   -}  
--   SlashSlashV2V v ant pol vps = -- : V2V -> Ant -> Pol -> VPSlash -> VPSlash ; --- not implemented in Eng so far
--      insertObj (\\_,b,a => infVPGen pol.p v.sc b a vps v.vi) (predSV v) ** {c2 = v.c2} ; --- or vps.c2 ??

--in Verb,   SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash

}

