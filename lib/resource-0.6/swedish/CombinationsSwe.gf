--# -path=.:../abstract:../../prelude

--1 The Top-Level Swedish Resource Grammar: Combination Rules
--
-- Aarne Ranta 2002 -- 2003
--
-- This is the Swedish concrete syntax of the multilingual resource
-- grammar. Most of the work is done in the file $SyntaxSwe.gf$.
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
-- implemented. The parameter types are defined in $TypesSwe.gf$.

concrete CombinationsSwe of Combinations = open Prelude, SyntaxSwe in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

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
  Num    = {s : Case => Str} ;
  Prep   = {s : Str} ;

  Adj1   = Adjective ;
      -- = {s : AdjFormPos => Case => Str} ; 
  Adj2   = Adjective ** {s2 : Preposition} ;
  AdjDeg = {s : AdjForm => Str} ;
  AP     = Adjective ** {p : IsPostfixAdj} ;

  V      = Verb ;
      -- = {s : VForm => Str ; s1 : Str} ;
  VG     = {s : VForm => Str ; s2 : Bool => Str ; s3 : Gender => Number => Str} ;
  VP     = {s : VForm => Str ; s2 : Str ; s3 : Gender => Number => Str} ;
  TV     = TransVerb ; 
      -- = Verb ** {s2 : Preposition} ;
  V3     = TransVerb ** {s3 : Preposition} ;
  VS     = Verb ;
  VV     = Verb ** {isAux : Bool} ;

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
  MassNP = detNounPhrase (mkDeterminerSg (detSgInvar []) IndefP) ;
  UseInt i = {s = table {Nom => i.s ; Gen => i.s ++ "s"}} ; ---
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
  PredPassV = passVerb ;
  PredNP = predNounPhrase ;
  PredAdV = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = transAsVerb ;

  AdjAdv a = advPost (a.s ! adverbForm ! Nom) ;
  PrepNP p = prepPhrase p.s ; ---
  AdvVP = adVerbPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  ThereNP A = predVerbPhrase npDet 
                (predVerbGroup True
                  (complTransVerb (mkDirectVerb verbFinnas) A)) ;

  PosSlashTV = slashTransVerb True ;
  NegSlashTV = slashTransVerb False ;
  OneVP = predVerbPhrase npMan ;

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
  IsThereNP A = questVerbPhrase npDet 
                 (predVerbGroup True
                  (complTransVerb (mkDirectVerb verbFinnas) A)) ; 

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
