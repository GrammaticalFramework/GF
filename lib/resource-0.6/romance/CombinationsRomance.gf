--# -path=.:../abstract:../../prelude

--1 The Top-Level French Resource Grammar
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the French concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file 
-- $syntax.Romance.gf$, some in $syntax.Fra.gf$.
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
-- implemented. Most parameter types are defined in $types.Romance.gf$, some in
-- $types.Fra.gf$.

incomplete concrete CombinationsRomance of Combinations = 
  open Prelude, SyntaxRomance in {

flags 
  startcat=Phr ; 

lincat 
  N      = CommNoun ; 
      -- = {s : Number => Str ; g : Gender} ;
  CN     = CommNoun ; 
  NP     = {s : NPFormA => Str ; g : PronGen ; 
            n : Number ; p : Person ; c : ClitType} ;
  PN     = {s : Str ; g : Gender} ;
  Det    = {s : Gender => Str ; n : Number} ;
  Adj1   = Adjective ;
      -- = {s : AForm => Str ; p : Bool} ;
  Adj2   = Adjective ** {s2 : Preposition ; c : CaseA} ;
  AdjDeg = {s : Degree => AForm => Str ; p : Bool} ;
  AP     = Adjective ;
  Fun    = Function ;
      -- = CommNoun ** {s2 : Preposition ; c : CaseA} ;
  Fun2   = Function ** {s3 : Preposition ; c3 : CaseA} ;
  Prep   = {s : Preposition ; c : CaseA} ; 
  Num    = {s : Gender => Str} ;

  V      = Verb ; 
      -- = {s : VF => Str} ;
  VG     = {s : Bool => Gender => VF => Str} ;
  VP     = {s : Gender => VF => Str} ;
  TV     = TransVerb ;
      -- = Verb ** {s2 : Preposition ; c : CaseA} ; 
  V3     = TransVerb ** {s3 : Preposition ; c3 : CaseA} ;
  VS     = Verb ** {mp,mn : Mode} ;
  VV     = Verb ** {c : CaseA} ;
  AdV    = {s : Str} ;

  S      = Sentence ; 
      -- = {s : Mode => Str} ;
  Slash  = Sentence ** {s2 : Preposition ; c : CaseA} ;

  RP     = {s : RelForm => Str ; g : RelGen} ;
  RC     = {s : Mode => Gender => Number => Str} ;

  IP     = {s : CaseA => Str ; g : Gender ; n : Number} ;
  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Gender => Number => Str} ;
  Phr    = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1,s2 : Str ; n : Number} ;

  ListS  = {s1,s2 : Mode => Str} ;
  ListAP = {s1,s2 : AForm => Str ; p : Bool} ;
  ListNP = {s1,s2 : CaseA => Str ; g : PronGen ; n : Number ; p : Person} ;

  Subj   = {s : Str ; m : Mode} ;
--.

lin 
  UseN = noun2CommNounPhrase ;
  ModAdj = modCommNounPhrase ;
  ModGenOne = npGenDet singular ;
  ModGenMany = npGenDetNum ;
  UsePN = nameNounPhrase ;
  UseFun = funAsCommNounPhrase ; -- [SyntaxFra.noun2CommNounPhrase]
  AppFun = appFunComm ;
  AppFun2 = appFun2 ;
  AdjP1 = adj2adjPhrase ;
  ComplAdj = complAdj ;
  PositAdjP = positAdjPhrase ;
  ComparAdjP = comparAdjPhrase ;
  SuperlNP = superlNounPhrase ;

  DetNP = detNounPhrase ;
  IndefOneNP = indefNounPhrase singular ;
  IndefManyNP = indefNounPhraseNum ;
  DefOneNP = defNounPhrase singular ;
  DefManyNP = defNounPhraseNum ;
  MassNP = partitiveNounPhrase singular ;
  UseInt i = {s = \\_ => i.s} ;
  NoNum = noNum ;

  CNthatS = nounThatSentence ;

  PredVP = predVerbPhrase ;
  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredV  = predVerb ;
  PredAP = predAdjective ; 
  PredCN = predCommNoun ;
  PredTV = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredNP = predNounPhrase ;
  PredAdV = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  PredPassV = predPassVerb ;
  VTrans = transAsVerb ;

  AdjAdv a = {s = a.s ! AA} ;
  AdvVP = adVerbPhrase ;
  PrepNP = prepNounPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  ThereNP = existNounPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = predVerbPhrase nounPhraseOn ;


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
  IsThereNP = existNounPhraseQuest ;

  ImperVP = imperVerbPhrase ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

  AdvS = advSentence ;

  TwoS = twoSentence ;
  ConsS = consSentence ;
  ConjS = conjunctSentence ;
  ConjDS = conjunctDistrSentence ; -- [Coordination.conjunctDistrTable]

  TwoAP = twoAdjPhrase ;
  ConsAP = consAdjPhrase ;
  ConjAP = conjunctAdjPhrase ;
  ConjDAP = conjunctDistrAdjPhrase ;

  TwoNP = twoNounPhrase ;
  ConsNP = consNounPhrase ;
  ConjNP = conjunctNounPhrase ;
  ConjDNP = conjunctDistrNounPhrase ;

  SubjS = subjunctSentence ;       -- stack
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
}
