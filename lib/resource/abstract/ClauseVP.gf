--# -path=.:../abstract:../../prelude

abstract ClauseVP = Rules, Clause, Verbphrase ** {

 fun
  trCl  : Cl -> Cl ;
  trQCl : QCl -> QCl ;
  trRCl : RCl -> RCl ;
  trVCl : VCl -> VCl ;

 def
  trCl (SPredV np v) = PredVP np (UseV v) ;
  trCl (SPredPassV np v) = PredVP np (UsePassV v) ;
  trCl (SPredV2 np v x) = PredVP np (ComplV2 v x) ;
  trCl (SPredV3 np v x y) = PredVP np (ComplV3 v x y) ;
  trCl (SPredReflV2 np v) = PredVP np (ComplReflV2 v) ;
  trCl (SPredVS np v x) = PredVP np (ComplVS v x) ;
  trCl (SPredVV np v x) = PredVP np (ComplVV v x) ;
  trCl (SPredVQ np v x) = PredVP np (ComplVQ v x) ;
  trCl (SPredVA np v x) = PredVP np (ComplVA v x) ;
  trCl (SPredV2A np v x y) = PredVP np (ComplV2A v x y) ;
  trCl (SPredSubjV2V np v x y) = PredVP np (ComplSubjV2V v x y) ;
  trCl (SPredObjV2V np v x y) = PredVP np (ComplObjV2V v x y) ;
  trCl (SPredV2S np v x y) = PredVP np (ComplV2S v x y) ;
  trCl (SPredV2Q np v x y) = PredVP np (ComplV2Q v x y) ;

  trCl (SPredAP np v) = PredVP np (PredAP v) ;
  trCl (SPredCN np v) = PredVP np (PredCN v) ;
  trCl (SPredNP np v) = PredVP np (PredNP v) ;
  trCl (SPredAdv np v) = PredVP np (PredAdv v) ;

  trCl (SPredProgVP np vp) = PredVP np (PredProgVP vp) ;

  trQCl (QPredV np v) = IntVP np (UseV v) ;
  trQCl (QPredPassV np v) = IntVP np (UsePassV v) ;
  trQCl (QPredV2 np v x) = IntVP np (ComplV2 v x) ;
  trQCl (QPredV3 np v x y) = IntVP np (ComplV3 v x y) ;
  trQCl (QPredReflV2 np v) = IntVP np (ComplReflV2 v) ;
  trQCl (QPredVS np v x) = IntVP np (ComplVS v x) ;
  trQCl (QPredVV np v x) = IntVP np (ComplVV v x) ;
  trQCl (QPredVQ np v x) = IntVP np (ComplVQ v x) ;
  trQCl (QPredVA np v x) = IntVP np (ComplVA v x) ;
  trQCl (QPredV2A np v x y) = IntVP np (ComplV2A v x y) ;
  trQCl (QPredSubjV2V np v x y) = IntVP np (ComplSubjV2V v x y) ;
  trQCl (QPredObjV2V np v x y) = IntVP np (ComplObjV2V v x y) ;
  trQCl (QPredV2S np v x y) = IntVP np (ComplV2S v x y) ;
  trQCl (QPredV2Q np v x y) = IntVP np (ComplV2Q v x y) ;

  trQCl (QPredAP np v) = IntVP np (PredAP v) ;
  trQCl (QPredCN np v) = IntVP np (PredCN v) ;
  trQCl (QPredNP np v) = IntVP np (PredNP v) ;
  trQCl (QPredAdv np v) = IntVP np (PredAdv v) ;

  trQCl (QPredProgVP np vp) = IntVP np (PredProgVP vp) ;

  trRCl (RPredV np v) = RelVP np (UseV v) ;
  trRCl (RPredPassV np v) = RelVP np (UsePassV v) ;
  trRCl (RPredV2 np v x) = RelVP np (ComplV2 v x) ;
  trRCl (RPredV3 np v x y) = RelVP np (ComplV3 v x y) ;
  trRCl (RPredReflV2 np v) = RelVP np (ComplReflV2 v) ;
  trRCl (RPredVS np v x) = RelVP np (ComplVS v x) ;
  trRCl (RPredVV np v x) = RelVP np (ComplVV v x) ;
  trRCl (RPredVQ np v x) = RelVP np (ComplVQ v x) ;
  trRCl (RPredVA np v x) = RelVP np (ComplVA v x) ;
  trRCl (RPredV2A np v x y) = RelVP np (ComplV2A v x y) ;
  trRCl (RPredSubjV2V np v x y) = RelVP np (ComplSubjV2V v x y) ;
  trRCl (RPredObjV2V np v x y) = RelVP np (ComplObjV2V v x y) ;
  trRCl (RPredV2S np v x y) = RelVP np (ComplV2S v x y) ;
  trRCl (RPredV2Q np v x y) = RelVP np (ComplV2Q v x y) ;

  trRCl (RPredAP np v) = RelVP np (PredAP v) ;
  trRCl (RPredCN np v) = RelVP np (PredCN v) ;
  trRCl (RPredNP np v) = RelVP np (PredNP v) ;
  trRCl (RPredAdv np v) = RelVP np (PredAdv v) ;

  trRCl (RPredProgVP np vp) = RelVP np (PredProgVP vp) ;

  trVCl (IPredV v) = UseVP (UseV v) ;
  trVCl (IPredV2 v x) = UseVP (ComplV2 v x) ;
  trVCl (IPredPassV v) = UseVP (UsePassV v) ;
  trVCl (IPredV3 v x y) = UseVP (ComplV3 v x y) ;
  trVCl (IPredReflV2 v) = UseVP (ComplReflV2 v) ;
  trVCl (IPredVS v x) = UseVP (ComplVS v x) ;
  trVCl (IPredVV v x) = UseVP (ComplVV v x) ;
  trVCl (IPredVQ v x) = UseVP (ComplVQ v x) ;
  trVCl (IPredVA v x) = UseVP (ComplVA v x) ;
  trVCl (IPredV2A v x y) = UseVP (ComplV2A v x y) ;
  trVCl (IPredSubjV2V v x y) = UseVP (ComplSubjV2V v x y) ;
  trVCl (IPredObjV2V v x y) = UseVP (ComplObjV2V v x y) ;
  trVCl (IPredV2S v x y) = UseVP (ComplV2S v x y) ;
  trVCl (IPredV2Q v x y) = UseVP (ComplV2Q v x y) ;

  trVCl (IPredAP v) = UseVP (PredAP v) ;
  trVCl (IPredCN v) = UseVP (PredCN v) ;
  trVCl (IPredNP v) = UseVP (PredNP v) ;
  trVCl (IPredAdv v) = UseVP (PredAdv v) ;

  trVCl (IPredProgVP vp) = UseVP (PredProgVP vp) ;

{-
-- Use VPs

  trRCl (IntVP) = intVerbPhrase ;
  trRCl (RelVP) = relVerbPhrase ;


  trRCl (PosVP tp) = predVerbGroup True tp.a ;
  trRCl (NegVP tp) = predVerbGroup False tp.a ;

  trRCl (AdvVP) = adVerbPhrase ;
  trRCl (SubjVP) = subjunctVerbPhrase ;
-}

}