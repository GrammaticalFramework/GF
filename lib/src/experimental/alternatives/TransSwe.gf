--# -path=.:../translator

concrete TransSwe of Trans =
   RGLBaseSwe - [Pol,Tense]
  ,PredSwe
  ,DictionarySwe - [Pol,Tense]

              ** open CommonScand, ResSwe, PredInstanceSwe, Prelude in {

flags 
  literal=Symb ;

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
  LiftCN cn = {s = \\n => cn.s ! n ! DIndef ! Nom ; c1,c2 = [] ; obj1 = \\_ => []} ; 

  LiftAdv  a = a ** {isAdV = False ; c1 = []} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = []} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p.s} ;

}

