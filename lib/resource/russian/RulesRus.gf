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

---  PosVG  = predVerbGroup True Present ;
---  NegVG  = predVerbGroup False Present ;
---  PredVP = predVerbPhrase ;
---  PredV  = predVerb ;
---  PredAP = predAdjective ;
---  PredCN = predCommNoun ;
---  PredV2 = complTransVerb ;
---  PredV3 = complDitransVerb ;
---  PredPassV = predPassVerb ;
---  PredNP = predNounPhrase ;
---  PredPP = predAdverb ;
---  PredVS = complSentVerb ;
---  PredVV = complVerbVerb ;
---  VTrans = verbOfTransVerb ;

-- The main uses of verbs and verb phrases have been moved to the
-- module $Verbphrase$ (deep $VP$ nesting) and its alternative,
-- $Clause$ (shallow many-place predication structure).

--  PredAS     : AS -> S  -> Cl ;          -- "it is good that he comes"                
--  PredV0     : V0 -> Cl ;                -- "it is raining"

-- Partial saturation.

--  UseV2     : V2 -> V ;                 -- "loves"

--  ComplA2S   : A2S -> NP  -> AS ;        -- "good for John"

--  UseV2V  : V2V -> VV ;
--  UseV2S  : V2S -> VS ;
--  UseV2Q  : V2Q -> VQ ;
--  UseA2S  : A2S -> AS ;
--  UseA2V  : A2V -> AV ;


-- Formation of tensed phrases.

--  AdjPart : V -> A ;                       -- past participle, e.g. "forgotten"
          
--  UseCl   : TP -> Cl  -> S ;
--  UseRCl  : TP -> RCl -> RS ;
--  UseQCl  : TP -> QCl -> QS ;

--  UseVCl  : Pol -> Ant -> VCl -> VPI ;

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
  AdvAP = advAdjPhrase ;

  AdvCl = advClause ;
  AdCPhr = advSentencePhr ;
  AdvPhr = advSentencePhr ;

---AdvVP    = adVerbPhrase ;
---LocNP = locativeNounPhrase ;


  IdRP = identRelPron ;
  FunRP = funRelPron ;

  RelCl = relCl;
  RelSlash = relSlash ;

---  ModRC = modRelClause ;
---  RelSuch = relSuch ;
---  RelVP = relVerbPhrase ;
---  PosSlashV2 = slashTransVerb True ;
---  NegSlashV2 = slashTransVerb False ;
---  OneVP = predVerbPhrase (pron2NounPhrase pronKtoTo Animate) ;
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

  FunIP = funIntPron ;
  QuestAdv = questAdverbial ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance Masc Sg ;
  ImperMany = imperUtterance Masc Pl ;

--  IDetCN : IDet -> CN -> IP ;               -- "which car", "which cars"

--  SlashV2   : NP -> V2 -> Slash ;       -- "(whom) John doesn't love"
--  SlashVV2  : NP -> VV -> V2 -> Slash ; -- "(which song do you) want to play"
--  SlashAdv  : Cl -> Prep -> Slash ;     -- "(whom) John walks with"

--  IntSlash = intSlash ;
--  QuestCl    : Cl -> QCl ;                  -- "does John walk"; "doesn't John walk"

--  PosImpVP, NegImpVP  : VCl -> Imp ;         -- "(don't) be a man"
  

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

---  SubjS = subjunctSentence ;
---  SubjImper = subjunctImperative ;
---  SubjQu = subjunctQuestion ;
---  SubjVP = subjunctVerbPhrase ;

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
--  ExistCN = existCN ;   
--  ExistNumCN = existNumCN ;

  OneNP  = npOne ;  

} ;

