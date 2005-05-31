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

  IPredV a v = predVerbI True a v (complVerb v) ;
  IPredPassV a v = predVerbI True a v (passVerb v) ;
  IPredV2 a v x = predVerbI True a v (complTransVerb v x) ;
  IPredReflV2 a v = predVerbI True a v (reflTransVerb v) ;
  IPredV3 a v x y = predVerbI True a v (complDitransVerb v x y) ;
  IPredVS a v x = predVerbI True a v (complSentVerb v x) ;
  IPredVV a v x = predVerbI True a (aux2verb v) (complVerbVerb v x) ;
  IPredVQ a v x = predVerbI True a v (complQuestVerb v x) ;
  IPredVA a v x = predVerbI True a v (complAdjVerb v x) ;
  IPredV2A a v x y = predVerbI True a v (complDitransAdjVerb v x y) ;
  IPredSubjV2V a v x y = predVerbI True a v (complDitransVerbVerb False v x y) ;
  IPredObjV2V a v x y = predVerbI True a v (complDitransVerbVerb True v x y) ;
  IPredV2S a v x y = predVerbI True a v (complDitransSentVerb v x y) ;
  IPredV2Q a v x y = predVerbI True a v (complDitransQuestVerb v x y) ;

  IPredAP a v = predBeGroupI True a v.s ;
  IPredCN a v = predBeGroupI True a (complCommNoun v) ;
  IPredNP a v = predBeGroupI True a (complNounPhrase v) ;
  IPredAdv a v = predBeGroupI True a (complAdverb v) ;

  IPredProgVP a vp = predBeGroupI True a (vp.s ! VIPresPart) ;

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