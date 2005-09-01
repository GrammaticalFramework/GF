--# -path=.:../abstract:../../prelude

--1 The Top-Level English Resource Grammar: Combination Rules
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the English concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Eng.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part are the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $resource.Abs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $TypesEng.gf$.

concrete RulesEng of Rules = CategoriesEng ** open Prelude, SyntaxEng in {

flags 
  optimize=all ;

lin 
  UseN  = noun2CommNounPhrase ;
  UsePN = nameNounPhrase ;

  SymbPN i = {s = table {Nom => i.s ; Gen => i.s ++ "'s"} ; g = Neutr} ; ---
  SymbCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g} ;
  IntCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g} ;

  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum plural ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum plural ;

  DetNP = detNounPhrase ;
  NDetNP = numDetNounPhrase ;
  NDetNum = justNumDetNounPhrase ; 
  MassNP = detNounPhrase (mkDeterminer Sg []) ;

  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseN2 = funAsCommNounPhrase ;

  ModAP = modCommNounPhrase ;
  CNthatS = nounThatSentence ;

  ModGenOne = npGenDet singular noNum ;
  ModGenNum = npGenDet plural ;

  UseInt i = {s = table {Nom => i.s ; Gen => i.s ++ "s"} ; n = Pl} ; ---
  NoNum = noNum ;

  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;

  ComplAV v x = complVerbAdj v x ;
  ComplObjA2V v x y = complVerbAdj2 True v x y ;

  PositADeg  = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlADeg = superlAdjPhrase ;

-- verbs and verb prases

  PredAS = predAdjSent ;
  PredV0 rain = predVerbClause (pronNounPhrase pronIt) rain (complVerb rain) ;

-- Partial saturation.

  UseV2 = transAsVerb ;

  ComplA2S = predAdjSent2 ;

  AdjPart = adjPastPart ;

  UseV2V x = verb2aux x ** {isAux = False} ;
  UseV2S x = x ;
  UseV2Q x = x ;
  UseA2S x = x ;
  UseA2V x = x ;

  UseCl  tp cl = {s = tp.s ++ cl.s ! Dir ! tp.b ! VFinite tp.t tp.a} ;
  UseQCl tp cl = {s = \\q => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! q} ;
  UseRCl tp cl = {s = \\a => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! a} ;
  UseVCl p a cl = {
    s  = \\v,ag => p.s ++ a.s ++ cl.s ! p.p ! a.a ! v ! ag ; 
    s1 = cl.s1 ! p.p
    } ;

  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = Present} ;
  TPast        = {s = [] ; t = Past} ;
  TFuture      = {s = [] ; t = Future} ;
  TConditional = {s = [] ; t = Conditional} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

  PPos = {s = [] ; p = True} ;
  PNeg = {s = [] ; p = False} ;

-- Adverbs.

  AdjAdv a = ss (a.s ! AAdv) ;
  AdvPP p = p ;
  PrepNP p = prepPhrase p.s ; ---
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;
  AdvAdv = cc2 ;
  AdvNP pn pp = {s = \\c => pn.s ! c ++ pp.s ; a = pn.a} ;

--3 Sentences and relative clauses
--

  SlashV2 = slashTransVerbCl ;
  SlashVV2 = slashVerbVerb ;
  SlashAdv cl p = slashAdverb cl p.s ;

  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelSlash = relSlash ;
  ModRS = modRelClause ;
  RelCl = relSuch ;


--!
--3 Questions and imperatives
--

  IDetCN d n = nounPhraseInt (detNounPhrase d n) ;
  FunIP = funIntPron ;

  QuestCl = questClause ;
  IntSlash = intSlash ;
  QuestAdv = questAdverbial ;

  PosImpVP = imperVerbPhrase True ;
  NegImpVP = imperVerbPhrase False ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne  = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  AdvCl  = advClause ;
  AdvVPI = advVerbPhrase ;

  AdCPhr = advSentence ;
  AdvPhr = advSentence ;


--!
--3 Coordination
--

  TwoS = twoSentence ;
  ConsS = consSentence ;
  ConjS = conjunctSentence ;
  ConjDS = conjunctDistrSentence ;

  TwoAP = twoAdjPhrase ;
  ConsAP = consAdjPhrase ;
  ConjAP = conjunctAdjPhrase ;
  ConjDAP = conjunctDistrAdjPhrase ;

  TwoNP = twoNounPhrase ;
  ConsNP = consNounPhrase ;
  ConjNP = conjunctNounPhrase ;
  ConjDNP = conjunctDistrNounPhrase ;

  TwoAdv = twoSentence ;
  ConsAdv = consSentence ;
  ConjAdv = conjunctSentence ;
  ConjDAdv = conjunctDistrSentence ;

  SubjS = subjunctSentence ;
  SubjImper = subjunctImperative ;
  SubjQS = subjunctQuestion ;
  AdvSubj if A = ss (if.s ++ A.s) ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = ip ;
  PhrIAdv ia = ia ;
  PhrVPI = verbUtterance ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

-----------------------
-- special constructions

  OneNP = nameNounPhrase (nameReg "one" human) ;

  ExistCN A = predBeGroup
                (nameNounPhrase (nameReg "there" Neutr))
                (complNounPhrase (indefNounPhrase singular A)) ;
  ExistNumCN nu A = 
              predBeGroup 
                (nameNounPhrasePl (nameReg "there" Neutr))
                (complNounPhrase (indefNounPhraseNum plural nu A)) ;

} ;
