--# -path=.:../abstract:../../prelude

incomplete concrete RulesScand of Rules = CategoriesScand ** 
  open Prelude, SyntaxScand in {

lin 
  UseN = noun2CommNounPhrase ;
  UsePN = nameNounPhrase ;

  SymbPN i = {s = \\_ => i.s ; g = NNeutr} ;
  SymbCN cn s =
    {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
     g = cn.g ;
     p = cn.p
     } ;
  IntCN cn s =
    {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
     g = cn.g ;
     p = cn.p
     } ;

  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum plural ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum plural ;

  DetNP = detNounPhrase ;
  MassNP = detNounPhrase (mkDeterminerSg (detSgInvar []) IndefP) ;

  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseN2 = funAsCommNounPhrase ;

  ModAP = modCommNounPhrase ;
  CNthatS = nounThatSentence ;

  ModGenOne = npGenDet singular noNum ;
  ModGenNum = npGenDet plural ;

  UseInt i = {s = table {Nom => i.s ; Gen => i.s ++ "s"}} ; ---
  NoNum = noNum ;

  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;

  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

-- verbs and verb phrases

  PredAS = predAdjSent ;
  PredV0 = predVerb0 ;

-- Partial saturation.

  UseV2 = transAsVerb ;
  ComplV3 = complDitransVerb ;

  ComplA2S = predAdjSent2 ;

  TransVV2 = transVerbVerb ;
  AdjPart = adjPastPart ;

  UseV2V x = x ;
  UseV2S x = x ;
  UseV2Q x = x ;
  UseA2S x = x ;
  UseA2V x = x ;

-- Formation of infinitival phrases.

  UseCl tp cl = {s = \\o => tp.s ++ cl.s ! tp.b ! ClFinite tp.t tp.a o} ;
  UseRCl tp cl = 
    {s = \\gn,p => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! gn ! p} ;
  UseQCl tp cl = {s = \\q => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! q} ;
 
  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = Present} ;
  TPast        = {s = [] ; t = Past} ;
  TFuture      = {s = [] ; t = Future} ;
  TConditional = {s = [] ; t = Condit} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

-- Adverbs.

  AdjAdv a = advPost (a.s ! adverbForm ! Nom) ;
  AdvPP p = p ;
  PrepNP p = prepPhrase p.s ; ---

  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

--3 Sentences and relative clauses
--

  SlashV2 = slashTransVerb ;
  OneVP = predVerbGroupClause npMan ;

  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelSlash = relSlash ;
  ModRS = modRelClause ;
  RelCl = relSuch ;


--!
--3 Questions and imperatives
--

  WhoOne = intPronWho singular ;
  WhoMany = intPronWho plural ;
  WhatOne = intPronWhat singular ;
  WhatMany = intPronWhat plural ;
  FunIP = funIntPron ;
  NounIPOne = nounIntPron singular ;
  NounIPMany = nounIntPron plural ;

  QuestCl = questClause ;
  IntSlash = intSlash ;
  QuestAdv = questAdverbial ;

  PosImpVP = imperVerbPhrase True ;
  NegImpVP = imperVerbPhrase False ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne  = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  AdvCl = advClause ;
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

  SubjS = subjunctSentence ;
  SubjImper = subjunctImperative ;
  SubjQS = subjunctQuestion ;

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

  OneVP = predVerbGroupClause npMan ;

  ExistCN A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhrase singular A)) ;
  ExistNumCN nu A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhraseNum plural nu A)) ;


} ;
