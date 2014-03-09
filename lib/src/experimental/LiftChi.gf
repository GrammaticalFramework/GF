concrete LiftChi of Lift =
   RGLBaseChi - [Pol,Tense,Ant]
  ,PredChi

              ** open CommonScand, ResChi, PredInstanceChi, Prelude in {

--flags literal=Symb ;

oper
  liftV = PredInstanceChi.liftV ;

lin
  LiftV  v = liftV v ;
  LiftV2 v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2} ;
  LiftVS v = liftV v ;
  LiftVQ v = liftV v ;
  LiftVA v = liftV v ; ---- c1?
  LiftVN v = liftV v ; ---- c1?
  LiftVV v = liftV v ;

  LiftV3  v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2 ; c2 = v.c3} ;

  LiftV2S v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2} ;
  LiftV2Q v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2} ;
  LiftV2V v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2 ; c2 = v.c3} ;
  LiftV2A v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2} ;
  LiftV2N v = <liftV <v : Verb> : PrVerb> ** {c1 = v.c2} ;

  LiftAP ap = {s = \\a => ap.s ; c1,c2 = noComplCase ; obj1 = \\_ => []} ;  --- monosyl
  LiftA2 ap = {s = \\a => ap.s ; c1 = ap.c2 ; c2 = noComplCase ; obj1 = \\_ => []} ;  --- isPre

  LiftCN cn = {s = \\n => cn.s ; c1,c2 = noComplCase ; obj1 = \\_ => []} ; 
  LiftN2 cn = {s = \\n => cn.s ; c1 = cn.c2 ; c2 = noComplCase ; obj1 = \\_ => []} ; 

  AppAPCN ap cn = {s = ap.s ! UUnit ++ cn.s ; c = cn.c} ; ----

  LiftAdv  a = {advType = a.advType ; prepPre = a.s ; prepPost = []} ;
  LiftAdV  a = {advType = ATTime ; prepPre = a.s ; prepPost = []} ;  ---- the first adv place
  LiftPrep p = p ;

}

