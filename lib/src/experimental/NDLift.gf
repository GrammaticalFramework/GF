abstract NDLift =
   RGLBase - [Pol,Tense]
  ,NDPred

              ** {

fun
  LiftV  : V  -> PrV_none ;
  LiftV2 : V2 -> PrV_np ;
  LiftVS : VS -> PrV_s ;
  LiftVQ : VQ -> PrV_q ;
  LiftVV : VV -> PrV_v ;
  LiftVA : VA -> PrV_a ;
  LiftVN : VA -> PrV_n ; ----

  LiftV3  : V3  -> PrV_np_np ;
  LiftV2S : V2S -> PrV_np_s ;
  LiftV2Q : V2Q -> PrV_np_q ;
  LiftV2V : V2V -> PrV_np_v ;
  LiftV2A : V2A -> PrV_np_a ;
  LiftV2N : V2A -> PrV_np_n ; ----

  LiftAP  : AP  -> PrAP_none ;
  LiftA2  : A2  -> PrAP_np ;
  LiftCN  : CN  -> PrCN_none ;
  LiftN2  : N2  -> PrCN_np ;

  AppAPCN : PrAP_none -> CN -> CN ;

  LiftAdv  : Adv  -> PrAdv_none ;
  LiftAdV  : AdV  -> PrAdv_none ;
  LiftPrep : Prep -> PrAdv_np ;


}
