--# -path=.:../abstract:../../prelude

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
-- implemented. The parameter types are defined in $TypesGer.gf$.

concrete CombinationsGer of Combinations = open Prelude, SyntaxGer in {

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
  Num    = {s : Str} ;
  Prep   = {s : Str ; c : Case} ;

  Adj1   = Adjective ;
      -- = {s : AForm => Str} ;
  Adj2   = Adjective ** {s2 : Preposition ; c : Case} ;
  AdjDeg = {s : Degree => AForm => Str} ;
  AP     = Adjective ** {p : Bool} ;

  V      = Verb ; 
      -- = {s : VForm => Str ; s2 : Particle} ;
  VG     = {s : VForm => Str ; s2 : Str ; s3 : Bool => Number => Str ; s4 : Str} ;
  VP     = Verb ** {s3 : Number => Str ; s4 : Str} ; 
  TV     = TransVerb ; 
      -- = Verb ** {s3 : Preposition ; c : Case} ;
  V3     = TransVerb ** {s4 : Preposition ; c2 : Case} ;
  VS     = Verb ;
  VV     = Verb ** {isAux : Bool} ;
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
  ModGenOne = npGenDet singular noNum ;
  ModGenNum = npGenDet plural ;
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
  IndefNumNP = plurDetNum ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP nu = defNounPhraseNum nu plural ;
  MassNP = massNounPhrase ;
  UseInt i = i ;
  NoNum = noNum ;

  CNthatS = nounThatSentence ;
  PredVP = predVerbPhrase ;
  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  SymbPN i = {s = \\_ => i.s} ;
  SymbCN cn s =
    {s = \\a,n,c => cn.s ! a ! n ! c ++ s.s ; 
     g = cn.g} ;

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

  AdjAdv a = ss (a.s ! APred) ;
  PrepNP = prepPhrase ;
  AdvVP = adVerbPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  ThereNP A = predVerbPhrase (pronNounPhrase pronEs) 
    (predVerbGroup True (complTransVerb (transDir verbGeben) A)) ;
  IsThereNP A = questVerbPhrase (pronNounPhrase pronEs) 
    (predVerbGroup True (complTransVerb (transDir verbGeben) A)) ;

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

} ;
