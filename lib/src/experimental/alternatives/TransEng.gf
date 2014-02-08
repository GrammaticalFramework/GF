--# -path=.:../translator

concrete TransEng of Trans =
   RGLBaseEng - [Pol,Tense]
  ,PredEng
  ,DictionaryEng - [Pol,Tense]

              ** open ResEng, PredInstanceEng, Prelude, (Pr = PredEng) in {

flags 
  literal=Symb ;

oper
  liftV : ResEng.Verb -> Pr.PrV = \v -> lin PrV {s = v.s ; p = v.p ; c1,c2 = [] ; isSubjectControl = False ; vtype = VTAct ; vvtype = VVInf} ;

lin
  LiftV  v = liftV v ;
  LiftV2 v = liftV v ** {c1 = v.c2} ;
  LiftVS v = liftV v ;
  LiftVQ v = liftV v ;
  LiftVA v = liftV v ; ---- c1?
  LiftVN v = liftV v ; ---- c1?
  LiftVV v = {s = \\f => v.s ! VVF f ; p = v.p ; c1,c2 = [] ; isSubjectControl = False ; vtype = VTAct ; vvtype = VVInf} ; ---- c1? ---- VVF

  LiftV3  v = liftV v ** {c1 = v.c2 ; c2 = v.c3} ;
  LiftV2S v = liftV v ** {c1 = v.c2} ;
  LiftV2Q v = liftV v ** {c1 = v.c2} ;
  LiftV2V v = liftV v ** {c1 = v.c2 ; c2 = v.c3 ; isSubjectControl = False ; vvtype = v.typ} ; ---- subj control should be defined in V2V
  LiftV2A v = liftV v ** {c1 = v.c2} ;
  LiftV2N v = liftV v ** {c1 = v.c2} ;


  LiftAP ap = ap ** {c1,c2 = [] ; obj1 = \\_ => []} ;  --- isPre
  LiftCN cn = {s = \\n => cn.s ! n ! Nom ; c1,c2 = [] ; obj1 = \\_ => []} ; 

  LiftAdv  a = a ** {isAdV = False ; c1 = []} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = []} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p.s} ;


}
