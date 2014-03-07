concrete LiftEng of Lift =
   RGLBaseEng - [Pol,Tense]
  ,PredEng

              ** open ResEng, PredInstanceEng, Prelude, (Pr = PredEng) in {

--flags literal=Symb ;

oper
  liftV : ResEng.Verb -> Pr.PrV = \v -> lin PrV {
    s = table {VVF f => v.s ! f ; VVPresNeg | VVPastNeg => v.s ! VInf} ;  ---- only used for Aux  
    p = v.p ; 
    c1,c2 = [] ; isSubjectControl = True ; vtype = VTAct ; vvtype = VVInf
    } ;

lin
  LiftV  v = liftV v ;
  LiftV2 v = liftV v ** {c1 = v.c2} ;
  LiftVS v = liftV v ;
  LiftVQ v = liftV v ;
  LiftVA v = liftV v ; ---- c1?
  LiftVN v = liftV v ; ---- c1?
  LiftVV v = {s = v.s ; p = v.p ; c1,c2 = [] ; isSubjectControl = True ; 
              vtype = case v.typ of {VVAux => VTAux ; _ => VTAct} ; vvtype = v.typ} ; ---- c1? ---- VVF

  LiftV3  v = liftV v ** {c1 = v.c2 ; c2 = v.c3} ;
  LiftV2S v = liftV v ** {c1 = v.c2} ;
  LiftV2Q v = liftV v ** {c1 = v.c2} ;
  LiftV2V v = liftV v ** {c1 = v.c2 ; c2 = v.c3 ; isSubjectControl = False ; vvtype = v.typ} ; ---- subj control should be defined in V2V
  LiftV2A v = liftV v ** {c1 = v.c2} ;
  LiftV2N v = liftV v ** {c1 = v.c2} ;


  LiftAP ap = {s = \\a => ap.s ! a ; c1,c2 = [] ; obj1 = \\_ => []} ;  --- isPre
  LiftA2 a  = {s = \\_ => a.s ! AAdj Posit Nom ; c1 = a.c2 ; c2 = [] ; obj1 = \\_ => []} ;  --- isPre
  LiftCN cn = {s = \\n => cn.s ! n ! Nom ; c1,c2 = [] ; obj1 = \\_ => []} ; 
  LiftN2 cn = {s = \\n => cn.s ! n ! Nom ; c1 = cn.c2 ; c2 = [] ; obj1 = \\_ => []} ; 

  AppAPCN ap cn = {s = \\n,c => cn.s ! n ! c ++ ap.s ! agrgP3 n cn.g ++ ap.obj1 ! agrgP3 n cn.g ; g = cn.g}
                | {s = \\n,c => ap.s ! agrgP3 n cn.g ++ ap.obj1 ! agrgP3 n cn.g ++ cn.s ! n ! c ; g = cn.g} ; ---- isPre

  LiftAdv  a = a ** {isAdV = False ; c1 = []} ;
  LiftAdV  a = a ** {isAdV = True ; c1 = []} ;
  LiftPrep p = {s = [] ; isAdV = False ; c1 = p.s} ;

}
