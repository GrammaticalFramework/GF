concrete LiftSwe of Lift =
   RGLBaseSwe - [Pol,Tense]
  ,PredSwe

              ** open CommonScand, ResSwe, PredInstanceSwe, Prelude in {

--flags literal=Symb ;

oper
  liftV = PredInstanceSwe.liftV ;

lin
  LiftV  v = liftV v ;
  LiftV2 v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;
  LiftVS v = liftV v ;
  LiftVQ v = liftV v ;
  LiftVA v = liftV v ; ---- c1?
  LiftVN v = liftV v ; ---- c1?
  LiftVV v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;

  LiftV3  v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s ; c2 = v.c3.s} ;

  LiftV2S v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;
  LiftV2Q v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;
  LiftV2V v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s ; c2 = v.c3.s} ;
  LiftV2A v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;
  LiftV2N v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2.s} ;

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

}

