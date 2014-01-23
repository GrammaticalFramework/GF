concrete PredicationEng of Predication = {

param
  Agr      = Sg | Pl ;
  Case     = Nom | Acc ;
  Tense    = Pres | Past ;
  Polarity = Pos | Neg ;

lincat
  Arg = {s : Str} ;
  V   = {v : Tense => Agr => Str       ;             c1 : Str ; c2 : Str} ; 
  VP  = {v :          Agr => Str * Str ; inf : Str ; c1 : Str ; c2 : Str ; adj,obj1,obj2 : Agr => Str ; adv : Str ; ext : Str} ; 
  Cl  = {v :                 Str * Str ; inf : Str ;                       adj,obj1,obj2 :        Str ; adv : Str ; ext : Str ; subj : Str} ; 

  Temp = {s : Str ; t : Tense} ;
  Pol  = {s : Str ; p : Polarity} ;
  NP   = {s : Case => Str ; a : Agr} ;
  Adv  = {s : Str} ;
  S    = {s : Str} ;
  QS   = {s : Str} ;
  Utt  = {s : Str} ;
  AP   = {s : Str ; c1 : Str ; c2 : Str ; obj1 : Agr => Str} ;
  IP   = {s : Str ; a : Agr} ;

lin
  aNone, aS, aV = {s = []} ;
  aNP a = a ;

  TPres = {s = [] ; t = Pres} ;
  TPast = {s = [] ; t = Past} ;
  PPos  = {s = [] ; p = Pos} ;
  PNeg  = {s = [] ; p = Neg} ;

  UseV t p _ v = {
    v   = \\a => <t.s ++ p.s ++ do_Aux t.t a, p.s ++ neg p.p ++ v.v ! Pres ! Pl> ;  ---- always with "do"
    inf = t.s ++ p.s ++ neg p.p ++ aux t.t ++ v.v ! Pres ! Pl ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj,obj1,obj2 = \\a => [] ;
    adv = [] ;
    ext = [] ;
    } ;

  UseAP t p _ ap = {
    v   = \\a => <t.s ++ be_Aux t.t a, p.s ++ neg p.p> ;  ---- always with "do"
    inf = t.s ++ p.s ++ neg p.p ++ aux t.t ++ "be" ;
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\_ => ap.s ;
    obj1 = ap.obj1 ;
    obj2 = \\a => [] ;
    adv = [] ;
    ext = [] ;
    } ;

  SlashVNP x vp np = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = \\a => np.s ! Acc ;
    obj2 = vp.obj2 ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashVNP2 x vp np = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => np.s ! Acc ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ComplVS vp s = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adv = vp.adv ;
    ext = s.s ;
    } ;

  ComplVV vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => infVP a vpo ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2S vp s = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adv = vp.adv ;
    ext = s.s ;
    } ;

  SlashV2V vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => infVP a vpo ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  AdvVP adv _ vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adv = vp.adv ++ adv.s ;
    ext = vp.ext ;
    } ;

  ReflVP x vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = \\a => reflPron a ;
    obj2 = vp.obj2 ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ReflVP2 x vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => reflPron a ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  PredVP x np vp = {
    subj = np.s ! Nom ;
    v    = vp.v ! np.a ;
    inf  = vp.inf ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.c1 ++ vp.obj1 ! np.a ;
    obj2 = vp.c2 ++ vp.obj2 ! np.a ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    } ;

  DeclCl cl = {
    s = cl.subj ++ cl.v.p1 ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
    } ;

  QuestCl cl = {
    s = cl.v.p1 ++ cl.subj ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
    } ;

  QuestVP ip vp = {
    s = ip.s ++ (vp.v ! ip.a).p1 ++ (vp.v ! ip.a).p2 ++ vp.adj ! ip.a ++ vp.c1 ++ vp.obj1 ! ip.a ++ vp.c2 ++ vp.obj2 ! ip.a ++ vp.adv ++ vp.ext
    } ;

  QuestSlash ip cl = {
    s = ip.s ++ cl.v.p1 ++ cl.subj ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
    } ;

  UttS s = s ;
  UttQS s = s ;

  sleep_V = mkV "sleep" ;
  love_V2 = mkV "love" ;
  believe_VS = mkV "believe" ;
  tell_V2S = mkV "tell" ;
  prefer_V3 = mkV "prefer" [] "to" ;
  want_VV = mkV "want" [] "to" ;
  force_V2V = mkV "force" [] "to" ;

  old_A = {s = "old" ; c1 = [] ; c2 = [] ; obj1 = \\_ => []} ;
  married_A2 = {s = "married" ; c1 = "to" ; c2 = [] ; obj1 = \\_ => []} ;
  eager_AV = {s = "eager" ; c1 = [] ; c2 = "to" ; obj1 = \\_ => []} ;
  easy_A2V = {s = "easy" ; c1 = "for" ; c2 = "to" ; obj1 = \\_ => []} ;

  she_NP = {s = table {Nom => "she" ; Acc => "her"} ; a = Sg} ;
  we_NP = {s = table {Nom => "we" ; Acc => "us"} ; a = Pl} ;

  today_Adv = {s = "today"} ;

  who_IP = {s = "who" ; a = Sg} ;

oper
  mkV = overload {
    mkV : Str -> V = \s -> lin V {v = \\_,_ => s ; c1 = [] ; c2 = []} ; 
    mkV : Str -> Str -> Str -> V = \s,p,q -> lin V {v = \\_,_ => s ; c1 = p ; c2 = q} ; 
    } ;

  do_Aux : Tense -> Agr -> Str = \t,a -> case <t,a> of {
    <Pres,Sg> => "does" ;
    <Pres,Pl> => "do" ;
    <Past,_>  => "did"
    } ;

  be_Aux : Tense -> Agr -> Str = \t,a -> case <t,a> of {
    <Pres,Sg> => "is" ;
    <Pres,Pl> => "are" ;
    <Past,Sg> => "was" ;
    <Past,Pl> => "were"
    } ;

  neg : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "not"} ;

  aux : Tense -> Str = \t -> case t of {Pres => [] ; Past => "have"} ;

  reflPron : Agr -> Str = \a -> case a of {Sg => "herself" ; Pl => "ourselves"} ;

  infVP : Agr -> VP -> Str = \a,vp -> vp.inf ++ vp.adj ! a ++ vp.obj1 ! a ++ vp.obj2 ! a ++ vp.adv ++ vp.ext ;

}