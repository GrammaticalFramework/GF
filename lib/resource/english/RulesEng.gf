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

concrete RulesEng of Rules = CategoriesEng ** open Prelude, SyntaxEng in {

flags 
  startcat=Phr ; 
  lexer=text ;
  unlexer=text ;

lin 
  UseN = noun2CommNounPhrase ;
  ModAP = modCommNounPhrase ;
  ModGenOne = npGenDet singular noNum ;
  ModGenNum = npGenDet plural ;
  UsePN = nameNounPhrase ;
  UseN2 = funAsCommNounPhrase ;
  AppN2 = appFunComm ;
  AppN3 = appFun2 ;
  UseA = adj2adjPhrase ;
  ComplA2 = complAdj ;
  PositADeg = positAdjPhrase ;
  ComparADeg = comparAdjPhrase ;
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
  IntCN cn s =
    {s = \\n,c => cn.s ! n ! c ++ s.s ; 
     g = cn.g} ;

  PredVP = predVerbPhrase ;
  PosVG  = predVerbGroup True ;
  NegVG  = predVerbGroup False ;

  PredVG = predVerbGroupClause ;

  PredV  = predVerb ;
  PredAP = predAdjective ;
  PredSuperl a = predAdjective (superlAdjPhrase a) ;
  PredCN = predCommNoun ;
  PredV2 = complTransVerb ;
  PredV3 = complDitransVerb ;
  PredPassV = passVerb ;
  PredNP = predNounPhrase ;
  PredPP = predAdverb ;
  PredVS = complSentVerb ;
  PredVV = complVerbVerb ;
  VTrans = transAsVerb ;

  AdjAdv a = advPost (a.s ! AAdv) ;
  AdvPP p = advPost p.s ;
  PrepNP p = prepPhrase p.s ; ---
  AdvVP = adVerbPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  PosSlashV2 = slashTransVerb True ;
  NegSlashV2 = slashTransVerb False ;
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

  PrepS p = ss (p.s ++ ",") ;
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
