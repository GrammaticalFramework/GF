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

incomplete concrete VerbphraseScand of Verbphrase = CategoriesScand ** 
  open Prelude, SyntaxScand in {

  lin
  UseV  = predVerb ;
  UsePassV = passVerb ;
  ComplV2 = complTransVerb ;
  ComplReflV2 = reflTransVerb ;
  ComplVS = complSentVerb ;
  ComplVV = complVerbVerb ;
  ComplVQ = complQuestVerb ;
  ComplVA = complAdjVerb ;
  ComplV2A = complDitransAdjVerb ;
  ComplSubjV2V = complDitransVerbVerb False ;
  ComplObjV2V = complDitransVerbVerb True ;
  ComplV2S = complDitransSentVerb ;
  ComplV2Q = complDitransQuestVerb ;

  PredAP = predAdjective ;
  PredSuperl a = predAdjective (superlAdjPhrase a) ;
  PredCN = predCommNoun ;
  PredNP = predNounPhrase ;
  PredAdv = predAdverb ;
  PredAV = complVerbAdj ;
  PredObjA2V = complVerbAdj2 True ;

  PredProgVP = progressiveVerbPhrase ;

-- Use VPs

  PredVP = predVerbGroupClause ;
  RelVP = relVerbPhrase ;
  IntVP = intVerbPhrase ;

  PosVP tp = predVerbGroup True tp ;
  NegVP tp = predVerbGroup False tp ;

  AdvVP = adVerbPhrase ;
  SubjVP = subjunctVerbPhrase ;

}
