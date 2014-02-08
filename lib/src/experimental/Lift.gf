abstract Lift =
   RGLBase - [Pol,Tense]
  ,Pred
              ** {
fun
  LiftV  : V  -> PrV aNone ;
  LiftV2 : V2 -> PrV (aNP aNone) ;
  LiftVS : VS -> PrV aS ;
  LiftVQ : VQ -> PrV aQ ;
  LiftVV : VV -> PrV aV ;
  LiftVA : VA -> PrV aA ;
  LiftVN : VA -> PrV aN ; ----

  LiftV3  : V3  -> PrV (aNP (aNP aNone)) ;
  LiftV2S : V2S -> PrV (aNP aS) ;
  LiftV2Q : V2Q -> PrV (aNP aQ) ;
  LiftV2V : V2V -> PrV (aNP aV) ;
  LiftV2A : V2A -> PrV (aNP aA) ;
  LiftV2N : V2A -> PrV (aNP aN) ; ----

  LiftAP  : AP  -> PrAP aNone ;
  LiftA2  : A2  -> PrAP (aNP aNone) ;
  LiftCN  : CN  -> PrCN aNone ;
  LiftN2  : N2  -> PrCN (aNP aNone) ;

  AppAPCN : PrAP aNone -> CN -> CN ;

  LiftAdv  : Adv  -> PrAdv aNone ;
  LiftAdV  : AdV  -> PrAdv aNone ;
  LiftPrep : Prep -> PrAdv (aNP aNone) ;

}
