--# -path=.:../abstract:../../prelude

--1 The Top-Level English Resource Grammar: Combination Rules
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the English concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $syntax.Eng.gf$.
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
-- implemented. The parameter types are defined in $TypesEng.gf$.

concrete CombinationsEng of Combinations = open Prelude, SyntaxEng in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lincat 
  N      = CommNoun ;         
      -- = {s : Number => Case => Str}
  CN     = CommNounPhrase ;   
      -- = CommNoun ** {g : Gender}
  NP     = {s : NPForm => Str ; n : Number ; p : Person} ;
  PN     = {s : Case => Str} ;
  Det    = {s : Str ; n : Number} ;
  Fun    = Function ;
      -- = CommNounPhrase ** {s2 : Preposition} ;
  Fun2   = Function ** {s3 : Preposition} ;
  Num    = {s : Case => Str} ;

  Adj1   = Adjective ; 
      -- = {s : AForm => Str}
  Adj2   = Adjective ** {s2 : Preposition} ;
  AdjDeg = {s : Degree => AForm => Str} ;
  AP     = Adjective ** {p : Bool} ;

  V      = Verb ; 
      -- = {s : VForm => Str ; s1 : Particle}
  VG     = {s : Bool => VForm => Str ; s2 : Bool => Number => Str ; 
            isAuxT, isAuxF : Bool} ;
  VP     = {s : VForm => Str ; s2 : Number => Str ; isAux : Bool} ;
  TV     = TransVerb ; 
      -- = Verb ** {s3 : Preposition} ;
  V3     = TransVerb ** {s4 : Preposition} ;
  VS     = Verb ;
  VV     = Verb ** {isAux : Bool} ;

  AdV    = {s : Str ; p : Bool} ;

  S      = {s : Str} ; 
  Slash  = {s : Bool => Str ; s2 : Preposition} ;
  RP     = {s : Gender => Number => NPForm => Str} ;
  RC     = {s : Gender => Number => Str} ;

  IP     = {s : NPForm => Str ; n : Number} ;
  Qu     = {s : QuestForm => Str} ;
  Imp    = {s : Number => Str} ;
  Phr    = {s : Str} ;
  Text   = {s : Str} ;

  Conj   = {s : Str ; n : Number} ;
  ConjD  = {s1 : Str ; s2 : Str ; n : Number} ;

  ListS  = {s1 : Str ; s2 : Str} ;
  ListAP = {s1,s2 : AForm => Str ; p : Bool} ;
  ListNP = {s1,s2 : NPForm => Str ; n : Number ; p : Person} ;

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
  IndefNumNP = indefNounPhraseNum plural ;
  DefOneNP = defNounPhrase singular ;
  DefNumNP = defNounPhraseNum plural ;
  MassNP = detNounPhrase (mkDeterminer Sg []) ;

  CNthatS = nounThatSentence ;
  UseInt i = {s = table {Nom => i.s ; Gen => i.s ++ "'s"}} ; ---
  NoNum = noNum ;

  SymbPN i = {s = table {Nom => i.s ; Gen => i.s ++ "'s"}} ; ---
  SymbCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g} ;

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

  AdjAdv a = advPost (a.s ! AAdv) ;
  PrepNP p = prepPhrase p.s ; ---
  AdvVP = adVerbPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = predVerbPhrase (nameNounPhrase (nameReg "one")) ;
  ThereNP = thereIs ;

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
  IsThereNP = isThere ;

  ImperVP = imperVerbPhrase ;

  IndicPhrase = indicUtt ;
  QuestPhrase = interrogUtt ;
  ImperOne = imperUtterance singular ;
  ImperMany = imperUtterance plural ;

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
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = ip ;
  PhrIAdv ia = ia ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

} ;
