concrete PredicationSwO of Predication = open Prelude in {

-- Swedish predication: simpler and purer than English.
-- two principles:
-- - keep records discontinuous as long as possible (last step from Cl to S)
-- - select from tables as soon as possible (first step from V to VP)
-- a question: would it make sense to make this into a functor?

param
  Agr      = Sg | Pl ;
  Case     = Nom | Acc ;
  STense   = Pres | Past | Perf | Fut ;
  Anteriority = Simul | Anter ;
  Polarity = Pos | Neg ;
  VTense   = VInf | VPres | VPret | VSup ;
  VForm    = TV Voice VTense | PastPart Agr | PresPart ;
  Voice    = Act | Pass ;
   

  FocusType = NoFoc | FocSubj | FocObj ;  -- sover hon/om hon sover, vem älskar hon/vem hon älskar, vem sover/vem som sover 

oper
  defaultAgr = Sg ;
  ComplCase  = Str ; -- preposition

lincat
  Arg = {s : Str} ;

  V = {
    v  : VForm => Str ;             
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    } ; 

  VP = {
    v : Str * Str * Str ;  -- ska,ha,sovit 
    inf : Str * Str ;      -- ha,sovit
    c1 : ComplCase ; 
    c2 : ComplCase ; 
    adj   : Agr => Str ; 
    obj1  : (Agr => Str) * Agr ; 
    obj2  : (Agr => Str) * Bool ; -- subject control = True 
    adv : Str ; 
    adV : Str ;
    ext : Str
    } ;
 
oper Clause = {
    v : Str * Str * Str ; 
    inf : Str * Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3  : ComplCase  -- for a slashed adjunct, not belonging to the verb valency
    } ; 

lincat
  Cl = Clause ;

  QCl = Clause ** {
    foc : Str ; -- the focal position at the beginning, e.g. *vem* älskar hon
    focType : FocusType ; --- if already filled, then use other place: vem älskar *vem*
    } ; 

  VPC = {
    v   : Agr => Str ;
    inf : Agr => Str ; 
    c1  : ComplCase ; 
    c2  : ComplCase
    } ;

  ClC = {
    s  : Str ;
    c3 : ComplCase ;
    } ;

  Tense = {s : Str ; t : STense} ;
  Ant   = {s : Str ; a : Anteriority} ;
  Pol   = {s : Str ; p : Polarity} ;

  NP   = {s : Case => Str ; a : Agr} ;
  Adv  = {s : Str} ;
  AdV  = {s : Str} ;
  S    = {s : Str} ;
  Utt  = {s : Str} ;
  AP   = {
    s : Agr => Str ; 
    c1, c2 : ComplCase ; 
    obj1 : 
    Agr => Str
    } ;
  CN   = {
    s : Agr => Str ; 
    c1, c2 : ComplCase ; 
    obj1 : 
    Agr => Str
    } ;
  IP   = {s : Str ; a : Agr} ;
  Prep = {s : Str} ;
  Conj = {s : Str} ;
  IAdv = {s : Str} ;

lin
  aNone, aS, aV, aA, aQ, aN = {s = []} ;
  aNP a = a ;

  TPres  = {s = [] ; t = Pres} ;
  TPast  = {s = [] ; t = Past} ;
  TFut   = {s = [] ; t = Fut} ;
  TCond  = {s = [] ; t = Perf} ;
  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;

  PPos  = {s = [] ; p = Pos} ;
  PNeg  = {s = [] ; p = Neg} ;

  UseV a t p _ v = {
    v   = tenseV (a.s ++ t.s) t.t a.a Act v ;
    inf = tenseInfV a.s a.a Act v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj = noObj ;
    obj1 = <noObj, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, v.isSubjectControl> ;
    adV = p.s ++ neg p.p ;
    adv = [] ;
    ext = [] ;
    } ;

  PassUseV a t p _ v = {
    v   = tenseV (a.s ++ t.s) t.t a.a Pass v ;
    inf = tenseInfV a.s a.a Pass v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj = noObj ;
    obj1 = <noObj, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, True> ; -- becomes subject control even if object control otherwise "*she was promised by us to love ourselves"
    adV = p.s ++ neg p.p ;
    adv = [] ;
    ext = [] ;
    } ;

  AgentPassUseV a t p _ v np = {
    v   = tenseV (a.s ++ t.s) t.t a.a Pass v ;
    inf = tenseInfV a.s a.a Pass v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    adj = \\a => [] ;
    obj1 = <noObj, defaultAgr> ; 
    obj2 = <noObj, True> ;
    adV = p.s ++ neg p.p ;
    adv = appComplCase agentCase np ; ---- add a specific field for agent?
    ext = [] ;
    } ;

  UseAP a t p _ ap = {
    v   = tenseV (a.s ++ t.s) t.t a.a Act be_V ;
    inf = tenseInfV a.s a.a Act be_V ;
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    adj = \\a => ap.s ! a ;
    obj1 = <ap.obj1, defaultAgr> ;
    obj2 = <noObj, True> ; --- there are no A3's
    adV = p.s ++ neg p.p ;
    adv = [] ;
    ext = [] ;
    } ;

  SlashV2 x vp np = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;  ---- should be consumed now
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = <\\a => np.s ! Acc, np.a> ;  -- np.a for object control ---- Acc to be abstracted
    obj2 = vp.obj2 ;
    adv = vp.adv ;
    adV = vp.adV ;
    ext = vp.ext ;
    } ;

  SlashV3 x vp np = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;  ---- should be consumed now
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => np.s ! Acc, vp.obj2.p2> ; -- control is preserved  ---- Acc to be abstracted
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
    obj1 = vp.obj1 ; ---- consumed
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = that_Compl ++ declSubordCl (lin Cl cl) ; ---- sentence form
    } ;

  ComplVQ x vp qcl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ; ---- consumed
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = questSubordCl qcl ; ---- question form
    } ;

  ComplVV x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => infVP a vpo, vp.obj2.p2> ; ---- infForm
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ComplVA x vp ap = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ; ---- consumed
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => ap.s ! a ++ ap.obj1 ! a, vp.obj2.p2> ; ---- adjForm
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ComplVN x vp cn = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ; ---- consumed
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => cn.s ! a ++ cn.obj1 ! a, vp.obj2.p2> ; ---- cnForm
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2S x vp cl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = that_Compl ++ declSubordCl (lin Cl cl) ; ---- sentence form
    } ;

  SlashV2Q x vp cl = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = questSubordCl (lin QCl cl) ; ---- question form
    } ;

  SlashV2V x vp vpo = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => infVP a (lin VP vpo), vp.obj2.p2> ; ---- infForm
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2A x vp ap = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => ap.s ! a ++ ap.obj1 ! a, vp.obj2.p2> ; ---- adjForm
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  SlashV2N x vp cn = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => cn.s ! a ++ cn.obj1 ! a, vp.obj2.p2> ; ---- cn form
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ReflVP x vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ; ---- consumed
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = <\\a => reflPron a, defaultAgr> ; --- hack: defaultAgr will not be used but subj.a instead
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  ReflVP2 x vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ; ---- consumed
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = <\\a => reflPron a, vp.obj2.p2> ; --- subj/obj control doesn't matter any more
    adV = vp.adV ;
    adv = vp.adv ;
    ext = vp.ext ;
    } ;

  PredVP x np vp = {
    subj = np.s ! Nom ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.c1 ++ vp.obj1.p1 ! np.a ;  ---- apply complCase
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => np.a ; False => vp.obj1.p2}) ;   ---- apply complCase
    adV  = vp.adV ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    c3   = noComplCase ;      -- for one more prep to build ClSlash 
    } ;

  PrepCl p x cl = {   -- Cl/NP ::= Cl PP/NP
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ;
    adv  = cl.adv ;
    ext  = cl.ext ; 
    c3   = prepComplCase p ; 
    } ;

  SlashClNP x cl np = {  -- Cl ::= Cl/NP NP 
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ;
    adv  = cl.adv ++ appComplCase cl.c3 np ; ---- again, adv just added
    ext  = cl.ext ; 
    c3   = noComplCase ;  -- complCase has been consumed
    } ;


-- QCl ::= Cl by just adding focus field
  QuestCl x cl = cl ** {foc = [] ; focType = NoFoc} ;  -- NoFoc implies verb first: älskar hon oss

  QuestIAdv x iadv cl = cl ** {foc = iadv.s ; focType = FocObj} ; -- FocObj implies Foc + V + Subj: varför älskar hon oss

  QuestVP x ip vp = {
    foc  = ip.s ;   -- vem älskar henne
    focType = FocSubj ;
    subj = [] ;
    v    = vp.v ;
    inf  = vp.inf ;
    adj  = vp.adj ! ip.a ;
    obj1 = vp.c1 ++ vp.obj1.p1 ! ip.a ; ---- appComplCase
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ip.a ; False => vp.obj1.p2}) ; ---- appComplCase
    adV  = vp.adV ;
    adv  = vp.adv ;
    ext  = vp.ext ; 
    c3   = noComplCase ;      -- for one more prep to build ClSlash ---- ever needed for QCl?
    } ;

  QuestSlash x ip cl =  
    let
      ips = cl.c3 ++ ip.s ;     -- in Cl/NP, c3 is the only prep ---- appComplCase for ip
      focobj = case cl.focType of {
        NoFoc => <ips, [], FocObj> ;  -- put ip object to focus  if there is no focus yet
        t     => <[], ips, t>         -- put ip object in situ   if there already is a focus
        } ;
    in {
    foc  = focobj.p1 ;
    focType = focobj.p3 ;
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ++ focobj.p2 ;     ---- just add to a field?
    obj2 = cl.obj2 ;                  ---- slash to this part? maybe with one more value of focType?
    adV  = cl.adV ;
    adv  = cl.adv ;
    ext  = cl.ext ; 
    c3   = noComplCase ; 
    } ;

  UseCl  cl = {s = declCl cl} ;
  UseQCl cl = {s = questCl cl} ;

  UttS s = s ;

  AdvCl a x cl = {
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ;
    adv  = cl.adv ++ a.s ;
    ext  = cl.ext ; 
    c3   = cl.c3 ;
    } ;

  AdVCl a x cl = {
    subj = cl.subj ;
    v    = cl.v ;
    inf  = cl.inf ;
    adj  = cl.adj ;
    obj1 = cl.obj1 ;
    obj2 = cl.obj2 ;
    adV  = cl.adV ++ a.s ;
    adv  = cl.adv ;
    ext  = cl.ext ; 
    c3   = cl.c3 ;
    } ;


{-
  AdvVP adv x vp = {
    v   = vp.v ;
    inf = vp.inf ;
    c1  = vp.c1 ;
    c2  = vp.c2 ;
    adj = vp.adj ;
    obj1 = vp.obj1 ;
    obj2 = vp.obj2 ;
    adV = vp.adV ;
    adv = vp.adv ++ adv.s ; ---- all adverbs become one field - how to front one of them?
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
    adV = vp.adV ++ adv.s ; ---- all adV's become one field - how to front one of them?
    adv = vp.adv ;
    ext = vp.ext ;
    } ;
-}





  PresPartAP x v = {            
    s = \\a => v.v ! PresPart ;
    c1 = v.c1 ;                    -- tittande på henne
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  PastPartAP x v = {
    s = \\a => v.v ! PastPart a ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  AgentPastPartAP x v np = {
    s = \\a => v.v ! PastPart a ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = \\_ => appComplCase agentCase np ; ---- addObj
    } ;

  StartVPC c x v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          v.v.p1 ++ v.adV ++ v.v.p2 ++ v.v.p3 ++ v.adj ! a ++ 
          v.c1 ++ v.obj1.p1 ! a ++ v.c2 ++ v.obj2.p1 ! a ++ v.adv ++ v.ext   ---- appComplCase
            ++ c.s ++  
          w.v.p1 ++ w.adV ++ w.v.p2 ++ w.v.p3 ++ w.adj ! a ++                ---- appComplCase
          w.c1 ++ w.obj1.p1 ! a ++ w.c2 ++ w.obj2.p1 ! a ++ w.adv ++ w.ext ;
    inf = \\a => 
            infVP a (lin VP v) ++ c.s ++ infVP a (lin VP w) ;
    c1 = [] ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = [] ; ---- w.c2 ? 
    } ;

  UseVPC x vpc = { ---- big loss of quality (overgeneration) seems inevitable
    v   = <[], [], vpc.v ! defaultAgr> ;   ---- agreement
    inf = <[], vpc.inf ! defaultAgr> ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    adj = \\a => [] ;
    obj1 = <noObj, defaultAgr> ;
    obj2 = <noObj,True> ;
    adv,adV = [] ;
    ext = [] ;
    } ;

  StartClC c x a b = {
    s  = declCl (lin Cl a) ++ c.s ++ declCl (lin Cl b) ;
    c3 = b.c3 ; ---- 
    } ;

  UseClC x cl = {
    subj = [] ;
    v    = <[],[],cl.s> ; ----
    inf  = <[],[]> ;
    adj  = [] ;
    obj1 = [] ;
    obj2 = [] ;
    adV  = [] ;
    adv  = [] ;
    ext  = [] ;
    c3   = cl.c3 ;
    } ;

---- the lexicon is just for testing: use standard Swe lexicon and morphology instead

  sleep_V = mkV "sova" "sover" "sov" "sovit" "soven" "sovna" ;
  walk_V = mkV "gå" "går" "gick" "gått" "gången" "gångna" ;
  love_V2 = mkV "älska" "älskar" "älskade" "älskat" "älskad" "älskade" ;
  look_V2 = mkV "titta" "tittar" "tittade" "tittat" "tittad" "tittade" "på" [] ;
  believe_VS = mkV "tro" "tror" "trodde" "trott" "trodd" "trodda" ;
  tell_V2S = mkV "berätta" "berättar" "berättade" "berättat" "berättad" "berättade" "för" [] ;
  prefer_V3 = mkV "föredra" "föredrar" "föredrog" "föredragit" "föredragen" "föredragna" [] "framför" ;
  want_VV = mkV "vilja" "vill" "ville" "velat" "velad" "velade" ;
  force_V2V = let tvinga : V = mkV "tvinga" "tvingar" "tvingade" "tvingat" "tvingad" "tvingade" in 
              {v = tvinga.v ; c1 = [] ; c2 = "att" ; isSubjectControl = False} ; 
  promise_V2V = mkV "lova" "lovar" "lovade" "lovat" "lovad" "lovade" [] "att" ;
  wonder_VQ = mkV "undra" "undrar" "undrade" "undrat" "undrad" "undrade" ;
  become_VA = mkV "bli" "blir" "blev" "blivit" "bliven" "blivna" ;
  become_VN = mkV "bli" "blir" "blev" "blivit" "bliven" "blivna" ;
  make_V2A = let gora : V = mkV "göra" "gör" "gjorde" "gjort" "gjord" "gjorda" in 
             {v = table {TV Pass VPres => "görs" ; f => gora.v ! f} ; c1 = [] ; c2 = [] ; isSubjectControl = False} ; 
  promote_V2N = let befordra : V = mkV "befordra" "befordrar" "befordrade" "befordrat" "befordrad" "befordrade"
                in {v = befordra.v ; c1 = [] ; c2 = "till" ; isSubjectControl = False} ; ---- ? de befordrade dem till chefer för sig/dem 
  ask_V2Q = mkV "fråga" "frågar" "frågade" "frågat" "frågad" "frågade" ;

  old_A = {s = table {Sg => "gammal" ; Pl => "gamla"} ; c1 = [] ; c2 = [] ; obj1 = \\_ => []} ;
  married_A2 = {s = table {Sg => "gift" ; Pl => "gifta"} ; c1 = "med" ; c2 = [] ; obj1 = \\_ => []} ;
  eager_AV = {s = table {Sg => "ivrig" ; Pl => "ivriga"} ; c1 = [] ; c2 = "att" ; obj1 = \\_ => []} ;
  easy_A2V = {s = table {Sg => "lätt" ; Pl => "lätta"} ; c1 = "för" ; c2 = "att" ; obj1 = \\_ => []} ;
  professor_N = {s = table {Sg => "professor" ; Pl => "professorer"} ; c1 = [] ; c2 = [] ; obj1 = \\_ => []} ;
  manager_N2 = {s = table {Sg => "chef" ; Pl => "chefer"} ; c1 = "för" ; c2 = [] ; obj1 = \\_ => []} ;

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
    mkV : (x,y,z,u,v,w : Str) -> V = \x,y,z,u,v,w -> 
      lin V {
        v = table {
              TV Act VInf => x ; TV Act VPres => y ; TV Act VPret => z ; TV Act VSup => u ;
              TV Pass VInf => x + "s" ; TV Pass VPres => init y + "s" ; TV Pass VPret => z + "s" ; TV Pass VSup => u + "s" ;
              PastPart Sg => v ; PastPart Pl => w ; PresPart => x + "nde"
              } ; 
        c1 = [] ; c2 = [] ; isSubjectControl = True} ; 
    mkV : (x,y,z,u,v,w : Str) -> Str -> Str -> V = \x,y,z,u,v,w,p,q -> 
      lin V {
        v = table {
              TV Act VInf => x ; TV Act VPres => y ; TV Act VPret => z ; TV Act VSup => u ;
              TV Pass VInf => x + "s" ; TV Pass VPres => init y + "s" ; TV Pass VPret => z + "s" ; TV Pass VSup => u + "s" ;
              PastPart Sg => v ; PastPart Pl => w ; PresPart => x + "nde"
              } ; 
        c1 = p ; c2 = q  ; isSubjectControl = True} ; 
    } ;

  be_V : V = mkV "vara" "är" "var" "varit" "varen" "varna" ;

  have_V : V = mkV "ha" "har" "hade" "haft" "havd" "havda" ;

  shall_V : V = mkV "skola" "ska" "skulle" "skolat" "skolad" "skolade" ;


---- the following may become parameters for a functor

  neg : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "inte"} ;

  reflPron : Agr -> Str = \a -> case a of {Sg => "sig" ; Pl => "oss"} ;

  infVP : Agr -> VP -> Str = \a,vp -> 
    let 
      a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} 
    in
      vp.adV ++ (vp.inf.p1 | []) ++ vp.inf.p2 ++     ---- *hon tvingar oss att sovit 
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  tenseV : Str -> STense -> Anteriority -> Voice -> V -> Str * Str * Str = \sta,t,a,o,v -> case <t,a> of {  --- sta dummy s field of Ant and Tense
    <Pres,Simul> => <sta ++ v.v ! TV o   VPres,   [],                      []> ;
    <Past,Simul> => <sta ++ v.v ! TV o   VPret,   [],                      []> ;
    <Fut, Simul> => <shall_V.v  ! TV Act VPres,   [],                      sta ++ v.v ! TV o VInf> ;
    <Cond,Simul> => <shall_V.v  ! TV Act VPret,   [],                      sta ++ v.v ! TV o VInf> ;
    <Pres,Anter> => <[],                          have_V.v ! TV Act VPres, sta ++ v.v ! TV o VSup> ;
    <Past,Anter> => <[],                          have_V.v ! TV Act VPret, sta ++ v.v ! TV o VSup> ;
    <Fut, Anter> => <shall_V.v  ! TV Act VPres,   have_V.v ! TV Act VInf,  sta ++ v.v ! TV o VSup> ;
    <Cond,Anter> => <shall_V.v  ! TV Act VPret,   have_V.v ! TV Act VInf,  sta ++ v.v ! TV o VSup> 
    } ;

  tenseInfV : Str -> Anteriority -> Voice -> V -> Str * Str = \sa,a,o,v ->
    case a of {
      Simul => <[],                     sa ++ v.v ! TV o VInf> ;  -- hon vill sova
      Anter => <have_V.v ! TV Act VInf, sa ++ v.v ! TV o VSup>    -- hon vill (ha) sovit
      } ;


  declCl       : Clause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : Clause -> Str = \cl -> cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl ;
  declInvCl    : Clause -> Str = \cl -> cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questCl      : QCl    -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questSubordCl : QCl -> Str = \cl -> 
    let 
      rest = cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl 
    in case cl.focType of {
      NoFoc   => "om" ++ cl.foc          ++ rest ;  -- om hon sover
      FocObj  =>         cl.foc          ++ rest ;  -- vem älskar hon / varför hon sover
      FocSubj =>         cl.foc ++ "som" ++ rest    -- vem som älskar henne
      } ;

  that_Compl : Str = "att" | [] ;

  -- this part is usually the same in all reconfigurations
  restCl : Clause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3 ;

  agentCase : ComplCase = "av" ;

  appComplCase : ComplCase -> NP -> Str = \p,np -> p ++ np.s ! Acc ;

  noComplCase : ComplCase = [] ;

  prepComplCase : Prep -> ComplCase = \p -> p.s ; 

  noObj : Agr => Str = \\_ => [] ;

}