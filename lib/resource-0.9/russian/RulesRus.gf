--# -path=.:../abstract:../../prelude
concrete RulesRus of Rules = CategoriesRus ** open Prelude, SyntaxRus in {

lin 

  UsePN = nameNounPhrase ;
  ComplA2 = complAdj ;
  ComplAV = complVerbAdj ; 
  ComplObjA2V = complObjA2V ; 
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
  SuperlADeg = superlAdjPhrase ; 


  CNthatS = nounThatSentence ;
  UseInt i = useInt i.s;
  NoNum = noNum ;


  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase Sg ;
  IndefNumNP = indefNounPhraseNum Pl ;
  DefOneNP = indefNounPhrase Sg ;
  DefNumNP = indefNounPhraseNum Pl ;
  MassNP = indefNounPhrase Sg;
  NDetNP = nDetNP ;
  NDetNum = nDetNum ;


-- The main uses of verbs and verb phrases have been moved to the
-- module $Verbphrase$ (deep $VP$ nesting) and its alternative,
-- $Clause$ (shallow many-place predication structure).

  PredAS = predAS ;       
  PredV0 = predV0 ;

-- Partial saturation.

  ComplA2S  = complA2S ;

---  VTrans = verbOfTransVerb ;
  UseV2  = verbOfTransVerb ;
  UseV2V = verbOfTransVerb ;
  UseV2S = verbOfTransVerb ; 
  UseV2Q = verbOfTransVerb ;
  UseA2S = useA2S ;
  UseA2V = useA2V;


-- Formation of tensed phrases.

  AdjPart = adjPart ;
          
  UseCl = useCl ;
  UseRCl = useRCl ;
  UseQCl  = useQCl ;
  UseVCl = useVCl ;

  -- s field is superficial:
  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;

  TPresent     = {s = [] ; t = ClPresent} ;
  TPast        = {s = [] ; t = ClPast} ;
  TFuture      = {s = [] ; t = ClFuture} ;
  TConditional = {s = [] ; t = ClConditional} ;

  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

  PPos = {s = [] ; p = True} ;
  PNeg = {s = [] ; p = False} ;


  AdvPP x = x ;
  AdvAdv  = advAdv ;   

  AdjAdv a = mkAdverb (a.s ! AdvF) ;
  PrepNP p = prepPhrase p ;
  AdvVPI = adVerbPhraseInf ;
  AdvCN = advCommNounPhrase ;
  AdvNP = advNP ; 
  AdvAP = advAdjPhrase ;

  AdvCl = advClause ;
  AdCPhr = advSentencePhr ;
  AdvPhr = advSentencePhr ;


  IdRP = identRelPron ;
  FunRP = funRelPron ;

  RelCl = relCl;
  RelSlash = relSlash ;

  ModRS  = modRS ;    


  FunIP = funIntPron ;
  QuestAdv = questAdverbial ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance Masc Sg ;
  ImperMany = imperUtterance Masc Pl ;

  IDetCN = iDetCN;

  SlashV2  = slashV2 ;
  SlashVV2  = slashVV2 ;
  SlashAdv = slashAdv ; 

  IntSlash = intSlash ;
  QuestCl  = questCl ; 

  PosImpVP = posImpVP ;
  NegImpVP = negImpVP ;  

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

  ConjAdv = conjAdverb ; 
  ConjDAdv  = conjDAdverb ;
  TwoAdv = twoAdverb ;
  ConsAdv = consAdverb ;


  SubjQS  = subjQS ;

-- This rule makes a subordinate clause into a sentence adverb, which
-- can be attached to e.g. noun phrases. It might even replace the
-- previous subjunction rules.

  AdvSubj = advSubj ;

  SubjS = subjunctSentence ;
  SubjImper = subjunctImperative ;


  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase Sg ;
  PhrManyCN = useCommonNounPhrase Pl ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;
  OnePhr p = p ;
  ConsPhr = cc2 ;  
  PhrVPI  =  phrVPI ;

--2 Special constructs.
--
-- These constructs tend to have language-specific syntactic realizations.

---  IsThereNP = isThere ;
  ExistCN = existCN ;   
  ExistNumCN = existNumCN ;

  OneNP  = npOne ;  

---  ThereNP = thereIs ;

---  WhoOne = intPronKto Sg ;
---  WhoMany = intPronKto Pl ;
---  WhatOne = intPronChto Sg ;
---  WhatMany = intPronChto Pl ;
---  NounIPOne = nounIntPron Sg ;
---  NounIPMany = nounIntPron Pl ;
---  SuperlNP = superlNounPhrase ;
---  QuestVP = questVerbPhrase ;
---  IntVP = intVerbPhrase ;
---  ImperVP = imperVerbPhrase ;

---  SubjQu = subjunctQuestion ;

---  ModRC = modRelClause ;
---  RelSuch = relSuch ;
---  PosSlashV2 = slashTransVerb True ;
---  NegSlashV2 = slashTransVerb False ;


} ;

