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

incomplete concrete ResRomance of ResAbs = open Prelude, SyntaxRomance in {

flags 
  startcat=Phr ; 
  parser=chart ;

lincat 
  N      = CommNoun ; 
      -- = {s : Number => Str ; g : Gender} ;
  CN     = CommNoun ; 
  NP     = {s : NPFormA => Str ; g : PronGen ; 
            n : Number ; p : Person ; c : ClitType} ;
  PN     = {s : Str ; g : Gender} ;
  Det    = {s : Gender => Str ; n : Number} ;
  Adj1   = Adjective ;
      -- = {s : Gender => Number => Str ; p : Bool} ;
  Adj2   = Adjective ** {s2 : Preposition ; c : CaseA} ;
  AdjDeg = {s : Degree => Gender => Number => Str ; p : Bool} ;
  AP     = Adjective ;
  Fun    = CommNoun ** {s2 : Preposition ; c : CaseA} ;

  V      = Verb ; 
      -- = {s : VF => Str} ;
  VP     = {s : Gender => VF => Str} ;
  TV     = Verb ** {s2 : Preposition ; c : CaseA} ; 
  VS     = Verb ** {mp,mn : Mode} ;
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
  ListAP = {s1,s2 : Gender => Number => Str ; p : Bool} ;
  ListNP = {s1,s2 : CaseA => Str ; g : PronGen ; n : Number ; p : Person} ;

--.

lin 
  UseN = noun2CommNounPhrase ;
  ModAdj = modCommNounPhrase ;
  ModGenOne = npGenDet singular ;
  ModGenMany = npGenDet plural ;
  UsePN = nameNounPhrase ;
  UseFun = funAsCommNounPhrase ; -- [SyntaxFra.noun2CommNounPhrase]
  AppFun = appFunComm ;
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

  PredVP = predVerbPhrase ;
  PosV = predVerb True ;
  NegV = predVerb False ;
  PosA = predAdjective True ; 
  NegA = predAdjective False ;
  PosCN = predCommNoun True ;
  NegCN = predCommNoun False ;
  PosTV = complTransVerb True ;
  NegTV = complTransVerb False ;
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

lin
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

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = ip ;
  PhrIAdv ia = ia ;

  INP    = pronNounPhrase pronJe ;
  ThouNP = pronNounPhrase pronTu ;
  HeNP   = pronNounPhrase pronIl ;
  SheNP  = pronNounPhrase pronElle ;
  WeNP   = pronNounPhrase pronNous ;
  YeNP   = pronNounPhrase pronVous ;
  YouNP  = pronNounPhrase pronVous ;
  TheyNP = pronNounPhrase pronIls ; 

-- Here is a point where the API is really inadequate for French,
-- which distinguishes between masculine and feminine "they".
-- The following solution is not attractive.

---  TheyNP = pronNounPhrase (variants {pronIls ; pronElles}) ;

  EveryDet = chaqueDet ; 
  AllDet   = tousDet ;
  WhichDet = quelDet ;
  MostDet  = plupartDet ;

  HowIAdv = commentAdv ;
  WhenIAdv = quandAdv ;
  WhereIAdv = ouAdv ;
  WhyIAdv = pourquoiAdv ;

  AndConj = etConj ;
  OrConj = ouConj  ;
  BothAnd = etetConj ;
  EitherOr = ououConj  ;
  NeitherNor = niniConj  ; --- requires ne !
  IfSubj = siSubj ;
  WhenSubj = quandSubj ;

  PhrYes = ouiPhr ;  
  PhrNo = nonPhr ; --- and also Si!
}
