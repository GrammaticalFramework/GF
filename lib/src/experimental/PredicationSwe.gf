concrete PredicationSwe of Predication = {

param
  Agr      = Sg | Pl ;
  Case     = Nom | Acc ;
  Tense    = Pres | Past ;
  Polarity = Pos | Neg ;
  VForm    = Inf | VT Tense ;

lincat
  Arg = {s : Str} ;

  V = {
    v  : VForm => Str ;             
    c1 : Str ; 
    c2 : Str
    } ; 

  VP = {
    v : Str ; 
    inf : Str ; 
    c1 : Str ; 
    c2 : Str ; 
    adj,obj1,obj2 : Agr => Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str
    } ;
 
  Cl = {
    v : Str ; 
    inf : Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3 : Str
    } ; 

  Temp = {s : Str ; t : Tense} ;
  Pol  = {s : Str ; p : Polarity} ;
  NP   = {s : Case => Str ; a : Agr} ;
  Adv  = {s : Str} ;
  AdV  = {s : Str} ;
  S    = {s : Str} ;
  QS   = {s : Str} ;
  Utt  = {s : Str} ;
  AP   = {s : Agr => Str ; c1 : Str ; c2 : Str ; obj1 : Agr => Str} ;
  IP   = {s : Str ; a : Agr} ;
  Prep = {s : Str} ;

lin
  aNone, aS, aV = {s = []} ;
  aNP a = a ;

  TPres = {s = [] ; t = Pres} ;
  TPast = {s = [] ; t = Past} ;
  PPos  = {s = [] ; p = Pos} ;
  PNeg  = {s = [] ; p = Neg} ;

  UseV t p _ v = {
    v   = t.s ++ v.v ! VT t.t ;
    inf = t.s ++ aux t.t ++ v.v ! Inf ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj,obj1,obj2 = \\a => [] ;
    adV = p.s ++ neg p.p ;
    adv = [] ;
    ext = [] ;
    } ;

  UseAP t p _ ap = {
    v   = t.s ++ be_Aux (VT t.t) ;
    inf = t.s ++ p.s ++ aux t.t ++ be_Aux Inf ;
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\a => ap.s ! a ;
    obj1 = ap.obj1 ;
    obj2 = \\a => [] ;
    adV = p.s ++ neg p.p ;
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
    adV = vp.adV ;
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
    adV = vp.adV ;
    ext = vp.ext ;
    } ;

  ComplVS x vp cl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = (DeclCl (lin Cl cl)).s ;
    } ;

  ComplVV x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => infVP a vpo ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2S x vp cl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = (DeclCl (lin Cl cl)).s ;
    } ;

  SlashV2V x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = \\a => infVP a vpo ;
    adV = vp.adV ;
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
    adV = vp.adV ;
    adv = vp.adv ++ adv.s ;
    ext = vp.ext ;
    } ;

  AdVVP adv _ vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ++ adv.s ;
    adv = vp.adv ;
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
    adV = vp.adV ;
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
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  PredVP x np vp = {
    subj = np.s ! Nom ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.c1 ++ vp.obj1 ! np.a ;
    obj2 = vp.c2 ++ vp.obj2 ! np.a ;
    adV  = vp.adV ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    c3   = [] ;      -- for one more prep to build ClSlash 
    } ;

  PrepCl p x cl = {
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ;
    adv  = cl.adv ;
    ext  = cl.ext ; 
    c3   = p.s ;      -- for one more prep to build ClSlash 
    } ;


  DeclCl cl = {
    s = cl.subj ++ cl.v ++ cl.adV ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
    } ;

  QuestCl cl = {
    s = cl.v ++ cl.subj ++ cl.adV ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
    } ;

  QuestVP ip vp = {
    s = ip.s ++ vp.v ++ vp.adV ++ vp.adj ! ip.a ++ vp.c1 ++ vp.obj1 ! ip.a ++ vp.c2 ++ vp.obj2 ! ip.a ++ vp.adv ++ vp.ext
    } ;

  QuestSlash ip cl = {
    s = ip.s ++ cl.v ++ cl.subj ++ cl.adV ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3
    } ;

  UttS s = s ;
  UttQS s = s ;

  sleep_V = mkV "sova" "sover" "sov" ;
  love_V2 = mkV "älska" "älskar" "älskade" ;
  believe_VS = mkV "tro" "tror" "trodde" ;
  tell_V2S = mkV "berätta" "berättar" "berättade" "för" [] ;
  prefer_V3 = mkV "föredra" "föredrar" "föredrog" [] "framför" ;
  want_VV = mkV "vilja" "vill" "ville" ;
  force_V2V = mkV "tvinga" "tvingar" "tvingade" [] "att" ;

  old_A = {s = table {Sg => "gammal" ; Pl => "gamla"} ; c1 = [] ; c2 = [] ; obj1 = \\_ => []} ;
  married_A2 = {s = table {Sg => "gift" ; Pl => "gifta"} ; c1 = "med" ; c2 = [] ; obj1 = \\_ => []} ;
  eager_AV = {s = table {Sg => "ivrig" ; Pl => "ivriga"} ; c1 = [] ; c2 = "att" ; obj1 = \\_ => []} ;
  easy_A2V = {s = table {Sg => "lätt" ; Pl => "lätta"} ; c1 = "för" ; c2 = "att" ; obj1 = \\_ => []} ;

  she_NP = {s = table {Nom => "hon" ; Acc => "henne"} ; a = Sg} ;
  we_NP = {s = table {Nom => "vi" ; Acc => "oss"} ; a = Pl} ;

  today_Adv = {s = "idag"} ;
  always_AdV = {s = "alltid"} ;

  who_IP = {s = "vem" ; a = Sg} ;

  PrepNP p np = {s = p.s ++ np.s ! Acc} ;

  with_Prep = {s = "med"} ;

oper
  mkV = overload {
    mkV : (x,y,z : Str) -> V = \x,y,z -> 
      lin V {v = table {Inf => x ; VT Pres => y ; VT Past => z} ; c1 = [] ; c2 = []} ; 
    mkV : (x,y,z : Str) -> Str -> Str -> V = \x,y,z,p,q -> 
      lin V {v = table {Inf => x ; VT Pres => y ; VT Past => z} ; c1 = p ; c2 = q} ; 
    } ;

  be_Aux : VForm -> Str = \t -> case t of {
    Inf     => "vara" ;
    VT Pres => "är" ;
    VT Past => "var"
    } ;

  neg : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "inte"} ;

  aux : Tense -> Str = \t -> case t of {Pres => [] ; Past => "ha"} ;

  reflPron : Agr -> Str = \a -> case a of {Sg => "sig" ; Pl => "oss"} ;

  infVP : Agr -> VP -> Str = \a,vp -> vp.adV ++ vp.inf ++ vp.adj ! a ++ vp.c1 ++ vp.obj1 ! a ++ vp.c2 ++ vp.obj2 ! a ++ vp.adv ++ vp.ext ;

}