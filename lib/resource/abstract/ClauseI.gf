--# -path=.:../abstract:../../prelude

incomplete concrete ClauseI of Clause = open Rules, Verbphrase in {

  flags optimize=all_subs ;

  lin

  SPredV np v = PredVP np (UseV v) ;
  SPredPassV np v = PredVP np (UsePassV v) ;
  SPredV2 np v x = PredVP np (ComplV2 v x) ;
  SPredV3 np v x y = PredVP np (ComplV3 v x y) ;
  SPredReflV2 np v = PredVP np (ComplReflV2 v) ;
  SPredVS np v x = PredVP np (ComplVS v x) ;
  SPredVV np v x = PredVP np (ComplVV v x) ;
  SPredVQ np v x = PredVP np (ComplVQ v x) ;
  SPredVA np v x = PredVP np (ComplVA v x) ;
  SPredV2A np v x y = PredVP np (ComplV2A v x y) ;
  SPredSubjV2V np v x y = PredVP np (ComplSubjV2V v x y) ;
  SPredObjV2V np v x y = PredVP np (ComplObjV2V v x y) ;
  SPredV2S np v x y = PredVP np (ComplV2S v x y) ;
  SPredV2Q np v x y = PredVP np (ComplV2Q v x y) ;

  SPredAP np v = PredVP np (PredAP v) ;
  SPredCN np v = PredVP np (PredCN v) ;
  SPredNP np v = PredVP np (PredNP v) ;
  SPredAdv np v = PredVP np (PredAdv v) ;

  SPredProgVP np vp = PredVP np (PredProgVP vp) ;

  QPredV np v = IntVP np (UseV v) ;
  QPredPassV np v = IntVP np (UsePassV v) ;
  QPredV2 np v x = IntVP np (ComplV2 v x) ;
  QPredV3 np v x y = IntVP np (ComplV3 v x y) ;
  QPredReflV2 np v = IntVP np (ComplReflV2 v) ;
  QPredVS np v x = IntVP np (ComplVS v x) ;
  QPredVV np v x = IntVP np (ComplVV v x) ;
  QPredVQ np v x = IntVP np (ComplVQ v x) ;
  QPredVA np v x = IntVP np (ComplVA v x) ;
  QPredV2A np v x y = IntVP np (ComplV2A v x y) ;
  QPredSubjV2V np v x y = IntVP np (ComplSubjV2V v x y) ;
  QPredObjV2V np v x y = IntVP np (ComplObjV2V v x y) ;
  QPredV2S np v x y = IntVP np (ComplV2S v x y) ;
  QPredV2Q np v x y = IntVP np (ComplV2Q v x y) ;

  QPredAP np v = IntVP np (PredAP v) ;
  QPredCN np v = IntVP np (PredCN v) ;
  QPredNP np v = IntVP np (PredNP v) ;
  QPredAdv np v = IntVP np (PredAdv v) ;

  QPredProgVP np vp = IntVP np (PredProgVP vp) ;

  RPredV np v = RelVP np (UseV v) ;
  RPredPassV np v = RelVP np (UsePassV v) ;
  RPredV2 np v x = RelVP np (ComplV2 v x) ;
  RPredV3 np v x y = RelVP np (ComplV3 v x y) ;
  RPredReflV2 np v = RelVP np (ComplReflV2 v) ;
  RPredVS np v x = RelVP np (ComplVS v x) ;
  RPredVV np v x = RelVP np (ComplVV v x) ;
  RPredVQ np v x = RelVP np (ComplVQ v x) ;
  RPredVA np v x = RelVP np (ComplVA v x) ;
  RPredV2A np v x y = RelVP np (ComplV2A v x y) ;
  RPredSubjV2V np v x y = RelVP np (ComplSubjV2V v x y) ;
  RPredObjV2V np v x y = RelVP np (ComplObjV2V v x y) ;
  RPredV2S np v x y = RelVP np (ComplV2S v x y) ;
  RPredV2Q np v x y = RelVP np (ComplV2Q v x y) ;

  RPredAP np v = RelVP np (PredAP v) ;
  RPredCN np v = RelVP np (PredCN v) ;
  RPredNP np v = RelVP np (PredNP v) ;
  RPredAdv np v = RelVP np (PredAdv v) ;

  RPredProgVP np vp = RelVP np (PredProgVP vp) ;

  IPredV v = UseVP (UseV v) ;
  IPredV2 v x = UseVP (ComplV2 v x) ;
  IPredPassV v = UseVP (UsePassV v) ;
  IPredV3 v x y = UseVP (ComplV3 v x y) ;
  IPredReflV2 v = UseVP (ComplReflV2 v) ;
  IPredVS v x = UseVP (ComplVS v x) ;
  IPredVV v x = UseVP (ComplVV v x) ;
  IPredVQ v x = UseVP (ComplVQ v x) ;
  IPredVA v x = UseVP (ComplVA v x) ;
  IPredV2A v x y = UseVP (ComplV2A v x y) ;
  IPredSubjV2V v x y = UseVP (ComplSubjV2V v x y) ;
  IPredObjV2V v x y = UseVP (ComplObjV2V v x y) ;
  IPredV2S v x y = UseVP (ComplV2S v x y) ;
  IPredV2Q v x y = UseVP (ComplV2Q v x y) ;

  IPredAP v = UseVP (PredAP v) ;
  IPredCN v = UseVP (PredCN v) ;
  IPredNP v = UseVP (PredNP v) ;
  IPredAdv v = UseVP (PredAdv v) ;

  IPredProgVP vp = UseVP (PredProgVP vp) ;

{-
-- Use VPs

  IntVP = intVerbPhrase ;
  RelVP = relVerbPhrase ;


  PosVP tp = predVerbGroup True tp.a ;
  NegVP tp = predVerbGroup False tp.a ;

  AdvVP = adVerbPhrase ;
  SubjVP = subjunctVerbPhrase ;
-}

}