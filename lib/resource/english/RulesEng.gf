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

  AdjPart = adjPastPart ;
  ReflV2 = reflTransVerb ;

  PredV2A = complDitransAdjVerb ;
  PredSubjV2V = complDitransVerbVerb False ;
  PredObjV2V = complDitransVerbVerb True ;
  PredV2S = complDitransSentVerb ;
  PredV2Q = complDitransQuestVerb ;
  PredVA = complAdjVerb ;
  PredVV2 = transVerbVerb ;

  UseV2V x = x ;
  UseV2S x = x ;
  UseV2Q x = x ;
  UseA2S x = x ;
  UseA2V x = x ;

  UseCl  tp cl = {s = tp.s ++ cl.s ! tp.b ! t2cl tp.t tp.a} ;

  PosVP tp = predVerbGroup True tp.a ;
  NegVP tp = predVerbGroup False tp.a ;

  ProgVP = progressiveVerbPhrase ;

  PosTP t a = {s = t.s ++ a.s ; b = True  ; t = t.t ; a = a.a} ;
  NegTP t a = {s = t.s ++ a.s ; b = False ; t = t.t ; a = a.a} ;
  TPresent     = {s = [] ; t = ClPresent} ;
  TPast        = {s = [] ; t = ClPast} ;
  TFuture      = {s = [] ; t = ClFuture} ;
  TConditional = {s = [] ; t = ClConditional} ;
  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

  PredVP = predVerbGroupClause ;

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
  PredVQ = complQuestVerb ;
  VTrans = transAsVerb ;
  PredV0 rain = predVerbGroupClause pronIt (predVerb rain) ;

  PredAS  = predAdjSent ;
  PredA2S = predAdjSent2 ;
  PredAV  = complVerbAdj ;
  PredSubjA2V = complVerbAdj2 False ;
  PredObjA2V = complVerbAdj2 True ;

  AdjAdv a = advPost (a.s ! AAdv) ;
  AdvPP p = advPost p.s ;
  PrepNP p = prepPhrase p.s ; ---
  AdvVP = adVerbPhrase ;
  AdvCN = advCommNounPhrase ;
  AdvAP = advAdjPhrase ;

  SlashV2 = slashTransVerbCl ;
  OneVP = predVerbGroupClause (nameNounPhrase (nameReg "one")) ;
----  ThereNP = thereIs ;
  ExistCN A = predVerbGroupClause 
                (nameNounPhrase (nameReg "there"))
                (complTransVerb (mkTransVerbDir verbBe) 
                   (indefNounPhrase singular A)) ;
  ExistNumCN nu A = 
              predVerbGroupClause 
                (nameNounPhrasePl (nameReg "there"))
                (complTransVerb (mkTransVerbDir verbBe) 
                   (indefNounPhraseNum plural nu A)) ;

  IdRP = identRelPron ;
  FunRP = funRelPron ;
  RelVP = relVerbPhrase ;
  RelSlash = relSlash ;
  ModRS = modRelClause ;
  RelCl = relSuch ;

  UseRCl tp cl = 
    {s = \\g,n => 
      tp.s ++ cl.s ! tp.b ! (cl2s (t2cl tp.t tp.a) n P3).form ! g ! n} ;
    --- P3 ==> p

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

  UseQCl tp cl = {s = \\q => tp.s ++ cl.s ! tp.b ! t2cl tp.t tp.a ! q} ;

  ExistQCl A = questVerbPhrase
                (nameNounPhrase (nameReg "there"))
                (complTransVerb (mkTransVerbDir verbBe) 
                   (indefNounPhrase singular A)) ;
  ExistNumQCl nu A = 
              questVerbPhrase
                (nameNounPhrasePl (nameReg "there"))
                (complTransVerb (mkTransVerbDir verbBe) 
                   (indefNounPhraseNum plural nu A)) ;


  PosImperVP = imperVerbPhrase True ;
  NegImperVP = imperVerbPhrase False ;

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
  SubjQS = subjunctQuestion ;
  SubjVP = subjunctVerbPhrase ;

  PhrNP = useNounPhrase ;
  PhrOneCN = useCommonNounPhrase singular ;
  PhrManyCN = useCommonNounPhrase plural ;
  PhrIP ip = ip ;
  PhrIAdv ia = ia ;

  OnePhr p = p ;
  ConsPhr = cc2 ;

} ;
