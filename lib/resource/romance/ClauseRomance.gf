--# -path=.:../abstract:../../prelude

incomplete concrete ClauseRomance of Clause = CategoriesRomance ** 
  open Prelude, SyntaxRomance in {

  flags optimize=all ; --- parametrize much worse, 15/2

  lin
  SPredV  np v   = 
    sats2clause (mkSats np v) ;
  SPredPassV subj v = 
    sats2clause (mkSatsCopula subj (v.s ! VPart (pgen2gen subj.g) subj.n)) ;
  SPredV2 np v y = 
    sats2clause (mkSatsObject np v y) ;
  SPredV3 subj verb obj1 obj2 = 
    sats2clause (insertObject (mkSatsObject subj verb obj1) verb.c3 verb.s3 obj2) ;

  SPredReflV2 subj verb = 
    sats2clause (
      mkSatsObject subj
        {s = verb.s ; s2 = [] ; c = accusative ; aux = AEsse}
        ---- {s = verb.s ; s2 = verb.s2 ; c = verb.c ; aux = AEsse}
        ---- this produces huge cf - find out why! AR 16/3/2005 
        (reflPronNounPhrase (pgen2gen subj.g) subj.n subj.p)) ;

  SPredVS subj verb sent = 
    sats2clause (
      insertExtrapos (mkSats subj verb) (embedConj ++ sent.s ! verb.mp)) ; ---- mn
  SPredVQ subj verb quest = 
    sats2clause (
      insertExtrapos (mkSats subj verb) (quest.s ! IndirQ)) ;
  SPredV2S subj verb obj sent = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj)
        (embedConj ++ sent.s ! verb.mp)) ; ---- mn ;
  SPredV2Q subj verb obj quest = 
    sats2clause (
      insertExtrapos 
        (mkSatsObject subj verb obj) 
        (quest.s ! IndirQ)) ;
  SPredAP subj adj = 
    sats2clause (mkSatsCopula subj (adj.s ! AF (pgen2gen subj.g) subj.n)) ;
  SPredCN subj cn = 
    sats2clause (mkSatsCopula subj (indefNoun subj.n cn)) ;
  SPredNP subj np = 
    sats2clause (mkSatsCopula subj (np.s ! stressed nominative)) ;
  SPredAdv subj adv = 
    sats2clause (mkSatsCopula subj adv.s) ;

{-

  SPredVA np v x = predVerbClause np v (complAdjVerb v x) ;
  SPredV2A np v x y = predVerbClause np v (complDitransAdjVerb v x y) ;
  SPredSubjV2V np v x y = predVerbClause np v (complDitransVerbVerb False v x y) ;
  SPredObjV2V np v x y = predVerbClause np v (complDitransVerbVerb True v x y) ;
--  SPredV2S np v x y = predVerbClause np v (complDitransSentVerb v x y) ;
--  SPredV2Q np v x y = predVerbClause np v (complDitransQuestVerb v x y) ;
  SPredAP np v = predCopula np (complAdjective v) ;
  SPredSuperl np a = predCopula np (complAdjective (superlAdjPhrase a)) ;
  SPredCN np v = predCopula np (complCommNoun v) ;
  SPredNP np v = predCopula np (complNounPhrase v) ;
  SPredPP np v = predCopula np (complAdverb v) ;
  SPredAV np v x = predCopula np (complVerbAdj v x) ;

  SPredObjA2V np v x y = predCopula np (complVerbAdj2 True v x y) ;

  SPredProgVP = progressiveClause ;

  QPredV np v = intVerbClause np v (complVerb v) ;
  QPredPassV np v = predCopulaQ np (passVerb v) ;
  QPredV2 np v x = intVerbClause np v (complTransVerb v x) ;
--  QPredReflV2 np v = intVerbClause np v (reflTransVerb v) ;
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

  QPredAP np v = predCopulaQ np (complAdjective v) ;
  QPredSuperl np a = predCopulaQ np (complAdjective (superlAdjPhrase a)) ;
  QPredCN np v = predCopulaQ np (complCommNoun v) ;
  QPredNP np v = predCopulaQ np (complNounPhrase v) ;
  QPredPP np v = predCopulaQ np (complAdverb v) ;
  QPredAV np v x = predCopulaQ np (complVerbAdj v x) ;
  QPredObjA2V np v x y = predCopulaQ np (complVerbAdj2 True v x y) ;

  IPredV a v = predVerbI True a v (complVerb v) ;
  IPredV2 a v x = predVerbI True a v (complTransVerb v x) ;

  IPredAP a v = predCopulaI True a (complAdjective v) ;
-}
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



{-
  lin
  SPredV np v = predVerbGroupClause np (predVerb v) ;
  SPredPassV np v = predVerbGroupClause np (passVerb v) ;
  SPredV2 np v x = predVerbGroupClause np (complTransVerb v x) ;
--  SPredReflV2 np v = predVerbGroupClause np (reflTransVerb v) ;
  SPredVS np v x = predVerbGroupClause np (complSentVerb v x) ;
--  SPredVV np v x = predVerbGroupClause np (complVerbVerb v x) ;
--  SPredVQ np v x = predVerbGroupClause np (complQuestVerb v x) ;
--  SPredVA np v x = predVerbGroupClause np (complAdjVerb v x) ;
--  SPredV2A np v x y = predVerbGroupClause np (complDitransAdjVerb v x y) ;
--  SPredSubjV2V np v x y = predVerbGroupClause np (complDitransVerbVerb False v x y) ;
--  SPredObjV2V np v x y = predVerbGroupClause np (complDitransVerbVerb True v x y) ;
--  SPredV2S np v x y = predVerbGroupClause np (complDitransSentVerb v x y) ;
--  SPredV2Q np v x y = predVerbGroupClause np (complDitransQuestVerb v x y) ;

  SPredAP np v = predVerbGroupClause np (predAdjective v) ;
  SPredSuperl np a = predVerbGroupClause np (predAdjective (superlAdjPhrase a)) ;
  SPredCN np v = predVerbGroupClause np (predCommNoun v) ;
  SPredNP np v = predVerbGroupClause np (predNounPhrase v) ;
  SPredPP np v = predVerbGroupClause np (predAdverb v) ;
--  SPredAV np v x = predVerbGroupClause np (complVerbAdj v x) ;
--  SPredObjA2V np v x y = predVerbGroupClause np (complVerbAdj2 True v x y) ;
-}
--  SPredProgVP = progressiveClause ;

{-
  QPredV np v = intVerbPhrase np (predVerb v) ;
  QPredPassV np v = intVerbPhrase np (passVerb v) ;
  QPredV2 np v x = intVerbPhrase np (complTransVerb v x) ;
--  QPredReflV2 np v = intVerbPhrase np (reflTransVerb v) ;
  QPredVS np v x = intVerbPhrase np (complSentVerb v x) ;
  QPredVV np v x = intVerbPhrase np (complVerbVerb v x) ;
--  QPredVQ np v x = intVerbPhrase np (complQuestVerb v x) ;
--  QPredVA np v x = intVerbPhrase np (complAdjVerb v x) ;
--  QPredV2A np v x y = intVerbPhrase np (complDitransAdjVerb v x y) ;
--  QPredSubjV2V np v x y = intVerbPhrase np (complDitransVerbVerb False v x y) ;
--  QPredObjV2V np v x y = intVerbPhrase np (complDitransVerbVerb True v x y) ;
--  QPredV2S np v x y = intVerbPhrase np (complDitransSentVerb v x y) ;
--  QPredV2Q np v x y = intVerbPhrase np (complDitransQuestVerb v x y) ;

  QPredAP np v = intVerbPhrase np (predAdjective v) ;
  QPredSuperl np a = intVerbPhrase np (predAdjective (superlAdjPhrase a)) ;
  QPredCN np v = intVerbPhrase np (predCommNoun v) ;
  QPredNP np v = intVerbPhrase np (predNounPhrase v) ;
  QPredPP np v = intVerbPhrase np (predAdverb v) ;
--  QPredAV np v x = intVerbPhrase np (complVerbAdj v x) ;
--  QPredObjA2V np v x y = intVerbPhrase np (complVerbAdj2 True v x y) ;
-}
--  IPredV a v = predVerbGroupI True a (predVerb v) ;
--  IPredV2 a v x = predVerbGroupI True a (complTransVerb v x) ;
--  IPredAP a v = predVerbGroupI True a (predAdjective v) ;

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
