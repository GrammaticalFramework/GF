--# -path=.:../translator

concrete NDTransSwe of NDTrans =
   RGLBaseSwe - [Pol,Tense]
  ,NDPredSwe
  ,DictionarySwe - [Pol,Tense]

              ** open CommonScand, ResSwe, PredInstanceSwe, (Pr=PredSwe), Prelude in {

flags 
  literal=Symb ;

oper
  vliftV : Verb -> PrV = \v -> lin PrV (PredInstanceSwe.liftV v) ;
  PrV = Pr.PrV ;

lin
  LiftV  v = vliftV v ;
  LiftV2 v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;
  LiftVS v = vliftV v ;
  LiftVQ v = vliftV v ;
  LiftVA v = vliftV v ; ---- c1?
  LiftVN v = vliftV v ; ---- c1?
  LiftVV v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;

  LiftV3  v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s ; c2 = v.c3.s} ;

  LiftV2S v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;
  LiftV2Q v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;
  LiftV2V v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s ; c2 = v.c3.s} ;
  LiftV2A v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;
  LiftV2N v = <vliftV <v : Verb> : PrV> ** {c1 = v.c2.s} ;

  LiftAP ap = lin PrAP {s = \\a => ap.s ! agr2aformpos a ; c1,c2 = [] ; obj1 = \\_ => []} ;  --- isPre
  LiftCN cn = lin PrCN {s = \\n => cn.s ! n ! DIndef ! Nom ; c1,c2 = [] ; obj1 = \\_ => []} ; 

  LiftAdv  a = lin PrAdv (a ** {isAdV = False ; c1 = []}) ;
  LiftAdV  a = lin PrAdv (a ** {isAdV = True ; c1 = []}) ;
  LiftPrep p = lin PrAdv ({s = [] ; isAdV = False ; c1 = p.s}) ;

}

