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

concrete ResRus of ResAbs = open Prelude, Syntax in {
flags 
 coding=utf8 ;
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
      --     g: Gender ; anim : Animacy ;  pron: Bool} ;     
  PN     = ProperName ;
      -- = {s :  Case => Str ; g : Gender ; anim : Animacy} ;
  Adj1   = Adjective ;
      -- = {s : AdjForm => Str} ;
  Det    = Determiner ;
      -- = Adjective ** { n: Number; c : Case } ;
  Adj2   = AdjCompl ;
      -- = Adjective ** Complement ;
  AdjDeg = AdjDegr ;
      -- = {s : Degree => AdjForm => Str} ;
  AP     = AdjPhrase ; 
      -- = Adjective ** {p : IsPostfixAdj} ; 
  Fun    = Function ;  
      -- = CommNounPhrase ** Complement ;

  V      = Verb ; 
      -- = {s : VF => Str ; t: Tense ; a : Aspect ; v: Voice} ;
  VP     = VerbPhrase ; 
      -- = Verb ** {s2 : Str ; s3 : Gender => Number => Str ;
      --            negBefore: Bool} ;
  TV     = TransVerb ; 
      -- = Verb ** {s2 : Preposition ; c: Case } ; 
  VS     = SentenceVerb ;
      -- = Verb ;
  AdV    = Adverb ;
      -- = {s : Str} ;

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
  PosTV = complTransVerb True ;
  NegTV = complTransVerb False ;
  AdjP1 = adj2adjPhrase ; 
  ModAdj = modCommNounPhrase ;
  PosA = predAdjective True ;
  NegA = predAdjective False ;

  UseN  = noun2CommNounPhrase ;
  ModGenOne = npGenDet Sg ;
  ModGenMany = npGenDet Pl ;
  UseFun = funAsCommNounPhrase ;
  AppFun = appFunComm ;
  PositAdjP = positAdjPhrase ;
  ComparAdjP = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase Sg ;
  IndefManyNP = indefNounPhrase Pl ;
  DefOneNP = defNounPhrase Sg ;
  DefManyNP = defNounPhrase Pl ;

  PosV = predVerb True ;
  NegV = predVerb False ;
  PosCN = predCommNoun True ;
  NegCN = predCommNoun False ;
  PosNP = predNounPhrase True ;
  NegNP = predNounPhrase False ;
  PosVS = complSentVerb True ;
  NegVS = complSentVerb False ;

  AdvVP = adVerbPhrase ;
  LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;

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

  ImperVP = imperVerbPhrase ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance Masc Sg ;
  ImperMany = imperUtterance Masc Pl ;

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

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase Sg ;
  PhrManyCN = useCommonNounPhrase Pl ;
  PhrIP ip = postfixSS "?" ip ;
  PhrIAdv ia = postfixSS "?" ia ;


  INP    = pron2NounPhrase pronYa Animate;
  ThouNP = pron2NounPhrase pronTu Animate;
  HeNP   = pron2NounPhrase pronOn Animate;
  SheNP  = pron2NounPhrase pronOna Animate;
  WeNP   = pron2NounPhrase pronMu Animate;
  YeNP   = pron2NounPhrase pronVu Animate;
  YouNP  = pron2NounPhrase pronVu Animate;
  TheyNP = pron2NounPhrase pronOni Animate;

  EveryDet = kazhdujDet ** {n = Sg ; c= Nom} ; 
  AllDet   = vseDetPl ** {n = Pl;  c= Nom} ; 
  WhichDet = kotorujDet ** {n = Sg; c= Nom} ;  -- a singular version only 
  MostDet  = bolshinstvoDet ** {n = Pl; c= Gen} ;

  HowIAdv = ss "как" ;
  WhenIAdv = ss "когда" ;
  WhereIAdv = ss "где" ;
  WhyIAdv = ss "почему" ;

  AndConj  = ss "и"  ** {n = Pl} ;
  OrConj   = ss "или"  ** {n = Sg} ;
  BothAnd  = sd2 "как" [", так"]  ** {n = Pl} ;
  EitherOr = sd2 "либо" [", либо"]  ** {n = Sg} ;

-- In case of "neither..  no" expression double negation is not 
-- only possible, but also required in Russian.
-- There is no means of control for this however in the resource grammar.

  NeitherNor = sd2 "ни" [", ни"]  ** {n = Sg} ;

  IfSubj   = ss "если" ;
  WhenSubj = ss "когда" ;

  PhrYes = ss ["да ."] ;
  PhrNo = ss ["нет ."] ;

} ;
