--# -path=.:../abstract:../../prelude

incomplete concrete ClauseI of Clause = open Rules, Verbphrase in {

  flags optimize=all ;

  lin

  SPredV np v = PredVP np (UseV v) ;
  SPredPassV np v = PredVP np (UsePassV v) ;
  SPredV2 np v x = PredVP np (ComplV2 v x) ;
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
  SPredSuperl np a = PredVP np (PredSuperl a) ;
  SPredCN np v = PredVP np (PredCN v) ;
  SPredNP np v = PredVP np (PredNP v) ;
  SPredPP np v = PredVP np (PredPP v) ;
  SPredAV np v x = PredVP np (PredAV v x) ;
  SPredObjA2V np v x y = PredVP np (PredObjA2V v x y) ;

  SPredProgVP np vp = PredVP np (PredProgVP vp) ;

  QPredV np v = IntVP np (UseV v) ;
  QPredPassV np v = IntVP np (UsePassV v) ;
  QPredV2 np v x = IntVP np (ComplV2 v x) ;
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
  QPredSuperl np a = IntVP np (PredSuperl a) ;
  QPredCN np v = IntVP np (PredCN v) ;
  QPredNP np v = IntVP np (PredNP v) ;
  QPredPP np v = IntVP np (PredPP v) ;
  QPredAV np v x = IntVP np (PredAV v x) ;
  QPredObjA2V np v x y = IntVP np (PredObjA2V v x y) ;

  IPredV a v = PosVP a (UseV v) ;
  IPredV2 a v x = PosVP a (ComplV2 v x) ;
  IPredAP a v = PosVP a (PredAP v) ;

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