--# -path=.:../abstract:../../prelude
concrete RulesRus of Rules = CategoriesRus ** open Prelude, SyntaxRus in {

lin 

  UsePN = nameNounPhrase ;
  ComplA2 = complAdj ;
  PredVP = predVerbPhrase ;
  UseA = adj2adjPhrase ; 
  ModAP = modCommNounPhrase ;
  UseN  = noun2CommNounPhrase ;
  ModGenOne = npGenDet Sg noNum ;
  ModGenNum = npGenDet Pl ;
  UseN2 = funAsCommNounPhrase ;
  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  CNthatS = nounThatSentence ;
  UseInt i = useInt i.s;
  NoNum = noNum ;

  --- these two by AR 3/6/2004
  SymbPN i = {s = \\_ => i.s ; g = Neut ; anim = Inanimate} ; ---
  SymbCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g ;
     anim = cn.anim
    } ;


  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase Sg ;
  IndefNumNP = indefNounPhraseNum Pl ;
  DefOneNP = indefNounPhrase Sg ;
  DefNumNP = indefNounPhraseNum Pl ;
  MassNP = indefNounPhrase Sg;

  PosVG  = predVerbGroup True Present ;
  NegVG  = predVerbGroup False Present ;

  PredV  = predVerb ;
  PredAP = predAdjective ;
  PredCN = predCommNoun ;
  PredV2 = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredPassV = predPassVerb ;
  PredNP = predNounPhrase ;
  PredPP = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = verbOfTransVerb ;

  AdjAdv a = mkAdverb (a.s ! AdvF) ;
  PrepNP p = prepPhrase p ;
  AdvVP = adVerbPhrase ;
  --LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashV2 = slashTransVerb True ;
  NegSlashV2 = slashTransVerb False ;
  OneVP = predVerbPhrase (pron2NounPhrase pronKtoTo Animate) ;
  ThereNP = thereIs ;

  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelVP = relVerbPhrase ;
  RelSlash = relSlash ;
  ModRC = modRelClause ;
  RelSuch = relSuch ;

  WhoOne = intPronKto Sg ;
  WhoMany = intPronKto Pl ;
  WhatOne = intPronChto Sg ;
  WhatMany = intPronChto Pl ;
  FunIP = funIntPron ;
  NounIPOne = nounIntPron Sg ;
  NounIPMany = nounIntPron Pl ;

  QuestVP = questVerbPhrase ;
  IntVP = intVerbPhrase ;
  IntSlash = intSlash ;
  QuestAdv = questAdverbial ;
  IsThereNP = isThere ;

  ImperVP = imperVerbPhrase ;
  
  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance Masc Sg ;
  ImperMany = imperUtterance Masc Pl ;
  AdvS = advSentence ;

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
  SubjQu = subjunctQuestion ;
  SubjVP = subjunctVerbPhrase ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase Sg ;
  PhrManyCN = useCommonNounPhrase Pl ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;
  OnePhr p = p ;
  ConsPhr = cc2 ;  

--New in the "lib"-version from Swedish:

  AdvPP p = p ;
  PredSuperl a = predAdjective (superlAdjPhrase a) ;
  PrepS p = ss (p.s ++ ",") ;
  IntCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g ;
     anim = cn.anim
     } ;
  PredVG = predVerbGroupClause ;  

} ;

