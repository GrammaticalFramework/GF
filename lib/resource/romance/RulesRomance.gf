--# -path=.:../abstract:../../prelude

incomplete concrete RulesRomance of Rules = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

lin 
  UseN = noun2CommNounPhrase ;
  UsePN = nameNounPhrase ;

  SymbPN i = {s = i.s ; g = Masc} ; --- cannot know gender
  SymbCN cn s =
    {s = \\n => cn.s ! n ++ s.s ; 
     g = cn.g} ;
  IntCN cn i =
    {s = \\n => cn.s ! n ++ i.s ; 
     g = cn.g} ;

  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum ;

  DetNP = detNounPhrase ;
  MassNP = partitiveNounPhrase singular ;

  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseN2 = funAsCommNounPhrase ; -- [SyntaxFra.noun2CommNounPhrase]

  ModAP = modCommNounPhrase ;
  CNthatS = nounThatSentence ;

  ModGenOne = npGenDet singular ;
  ModGenNum = npGenDetNum ;

  UseInt i = {s = \\_ => i.s} ;
  NoNum = noNum ;

  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;

  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  UseV2 = transAsVerb ;

-- Formation of infinitival phrases.

  UseCl tp cl = {s = \\o => tp.s ++ cl.s ! tp.b ! ClFinite tp.t tp.a o} ;
{- ----
  UseRCl tp cl = 
    {s = \\gn,p => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! gn ! p} ;
  UseQCl tp cl = {s = \\q => tp.s ++ cl.s ! tp.b ! VFinite tp.t tp.a ! q} ;
-}

  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = Present} ;
  TPast        = {s = [] ; t = Past} ;
  TFuture      = {s = [] ; t = Future} ;
  TConditional = {s = [] ; t = Condit} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

-- Adverbs.

  AdjAdv a = {s = a.s ! AA} ;
----  AdvVP = adVerbPhrase ;
  AdvPP p = p ;

  PrepNP = prepNounPhrase ;

  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;
  AdvAdv = cc2 ;

{-
--3 Sentences and relative clauses
--

  SlashV2 = slashTransVerb ;
  SlashVV2 = slashVerbVerb ;
  SlashAdv cl p = slashAdverb cl p.s ;

  --PosSlashV2 = slashTransVerb True ;
  --NegSlashV2 = slashTransVerb False ;
-}

  IdRP = identRelPron ;
  FunRP = funRelPron ;
----  RelSlash = relSlash ;
----  ModRS = modRelClause ;
----  RelCl = relSuch ;

--!
--3 Questions and imperatives
--

----  IDetCN d n = detNounPhrase d n ;
  FunIP = funIntPron ;

----  QuestCl = questClause ;
----  IntSlash = intSlash ;
----  QuestAdv = questAdverbial ;

----  PosImpVP = imperVerbPhrase True ;
----  NegImpVP = imperVerbPhrase False ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

-----  PrepS p = p ;
-----  AdvS = advSentence ;

  TwoS = twoSentence ;
  ConsS = consSentence ;
  ConjS = conjunctSentence ;
  ConjDS = conjunctDistrSentence ; -- [Coordination.conjunctDistrTable]

  TwoAP = twoAdjPhrase ;
  ConsAP = consAdjPhrase ;
  ConjAP = conjunctAdjPhrase ;
  ConjDAP = conjunctDistrAdjPhrase ;

  TwoNP = twoNounPhrase ;
  ConsNP = consNounPhrase ;
  ConjNP = conjunctNounPhrase ;
  ConjDNP = conjunctDistrNounPhrase ;

  SubjS = subjunctSentence ;       -- stack
  SubjImper = subjunctImperative ; 
  SubjQS = subjunctQuestion ;
 ----- SubjVP = subjunctVerbPhrase ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

-----------------------
-- special constructions

  OneNP = nounPhraseOn ;


{- ----
  ExistCN A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhrase singular A)) ;
  ExistNumCN nu A = predVerbGroupClause npDet 
                (complTransVerb (mkDirectVerb (deponentVerb verbFinnas)) 
                   (indefNounPhraseNum plural nu A)) ;
-}

}
