--# -path=.:../translator

concrete TransSwe of Trans =
   RGLBaseSwe - [Pol,Tense]
  ,PredSwe
  ,DictionarySwe - [Pol,Tense]

              ** open ResSwe, Prelude in {

flags 
  literal=Symb ;

lin
  LiftV  v = {v = v.s ; p = v.part ; c1,c2 = [] ; isSubjectControl = False ; isAux,isRefl = False} ; ---- vtype : VType
  LiftV2 v = {v = v.s ; p = v.part ; c1 = v.c2.s ; c2 = [] ; isSubjectControl = False ; isAux,isRefl = False} ; ---- vtype : VType
  LiftVS v = {v = v.s ; p = v.part ; c1,c2 = [] ; isSubjectControl = False ; isAux,isRefl = False} ; ---- vtype : VType

{-
  LiftAP ap = {s = \\_ => ap.s ! AgP3Sg Neutr ; c1,c2 = [] ; obj1 = \\_ => []} ;  --- agr, isPre
-}
  LiftAdv  a = a ** {isAdV = False ; c1 = []} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = []} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p.s} ;

{-
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
-}

}
