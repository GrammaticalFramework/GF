concrete PredSwe of Pred = CatSwe - [Tense] ** open ResSwe, (P = ParadigmsSwe), CommonScand, ParamX, Prelude in {

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

  Voice    = Act | Pass ;
-}
  Unit     = UUnit ;

-- predication specific   
  FocusType = NoFoc | FocSubj | FocObj ;  -- sover hon/om hon sover, vem älskar hon/vem hon älskar, vem sover/vem som sover 

{-
-- standard Swedish
  Gender   = Utr | Neutr ;
  Agr      = {g : Gender ; n : Number ; p : Person} ;
  Case     = Nom | Gen ;
  NPForm   = NPNom | NPAcc | NPPoss GenNum Case ; 
  VForm    = VF VFin | VI VInf ;

-- above, type names shared with Eng, below Scandinavian only
  VFin = VPres Voice | VPret Voice | VImper Voice ;
  VInf = VInfin  Voice | VSupin  Voice | VPtPret AFormPos Case | VPtPres Number Species Case ;
  VType = VAct | VPass | VRefl ;
  GenNum = GSg Gender | GPl ;
  AFormPos = Strong GenNum | Weak Number ;
  Species = Indef | Def ;
-}

oper
  STense = ParamX.Tense ;

-- language dependent
oper
  VAgr = Unit ;

oper
  subjCase : NPForm = NPNom ;
  objCase  : NPForm = NPAcc ;

  agentCase : ComplCase = "av" ;

  ComplCase = Str ; -- preposition

  NounPhrase = {s : NPForm => Str ; a : Agr} ;
  Preposition = {s : Str} ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> p ++ np.s ! objCase ;
  noComplCase   : ComplCase = [] ;
  prepComplCase : Preposition -> ComplCase = \p -> p.s ; 

  noObj : Agr => Str = \\_ => [] ;

  NAgr = Number ; --- only Indef Nom forms are needed here
  AAgr = AFormPos ;
  IPAgr = {g : Gender ; n : Number} ; --- two separate fields in RGL

  defaultAgr : Agr = {g = Utr ; n = Sg ; p = P3} ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> UUnit ;

  agr2aagr : Agr -> AAgr = \a -> case a.n of {
    Sg => Strong (GSg a.g) ;
    Pl => Strong GPl
    } ;

  agr2nagr : Agr -> NAgr = \a -> a.n ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> a ** {p = P3} ;

  ipagr2vagr : IPAgr -> VAgr = \n -> UUnit ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> defaultAgr ;

  vPastPart : AAgr -> VForm = \a -> VI (VPtPret a Nom) ;
  vPresPart : AAgr -> VForm = \a -> VI (VPtPres Sg Indef Nom) ; ---- Sg

------------------------------------
-- lincats
-------------------------------------
lincat

-- standard general
  Tense = {s : Str ; t : ParamX.Tense} ;
--  Ant   = {s : Str ; a : Anteriority} ;
--  Pol   = {s : Str ; p : Polarity} ;
--  Utt   = {s : Str} ;
--  IAdv  = {s : Str} ;

-- predication-specific
  Arg = {s : Str} ;

  PrV = {
    v  : VForm => Str ;
    p  : Str ;                 -- verb particle             
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    isAux : Bool ;
    isRefl : Bool ;
    } ; 

oper
  PrVerbPhrase = {
    v : VAgr => Str * Str * Str ;  -- would,have,slept
    inf : Str * Str ;              -- have,slept
    c1 : ComplCase ; 
    c2 : ComplCase ; 
    part  : Str ;                  -- (look) up
    adj   : Agr => Str ; 
    obj1  : (Agr => Str) * Agr ;   -- agr for object control
    obj2  : (Agr => Str) * Bool ;  -- subject control = True 
    adv : Str ; 
    adV : Str ;
    ext : Str ;
    qforms : VAgr => Str * Str     -- special Swe for introducing "do" in questions
    } ;
 
  PrClause = {
    v : Str * Str * Str ; 
    inf : Str * Str ; 
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
  IP   = {s : NPCase => Str ; n : IPAgr} ; ---- n : Number in Swe
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
  PrAP  = \ap  -> ap.s ! agr2aagr defaultAgr ++ ap.obj1 ! defaultAgr ;  
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
    obj1 = <case v.isRefl of {True => \\a => reflPron a ; False => \\_ => []}, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, v.isSubjectControl> ;
    adV = negAdV p ; --- just p.s in Swe
    adv = [] ;
    ext = [] ;
    qforms = \\_ => <[],[]> ;  ---- not needed in Swe
    } ;

{- -----------------------------------  
  PassUseV a t p _ v = {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p Pass agr v ;
    inf = tenseInfV a.s a.a p.p Pass v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    adj = noObj ;
    obj1 = <noObj, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, True> ; -- becomes subject control even if object control otherwise "*she was promised by us to love ourselves"
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
    adV = negAdV p ;
    adv = [] ;
    ext = [] ;
    qforms = \\agr => qformsBe (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

---------------------- -}



  SlashV2 x vp np = vp ** {
    obj1 : (Agr => Str) * Agr = <\\a => np.s ! objCase, np.a>  -- np.a for object control 
    } ;

  SlashV3 x vp np = addObj2VP vp (\\a => np.s ! objCase) ; -- control is preserved 

  ComplVS x vp cl = addExtVP vp (that_Compl ++ declSubordCl (lin Cl cl)) ; ---- sentence form

  ComplVQ x vp qcl = addExtVP vp (questSubordCl qcl) ; ---- question form

{---------------

  ComplVV x vp vpo = addObj2VP vp (\\a => infVP a vpo) ; ---- infForm

  ComplVA x vp ap = addObj2VP vp (\\a => ap.s ! agr2aagr a ++ ap.obj1 ! a) ; ---- adjForm

  ComplVN x vp cn = addObj2VP vp (\\a => cn.s ! agr2nagr a ++ cn.obj1 ! a) ; ---- cnForm

  SlashV2S x vp cl = addExtVP vp (that_Compl ++ declSubordCl (lin Cl cl)) ; ---- sentence form

  SlashV2Q x vp cl = addExtVP vp (questSubordCl (lin QCl cl)) ; ---- question form

  SlashV2V x vp vpo = addObj2VP vp (\\a => infVP a (lin VP vpo)) ; ---- infForm

  SlashV2A x vp ap = addObj2VP vp (\\a => ap.s ! agr2aagr a ++ ap.obj1 ! a) ; ---- adjForm

  SlashV2N x vp cn = addObj2VP vp (\\a => cn.s ! agr2nagr a ++ cn.obj1 ! a) ; ---- cn form

  ReflVP x vp = vp ** {
    obj1 : (Agr => Str) * Agr = <\\a => reflPron ! a, defaultAgr> ;  --- defaultAgr will not be used but subj.a instead
    } ;

  ReflVP2 x vp = vp ** {
    obj2 : (Agr => Str) * Bool = <\\a => reflPron ! a, vp.obj2.p2> ; --- subj/obj control doesn't matter any more
    } ;
-} ----------------------


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

  QuestVP x ip vp = 
   let 
     ipa = ipagr2agr {g = ip.g ; n = ip.n} ; ipv = ipagr2vagr {g = ip.g ; n = ip.n} 
   in
   vp ** {
    v    = vp.v ! ipv  ;
    foc  = ip.s ! subjCase ;                      -- who (loves her)
    focType = FocSubj ;
    subj = [] ;
    adj  = vp.adj ! ipa ;
    obj1 = vp.part ++ vp.c1 ++ vp.obj1.p1 ! ipa ; ---- appComplCase
    obj2 = vp.c2 ++ vp.obj2.p1 ! (case vp.obj2.p2 of {True => ipa ; False => vp.obj1.p2}) ; ---- appComplCase
    c3   = noComplCase ;      -- for one more prep to build ClSlash ---- ever needed for QCl?
    qforms = vp.qforms ! ipagr2vagr ipa ;
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

{- -----------------------------

  PresPartAP x v = {            
    s = \\a => v.v ! vPresPart a ;
    c1 = v.c1 ;                    -- looking at her
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  PastPartAP x v = {
    s = \\a => v.v ! vPastPart a ;
    c1 = v.c1 ; 
    c2 = v.c2 ;
    obj1 = noObj ;
    } ;

  AgentPastPartAP x v np = {
    s = \\a => v.v ! vPastPart a ;
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
            PredSwe.infVP a v ++ c.s2 ++ PredSwe.infVP a w ;
    c1 = [] ; ---- w.c1 ? --- the full story is to unify v and w...
    c2 = [] ; ---- w.c2 ? 
    } ;

  UseVPC x vpc = { ---- big loss of quality (overgeneration) seems inevitable
    v   = \\a => <[], [], vpc.v ! a> ;
    inf = <[], vpc.inf ! defaultAgr> ; ---- agreement
    c1  = vpc.c1 ;
    c2  = vpc.c2 ;
    part = [] ;
    adj = \\a => [] ;
    obj1 = <noObj, defaultAgr> ;
    obj2 = <noObj,True> ;
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
    inf  = <[],[]> ;
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



-}






------------------
--- opers --------
------------------

oper 

  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = \cl -> cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl ;
  declInvCl    : PrClause -> Str = \cl -> cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questCl      : PrQCl    -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questSubordCl : PrQCl -> Str = \cl -> 
    let 
      rest = cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl 
    in case cl.focType of {
      NoFoc   => "om" ++ cl.foc          ++ rest ;  -- om hon sover
      FocObj  =>         cl.foc          ++ rest ;  -- vem älskar hon / varför hon sover
      FocSubj =>         cl.foc ++ "som" ++ rest    -- vem som älskar henne
      } ;

  that_Compl : Str = "att" | [] ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3 ;

  negAdV : PredSwe.Pol -> Str = \p -> p.s ++ case p.p of {Pos => [] ; Neg => "inte"} ;

  tenseV : Str -> ParamX.Tense -> Anteriority -> Polarity -> Voice -> VAgr -> PrV -> Str * Str * Str = --- Polarity, VAgr not needed in Swe
       \sta,t,a,_,o,_,v -> case <t,a> of {  --- sta dummy s field of Ant and Tense
    <Pres,Simul> => <sta ++ v.v ! VF (VPres o),   [],                          []> ;
    <Past,Simul> => <sta ++ v.v ! VF (VPret o),   [],                          []> ;
    <Fut, Simul> => <skola_V.s  ! VF (VPres Act), [],                          sta ++ v.v ! VI (VInfin o)> ;
    <Cond,Simul> => <skola_V.s  ! VF (VPret Act), [],                          sta ++ v.v ! VI (VInfin o)> ;
    <Pres,Anter> => <hava_V.s   ! VF (VPres Act), [],                          sta ++ v.v ! VI (VSupin o)> ;
    <Past,Anter> => <hava_V.s   ! VF (VPret Act), [],                          sta ++ v.v ! VI (VSupin o)> ;
    <Fut, Anter> => <skola_V.s  ! VF (VPres Act), hava_V.s ! VI (VInfin Act),  sta ++ v.v ! VI (VSupin o)> ;
    <Cond,Anter> => <skola_V.s  ! VF (VPret Act), hava_V.s ! VI (VInfin Act),  sta ++ v.v ! VI (VSupin o)> 
    } ;

  tenseInfV : Str -> Anteriority -> Polarity -> Voice -> PrV -> Str * Str = \sa,a,_,o,v ->
    case a of {
      Simul => <[],                         sa ++ v.v ! VI (VInfin o)> ;  -- hon vill sova
      Anter => <hava_V.s ! VI (VInfin Act), sa ++ v.v ! VI (VSupin o)>    -- hon vill (ha) sovit
      } ;

  hava_V : V = P.mkV "ha" "har" "ha" "hade" "haft" "havd" ; -- havd not used

  skola_V : V = P.mkV "skola" "ska" "ska" "skulle" "skolat" "skolad" ; ---- not used but ska and skulle

  noObj : Agr => Str = \\_ => [] ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;



}