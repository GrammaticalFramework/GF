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

  QPredAP np v = predBeGroupQ np v.s ;
  QPredCN np v = predBeGroupQ np (complCommNoun v) ;
  QPredNP np v = predBeGroupQ np (complNounPhrase v) ;
  QPredAdv np v = predBeGroupQ np (complAdverb v) ;

  IPredV a v = predVerbI True a v (complVerb v) ;
  IPredV2 a v x = predVerbI True a v (complTransVerb v x) ;

  IPredAP a v = predBeGroupI True a v.s ;

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