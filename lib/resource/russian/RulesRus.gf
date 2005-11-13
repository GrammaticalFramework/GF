--# -path=.:../abstract:../../prelude
concrete RulesRus of Rules = CategoriesRus ** open Prelude, SyntaxRus in {

lin 

  UsePN = nameNounPhrase ;
  ComplA2 = complAdj ;
--  ComplAV    : AV  -> VPI -> AP ;         -- "eager to leave"
--  ComplObjA2V : A2V -> NP -> VPI -> AP ;   -- "easy for us to convince"
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
  --- SuperlNP = superlNounPhrase ;
--  SuperlADeg  : ADeg -> AP ;               -- "the oldest"


  CNthatS = nounThatSentence ;
  UseInt i = useInt i.s;
  NoNum = noNum ;


  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase Sg ;
  IndefNumNP = indefNounPhraseNum Pl ;
  DefOneNP = indefNounPhrase Sg ;
  DefNumNP = indefNounPhraseNum Pl ;
  MassNP = indefNounPhrase Sg;
--  NDetNP     : NDet -> Num -> CN -> NP ;  -- "these (5) cars"
--  NDetNum    : NDet -> Num ->       NP ;  -- "these (5)"

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


--  AdvPP   : PP -> Adv ;                 -- "in London", "after the war"
--  AdvAdv  : AdA -> Adv -> Adv ;         -- "very well"

  AdjAdv a = mkAdverb (a.s ! AdvF) ;
  PrepNP p = prepPhrase p ;
  AdvVPI = adVerbPhraseInf ;
  ---AdvVP    = adVerbPhrase ;
  ---LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;


--  SlashV2   : NP -> V2 -> Slash ;       -- "(whom) John doesn't love"
--  SlashVV2  : NP -> VV -> V2 -> Slash ; -- "(which song do you) want to play"
--  SlashAdv  : Cl -> Prep -> Slash ;     -- "(whom) John walks with"

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
--  RelCl     : Cl -> RCl ;               -- "such that it is even"


  WhoOne = intPronKto Sg ;
  WhoMany = intPronKto Pl ;
  WhatOne = intPronChto Sg ;
  WhatMany = intPronChto Pl ;
  FunIP = funIntPron ;
--  IDetCN : IDet -> CN -> IP ;               -- "which car", "which cars"

  NounIPOne = nounIntPron Sg ;
  NounIPMany = nounIntPron Pl ;

  QuestVP = questVerbPhrase ;
  ---IntVP = intVerbPhrase ;
  IntSlash = intSlash ;
-- QuestCl    : Cl -> QCl ;                  -- "does John walk"; "doesn't John walk"


  QuestAdv = questAdverbial ;


  ---ImperVP = imperVerbPhrase ;
--  PosImpVP, NegImpVP  : VCl -> Imp ;         -- "(don't) be a man"
  
  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance Masc Sg ;
  ImperMany = imperUtterance Masc Pl ;
  AdvCl = advClause ;
--  AdCPhr  : AdC -> S -> Phr ;                -- "Therefore, 2 is prime."
--  AdvPhr  : Adv -> S -> Phr ;                -- "In India, there are tigers."

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

--  ConjAdv   : Conj -> ListAdv -> Adv ;        -- "quickly or slowly"
--  ConjDAdv  : ConjD -> ListAdv -> Adv ;       -- "both badly and slowly"
--  TwoAdv   : Adv -> Adv -> ListAdv ;
--  ConsAdv  : ListAdv -> Adv -> ListAdv ;


  SubjS = subjunctSentence ;
  SubjImper = subjunctImperative ;
  SubjQu = subjunctQuestion ;
--  SubjQS    : Subj -> S -> QS -> QS ;      -- "if you are new, who are you?"
  SubjVP = subjunctVerbPhrase ;

-- This rule makes a subordinate clause into a sentence adverb, which
-- can be attached to e.g. noun phrases. It might even replace the
-- previous subjunction rules.

--  AdvSubj    : Subj -> S -> Adv ;           -- "when he arrives"

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase Sg ;
  PhrManyCN = useCommonNounPhrase Pl ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;
  OnePhr p = p ;
  ConsPhr = cc2 ;  
  
--  PhrVPI   : VPI -> Phr ;                   -- "Tända ljus."

--2 Special constructs.
--
-- These constructs tend to have language-specific syntactic realizations.

---  IsThereNP = isThere ;
--  ExistCN = existCN ;   
--  ExistNumCN = existNumCN ;

  OneNP  = npOne ;  

--New in the "lib"-version from Swedish:

  AdvPP p = p ;
  PredSuperl a = predAdjective (superlAdjPhrase a) ;
  PrepS p = ss (p.s ++ ",") ;
  PredVG = predVerbGroupClause ;  

} ;

