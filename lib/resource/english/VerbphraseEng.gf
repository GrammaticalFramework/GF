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

concrete VerbphraseEng of Verbphrase = CategoriesEng ** 
  open Prelude, SyntaxEng in {

  lin
  UseV v = predClauseGroup v (complVerb v) ;
  UsePassV v = predClauseBeGroup (passVerb v) ;
  ComplV2 v x = predClauseGroup v (complTransVerb v x) ;
  ComplReflV2 v = predClauseGroup v (reflTransVerb v) ;
  ComplVS v x = predClauseGroup v (complSentVerb v x) ;
  ComplVV v x = predClauseGroup (aux2verb v) (complVerbVerb v x) ;
  ComplVQ v x = predClauseGroup v (complQuestVerb v x) ;
  ComplVA v x = predClauseGroup v (complAdjVerb v x) ;
  ComplV2A v x y = predClauseGroup v (complDitransAdjVerb v x y) ;
  ComplSubjV2V v x y = predClauseGroup v (complDitransVerbVerb False v x y) ;
  ComplObjV2V v x y = predClauseGroup v (complDitransVerbVerb True v x y) ;
  ComplV2S v x y = predClauseGroup v (complDitransSentVerb v x y) ;
  ComplV2Q v x y = predClauseGroup v (complDitransQuestVerb v x y) ;

  PredAP v = predClauseBeGroup (complAdjective v) ;
  PredSuperl a = predClauseBeGroup (complAdjective (superlAdjPhrase a)) ;
  PredCN v = predClauseBeGroup (complCommNoun v) ;
  PredNP v = predClauseBeGroup (complNounPhrase v) ;
  PredAdv v = predClauseBeGroup (complAdverb v) ;

  PredAV v x = predClauseBeGroup (complVerbAdj v x) ;
  PredObjA2V v x y = predClauseBeGroup (complVerbAdj2 True v x y) ;

  PredProgVP = progressiveVerbPhrase ;

----  SPredProgVP = progressiveClause ;

-- Use VPs

  PredVP = predVerbGroupClause ;

  RelVP = relVerbPhrase ;
  IntVP = intVerbPhrase ;

  PosVP = predVerbGroup True ;
  NegVP = predVerbGroup False ;

  AdvVP = adVerbPhrase ;
  SubjVP = subjunctVerbPhrase ;
}