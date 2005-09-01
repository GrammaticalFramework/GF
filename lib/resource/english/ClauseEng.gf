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
  SPredV3 np v x y = predVerbClause np v (complDitransVerb v x y) ;
  SPredVS np v x = predVerbClause np v (complSentVerb v x) ;
  SPredVV np v x = predVerbClause np (aux2verb v) (complVerbVerb v x) ;
  SPredVQ np v x = predVerbClause np v (complQuestVerb v x) ;
  SPredVA np v x = predVerbClause np v (complAdjVerb v x) ;
  SPredV2A np v x y = predVerbClause np v (complDitransAdjVerb v x y) ;
  SPredSubjV2V np v x y = predVerbClause np v (complDitransVerbVerb False v x y) ;
  SPredObjV2V np v x y = predVerbClause np v (complDitransVerbVerb True v x y) ;
  SPredV2S np v x y = predVerbClause np v (complDitransSentVerb v x y) ;
  SPredV2Q np v x y = predVerbClause np v (complDitransQuestVerb v x y) ;

  SPredAP np v = predBeGroup np v.s ;
  SPredCN np v = predBeGroup np (complCommNoun v) ;
  SPredNP np v = predBeGroup np (complNounPhrase v) ;
  SPredAdv np v = predBeGroup np (complAdverb v) ;

  SPredProgVP = progressiveClause ;

  QPredV np v = intVerbClause np v (complVerb v) ;
  QPredPassV np v = predBeGroupQ np (passVerb v) ;
  QPredV2 np v x = intVerbClause np v (complTransVerb v x) ;
  QPredReflV2 np v = intVerbClause np v (reflTransVerb v) ;
  QPredV3 np v x y = intVerbClause np v (complDitransVerb v x y) ;
  QPredVS np v x = intVerbClause np v (complSentVerb v x) ;
  QPredVV np v x = intVerbClause np (aux2verb v) (complVerbVerb v x) ;
  QPredVQ np v x = intVerbClause np v (complQuestVerb v x) ;
  QPredVA np v x = intVerbClause np v (complAdjVerb v x) ;
  QPredV2A np v x y = intVerbClause np v (complDitransAdjVerb v x y) ;
  QPredSubjV2V np v x y = intVerbClause np v (complDitransVerbVerb False v x y) ;
  QPredObjV2V np v x y = intVerbClause np v (complDitransVerbVerb True v x y) ;
  QPredV2S np v x y = intVerbClause np v (complDitransSentVerb v x y) ;
  QPredV2Q np v x y = intVerbClause np v (complDitransQuestVerb v x y) ;

  QPredAP np v = predBeGroupQ np v.s ;
  QPredCN np v = predBeGroupQ np (complCommNoun v) ;
  QPredNP np v = predBeGroupQ np (complNounPhrase v) ;
  QPredAdv np v = predBeGroupQ np (complAdverb v) ;

  QPredProgVP np vp = predBeGroupQ np (vp.s ! VIPresPart) ;


  RPredV np v = relVerbClause np v (complVerb v) ;
  RPredPassV np v = predBeGroupR np (passVerb v) ;
  RPredV2 np v x = relVerbClause np v (complTransVerb v x) ;
  RPredReflV2 np v = relVerbClause np v (reflTransVerb v) ;
  RPredV3 np v x y = relVerbClause np v (complDitransVerb v x y) ;
  RPredVS np v x = relVerbClause np v (complSentVerb v x) ;
  RPredVV np v x = relVerbClause np (aux2verb v) (complVerbVerb v x) ;
  RPredVQ np v x = relVerbClause np v (complQuestVerb v x) ;
  RPredVA np v x = relVerbClause np v (complAdjVerb v x) ;
  RPredV2A np v x y = relVerbClause np v (complDitransAdjVerb v x y) ;
  RPredSubjV2V np v x y = relVerbClause np v (complDitransVerbVerb False v x y) ;
  RPredObjV2V np v x y = relVerbClause np v (complDitransVerbVerb True v x y) ;
  RPredV2S np v x y = relVerbClause np v (complDitransSentVerb v x y) ;
  RPredV2Q np v x y = relVerbClause np v (complDitransQuestVerb v x y) ;

  RPredAP np v = predBeGroupR np v.s ;
  RPredCN np v = predBeGroupR np (complCommNoun v) ;
  RPredNP np v = predBeGroupR np (complNounPhrase v) ;
  RPredAdv np v = predBeGroupR np (complAdverb v) ;

  RPredProgVP np vp = predBeGroupR np (vp.s ! VIPresPart) ;

  IPredV v = predVerbI v (complVerb v) ;
  IPredPassV v = predVerbI v (passVerb v) ;
  IPredV2 v x = predVerbI v (complTransVerb v x) ;
  IPredReflV2 v = predVerbI v (reflTransVerb v) ;
  IPredV3 v x y = predVerbI v (complDitransVerb v x y) ;
  IPredVS v x = predVerbI v (complSentVerb v x) ;
  IPredVV v x = predVerbI (aux2verb v) (complVerbVerb v x) ;
  IPredVQ v x = predVerbI v (complQuestVerb v x) ;
  IPredVA v x = predVerbI v (complAdjVerb v x) ;
  IPredV2A v x y = predVerbI v (complDitransAdjVerb v x y) ;
  IPredSubjV2V v x y = predVerbI v (complDitransVerbVerb False v x y) ;
  IPredObjV2V v x y = predVerbI v (complDitransVerbVerb True v x y) ;
  IPredV2S v x y = predVerbI v (complDitransSentVerb v x y) ;
  IPredV2Q v x y = predVerbI v (complDitransQuestVerb v x y) ;

  IPredAP v = predBeGroupI v.s ;
  IPredCN v = predBeGroupI (complCommNoun v) ;
  IPredNP v = predBeGroupI (complNounPhrase v) ;
  IPredAdv v = predBeGroupI (complAdverb v) ;

  IPredProgVP vp = predBeGroupI (vp.s ! VIPresPart) ;

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