--1 The Top-Level Finnish Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the Finnish concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Fin.gf$.
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
-- implemented. The parameter types are defined in $TypesFin.gf$.

concrete CombinationsFin of Combinations = open Prelude, SyntaxFin in {

flags 
  startcat=Phr ; 
  lexer=unglue ;
  unlexer=glue ;

lincat 
  N      = CommNoun ;         
      -- = {s : NForm => Str ; g : Gender}
  CN     = CommNounPhrase ;   
  NP     = {s : NPForm => Str ; n : Number ; p : NPPerson} ;
  PN     = {s : Case => Str} ;
  Det    = {s : Gender => Case => Str ; n : Number} ;
  Fun    = Function ;
      -- = CommNounPhrase ** {c : NPForm} ;
  Fun2   = Function ** {c2 : NPForm} ;

  Adj1   = Adjective ;
      -- = CommonNoun
  Adj2   = Adjective ** {c : NPForm} ;
  AdjDeg = {s : Degree => NForm => Str} ;
  AP     = {s : AdjPos => Number => Case => Str} ;

  V      = Verb ; 
      -- = {s : VForm => Str}
  VP     = Verb ** {s2 : VForm => Str ; c : ComplCase} ;
  TV     = TransVerb ;
      -- = Verb ** {s3, s4 : Str ; c : ComplCase} ;
  V3     = TransVerb ** {s5, s6 : Str ; c2 : ComplCase} ;
  VS     = Verb ;

  AdV    = {s : Str} ;

  S      = Sentence ;
      -- = {s : Str} ; 
  Slash  = Sentence ** {s2 : Str ; c : Case} ;

  RP     = {s : Number => Case => Str} ;
  RC     = {s : Number => Str} ;

  IP     = {s : NPForm => Str ; n : Number} ;
  Qu     = {s : Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1 : Str ; s2 : Str} ;
  ListAP = {s1,s2 : AdjPos => Number => Case => Str} ;
  ListNP = {s1,s2 : NPForm => Str ; n : Number ; p : NPPerson} ;

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
  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredV  = predVerb ;
  PredAP = predAdjective ;
  PredCN = predCommNoun ;
  PredTV = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredPassV = passVerb ;
  PredNP = predNounPhrase ;
  PredAdV = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = transAsVerb ;

  AdvVP = adVerbPhrase ;
  LocNP = locativeNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = passPredVerbPhrase ;

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


} ;
