concrete PredChi of Pred = 
  CatChi [NP,Utt,IP,IAdv,IComp,Conj,RP,RS,Imp,Subj] ** 
    PredFunctor - [UseNP,ComplV2,SlashV3,ContVPC, StartVPC, StartClC,
                   RelVP, RelSlash, QuestVP, QuestSlash, QuestIComp,PredVP,
                   SubjUttPreS, SubjUttPreQ, SubjUttPost]
    with 
      (PredInterface = PredInstanceChi) ** open ResChi, (P = ParadigmsChi), TenseX in {

lincat 
  Ant = {s : Str ; a : Anteriority} ;

lin
  UseNP a t p np = useCopula a t p ** {
    adj = \\a => np.s
    } ;

  ComplV2 x vp np = vp ** {
    obj1 : (Agr => Str) * Agr = <\\a => appObjCase np, UUnit>
    } ;

  SlashV3 x vp np = addObj2VP vp (\\a => np.s) ;

  RelVP rp vp = 
    let 
      rpa = UUnit ;
      cl : PrClause = vp ** {
        v    = applyVerb vp (agr2vagr rpa) ;
        subj = rp.s ;
        adj  = vp.adj ! rpa ;
        obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! rpa ;  ---- apply complCase ---- place of part depends on obj
        obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => rpa ; False => vp.obj1.p2}) ;   ---- apply complCase
        c3   = noComplCase ;      -- for one more prep to build ClSlash 
        }
    in {s = declCl cl ; c = subjCase} ;

  RelSlash rp cl = {
    s = rp.s ++ declCl cl ; ---- rp case 
    c = objCase
    } ;

  PredVP x np vp = 
    let npa = UUnit in
    vp ** {
    v    = applyVerb vp (agr2vagr npa) ;
    subj = appSubjCase np ;
    adj  = vp.adj ! npa ;
    obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! npa ;  ---- apply complCase ---- place of part depends on obj
    obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! npa ;
    c3   = vp.c1 ; -- in case there is any free slot left ---- could be c2 
    } ;

  StartVPC x c v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          let 
            vv = v.v ! a ; 
            wv = w.v ! a ;
            vpa = vagr2agr a ;
          in 
          vv.p1 ++ v.adV ++ vv.p2 ++ vv.p3 ++ v.adj ! vpa ++ 
          appPrep v.c1 (v.obj1.p1 ! vpa) ++ appPrep v.c2 (v.obj2.p1 ! vpa) ++ v.adv ++ v.ext
            ++ (c.s ! CPhr CVPhrase).s2 ++  
          wv.p1 ++ w.adV ++ wv.p2 ++ wv.p3 ++ w.adj ! vpa ++                ---- appComplCase
          appPrep w.c1 (w.obj1.p1 ! vpa) ++ appPrep w.c2 (w.obj2.p1 ! vpa) ++ w.adv ++ w.ext ;
    inf = \\a,vt => 
            infVP vt a v ++ (c.s ! CPhr CVPhrase).s2 ++ infVP vt a w ;
    imp = \\i => 
            impVP i v ++ (c.s ! CPhr CVPhrase).s2 ++ impVP i w ;
    c1 = noComplCase ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = noComplCase ; ---- w.c2 ? 
    s1 = (c.s ! CPhr CVPhrase).s1 ;
    } ;

  ContVPC x v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          let 
            vv = v.v ! a ; 
            wv = w.v ! a ;
            vpa = vagr2agr a ;
          in 
          vv.p1 ++ v.adV ++ vv.p2 ++ vv.p3 ++ v.adj ! vpa ++ 
          appPrep v.c1 (v.obj1.p1 ! vpa) ++ appPrep v.c2 (v.obj2.p1 ! vpa) ++ v.adv ++ v.ext   ---- appComplCase
            ++ "," ++  
          wv ;
    inf = \\a,vt => 
            infVP vt a v ++ "," ++ w.inf ! a ! vt ;
    imp = \\i => 
            impVP i v ++ "," ++ w.imp ! i ;
    c1 = noComplCase ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = noComplCase ; ---- w.c2 ? 
    s1 = w.s1 ;
    } ;

  StartClC x c a b = {
    s  = declCl a ++ (c.s ! CSent).s2 ++ declCl b ;
    c3 = b.c3 ; ---- 
    s1 = (c.s ! CSent).s1 ;
    } ;

  QuestVP x ip vp = 
   let 
       ipa = ipagr2agr UUnit 
   in {
    v    = applyVerb vp UUnit ;
    foc  = ip.s ;
    focType = FocSubj ;
    subj = [] ;
    adj  = vp.adj ! ipa ;
    obj1 = vp.part ++ strComplCase vp.c1 ++ vp.obj1.p1 ! ipa ; ---- appComplCase
    obj2 = strComplCase vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ipa ; False => vp.obj1.p2}) ; ---- appComplCase
    c3   = noComplCase ;      -- for one more prep to build ClSlash ---- ever needed for QCl?
    adv  = vp.adv ;
    adV  = vp.adV ;
    ext  = vp.ext ; 
    } ;

  QuestSlash x ip cl = 
    let 
      prep = cl.c3 ;
      ips  = ip.s ;                     -- in Cl/NP, c3 is the only prep ---- appComplCase for ip
      focobj = case cl.focType of {
        NoFoc => <ips, [], FocObj,prep> ;         -- put ip object to focus  if there is no focus yet
        t     => <[], strComplCase prep ++ ips, t,noComplCase> -- put ip object in situ   if there already is a focus
        } ;
    in 
    cl ** {     -- preposition stranding
      foc     = focobj.p1 ;
      focType = focobj.p3 ;
      obj1    = cl.obj1 ++ focobj.p2 ;     ---- just add to a field?
      c3      = focobj.p4 ; 
      } ;  

}
