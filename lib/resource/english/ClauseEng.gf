--# -path=.:../abstract:../../prelude
--# -opt

concrete ClauseEng of Clause = CategoriesEng ** 
  open Prelude, SyntaxEng in {

  flags optimize=all ;

  lin
  SPredV np v = predVerbClause np v (complVerb v) ;
  SPredPassV np v = predBeGroup np (passVerb v) ;
  SPredV2 np v x = predVerbClause np v (complTransVerb v x) ;
  SPredReflV2 np v = predVerbClause np v (reflTransVerb v) ;
  SPredVS np v x = predVerbClause np v (complSentVerb v x) ;
  SPredVV np v x = predVerbClause np (aux2verb v) (complVerbVerb v x) ;
  SPredVQ np v x = predVerbClause np v (complQuestVerb v x) ;
  SPredVA np v x = predVerbClause np v (complAdjVerb v x) ;
  SPredV2A np v x y = predVerbClause np v (complDitransAdjVerb v x y) ;
  SPredSubjV2V np v x y = predVerbClause np v (complDitransVerbVerb False v x y) ;
  SPredObjV2V np v x y = predVerbClause np v (complDitransVerbVerb True v x y) ;
  SPredV2S np v x y = predVerbClause np v (complDitransSentVerb v x y) ;
  SPredV2Q np v x y = predVerbClause np v (complDitransQuestVerb v x y) ;

  SPredAP np v = predBeGroup np (complAdjective v) ;
  SPredSuperl np a = predBeGroup np (complAdjective (superlAdjPhrase a)) ;
  SPredCN np v = predBeGroup np (complCommNoun v) ;
  SPredNP np v = predBeGroup np (complNounPhrase v) ;
  SPredPP np v = predBeGroup np (complAdverb v) ;

  SPredAV np v x = predBeGroup np (complVerbAdj v x) ;
  SPredObjA2V np v x y = predBeGroup np (complVerbAdj2 True v x y) ;

  SPredProgVP = progressiveClause ;

  QPredV np v = intVerbClause np v (complVerb v) ;
  QPredPassV np v = predBeGroupQ np (passVerb v) ;
  QPredV2 np v x = intVerbClause np v (complTransVerb v x) ;
  QPredReflV2 np v = intVerbClause np v (reflTransVerb v) ;
  QPredVS np v x = intVerbClause np v (complSentVerb v x) ;
  QPredVV np v x = intVerbClause np (aux2verb v) (complVerbVerb v x) ;
  QPredVQ np v x = intVerbClause np v (complQuestVerb v x) ;
  QPredVA np v x = intVerbClause np v (complAdjVerb v x) ;
  QPredV2A np v x y = intVerbClause np v (complDitransAdjVerb v x y) ;
  QPredSubjV2V np v x y = intVerbClause np v (complDitransVerbVerb
  False v x y) ;
  QPredObjV2V np v x y = intVerbClause np v (complDitransVerbVerb
  True v x y) ;
  QPredV2S np v x y = intVerbClause np v (complDitransSentVerb v x y) ;
  QPredV2Q np v x y = intVerbClause np v (complDitransQuestVerb v x y) ;

  QPredAP np v = predBeGroupQ np (complAdjective v) ;
  QPredSuperl np a = predBeGroupQ np (complAdjective (superlAdjPhrase a)) ;
  QPredCN np v = predBeGroupQ np (complCommNoun v) ;
  QPredNP np v = predBeGroupQ np (complNounPhrase v) ;
  QPredPP np v = predBeGroupQ np (complAdverb v) ;
  QPredAV np v x = predBeGroupQ np (complVerbAdj v x) ;
  QPredObjA2V np v x y = predBeGroupQ np (complVerbAdj2 True v x y) ;

  IPredV a v = predVerbI True a v (complVerb v) ;
  IPredV2 a v x = predVerbI True a v (complTransVerb v x) ;

  IPredAP a v = predBeGroupI True a (complAdjective v) ;

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