--# -path=.:../abstract:../../prelude

incomplete concrete RulesRomance of Rules = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

lin 
  UseN = noun2CommNounPhrase ;
  ModAdj = modCommNounPhrase ;
  ModGenOne = npGenDet singular ;
  ModGenNum = npGenDetNum ;
  UsePN = nameNounPhrase ;
  UseN2 = funAsCommNounPhrase ; -- [SyntaxFra.noun2CommNounPhrase]
  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseA1 = adj2adjPhrase ;
  ComplA2 = complAdj ;
  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase singular ;
  IndefNumNP = indefNounPhraseNum ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum ;
  MassNP = partitiveNounPhrase singular ;
  UseInt i = {s = \\_ => i.s} ;
  NoNum = noNum ;

  SymbPN i = {s = i.s ; g = Masc} ; --- cannot know gender
  SymbCN cn s =
    {s = \\n => cn.s ! n ++ s.s ; 
     g = cn.g} ;

  CNthatS = nounThatSentence ;

  PredVP = predVerbPhrase ;
  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredVG = predVerbGroupClause ;

  PredV  = predVerb ;
  PredAP = predAdjective ; 
  PredSuperl a = predAdjective (superlAdjDegr a) ; 
  PredCN = predCommNoun ;
  PredV2 = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredNP = predNounPhrase ;
  PredPP = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  PredPassV = predPassVerb ;
  VTrans = transAsVerb ;

  AdjAdv a = {s = a.s ! AA} ;
  AdvVP = adVerbPhrase ;
  AdvPP p = p ;
  PrepNP = prepNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  ThereNP = existNounPhrase ;

  PosSlashV2 = slashTransVerb True ;
  NegSlashV2 = slashTransVerb False ;
  OneVP = predVerbPhrase nounPhraseOn ;


  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelVP = relVerbPhrase ;
  RelSlash = relSlash ;
  ModRC = modRelClause ;
  RelSuch = relSuch ;

  WhoOne = intPronWho singular ;
  WhoMany = intPronWho plural ;
  WhatOne = intPronWhat singular ;
  WhatMany = intPronWhat plural ;
  FunIP = funIntPron ;
  NounIPOne = nounIntPron singular ;
  NounIPMany = nounIntPron plural ;

  QuestVP = questVerbPhrase ;
  IntVP = intVerbPhrase ;
  IntSlash = intSlash ;
  QuestAdv = questAdverbial ;
  IsThereNP = existNounPhraseQuest ;

  ImperVP = imperVerbPhrase ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  PrepS p = p ;
  AdvS = advSentence ;

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
  SubjQu = subjunctQuestion ;
  SubjVP = subjunctVerbPhrase ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;

  OnePhr p = p ;
  ConsPhr = cc2 ;
}
