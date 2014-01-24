concrete PredicationEng of Predication = open Prelude in {

param
  Agr      = Sg | Pl ;
  Case     = Nom | Acc ;
  Tense    = Pres | Past ;
  Polarity = Pos | Neg ;

lincat
  Arg = {s : Str} ;

  V = {
    v  : Tense => Agr => Str ;             
    c1 : Str ; 
    c2 : Str
    } ; 

  VP = {
    v : Agr => Str * Str ; 
    inf : Str ; 
    c1 : Str ; 
    c2 : Str ; 
    adj,obj1,obj2 : Agr => Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str
    } ;
 
  Cl = {
    v : Str * Str ; 
    inf : Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3 : Str
    } ; 

  QCl = {
    v : Str * Str ; 
    inf : Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3 : Str ;
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
  AP   = {s : Str ; c1 : Str ; c2 : Str ; obj1 : Agr => Str} ;
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
    v   = \\a => <t.s ++ p.s ++ do_Aux t.t a, p.s ++ neg p.p ++ v.v ! Pres ! Pl> ;  ---- always with "do"
    inf = t.s ++ p.s ++ neg p.p ++ aux t.t ++ v.v ! Pres ! Pl ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj,obj1,obj2 = \\a => [] ;
    adv,adV = [] ;
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
    adv,adV = [] ;
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
    v    = vp.v ! np.a ;
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
    v    = vp.v ! ip.a ;
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
          (v.v ! a).p1 ++ v.adV ++ (v.v ! a).p2 ++ v.adj ! a ++ v.c1 ++ v.obj1 ! a ++ v.c2 ++ v.obj2 ! a ++ v.adv ++ v.ext 
            ++ c.s ++
          (w.v ! a).p1 ++ w.adV ++ (w.v ! a).p2 ++ w.adj ! a ++ w.c1 ++ w.obj1 ! a ++ w.c2 ++ w.obj2 ! a ++ w.adv ++ w.ext ;
    inf = \\a => 
            infVP a (lin VP v) ++ c.s ++ infVP a (lin VP w) ;
    c1 = w.c1 ; --- the full story is to unify v and w...
    c2 = w.c2 ; 
    } ;

  UseVPC x vpc = {
    v   = \\a => <do_Aux Pres a, vpc.v ! a> ;  ---- there is no uniform tense
    inf = vpc.inf ! Sg ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    adj,obj1,obj2 = \\a => [] ;
    adv,adV = [] ;
    ext = [] ;
    } ;


  sleep_V = mkV "sleep" ;
  walk_V = mkV "walk" ;
  love_V2 = mkV "love" ;
  look_V2 = mkV "look" "at" [] ;
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
  always_AdV = {s = "always"} ;

  who_IP = {s = "who" ; a = Sg} ;

  PrepNP p np = {s = p.s ++ np.s ! Acc} ;

  with_Prep = {s = "with"} ;

  and_Conj = {s = "and"} ;

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

  infVP : Agr -> VP -> Str = \a,vp -> vp.adV ++ vp.inf ++ vp.adj ! a ++ vp.c1 ++ vp.obj1 ! a ++ vp.c2 ++ vp.obj2 ! a ++ vp.adv ++ vp.ext ;

  declCl : Cl -> Str = \cl ->cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;

  questCl : QCl -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;

}