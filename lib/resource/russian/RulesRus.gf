concrete RulesRus of Rules = CategoriesRus ** open Prelude, SyntaxRus in {

lin 

  UsePN = nameNounPhrase ;
  ComplAdj = complAdj ;
  PredVP = predVerbPhrase ;
  UseA1 = adj2adjPhrase ; 
  ModAdj = modCommNounPhrase ;
  UseN  = noun2CommNounPhrase ;
  ModGenOne = npGenDet Sg noNum ;
  ModGenNum = npGenDet Pl ;
  UseN2 = funAsCommNounPhrase ;
  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

 -- From RulesSwe.gf: ComplA2 = complAdj ;
 --  IntCN cn s =
 --   {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
 --    g = cn.g ;
 --    x = cn.x ;
 --    p = cn.p
 --    } ;

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

  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredV v = v ; -- From Swedish: PredV  = predVerb ;
  PredAP = predAdjective ;
  PredCN = predCommNoun ;
  PredV2 = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredPassV v = v ;
  PredNP = predNounPhrase ;
  PredAdV = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = verbOfTransVerb ;
--From Swedish:
  --PredVP = predVerbPhrase ;
  --PredVG = predVerbGroupClause ;
  --PredSuperl a = predAdjective (superlAdjPhrase a) ;


  AdjAdv a = mkAdverb (a.s ! AdvF) ;
  PrepNP p = prepPhrase p ;
  AdvVP = adVerbPhrase ;
  --LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;
  --From Swedish: AdvPP p = p ;


  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
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
  
  -- From Swedish: PrepS p = ss (p.s ++ ",") ;

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

} ;

