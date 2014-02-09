concrete LiftFin of Lift =
   RGLBaseFin - [Pol,Tense]
  ,PredFin

              ** open ResFin, 
                      StemFin,
                      PredInstanceFin, 
                      Prelude in {

--flags literal=Symb ;

oper
  vliftV : SVerb1 -> PrVerb = PredInstanceFin.liftV ;

lin
  LiftV  v = vliftV v ;
  LiftV2 v = vliftV v ** {c1 = v.c2} ;
  LiftVS v = vliftV v ;
  LiftVQ v = vliftV v ;
  LiftVA v = vliftV v ** {c1 = v.c2} ;
  LiftVN v = vliftV v ** {c1 = v.c2} ;
  LiftVV v = vliftV v ** {vvType = v.vi} ;

  LiftV3  v = vliftV v ** {c1 = v.c2 ; c2 = v.c3} ;

  LiftV2S v = vliftV v ** {c1 = v.c2} ;
  LiftV2Q v = vliftV v ** {c1 = v.c2} ;
  LiftV2V v = vliftV v ** {c1 = v.c2 ; vvType = v.vi} ;
  LiftV2A v = vliftV v ** {c1 = v.c2 ; c2 = v.c3} ;
  LiftV2N v = vliftV v ** {c1 = v.c2 ; c2 = v.c3} ;
{-
  LiftAP ap = {s = \\a => ap.s ! agr2aformpos a ; c1,c2 = [] ; obj1 = \\_ => []} ;  --- isPre
  LiftA2 ap = {s = \\a => ap.s ! AF (APosit (agr2aformpos a)) Nom ; c1 = ap.c2.s ; c2 = [] ; obj1 = \\_ => []} ;  --- isPre

  LiftCN cn = {s = \\n => cn.s ! n ! DIndef ! Nom ; c1,c2 = [] ; obj1 = \\_ => []} ; 
  LiftN2 cn = {s = \\n => cn.s ! n ! specDet DIndef ! Nom ; c1 = cn.c2.s ; c2 = [] ; obj1 = \\_ => []} ; 

  AppAPCN ap cn = 
    {s = \\n,d,c => 
         let 
            agr = {n = n ; g = cn.g ; p = P3}
         in (cn.s ! n ! d ! c) ++ (ap.s ! agr ++ ap.obj1 ! agr) ;  -- flicka älskad av alla
         g = cn.g ; 
         isMod = True
    } 
  | {s = \\n,d,c => 
         let 
            agr = {n = n ; g = cn.g ; p = P3}
         in (ap.obj1 ! agr ++ ap.s ! agr) ++ (cn.s ! n ! d ! c) ;  -- av alla älskad flicka
         g = cn.g ; 
         isMod = True
    } ; 

  LiftAdv  a = a ** {isAdV = False ; c1 = []} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = []} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p.s} ;
-}

}

