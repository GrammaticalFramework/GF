--# -path=.:../abstract:../../prelude

incomplete concrete ClauseI of Clause = open Rules, Verbphrase in {

  flags optimize=all ;

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

  IPredV a v = PosVP a (UseV v) ;
  IPredV2 a v x = PosVP a (ComplV2 v x) ;
  IPredPassV a v = PosVP a (UsePassV v) ;
  IPredV3 a v x y = PosVP a (ComplV3 v x y) ;
  IPredReflV2 a v = PosVP a (ComplReflV2 v) ;
  IPredVS a v x = PosVP a (ComplVS v x) ;
  IPredVV a v x = PosVP a (ComplVV v x) ;
  IPredVQ a v x = PosVP a (ComplVQ v x) ;
  IPredVA a v x = PosVP a (ComplVA v x) ;
  IPredV2A a v x y = PosVP a (ComplV2A v x y) ;
  IPredSubjV2V a v x y = PosVP a (ComplSubjV2V v x y) ;
  IPredObjV2V a v x y = PosVP a (ComplObjV2V v x y) ;
  IPredV2S a v x y = PosVP a (ComplV2S v x y) ;
  IPredV2Q a v x y = PosVP a (ComplV2Q v x y) ;

  IPredAP a v = PosVP a (PredAP v) ;
  IPredCN a v = PosVP a (PredCN v) ;
  IPredNP a v = PosVP a (PredNP v) ;
  IPredAdv a v = PosVP a (PredAdv v) ;

  IPredProgVP a vp = PosVP a (PredProgVP vp) ;

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