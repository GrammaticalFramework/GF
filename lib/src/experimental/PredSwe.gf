concrete PredSwe of Pred = 
  CatSwe [Ant,NP,Utt,IP,IAdv,IComp,Conj,RP,RS,Imp,Subj] ** 
    PredFunctor - [RelVP,RelSlash]  ---- incompatible arity: to be fixed in RGL
    with 
      (PredInterface = PredInstanceSwe) 

** open ResSwe, CommonScand in {

lin
  RelVP rp vp = 
    let 
      cl : Agr -> RCase -> PrClause = \a,c -> 
        let rpa = rpagr2agr rp.a a in
        
        vp ** {
        v    = applyVerb vp (agr2vagr rpa) ;
        subj = rp.s ! a.g ! a.n ! subjRPCase a ;
        adj  = vp.adj ! rpa ;
        obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! rpa ;  ---- apply complCase ---- place of part depends on obj
        obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => rpa ; False => vp.obj1.p2}) ;   ---- apply complCase
        c3   = noComplCase ;      -- for one more prep to build ClSlash 
        }
    in {s = \\a,c => declCl (cl a c) ; c = subjCase} ;

  RelSlash rp cl = {
    s = \\a,c => rp.s ! a.g ! a.n ! subjRPCase (rpagr2agr rp.a a) ++ declCl cl ; ---- rp case 
    c = objCase
    } ;

  NomVPNP vpi = {
    s = \\c => "att" ++ vpi.s ! vvInfinitive ! defaultAgr ;
    a = defaultAgr ** {g = Neutr} ;
    } ;

  ByVP x vp vpi = vp ** {adv = "genom att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr
  WhenVP x vp vpi = vp ** {adv = "vid att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr ----
  BeforeVP x vp vpi = vp ** {adv = "innan att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr ----
  AfterVP x vp vpi = vp ** {adv = "efter att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr
  InOrderVP x vp vpi = vp ** {adv = "för att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr
  WithoutVP x vp vpi = vp ** {adv = "utan att" ++ vpi.s ! vvInfinitive ! defaultAgr} ; ---- agr

}
