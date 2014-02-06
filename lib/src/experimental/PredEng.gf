concrete PredEng of Pred = CatEng - [Pol] ** open ResEng, TenseX, Prelude in {

---------------------
-- parameters -------
---------------------

-- standard general
param
{-
  Number   = Sg | Pl ;
  Person   = P1 | P2 | P3 ;
  Anteriority = Simul | Anter ;
  Polarity = Pos | Neg ;
  STense   = Pres | Past | Fut | Cond ;
-}
  Voice    = Act | Pass ;
  Unit     = UUnit ;

-- predication specific   
  FocusType = NoFoc | FocSubj | FocObj ;  -- sover hon/om hon sover, vem älskar hon/vem hon älskar, vem sover/vem som sover 

{-
-- standard English
  Gender   = Neutr | Masc | Fem ;
  Agr      = AgP1 Number | AgP2 Number | AgP3Sg Gender | AgP3Pl ;
  Case     = Nom | Acc ;
  NPCase   = NCase Case | NPAcc | NPNomPoss ;
  VForm    = VInf | VPres | VPast | VPPart | VPresPart ;

  VVForm   = VVF VForm | VVPresNeg | VVPastNeg ---- TODO: add all these to VForm
  VVType   = VVAux | VVInf | VVPresPart
-}

oper
  STense = ResEng.Tense ;

-- language dependent
param
  VAgr     = VASgP1 | VASgP3 | VAPl ;
  VType    = VTAct | VTRefl | VTAux ;

oper
  subjCase : NPCase = NCase Nom ;
  objCase  : NPCase = NPAcc ;

  agentCase : ComplCase = "by" ;

  ComplCase = Str ; -- preposition

  NounPhrase = {s : NPCase => Str ; a : Agr} ;
  Preposition = {s : Str} ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> p ++ np.s ! objCase ;
  noComplCase   : ComplCase = [] ;
  prepComplCase : Preposition -> ComplCase = \p -> p.s ; 

  noObj : Agr => Str = \\_ => [] ;

  NAgr = Number ;
  AAgr = Unit ;
  IPAgr = Number ;

  defaultAgr : Agr = AgP3Sg Neutr ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> case a of {
    AgP1 Sg  => VASgP1 ;
    AgP3Sg _ => VASgP3 ;
    _        => VAPl
    } ;

  agr2aagr : Agr -> AAgr = \n -> UUnit ;

  agr2nagr : Agr -> NAgr = \a -> case a of {
    AgP1 n => n ;
    AgP2 n => n ;
    AgP3Sg _ => Sg ;
    AgP3Pl => Pl
    } ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \n -> case n of {
    Sg => AgP3Sg Neutr ; ---- gender
    Pl => AgP3Pl
    } ;

  ipagr2vagr : IPAgr -> VAgr = \n -> case n of {
    Sg => VASgP3 ;
    Pl => VAPl
    } ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> case a of {
    VASgP1 => AgP1 Sg ;
    VASgP3 => AgP3Sg Neutr ;
    VAPl   => AgP3Pl
    } ;

  vPastPart : AAgr -> VForm = \_ ->  VPPart ;
  vPresPart : AAgr -> VForm = \_ ->  VPresPart ;

------------------------------------
-- lincats
-------------------------------------
lincat
{-
-- standard general
  Tense = {s : Str ; t : STense} ;
  Ant   = {s : Str ; a : Anteriority} ;
  Pol   = {s : Str ; p : Polarity} ;
  Utt   = {s : Str} ;
  IAdv  = {s : Str} ;
-}
  Pol   = {s : Str ; p : Polarity} ;

-- predication-specific
  Arg = {s : Str} ;

  PrV = {
    s  : VForm => Str ;
    p  : Str ;                 -- verb particle             
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    vtype : VType ;  
    vvtype : VVType ;
    } ; 

oper
  PrVerbPhrase = {
    v : VAgr => Str * Str * Str ;  -- would,have,slept
    inf : VVType => Str ;         -- (not) ((to)(sleep|have slept) | (sleeping|having slept)
    c1 : ComplCase ; 
    c2 : ComplCase ; 
    part  : Str ;                  -- (look) up
    adj   : Agr => Str ; 
    obj1  : (Agr => Str) * Agr ;   -- agr for object control
    obj2  : (Agr => Str) * Bool ;  -- subject control = True 
    vvtype : VVType ;              -- type of VP complement
    adv : Str ; 
    adV : Str ;
    ext : Str ;
    qforms : VAgr => Str * Str     -- special Eng for introducing "do" in questions
    } ;
 
  PrClause = {
    v : Str * Str * Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3  : ComplCase ;              -- for a slashed adjunct, not belonging to the verb valency
    qforms : Str * Str
    } ; 

lincat
  PrVP = PrVerbPhrase ;
  PrCl = PrClause ;

  PrQCl = PrClause ** {
    foc : Str ;                   -- the focal position at the beginning: *who* does she love
    focType : FocusType ;         --- if already filled, then use other place: who loves *who*
    } ; 

  VPC = {
    v   : VAgr => Str ;
    inf : Agr => Str ; 
    c1  : ComplCase ; 
    c2  : ComplCase
    } ;

  ClC = {
    s  : Str ;
    c3 : ComplCase ;
    } ;

  PrAdv   = {s : Str ; isAdV : Bool ; c1 : Str} ;
  PrS     = {s : Str} ;

  PrAP = {
    s : AAgr => Str ; 
    c1, c2 : ComplCase ; 
    obj1 : Agr => Str
    } ;

  PrCN = {
    s : NAgr => Str ; 
    c1, c2 : ComplCase ; 
    obj1 : Agr => Str
    } ;
 
{-
-- language specific
  NP   = {s : NPCase => Str ; a : Agr} ;
  IP   = {s : NPCase => Str ; n : IPAgr} ; ---- n : Number in Eng
  Conj = {s1,s2 : Str ; n : Number} ;
-}


-- reference linearizations for chunking

linref
  PrVP  = \vp  -> 
    let 
      agr  = defaultAgr ;
      vagr = agr2vagr agr ;
      verb = vp.v ! vagr ;
    in
    verb.p1 ++ verb.p2 ++ vp.adV ++ verb.p3 ++ vp.part ++ 
    vp.adj ! agr ++ vp.obj1.p1 ! agr ++ vp.obj2.p1 ! agr ++ vp.adv ++ vp.ext ;
 
  PrCl  = \cl  -> declCl cl ;
----  PrQCl = \qcl -> questCl (lin PrQCl qcl) ;
  PrAdv = \adv -> adv.c1 ++ adv.s ;
  PrAP  = \ap  -> ap.s ! UUnit ++ ap.obj1 ! defaultAgr ;  
  PrCN  = \cn  -> cn.s ! Sg ++ cn.obj1 ! defaultAgr ; 
  
----------------------------
--- linearization rules ----
----------------------------

lin

-- standard general

  TPres  = {s = [] ; t = Pres} ;
  TPast  = {s = [] ; t = Past} ;
  TFut   = {s = [] ; t = Fut} ;
  TCond  = {s = [] ; t = Cond} ;
  ASimul = {s = [] ; a = Simul} ;
  AAnter = {s = [] ; a = Anter} ;
  PPos  = {s = [] ; p = Pos} ;
  PNeg  = {s = [] ; p = Neg} ;

-- predication specific

  aNone, aS, aV, aA, aQ, aN = {s = []} ;
  aNP a = a ;

  UseV a t p _ v = {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p Act agr v ;
    inf = tenseInfV a.s a.a p.p Act v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    adj = noObj ;
    obj1 = <case v.vtype of {VTRefl => \\a => reflPron ! a ; _ => \\_ => []}, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, v.isSubjectControl> ;
    vvtype = v.vvtype ;
    adV = negAdV p ; --- just p.s in Eng
    adv = [] ;
    ext = [] ;
    qforms = \\agr => qformsV (a.s ++ t.s ++ p.s) t.t a.a p.p agr v ;
    } ;


  PassUseV a t p _ v = {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass agr v ;
    inf = tenseInfV a.s a.a p.p Pass v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    adj = noObj ;
    obj1 = <noObj, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, True> ; -- becomes subject control even if object control otherwise "*she was promised by us to love ourselves"
    vvtype = v.vvtype ;
    adV = negAdV p ;
    adv = [] ;
    ext = [] ;
    qforms = \\agr => qformsBe (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  AgentPassUseV a t p _ v np = {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass agr v ;
    inf = tenseInfV a.s a.a p.p Pass v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    adj = \\a => [] ;
    obj1 = <noObj, defaultAgr> ; 
    obj2 = <noObj, True> ;
    vvtype = v.vvtype ;
    adV = negAdV p ;
    adv = appComplCase agentCase np ;
    ext = [] ;
    qforms = \\agr => qformsBe (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  UseAP a t p _ ap = {
    v   = \\agr => be_Aux (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    inf = tenseInfV a.s a.a p.p Act be_V ;
    c1  = ap.c1 ;
    c2  = ap.c2 ;
    part = [] ;
    adj = \\a => ap.s ! agr2aagr a ;
    obj1 = <ap.obj1, defaultAgr> ;
    obj2 = <noObj, True> ; --- there are no A3's
    vvtype = be_V.vvtype ;
    adV = negAdV p ;
    adv = [] ;
    ext = [] ;
    qforms = \\agr => qformsBe (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  SlashV2 x vp np = vp ** {
    obj1 : (Agr => Str) * Agr = <\\a => np.s ! objCase, np.a>  -- np.a for object control 
    } ;

  SlashV3 x vp np = addObj2VP vp (\\a => np.s ! objCase) ; -- control is preserved 

  ComplVS x vp cl = addExtVP vp (that_Compl ++ declSubordCl (lin Cl cl)) ; ---- sentence form

  ComplVQ x vp qcl = addExtVP vp (questSubordCl qcl) ; ---- question form

  ComplVV x vp vpo = addObj2VP vp (\\a => infVP vp.vvtype a vpo) ;

  ComplVA x vp ap = addObj2VP vp (\\a => ap.s ! agr2aagr a ++ ap.obj1 ! a) ; ---- adjForm

  ComplVN x vp cn = addObj2VP vp (\\a => cn.s ! agr2nagr a ++ cn.obj1 ! a) ; ---- cnForm

  SlashV2S x vp cl = addExtVP vp (that_Compl ++ declSubordCl (lin Cl cl)) ; ---- sentence form

  SlashV2Q x vp cl = addExtVP vp (questSubordCl (lin QCl cl)) ; ---- question form

  SlashV2V x vp vpo = addObj2VP vp (\\a => infVP vp.vvtype a (lin VP vpo)) ;

  SlashV2A x vp ap = addObj2VP vp (\\a => ap.s ! agr2aagr a ++ ap.obj1 ! a) ; ---- adjForm

  SlashV2N x vp cn = addObj2VP vp (\\a => cn.s ! agr2nagr a ++ cn.obj1 ! a) ; ---- cn form

  ReflVP x vp = vp ** {
    obj1 : (Agr => Str) * Agr = <\\a => reflPron ! a, defaultAgr> ;  --- defaultAgr will not be used but subj.a instead
    } ;

  ReflVP2 x vp = vp ** {
    obj2 : (Agr => Str) * Bool = <\\a => reflPron ! a, vp.obj2.p2> ; --- subj/obj control doesn't matter any more
    } ;

  PredVP x np vp = vp ** {
    v    = vp.v ! agr2vagr np.a ;
    subj = np.s ! subjCase ;
    adj  = vp.adj ! np.a ;
    obj1 = vp.part ++ vp.c1 ++ vp.obj1.p1 ! np.a ;  ---- apply complCase ---- place of part depends on obj
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => np.a ; False => vp.obj1.p2}) ;   ---- apply complCase
    c3   = noComplCase ;      -- for one more prep to build ClSlash 
    qforms = vp.qforms ! agr2vagr np.a ;
    } ;

  PrepCl p x cl = cl ** {   -- Cl/NP ::= Cl PP/NP
    c3   = prepComplCase p ; 
    } ;

  SlashClNP x cl np = cl ** {  -- Cl ::= Cl/NP NP 
    adv  = cl.adv ++ appComplCase cl.c3 np ; ---- again, adv just added
    c3   = noComplCase ;  -- complCase has been consumed
    } ;


-- QCl ::= Cl by just adding focus field
  QuestCl x cl = cl ** {foc = [] ; focType = NoFoc} ;  -- NoFoc implies verb first: does she love us

  QuestIAdv x iadv cl = cl ** {foc = iadv.s ; focType = FocObj} ; -- FocObj implies Foc + V + Subj: why does she love us

  QuestVP x ip vp = let ipa = ipagr2agr ip.n in
   vp ** {
    v    = vp.v ! ipagr2vagr ip.n ;
    foc  = ip.s ! subjCase ;                      -- who (loves her)
    focType = FocSubj ;
    subj = [] ;
    adj  = vp.adj ! ipa ;
    obj1 = vp.part ++ vp.c1 ++ vp.obj1.p1 ! ipa ; ---- appComplCase
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ipa ; False => vp.obj1.p2}) ; ---- appComplCase
    c3   = noComplCase ;      -- for one more prep to build ClSlash ---- ever needed for QCl?
    qforms = vp.qforms ! ipagr2vagr ip.n ;
    } ;

  QuestSlash x ip cl = 
    let 
      prep = cl.c3 ;
      ips  = ip.s ! objCase ;                     -- in Cl/NP, c3 is the only prep ---- appComplCase for ip
      focobj = case cl.focType of {
        NoFoc => <ips, [], FocObj,prep> ;         -- put ip object to focus  if there is no focus yet
        t     => <[], prep ++ ips, t,noComplCase> -- put ip object in situ   if there already is a focus
        } ;
    in 
    cl ** {     -- preposition stranding
      foc     = focobj.p1 ;
      focType = focobj.p3 ;
      obj1    = cl.obj1 ++ focobj.p2 ;     ---- just add to a field?
      c3      = focobj.p4 ; 
      } ;  
{-
---- this is giving four records instead of two AR 5/2/2014 
   |
    cl ** {   -- pied piping
      foc     = focobj.p4 ++ focobj.p1 ;
      focType = focobj.p3 ;
      obj1    = cl.obj1 ++ focobj.p2 ;     ---- just add to a field?
      c3      = noComplCase ; 
      } ;
-}

  UseCl  cl = {s = declCl cl} ;
  UseQCl cl = {s = questCl cl} ;

----  UseAdvCl adv cl = {s = adv.s ++ declInvCl cl} ;

  UttS s = s ;


  AdvCl x a cl = case a.isAdV of {
    True  => cl ** {adV = cl.adV ++ a.s ; adv = cl.adv ; c3 = a.c1} ; 
    False => cl ** {adv = cl.adv ++ a.s ; adV = cl.adV ; c3 = a.c1}
    } ;

  AdvQCl x a cl = case a.isAdV of {
    True  => cl ** {adV = cl.adV ++ a.s ; adv = cl.adv ; c3 = a.c1} ; 
    False => cl ** {adv = cl.adv ++ a.s ; adV = cl.adV ; c3 = a.c1}
    } ;


  PresPartAP x v = {            
    s = \\a => v.s ! vPresPart a ;
    c1 = v.c1 ;                    -- looking at her
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  PastPartAP x v = {
    s = \\a => v.s ! vPastPart a ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  AgentPastPartAP x v np = {
    s = \\a => v.s ! vPastPart a ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = \\_ => appComplCase agentCase np ; ---- addObj
    } ;


  StartVPC c x v w = {  ---- some loss of quality seems inevitable
    v = \\a => 
          let 
            vv = v.v ! a ; 
            wv = w.v ! a ;
            vpa = vagr2agr a ;
          in 
          vv.p1 ++ v.adV ++ vv.p2 ++ vv.p3 ++ v.adj ! vpa ++ 
          v.c1 ++ v.obj1.p1 ! vpa ++ v.c2 ++ v.obj2.p1 ! vpa ++ v.adv ++ v.ext   ---- appComplCase
            ++ c.s2 ++  
          wv.p1 ++ w.adV ++ wv.p2 ++ wv.p3 ++ w.adj ! vpa ++                ---- appComplCase
          w.c1 ++ w.obj1.p1 ! vpa ++ w.c2 ++ w.obj2.p1 ! vpa ++ w.adv ++ w.ext ;
    inf = \\a => 
            PredEng.infVP v.vvtype a v ++ c.s2 ++ PredEng.infVP w.vvtype a w ;
    c1 = [] ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = [] ; ---- w.c2 ? 
    } ;

  UseVPC x vpc = { ---- big loss of quality (overgeneration) seems inevitable
    v   = \\a => <[], [], vpc.v ! a> ;
    inf = \\_ => vpc.inf ! defaultAgr ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    part = [] ;
    adj = \\a => [] ;
    obj1 = <noObj, defaultAgr> ;
    obj2 = <noObj,True> ;
    vvtype = VVInf ; ----
    adv,adV = [] ;
    ext = [] ;
    qforms = \\a => <"do", vpc.inf ! defaultAgr> ; ---- do/does/did
    } ;

  StartClC c x a b = {
    s  = declCl (lin Cl a) ++ c.s2 ++ declCl (lin Cl b) ;
    c3 = b.c3 ; ---- 
    } ;

  UseClC x cl = {
    subj = [] ;
    v    = <[],[],cl.s> ; ----
    inf  = [] ;
    adj  = [] ;
    obj1 = [] ;
    obj2 = [] ;
    adV  = [] ;
    adv  = [] ;
    ext  = [] ;
    c3   = cl.c3 ;
    qforms = <[],[]> ; ---- qforms
    } ;

  ComplAdv x p np = {s = p.c1 ++ np.s ! objCase ; isAdV = p.isAdV ; c1 = []} ;





oper
  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    let 
      a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} ;
    in
      vp.adV ++ vp.inf ! vt ++ vp.part ++
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrV -> Str * Str = 
    \sta,t,a,p,agr,v -> 
    let 
      verb  = tenseActV sta t a Neg agr v ;
      averb = tenseActV sta t a p agr v
    in case <v.vtype, t, a> of {
      <VTAct|VTRefl, Pres|Past, Simul> => case p of {
        Pos => < verb.p1,           verb.p3> ;   -- does , sleep
        Neg => < verb.p1,  verb.p2>              -- does , not sleep  ---- TODO: doesn't , sleep
        } ; 
      _  => <averb.p1, averb.p2>
      } ;

  qformsBe : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> 
    let verb = be_AuxL sta t a p agr
    in <verb.p1, verb.p2> ;                     -- is , not  ---- TODO isn't , 

  tenseV : Str -> STense -> Anteriority -> Polarity -> Voice -> VAgr -> PrV -> Str * Str * Str = 
    \sta,t,a,p,o,agr,v -> 
    case o of {  
      Act  => tenseActV sta t a p agr v ;
      Pass => tensePassV sta t a p agr v 
      } {-
      |    ---- leaving out these variants makes compilation time go down from 900ms to 300ms. 
           ---- parsing time of "she sleeps" goes down from 300ms to 60ms. 4/2/2014 
    case o of {  
      Act  => tenseActVContracted sta t a p agr v ;
      Pass => tensePassVContracted sta t a p agr v
      -} ;

  tenseActV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrV -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let vt : VForm = case <t,agr> of {
        <Pres,VASgP3>  => VPres ; 
        <Past|Cond,_ > => VPast ; 
        _              => VInf
        } ; 
    in 
    case <t,a> of {  
    <Pres|Past, Simul> =>
      case v.vtype of {
        VTAux          => <sta ++ v.s ! vt,      [],                              []> ;
        _              => case p of {
          Pos          => <[],                   sta ++ v.s ! vt,                 []> ;                 -- this is the deviating case
          Neg          => <do_Aux       vt Pos,  not_Str p,                       sta ++ v.s ! VInf>
          }
       } ;

    <Pres|Past, Anter> => <have_Aux     vt Pos,  not_Str p,                       sta ++ v.s ! VPPart> ;
    <Fut|Cond,  Simul> => <will_Aux     vt Pos,  not_Str p,                       sta ++ v.s ! VInf> ;
    <Fut|Cond,  Anter> => <will_Aux     vt Pos,  not_Str p ++ have_Aux VInf Pos,  sta ++ v.s ! VPPart>
    } ;

  tenseActVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrV -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let vt : VForm = case <t,agr> of {
        <Pres,VASgP3>  => VPres ; 
        <Past|Cond,_ > => VPast ; 
        _              => VInf
        } ; 
    in 

    case <t,a> of {  
    <Pres|Past, Simul> =>
      case v.vtype of {
        VTAux          => <sta ++ v.s ! vt,      [],                              []> ;
        _              => case p of {
          Pos          => <[],                   sta ++ v.s ! vt,                 []> ;                 -- this is the deviating case
          Neg          => <do_Aux       vt p,    [],                              sta ++ v.s ! VInf>
          }
       } ;
    <Pres|Past, Anter> => <have_AuxC    vt p,    [],                              sta ++ v.s ! VPPart>
                        | <have_AuxC    vt Pos,  not_Str p,                       sta ++ v.s ! VPPart> ; 
    <Fut|Cond,  Simul> => <will_AuxC    vt p,    [],                              sta ++ v.s ! VInf>
                        | <will_AuxC    vt Pos,  not_Str p,                       sta ++ v.s ! VInf> ; 
    <Fut|Cond,  Anter> => <will_AuxC    vt p,    have_Aux VInf Pos,               sta ++ v.s ! VPPart>
                        | <will_AuxC    vt Pos,  not_Str p ++ have_Aux VInf Pos,  sta ++ v.s ! VPPart> 
    } ;

  tensePassV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrV -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxL sta t a p agr ;
      done = v.s ! VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;
  tensePassVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrV -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxC sta t a p agr ;
      done = v.s ! VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;

  tenseInfV : Str -> Anteriority -> Polarity -> Voice -> PrV -> VVType => Str = \sa,a,p,o,v -> \\vt => 
    let 
      not = case p of {Pos => [] ; Neg => "not"} ;
    in
    case vt of {
      VVInf => 
        case a of {
          Simul => not ++ "to" ++                      sa ++ v.s ! VInf ;       -- (she wants) (not) to sleep
          Anter => not ++ "to" ++ have_Aux VInf Pos ++ sa ++ v.s ! VPPart       -- (she wants) (not) to have slept
          } ;
      VVAux =>
        case a of {
          Simul => not ++                              sa ++ v.s ! VInf ;       -- (she must) (not) sleep
          Anter => not ++         have_Aux VInf Pos ++ sa ++ v.s ! VPPart       -- (she must) (not) have slept
          } ;
     VVPresPart =>
        case a of {
          Simul => not ++                              sa ++ v.s ! VPresPart ;  -- (she starts) (not) sleeping
          Anter => not ++         "having"          ++ sa ++ v.s ! VPPart       -- (she starts) (not) having slept
          }
     } ;

----- dangerous variants for PMCFG generation - keep apart as long as possible
  be_Aux : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \sta,t,a,p,agr -> 
    be_AuxL sta t a p agr | be_AuxC sta t a p agr ; 
  be_AuxL : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \sta,t,a,p,agr -> 
    let 
      beV = tenseActV sta t a p agr be_V 
    in
    case <t,a,p,agr> of {
      <Pres,Simul,Pos,VASgP3> => <"is" ++ sta,                 [],    []> ;
      <Pres,Simul,Pos,VASgP1> => <"am" ++ sta,                 [],    []> ;
      <Pres,Simul,Pos,VAPl>   => <"are" ++ sta,                [],    []> ;
      <Pres,Simul,Neg,VASgP3> => <"is" ++ sta,                 "not", []> ;
      <Pres,Simul,Neg,VASgP1> => <"am" ++ sta,                 "not", []> ;
      <Pres,Simul,Neg,VAPl>   => <"are" ++ sta,                "not", []> ;
      <Past,Simul,Pos,VAPl>   => <"were" ++ sta,               [],    []> ; 
      <Past,Simul,Neg,VAPl>   => <"were" ++ sta,               "not", []> ;
      <Past,Simul,Neg,_>      => <"was" ++ sta,                "not", []>  ;
      _ => beV
      } ;
  be_AuxC : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \sta,t,a,p,agr -> 
    let 
      beV = tenseActVContracted sta t a p agr be_V 
    in
    case <t,a,p,agr> of {
      <Pres,Simul,Pos,VASgP3> => <Predef.BIND ++ "'s" ++ sta,  [],    []> ;
      <Pres,Simul,Pos,VASgP1> => <Predef.BIND ++ "'m" ++ sta,  [],    []> ;
      <Pres,Simul,Pos,VAPl>   => <Predef.BIND ++ "'re" ++ sta, [],    []> ;
      <Pres,Simul,Neg,VASgP3> => <Predef.BIND ++ "'s" ++ sta,  "not", []>
                               | <"isn't" ++ sta,              [],    []> ;
      <Pres,Simul,Neg,VASgP1> => <Predef.BIND ++ "'m" ++ sta,  "not", []> ;
      <Pres,Simul,Neg,VAPl>   => <Predef.BIND ++ "'re" ++ sta, "not", []>
                               | <"aren't" ++ sta,             [],    []> ;
      <Past,Simul,Pos,VAPl>   => <"were" ++ sta,               [],    []> ; 
      <Past,Simul,Neg,VAPl>   => <"weren't" ++ sta,            [],    []> ;
      <Past,Simul,Neg,_>      => <"wasn't" ++ sta,            [],    []> ;
      _ => beV
      } ;

  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = declCl ;
  declInvCl    : PrClause -> Str = declCl ;

  questCl : PrQCl -> Str = \cl -> case cl.focType of {
    NoFoc   => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- does she sleep
    FocObj  => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- who does she love
    FocSubj => cl.foc ++ cl.v.p1      ++ cl.subj ++ cl.adV ++ cl.v.p2      ++ restCl cl    -- who loves her
    } ;

  questSubordCl : PrQCl -> Str = \cl -> 
    let 
      rest = cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ restCl cl 
    in case cl.focType of {
      NoFoc   => "if" ++ cl.foc ++ rest ;  -- om she sleeps
      FocObj  =>         cl.foc ++ rest ;  -- who she loves / why she sleeps
      FocSubj =>         cl.foc ++ rest    -- who loves her
      } ;

  that_Compl : Str = "that" | [] ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3 ;


  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;




oper
  be_V : PrV = lin PrV {
    s = table {
      VInf => "be" ;
      VPres => "is" ;
      VPast => "was" ;
      VPPart => "been" ;
      VPresPart => "being"
      } ;
    p,c1,c2 = [] ; vtype = VTAux ; vvtype = VVInf ; isSubjectControl = False
    } ;

  negAdV : PredEng.Pol -> Str = \p -> p.s ;






oper
---- have to split the tables to two to get reasonable PMCFG generation
  will_Aux : VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf|VPres, Pos> => varAux "will" "ll" ;
    <VInf|VPres, Neg> => "won't" ;
    <VPast|_   , Pos> => varAux "would" "d" ; 
    <VPast|_   , Neg> => "wouldn't"
    } ; 
  will_AuxC : VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf|VPres, Pos> => varAuxC "will" "ll" ;
    <VInf|VPres, Neg> => "won't" ;
    <VPast|_   , Pos> => varAuxC "would" "d" ; 
    <VPast|_   , Neg> => "wouldn't"
    } ; 

  have_Aux : VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf,     Pos> => varAux "have" "ve" ;  --- slightly overgenerating if used in infinitive
    <VInf,     Neg> => "haven't" ;
    <VPres,    Pos> => varAux "has" "s" ;
    <VPres,    Neg> => "hasn't" ;
    <VPast|_ , Pos> => varAux "had" "d" ; 
    <VPast|_ , Neg> => "hadn't"
    } ; 
  have_AuxC : VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf,     Pos> => varAuxC "have" "ve" ;  --- slightly overgenerating if used in infinitive
    <VInf,     Neg> => "haven't" ;
    <VPres,    Pos> => varAuxC "has" "s" ;
    <VPres,    Neg> => "hasn't" ;
    <VPast|_ , Pos> => varAuxC "had" "d" ; 
    <VPast|_ , Neg> => "hadn't"
    } ; 

  do_Aux : VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf,     Pos> => "do" ;
    <VInf,     Neg> => "don't" ;
    <VPres,    Pos> => "does" ;
    <VPres,    Neg> => "doesn't" ;
    <VPast|_ , Pos> => "did" ; 
    <VPast|_ , Neg> => "didn't"
    } ; 

  varAux  : Str -> Str -> Str = \long,short -> long ; ----| Predef.BIND ++ ("'" + short) ;
  varAuxC : Str -> Str -> Str = \long,short ->              Predef.BIND ++ ("'" + short) ;

  not_Str : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "not"} ;

}