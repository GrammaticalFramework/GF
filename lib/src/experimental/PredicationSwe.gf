concrete PredicationSwe of Predication = open Prelude in {

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

  QCl = {
    v : Str ; 
    inf : Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3  : Str ;
    foc : Str ; -- the focal position at the beginning, e.g. *vem* älskar hon
    hasFoc : Bool ; --- if already filled, then use other place: vem älskar *vem*
    } ; 

  VPC = {
    v   : Agr => Str ;
    inf : Agr => Str ; 
    c1  : Str ; 
    c2  : Str
    } ;

  Temp = {s : Str ; t : Tense} ;
  Pol  = {s : Str ; p : Polarity} ;
  NP   = {s : Case => Str ; a : Agr} ;
  Adv  = {s : Str} ;
  AdV  = {s : Str} ;
  S    = {s : Str} ;
  Utt  = {s : Str} ;
  AP   = {s : Agr => Str ; c1 : Str ; c2 : Str ; obj1 : Agr => Str} ;
  IP   = {s : Str ; a : Agr} ;
  Prep = {s : Str} ;
  Conj = {s : Str} ;

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
    ext = declCl (lin Cl cl) ;
    } ;

  ComplVQ x vp qcl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = questCl qcl ;
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
    ext = declCl (lin Cl cl) ;
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

  QuestCl x cl = cl ** {foc = [] ; hasFoc = False} ;  -- verb first: älskar hon oss

  QuestVP x ip vp = {
    foc  = ip.s ;   -- vem älskar henne
    hasFoc = True ;
    subj = [] ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! ip.a ;
    obj1 = vp.c1 ++ vp.obj1 ! ip.a ;
    obj2 = vp.c2 ++ vp.obj2 ! ip.a ;
    adV  = vp.adV ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    c3   = [] ;      -- for one more prep to build ClSlash 
    } ;

  QuestSlash x ip cl =  
    let
      ips = cl.c3 ++ ip.s ;  ---- c3? 
      focobj = case cl.hasFoc of {
        True => <[],ips> ;
        False => <ips,[]>
        } ;
    in {
    foc  = focobj.p1 ;
    hasFoc = True ;
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ++ focobj.p2 ;
    obj2 = cl.obj2 ;        ---- slash to this part?
    adV  = cl.adV ;
    adv  = cl.adv ;
    ext  = cl.ext ; 
    c3   = [] ; 
    } ;

  UseCl  cl = {s = declCl cl} ;
  UseQCl cl = {s = questCl cl} ;

  UttS s = s ;

  StartVPC c x v w = {
    v = \\a => 
          v.v ++ v.adV ++ v.adj ! a ++ v.c1 ++ v.obj1 ! a ++ v.c2 ++ v.obj2 ! a ++ v.adv ++ v.ext 
            ++ c.s ++
          w.v ++ w.adV ++ w.adj ! a ++ w.c1 ++ w.obj1 ! a ++ w.c2 ++ w.obj2 ! a ++ w.adv ++ w.ext ;
    inf = \\a => 
            infVP a (lin VP v) ++ c.s ++ infVP a (lin VP w) ;
    c1 = [] ; --- w.c1 ; --- the full story is to unify v and w...
    c2 = [] ; --- w.c2 ; 
    } ;

  UseVPC x vpc = {
    v   = vpc.v ! Sg ;   ---- agreement
    inf = vpc.inf ! Sg ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    adj,obj1,obj2 = \\a => [] ;
    adv,adV = [] ;
    ext = [] ;
    } ;


  sleep_V = mkV "sova" "sover" "sov" ;
  walk_V = mkV "gå" "går" "gick" ;
  love_V2 = mkV "älska" "älskar" "älskade" ;
  look_V2 = mkV "titta" "tittar" "tittade" "på" [] ;
  believe_VS = mkV "tro" "tror" "trodde" ;
  tell_V2S = mkV "berätta" "berättar" "berättade" "för" [] ;
  prefer_V3 = mkV "föredra" "föredrar" "föredrog" [] "framför" ;
  want_VV = mkV "vilja" "vill" "ville" ;
  force_V2V = mkV "tvinga" "tvingar" "tvingade" [] "att" ;
  wonder_VQ = mkV "undra" "undrar" "undrade" ;

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

  and_Conj = {s = "och"} ;

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

  declCl  : Cl  -> Str = \cl -> cl.subj ++ cl.v ++ cl.adV ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
  questCl : QCl -> Str = \cl -> cl.foc ++ cl.v ++ cl.subj ++ cl.adV ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
}