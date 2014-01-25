concrete PredicationSwe of Predication = open Prelude in {

param
  Agr      = Sg | Pl ;
  Case     = Nom | Acc ;
  Tense    = Pres | Past | Perf | Fut ;
  Polarity = Pos | Neg ;
  VForm    = Inf | VPres | VPret | VSup ;

  FocusType = NoFoc | FocSubj | FocObj ;  -- sover hon/om hon sover, vem älskar hon/vem hon älskar, vem sover/vem som sover 

oper
  defaultAgr = Sg ;

lincat
  Arg = {s : Str} ;

  V = {
    v  : VForm => Str ;             
    c1 : Str ; 
    c2 : Str ;
    isSubjectControl : Bool ;
    } ; 

  VP = {
    v : Str * Str ; 
    inf : Str ; 
    c1 : Str ; 
    c2 : Str ; 
    adj   : Agr => Str ; 
    obj1  : (Agr => Str) * Agr ; 
    obj2  : (Agr => Str) * Bool ; -- subject control = True 
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
    c3  : Str ;
    foc : Str ; -- the focal position at the beginning, e.g. *vem* älskar hon
    focType : FocusType ; --- if already filled, then use other place: vem älskar *vem*
    } ; 

  VPC = {
    v   : Agr => Str ;
    inf : Agr => Str ; 
    c1  : Str ; 
    c2  : Str
    } ;

  ClC = {
    s  : Str ;
    c3 : Str ; ---- which prep
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
  IAdv = {s : Str} ;

lin
  aNone, aS, aV, aA, aQ = {s = []} ;
  aNP a = a ;

  TPres = {s = [] ; t = Pres} ;
  TPast = {s = [] ; t = Past} ;
  TPerf = {s = [] ; t = Perf} ;
  TFut  = {s = [] ; t = Fut} ;
  PPos  = {s = [] ; p = Pos} ;
  PNeg  = {s = [] ; p = Neg} ;

  UseV t p _ v = {
    v   = tenseV t.s t.t v ;
    inf = t.s ++ auxInf t.t v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj = \\a => [] ;
    obj1 = <\\a => [], defaultAgr> ; ---- not used, just default value
    obj2 = <\\a => [], v.isSubjectControl> ;
    adV = p.s ++ neg p.p ;
    adv = [] ;
    ext = [] ;
    } ;

  UseAP t p _ ap = {
    v   = tenseV t.s t.t be_V ;
    inf = t.s ++ p.s ++ auxInf t.t be_V ;
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\a => ap.s ! a ;
    obj1 = <ap.obj1, defaultAgr> ;
    obj2 = <\\a => [], True> ;
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
    obj1 = <\\a => np.s ! Acc, np.a> ;  -- np.a for object control
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
    obj2 = <\\a => np.s ! Acc, vp.obj2.p2> ;
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
    ext = that_Compl ++ declSubordCl (lin Cl cl) ;
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
    ext = questSubordCl qcl ;
    } ;

  ComplVV x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => infVP a vpo, vp.obj2.p2> ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ComplVA x vp ap = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => ap.s ! a,vp.obj2.p2> ;
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
    ext = that_Compl ++ declSubordCl (lin Cl cl) ;
    } ;

  SlashV2Q x vp cl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = questSubordCl (lin QCl cl) ;
    } ;

  SlashV2V x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => infVP a (lin VP vpo), vp.obj2.p2> ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2A x vp ap = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => ap.s ! a, vp.obj2.p2> ;
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
    obj1 = <\\a => reflPron a, defaultAgr> ; ---- defaultAgr will not be used but subj.a instead
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
    obj2 = <\\a => reflPron a, vp.obj2.p2> ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  PredVP x np vp = {
    subj = np.s ! Nom ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.c1 ++ vp.obj1.p1 ! np.a ;
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => np.a ; False => vp.obj1.p2}) ;
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

  SlashClNP x cl np = {
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ;
    adv  = cl.adv ++ cl.c3 ++ np.s ! Acc ;
    ext  = cl.ext ; 
    c3   = [] ;
    } ;



  QuestCl x cl = cl ** {foc = [] ; focType = NoFoc} ;  -- verb first: älskar hon oss
  QuestIAdv x iadv cl = cl ** {foc = iadv.s ; focType = FocObj} ;

  QuestVP x ip vp = {
    foc  = ip.s ;   -- vem älskar henne
    focType = FocSubj ;
    subj = [] ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! ip.a ;
    obj1 = vp.c1 ++ vp.obj1.p1 ! ip.a ;
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ip.a ; False => vp.obj1.p2}) ;
    adV  = vp.adV ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    c3   = [] ;      -- for one more prep to build ClSlash 
    } ;

  QuestSlash x ip cl =  
    let
      ips = cl.c3 ++ ip.s ;  ---- c3? 
      focobj = case cl.focType of {
        NoFoc => <ips, [], FocObj> ;  -- put ip object to focus  
        t     => <[], ips, t>         -- put ip object in situ
        } ;
    in {
    foc  = focobj.p1 ;
    focType = focobj.p3 ;
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

  StartVPC c x v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          v.v.p1 ++ v.adV ++ v.v.p2 ++ v.adj ! a ++ v.c1 ++ v.obj1.p1 ! a ++ v.c2 ++ v.obj2.p1 ! a ++ v.adv ++ v.ext 
            ++ c.s ++
          w.v.p1 ++ w.adV ++ w.v.p2 ++ w.adj ! a ++ w.c1 ++ w.obj1.p1 ! a ++ w.c2 ++ w.obj2.p1 ! a ++ w.adv ++ w.ext ;
    inf = \\a => 
            infVP a (lin VP v) ++ c.s ++ infVP a (lin VP w) ;
    c1 = [] ; --- w.c1 ; --- the full story is to unify v and w...
    c2 = [] ; --- w.c2 ; 
    } ;

  UseVPC x vpc = { ---- big loss of quality (overgeneration) seems inevitable
    v   = <[], vpc.v ! defaultAgr> ;   ---- agreement
    inf = vpc.inf ! defaultAgr ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    adj = \\a => [] ;
    obj1 = <\\a => [], defaultAgr> ;
    obj2 = <\\a => [],True> ;
    adv,adV = [] ;
    ext = [] ;
    } ;

  StartClC c x a b = {
    s  = declCl (lin Cl a) ++ c.s ++ declCl (lin Cl b) ;
    c3 = b.c3 ; ---- 
    } ;

  UseClC x cl = {
    subj = [] ;
    v    = <[],cl.s> ; ----
    inf  = [] ;
    adj  = [] ;
    obj1 = [] ;
    obj2 = [] ;
    adV  = [] ;
    adv  = [] ;
    ext  = [] ;
    c3   = cl.c3 ;
    } ;

  sleep_V = mkV "sova" "sover" "sov" "sovit" ;
  walk_V = mkV "gå" "går" "gick" "gått" ;
  love_V2 = mkV "älska" "älskar" "älskade" "älskat" ;
  look_V2 = mkV "titta" "tittar" "tittade" "tittat" "på" [] ;
  believe_VS = mkV "tro" "tror" "trodde" "trott" ;
  tell_V2S = mkV "berätta" "berättar" "berättade" "berättat" "för" [] ;
  prefer_V3 = mkV "föredra" "föredrar" "föredrog" "föredragit" [] "framför" ;
  want_VV = mkV "vilja" "vill" "ville" "velat" ;
  force_V2V = {v = table {Inf => "tvinga" ; VPres => "tvingar" ; VPret => "tvingade" ; VSup => "tvingat"} ; 
               c1 = [] ; c2 = "att" ; isSubjectControl = False} ; 
  promise_V2V = mkV "lova" "lovar" "lovade" "lovat" [] "att" ;
  wonder_VQ = mkV "undra" "undrar" "undrade" "undrat" ;
  become_VA = mkV "bli" "blir" "blev" "blivit" ;
  make_V2A = {v = table {Inf => "göra" ; VPres => "gör" ; VPret => "gjorde" ; VSup => "gjort"} ; 
               c1 = [] ; c2 = [] ; isSubjectControl = False} ; 
  ask_V2Q = mkV "fråga" "frågar" "frågade" "frågat" ;

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

  why_IAdv = {s = "varför"} ;

oper
  mkV = overload {
    mkV : (x,y,z,u : Str) -> V = \x,y,z,u -> 
      lin V {v = table {Inf => x ; VPres => y ; VPret => z ; VSup => u} ; c1 = [] ; c2 = [] ; isSubjectControl = True} ; 
    mkV : (x,y,z,u : Str) -> Str -> Str -> V = \x,y,z,u,p,q -> 
      lin V {v = table {Inf => x ; VPres => y ; VPret => z ; VSup => u} ; c1 = p ; c2 = q  ; isSubjectControl = True} ; 
    } ;

  be_V : V = mkV "vara" "är" "var" "varit" ;

  have_V : V = mkV "ha" "har" "hade" "haft" ;

  shall_V : V = mkV "skola" "ska" "skulle" "skolat" ;

  neg : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "inte"} ;

  auxInf : Tense -> V -> Str = \t,v -> case t of {Pres | Fut => v.v ! Inf ; _ => have_V.v ! Inf ++ v.v !  VSup} ; --- many tenses give the same form

  reflPron : Agr -> Str = \a -> case a of {Sg => "sig" ; Pl => "oss"} ;

  infVP : Agr -> VP -> Str = \a,vp -> 
    let a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} in
    vp.adV ++ vp.inf ++ vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  tenseV : Str -> Tense -> V -> Str * Str = \s,t,v -> case t of {  --- s : Str is the dummy s field of Temp
    Pres => <s ++ v.v ! VPres,      []> ;
    Past => <s ++ v.v ! VPret,      []> ;
    Perf => <have_V.v ! VPres,  s ++ v.v ! VSup> ;
    Fut  => <shall_V.v ! VPres, s ++ v.v ! Inf>
    } ;

  declCl       : Cl -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
  declSubordCl : Cl -> Str = \cl -> cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
  declInvCl    : Cl -> Str = \cl -> cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;

  questCl : QCl -> Str = \cl -> 
                         cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
  questSubordCl : QCl -> Str = \cl -> 
    case cl.focType of {
      NoFoc   => "om" ++ cl.foc          ++ cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
      FocObj  =>         cl.foc          ++ cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
      FocSubj =>         cl.foc ++ "som" ++ cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
      } ;

  that_Compl : Str = "att" | [] ;

}