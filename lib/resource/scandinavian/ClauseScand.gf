--# -path=.:../abstract:../../prelude

incomplete concrete ClauseScand of Clause = CategoriesScand ** 
  open Prelude, SyntaxScand in {

  lin
  SPredV np v = predVerbGroupClause np (predVerb v) ;
  SPredPassV np v = predVerbGroupClause np (passVerb v) ;
  SPredV2 np v x = predVerbGroupClause np (complTransVerb v x) ;
  SPredReflV2 np v = predVerbGroupClause np (reflTransVerb v) ;
  SPredVS np v x = predVerbGroupClause np (complSentVerb v x) ;
  SPredVV np v x = predVerbGroupClause np (complVerbVerb v x) ;
  SPredVQ np v x = predVerbGroupClause np (complQuestVerb v x) ;
  SPredVA np v x = predVerbGroupClause np (complAdjVerb v x) ;
  SPredV2A np v x y = predVerbGroupClause np (complDitransAdjVerb v x y) ;
  SPredSubjV2V np v x y = predVerbGroupClause np (complDitransVerbVerb
  False v x y) ;
  SPredObjV2V np v x y = predVerbGroupClause np (complDitransVerbVerb
  True v x y) ;
  SPredV2S np v x y = predVerbGroupClause np (complDitransSentVerb v x y) ;
  SPredV2Q np v x y = predVerbGroupClause np (complDitransQuestVerb v x y) ;

  SPredAP np v = predVerbGroupClause np (predAdjective v) ;
  SPredSuperl np a = predVerbGroupClause np (predAdjective (superlAdjPhrase a)) ;
  SPredCN np v = predVerbGroupClause np (predCommNoun v) ;
  SPredNP np v = predVerbGroupClause np (predNounPhrase v) ;
  SPredPP np v = predVerbGroupClause np (predAdverb v) ;
  SPredAV np v x = predVerbGroupClause np (complVerbAdj v x) ;
  SPredObjA2V np v x y = predVerbGroupClause np (complVerbAdj2 True v x y) ;


  QPredV np v = intVerbPhrase np (predVerb v) ;
  QPredPassV np v = intVerbPhrase np (passVerb v) ;
  QPredV2 np v x = intVerbPhrase np (complTransVerb v x) ;
  QPredReflV2 np v = intVerbPhrase np (reflTransVerb v) ;
  QPredVS np v x = intVerbPhrase np (complSentVerb v x) ;
  QPredVV np v x = intVerbPhrase np (complVerbVerb v x) ;
  QPredVQ np v x = intVerbPhrase np (complQuestVerb v x) ;
  QPredVA np v x = intVerbPhrase np (complAdjVerb v x) ;
  QPredV2A np v x y = intVerbPhrase np (complDitransAdjVerb v x y) ;
  QPredSubjV2V np v x y = intVerbPhrase np (complDitransVerbVerb
  False v x y) ;
  QPredObjV2V np v x y = intVerbPhrase np (complDitransVerbVerb
  True v x y) ;
  QPredV2S np v x y = intVerbPhrase np (complDitransSentVerb v x y) ;
  QPredV2Q np v x y = intVerbPhrase np (complDitransQuestVerb v x y) ;

  QPredAP np v = intVerbPhrase np (predAdjective v) ;
  QPredSuperl np a = intVerbPhrase np (predAdjective (superlAdjPhrase a)) ;
  QPredCN np v = intVerbPhrase np (predCommNoun v) ;
  QPredNP np v = intVerbPhrase np (predNounPhrase v) ;
  QPredPP np v = intVerbPhrase np (predAdverb v) ;
  QPredAV np v x = intVerbPhrase np (complVerbAdj v x) ;
  QPredObjA2V np v x y = intVerbPhrase np (complVerbAdj2 True v x y) ;

{-
-- Use VPs

  PredVP = predVerbGroupClause ;
  IntVP = intVerbPhrase ;
  RelVP = relVerbPhrase ;


  PosVP tp = predVerbGroup True tp.a ;
  NegVP tp = predVerbGroup False tp.a ;

  AdvVP = adVerbPhrase ;
  SubjVP = subjunctVerbPhrase ;
-}

}