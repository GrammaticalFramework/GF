concrete LiftFin of Lift =
   RGLBaseFin - [Pol,Tense]
  ,PredFin
              ** open ResFin, 
                      StemFin,
                      PredInstanceFin,
                      Prelude in {

--flags literal=Symb ;

lin
  LiftV  v = liftV v ;
  LiftV2 v = liftV v ** {c1 = v.c2} ;
  LiftVS v = liftV v ;
  LiftVQ v = liftV v ;
  LiftVA v = liftV v ** {c1 = v.c2} ;
  LiftVN v = liftV v ** {c1 = v.c2} ;
  LiftVV v = liftV v ** {vvtype = v.vi} ;

  LiftV3  v = liftV v ** {c1 = v.c2 ; c2 = v.c3} ;

  LiftV2S v = liftV v ** {c1 = v.c2} ;
  LiftV2Q v = liftV v ** {c1 = v.c2} ;
  LiftV2V v = liftV v ** {c1 = v.c2 ; vvtype = v.vi} ;
  LiftV2A v = liftV v ** {c1 = v.c2 ; c2 = v.c3} ;
  LiftV2N v = liftV v ** {c1 = v.c2 ; c2 = v.c3} ;

  LiftAP ap = {s = \\a => ap.s ! False ! NCase (complNumAgr a) Nom ; c1,c2 = noComplCase ; obj1 = \\_ => []} ;  --- Part in Pl
----  LiftA2 ap = {s = \\a => ap.s ! AF (APosit (agr2aformpos a)) Nom ; c1 = ap.c2.s ; c2 = noComplCase ; obj1 = \\_ => []} ;  --- isPre

  LiftCN cn = {s = \\n => cn.s ! NCase n Nom ; c1,c2 = noComplCase ; obj1 = \\_ => []} ; 
----  LiftN2 cn = {s = \\n => cn.s ! n ! specDet DIndef ! Nom ; c1 = cn.c2.s ; c2 = [] ; obj1 = \\_ => []} ; 

  LiftA2,LiftN2,AppAPCN = variants {} ; ---- for functor use
{-
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
-}
  LiftAdv  a = a ** {isAdV = False ; c1 = noComplCase} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = noComplCase} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p} ;
}

