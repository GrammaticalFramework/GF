--1 The Top-Level German Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the German concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Deu.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part are the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $resource.Abs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $Types.gf$.

concrete ResDeu of ResAbs = open Prelude, Syntax in {

flags 
  startcat=Phr ; 
  parser=chart ;

lincat 
  CN     = CommNounPhrase ; 
      -- = {s : Adjf => Number => Case => Str ; g : Gender} ;
  N      = CommNoun ;
      -- = {s : Number => Case => Str ; g : Gender} ; 
  NP     = NounPhrase ;
      -- = {s : NPForm => Str ; n : Number ; p : Person ; pro : Bool} ;
  PN     = ProperName ;
      -- = {s : Case => Str} ;
  Det    = {s : Gender => Case => Str ; n : Number ; a : Adjf} ;
  Fun    = Function ;
      -- = CommNounPhrase ** {s2 : Preposition ; c : Case} ;
  Fun2   = Function ** {s3 : Preposition ; c2 : Case} ;

  Adj1   = Adjective ;
      -- = {s : AForm => Str} ;
  Adj2   = Adjective ** {s2 : Preposition ; c : Case} ;
  AdjDeg = {s : Degree => AForm => Str} ;
  AP     = Adjective ** {p : Bool} ;

  V      = Verb ; 
      -- = {s : VForm => Str ; s2 : Particle} ;
  VP     = Verb ** {s3 : Number => Str ; s4 : Str} ;
  TV     = TransVerb ; 
      -- = Verb ** {s3 : Preposition ; c : Case} ;
  V3     = TransVerb ** {s4 : Preposition ; c2 : Case} ;
  VS     = Verb ;
  AdV    = {s : Str} ;

  S      = Sentence ;
      -- = {s : Order => Str} ; 
  Slash  = Sentence ** {s2 : Preposition ; c : Case} ;

  RP     = {s : GenNum => Case => Str} ;
  RC     = {s : GenNum => Str} ;

  IP     = ProperName ** {n : Number} ;
  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;
  Text   = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1,s2 : Str ; n : Number} ;

  ListS  = {s1,s2 : Order => Str} ; 
  ListAP = {s1,s2 : AForm => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; n : Number ; p : Person ; pro : Bool} ;

--.

lin 
  UseN = noun2CommNounPhrase ;
  ModAdj = modCommNounPhrase ;
  ModGenOne = npGenDet singular ;
  ModGenMany = npGenDet plural ;
  UsePN = nameNounPhrase ;
  UseFun = funAsCommNounPhrase ;
  AppFun = appFunComm ;
  AppFun2 = appFun2 ;
  AdjP1 = adj2adjPhrase ;
  ComplAdj = complAdj ;
  PositAdjP = positAdjPhrase ;
  ComparAdjP = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase singular ;
  IndefManyNP = indefNounPhrase plural ;
  DefOneNP = defNounPhrase singular ;
  DefManyNP = defNounPhrase plural ;

  CNthatS = nounThatSentence ;

  PredVP = predVerbPhrase ;
  PosV = predVerb True ;
  NegV = predVerb False ;
  PosA = predAdjective True ;
  NegA = predAdjective False ;
  PosCN = predCommNoun True ;
  NegCN = predCommNoun False ;
  PosTV = complTransVerb True ;
  NegTV = complTransVerb False ;
  PosPassV = passVerb True ;
  NegPassV = passVerb False ;
  PosNP = predNounPhrase True ;
  NegNP = predNounPhrase False ;
  PosVS = complSentVerb True ;
  NegVS = complSentVerb False ;
  PosV3 = complDitransVerb True ;
  NegV3 = complDitransVerb False ;
  VTrans = transAsVerb ;

  AdvVP = adVerbPhrase ;
  LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = predVerbPhrase (nameNounPhrase {s = \\_ => "man"}) ;

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

  ImperVP = imperVerbPhrase ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  AdvS = advSentence ;

lin
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
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = ip ;
  PhrIAdv ia = ia ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

  INP    = pronNounPhrase pronIch ;
  ThouNP = pronNounPhrase pronDu ;
  HeNP   = pronNounPhrase pronEr ;
  SheNP  = pronNounPhrase pronSie ; 
  ItNP   = pronNounPhrase pronEs ; 
  WeNP   = pronNounPhrase pronWir ;
  YeNP   = pronNounPhrase pronIhr ;
  TheyNP = pronNounPhrase pronSiePl ;

  YouNP  = pronNounPhrase pronSSie ;

  EveryDet = jederDet ; 
  AllDet   = alleDet ; 
  WhichDet = welcherDet ;
  MostDet  = meistDet ;

  HowIAdv   = ss "wie" ;
  WhenIAdv  = ss "wann" ;
  WhereIAdv = ss "war" ;
  WhyIAdv   = ss "warum" ;

  AndConj  = ss "und" ** {n = Pl} ;
  OrConj   = ss "oder" ** {n = Sg} ;
  BothAnd  = sd2 "sowohl" ["als auch"] ** {n = Pl} ;
  EitherOr = sd2 "entweder" "oder" ** {n = Sg} ;
  NeitherNor = sd2 "weder" "noch" ** {n = Sg} ;
  IfSubj   = ss "wenn" ;
  WhenSubj = ss "wenn" ;

  PhrYes = ss ["Ja ."] ;
  PhrNo = ss ["Nein ."] ;

  VeryAdv = ss "sehr" ;
  TooAdv = ss "zu" ;
  OtherwiseAdv = ss "sonst" ;
  ThereforeAdv = ss "deshalb" ;
} ;
