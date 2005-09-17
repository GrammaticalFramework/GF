--# -path=.:../abstract:../../prelude

incomplete concrete RulesScand of Rules = CategoriesScand ** 
  open Prelude, SyntaxScand in {

flags optimize=all ;

lin 
  UseN = noun2CommNounPhrase ;
  UsePN = nameNounPhrase ;


  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum plural ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum plural ;

  DetNP = detNounPhrase ;
  NDetNP = numDetNounPhrase ;
  NDetNum = justNumDetNounPhrase ; 
  MassNP = detNounPhrase (mkDeterminerSg (detSgInvar []) IndefP) ;

  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseN2 = funAsCommNounPhrase ;

  ModAP = modCommNounPhrase ;
  CNthatS = nounThatSentence ;

  ModGenOne = npGenDet singular noNum ;
  ModGenNum = npGenDet plural ;

  UseInt i = {s = \\_ => table {Nom => i.s ; Gen => i.s ++ "s"} ; n = Pl} ; ---
  NoNum = noNum ;

  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;
  ComplAV = complVerbAdj ;
  ComplObjA2V = complVerbAdj2 True ;

  PositADeg  = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlADeg = superlAdjPhrase ;

-- verbs and verb phrases mostly in $Clause$

  PredAS = predAdjSent ;
  PredV0 = predVerb0 ;

-- Partial saturation.

  UseV2 = transAsVerb ;
----  ComplV3 = complDitransVerb ;

  ComplA2S = predAdjSent2 ;

  AdjPart = adjPastPart ;

  UseV2V x = x ** {isAux = False} ;
  UseV2S x = x ;
  UseV2Q x = x ;
  UseA2S x = x ;
  UseA2V x = x ;

-- Formation of infinitival phrases.

  UseCl tp cl = {s = \\o => tp.s ++ cl.s ! tp.b ! ClFinite tp.t tp.a o} ;
  UseRCl tp cl = 
    {s = \\gn,p => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! gn ! p} ;
  UseQCl tp cl = {s = \\q => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! q} ;
  UseVCl po a cl = {
    s  = \\v,g,n,p => po.s ++ a.s ++ cl.s ! po.p ! a.a ! v ! g ! n ! p ; 
    } ;

  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = Present} ;
  TPast        = {s = [] ; t = Past} ;
  TFuture      = {s = [] ; t = Future} ;
  TConditional = {s = [] ; t = Condit} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

  PPos = {s = [] ; p = True} ;
  PNeg = {s = [] ; p = False} ;

-- Adverbs.

  AdjAdv a = advPost (a.s ! adverbForm ! Nom) ;
  AdvPP p = p ;
  PrepNP p = prepPhrase p.s ; ---

  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;
  AdvAdv = cc2 ;
  AdvNP np adv = <np : {g : Gender ; n : Number ; p : Person}> **
                 {s = \\f => np.s ! f ++ adv.s} ;

--3 Sentences and relative clauses
--

  SlashV2 = slashTransVerb ;
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

  IDetCN d n = detNounPhrase d n ;
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

  AdvCl = advClause ;
  AdvVPI = advVerbPhrase ;
  AdvPhr = advSentence ;
  AdCPhr = advSentence ;


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

  TwoAdv = twoAdverb ;
  ConsAdv = consAdverb ;
  ConjAdv = conjunctAdverb ;
  ConjDAdv = conjunctDistrAdverb ;

  SubjS = subjunctSentence ;
  SubjImper = subjunctImperative ;
  SubjQS = subjunctQuestion ;
  AdvSubj if A = {s = if.s ++ A.s ! Sub} ;

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

  OneNP = npMan ;

  ExistCN A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhrase singular A)) ;
  ExistNumCN nu A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhraseNum plural nu A)) ;


} ;
