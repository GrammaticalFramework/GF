--# -path=.:../abstract:../../prelude

--1 The Top-Level Russian Resource Grammar
--
-- Janna Khegai 2003
-- on the basis of code for other languages by Aarne Ranta
--
-- This is the Russian concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.RusU.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part is the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $resource.Abs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $types.RusU.gf$.

concrete CombinationsRus of Combinations = open Prelude, SyntaxRus in {
flags  
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 

  N      = CommNoun ; 
      -- = {s : SubstForm => Str ; g : Gender ; anim : Animacy } ;
  CN     = CommNounPhrase ; 
      -- = {s : Number => Case => Str; g : Gender; anim : Animacy} ;  
  NP     = NounPhrase ;
      -- = { s : PronForm => Str ; n : Number ; p : Person ;
      --     g: PronGen ; anim : Animacy ;  pron: Bool} ;     
  PN     = ProperName ;
      -- = {s :  Case => Str ; g : Gender ; anim : Animacy} ;
  Adj1   = Adjective ;
      -- = {s : AdjForm => Str} ;
  Det    = Determiner ;
      -- = Adjective ** {n: Number; g: PronGen; c: Case} ; 
  Adj2   = AdjCompl ;
      -- = Adjective ** Complement ;
  AdjDeg = AdjDegr ;
      -- = {s : Degree => AdjForm => Str} ;
  AP     = AdjPhrase ; 
      -- = Adjective ** {p : IsPostfixAdj} ; 
  Fun    = Function ;  
      -- = CommNounPhrase ** Complement ;
  Fun2   = Function ** {s3 : Str; c2: Case} ; 
  Num    = Numeral ;
      -- = {s : Case => Gender => Str} ;
  
  V      = Verb ; 
      -- = {s : VF => Str ; t: Tense ; a : Aspect ; w: Voice} ;
  VG     = VerbGroup ;
      -- = Verb ;
  VP     = VerbPhrase ; 
      -- = Verb ** {s2 : Str ; s3 : Gender => Number => Str ;
      --            negBefore: Bool} ;
  TV     = TransVerb ; 
      -- = Verb ** {s2 : Str ; c: Case } ; 
  V3     = DitransVerb ;
      -- = TransVerb ** {s4 : Str; c2: Case} ;
  VS     = SentenceVerb ;
      -- = Verb ;
  VV     = VerbVerb ; 
      -- = Verb ;
  AdV    = Adverb ;
      -- = {s : Str} ;
  Prep   = Preposition;
      -- = {s : Str ; c: Case } ;
 
  S      = Sentence ; 
      -- = {s : Str} ;
  Slash  = SentenceSlashNounPhrase ; 
      -- = Sentence ** Complement ;
  
  RP     = RelPron ;
      -- = {s : GenNum => Case => Animacy => Str} ;
  RC     = RelClause ;
      -- = RelPron ;

  IP     = IntPron ;
      -- = NounPhrase ;
  Qu     = Question ;
      -- = {s : QuestForm => Str} ;
  Imp    = Imperative ;
      -- = { s: Gender => Number => Str } ;
  Phr    = Utterance ;
      -- = {s : Str} ;
  Text   = {s : Str} ;

  Conj   = Conjunction ;
      -- = {s : Str ; n : Number} ;
  ConjD  = ConjunctionDistr ;
      -- = {s1,s2 : Str ; n : Number} ;

  ListS  = ListSentence ;
      -- = {s1,s2 : Mode => Str} ;
  ListAP = ListAdjPhrase ;
      -- = {s1,s2 : AdjForm => Str ; p : Bool} ;
  ListNP = ListNounPhrase ;
      -- = { s1,s2 : PronForm => Str ; g: Gender ; anim : Animacy ;
      --     n : Number ; p : Person ;  pron : Bool } ;

--.
lin 
  UsePN = nameNounPhrase ;
  ComplAdj = complAdj ;
  PredVP = predVerbPhrase ;
  --PosTV = complTransVerb True ;
  --NegTV = complTransVerb False ;
  AdjP1 = adj2adjPhrase ; 
  ModAdj = modCommNounPhrase ;
  --PosA = predAdjective True ;
  --NegA = predAdjective False ;

  UseN  = noun2CommNounPhrase ;
  ModGenOne = npGenDet Sg noNum ;
  ModGenMany = npGenDet Pl ;
  UseFun = funAsCommNounPhrase ;
  AppFun = appFunComm ;
  AppFun2 = appFun2 ;
  PositAdjP = positAdjPhrase ;
  ComparAdjP = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  CNthatS = nounThatSentence ;
  UseInt i = useInt i.s;
  NoNum = noNum ;


  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase Sg ;
  IndefManyNP = indefNounPhraseNum Pl ;
  DefOneNP = indefNounPhrase Sg ;
  DefManyNP = indefNounPhraseNum Pl ;
  MassNP = indefNounPhrase Sg;

  --PosV = predVerb True ;
  --NegV = predVerb False ;
  --PosCN = predCommNoun True ;
  --NegCN = predCommNoun False ;
  --PosNP = predNounPhrase True ;
  --NegNP = predNounPhrase False ;
  --PosVS = complSentVerb True ;
  --NegVS = complSentVerb False ;

  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredV v = v ;
  PredAP = predAdjective ;
  PredCN = predCommNoun ;
  PredTV = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredPassV v = v ;
  PredNP = predNounPhrase ;
  PredAdV = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = verbOfTransVerb ;


  AdjAdv a = mkAdverb (a.s ! AdvF) ;
  PrepNP p = prepPhrase p ;
  AdvVP = adVerbPhrase ;
  --LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

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
