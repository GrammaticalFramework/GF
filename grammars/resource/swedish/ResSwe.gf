--1 The Top-Level Swedish Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the Swedish concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Swe.gf$.
-- However, for the purpose of documentation, we make here explicit the
-- linearization types of each category, so that their structures and
-- dependencies can be seen.
-- Another substantial part are the linearization rules of some
-- structural words.
--
-- The users of the resource grammar should not look at this file for the
-- linearization rules, which are in fact hidden in the document version.
-- They should use $ResAbs.gf$ to access the syntactic rules.
-- This file can be consulted in those, hopefully rare, occasions in which
-- one has to know how the syntactic categories are
-- implemented. The parameter types are defined in $TypesSwe.gf$.

concrete ResSwe of ResAbs = open Prelude, SyntaxSwe in {

flags 
  startcat=Phr ; 
  parser=chart ;

lincat 
  CN     = {s : Number => SpeciesP => Case => Str ; g : Gender ; x : Sex ; 
            p : IsComplexCN} ;
  N      = CommNoun ;
      -- = {s : Number => Species => Case => Str ; g : Gender ; x : Sex} ;
  NP     = NounPhrase ;
      -- = {s : NPForm => Str ; g : Gender ; n : Number} ;
  PN     = {s : Case => Str ; g : Gender ; x : Sex} ;
  Det    = {s : Gender => Sex => Str ; n : Number ; b : SpeciesP} ;
  Fun    = Function ;
      -- = CommNoun ** {s2 : Preposition} ;
  Fun2   = Function ** {s3 : Preposition} ;

  Adj1   = Adjective ;
      -- = {s : AdjFormPos => Case => Str} ; 
  Adj2   = Adjective ** {s2 : Preposition} ;
  AdjDeg = {s : AdjForm => Str} ;
  AP     = Adjective ** {p : IsPostfixAdj} ;

  V      = Verb ;
      -- = {s : VForm => Str} ;
  VP     = Verb ** {s2 : Str ; s3 : Gender => Number => Str} ;
  TV     = TransVerb ; 
      -- = Verb ** {s2 : Preposition} ;
  V3     = TransVerb ** {s3 : Preposition} ;
  VS     = Verb ;

  AdV    = {s : Str ; isPost : Bool} ;

  S      = Sentence ;
      -- = {s : Order => Str} ;
  Slash  = Sentence ** {s2 : Preposition} ;
  RP     = {s : RelCase => GenNum => Str ; g : RelGender} ;
  RC     = {s : GenNum => Str} ;
  IP     = NounPhrase ;
  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Number => Str} ;

  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1,s2 : Order => Str} ; 
  ListAP = {s1,s2 : AdjFormPos => Case => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; g : Gender ; n : Number} ;

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
  PosV3 = complDitransVerb True ;
  NegV3 = complDitransVerb False ;
  PosNP = predNounPhrase True ;
  NegNP = predNounPhrase False ;
  PosPassV = passVerb True ;
  NegPassV = passVerb False ;
  PosVS = complSentVerb True ;
  NegVS = complSentVerb False ;
  VTrans = transAsVerb ;

  AdvVP = adVerbPhrase ;
  LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = predVerbPhrase (nameNounPhrase (mkProperName "man" Utr Masc)) ;

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

  INP    = pronNounPhrase jag_32 ;
  ThouNP = pronNounPhrase du_33 ;
  HeNP   = pronNounPhrase han_34 ;
  SheNP  = pronNounPhrase hon_35 ;
  ItNP   = pronNounPhrase det_40 ; ----
  WeNP   = pronNounPhrase vi_36 ;
  YeNP   = pronNounPhrase ni_37 ;
  TheyNP = pronNounPhrase de_38 ;

  YouNP  = let {ni = pronNounPhrase ni_37 } in {s = ni.s ; g = ni.g ; n = Sg} ;

  EveryDet = varjeDet ; 
  AllDet   = allaDet ; 
  WhichDet = vilkenDet ;
  MostDet  = flestaDet ;

  HowIAdv = ss "hur" ;
  WhenIAdv = ss "när" ;
  WhereIAdv = ss "var" ;
  WhyIAdv = ss "varför" ;

  AndConj  = ss "och" ** {n = Pl}  ;
  OrConj   = ss "eller" ** {n = Sg} ;
  BothAnd  = sd2 "både" "och" ** {n = Pl}  ;
  EitherOr = sd2 "antingen" "eller" ** {n = Sg} ;
  NeitherNor = sd2 "varken" "eller" ** {n = Sg} ;
  IfSubj   = ss "om" ;
  WhenSubj = ss "när" ;

  PhrYes = ss ["Ja ."] ;
  PhrNo = ss ["Nej ."] ;

  VeryAdv = ss "mycket" ;
  TooAdv = ss "för" ;
  OtherwiseAdv = ss "annars" ;
  ThereforeAdv = ss "därför" ;
} ;
