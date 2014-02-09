instance PredInstanceFin of 
  PredInterface - [
    NounPhrase,
    PrVerb, initPrVerb,
    PrVerbPhrase, initPrVerbPhrase, initPrVerbPhraseV, useCopula
  ] = 
      open ResFin, (P = ParadigmsFin), (S = StemFin), (X = ParamX), Prelude in {

-- overrides

oper
  NounPhrase = ResFin.NP ;

  PrVerb = StemFin.SVerb1 ** {
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    vtype : VType ;  
    vvtype : VVType ;
    } ; 

  initPrVerb : PrVerb = {
    s = \\_ => [] ;
    sc = subjCase ;
    h = Back ;
    p = [] ; 
    c1,c2 = noComplCase ; isSubjectControl = True ; vtype = defaultVType ; vvtype = vvInfinitive
    } ; 

  PrVerbPhrase = {
    v   : S.SVerb1 ;                
    atp : {a : Anteriority ; t : STense ; p : Polarity ; as,ts,ps : Str} ;
    vtype : VType ;
    c1 : ComplCase ; 
    c2 : ComplCase ; 
    part  : Str ;                  -- (look) up
    adj   : Agr => Str ; 
    obj1  : (Agr => Str) * Agr ;   -- agr for object control
    obj2  : (Agr => Str) * Bool ;  -- subject control = True 
    vvtype : VVType ;              -- type of VP complement
    adv : Str ; 
    adV : Str ;
    ext : Str 
    } ;

  initPrVerbPhrase : PrVerbPhrase = {
    v : S.SVerb1 = initPrVerb ;
    atp = {a = Simul ; t = Pres ; p = Pos ; as,ts,ps = []} ;
    vtype = defaultVType ;
    c1 : ComplCase = noComplCase ; 
    c2 : ComplCase = noComplCase ; 
    part  : Str = [] ;                  -- (look) up
    adj   : Agr => Str = noObj ; 
    obj1  : (Agr => Str) * Agr = <\\_ => [], defaultAgr> ;   -- agr for object control
    obj2  : (Agr => Str) * Bool = <\\_ => [], True>;  -- subject control = True 
    vvtype : VVType = vvInfinitive ;              -- type of VP complement
    adv : Str = [] ; 
    adV : Str = [] ;
    ext : Str = [] ;
    qforms : VAgr => Str * Str = \\_ => <[],[]>    -- special Eng for introducing "do" in questions
    } ;

  initPrVerbPhraseV : 
       {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerb -> PrVerbPhrase = 
  \a,t,p,v -> initPrVerbPhrase ** {
    v   : S.SVerb1 = v ;
    atp = {a = a.a ; t = t.t ; p = p.p ; as = a.s ; ts = t.s ; ps = p.s} ;
    vtype = v.vtype ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    obj1 = <case isRefl v of {True => \\a => reflPron a ; _ => \\_ => []}, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, v.isSubjectControl> ;
    vvtype = v.vvtype ;
    adV = negAdV p ; --- just p.s in Fin
    } ;

  useCopula : {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerbPhrase =
    \a,t,p -> initPrVerbPhraseV a t p (liftV P.olla_V) ;


---------------------
-- parameters -------
---------------------

oper
  Agr    = ResFin.Agr ;
  Case   = ResFin.Case ;
  NPCase = ResFin.NPForm ;
  VForm  = S.SVForm ;
  VVType = ResFin.InfForm ;
  VType  = Voice ; ----
  Gender = Unit ; ----

  VAgr   = Agr ;

  SVoice = Voice ;

oper
  active = Act ;
  passive = Pass ;

  defaultVType = Act ;

  subjCase : NPCase = ResFin.NPCase Nom ;
  objCase  : NPCase = NPAcc ;

  ComplCase = ResFin.Compl ; -- preposition
  agentCase : ComplCase = P.postGenPrep "toimesta" ;
  strComplCase : ComplCase -> Str = \c -> c.s ! False ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> appCompl True Pos p np ;
  noComplCase   : ComplCase = P.postGenPrep [] ; ----

  noObj : Agr => Str = \\_ => [] ;

  NAgr = Number ; 
  IPAgr = Number ; --- two separate fields in RGL

  defaultAgr : Agr = Ag Sg P3 ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> a ;

  agr2aagr : Agr -> AAgr = \a -> a ;

  agr2nagr : Agr -> NAgr = \a -> case a of {Ag n _ => n ; AgPol => Sg} ; -- minä olen pomo / te olette pomoja / te olette pomo

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> Ag a P3 ;

  ipagr2vagr : IPAgr -> VAgr = \n -> Ag n P3 ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> a ;

  vPastPart : PrVerb -> AAgr -> Str = \v,a -> (S.sverb2verbSep v).s ! PastPartPass (AN (NCase Sg Part)) ; ---- case
  vPresPart : PrVerb -> AAgr -> Str = \v,a -> (S.sverb2verbSep v).s ! PresPartAct (AN (NCase Sg Part)) ; ---- case

  vvInfinitive : VVType = Inf1 ;

  isRefl : PrVerb -> Bool = \_ -> False ; ----


------------------
--- opers --------
------------------

oper 
  reflPron : Agr -> Str = \a -> (ResFin.reflPron a).s ! NPAcc ; ---- case

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a, pvp -> 
    let
      ipol = pvp.atp.p ;
      sc   = pvp.v.sc ;
      pol  = Pos ; ----
      agr  = a ;
      vi   = vt ;
      vp0  : S.VP = {
        s = pvp.v ;
        s2 = \\b,p,agr => pvp.obj1.p1 ! agr ++ pvp.obj2.p1 ! agr ;
        adv = \\_ => pvp.adV ++ pvp.adv ;
        ext = pvp.ext ;
        vptyp = {isNeg = False ; isPass = case pvp.vtype of {Pass => True ; _ => False}} ;
        }
    in
    S.infVPGen -- : Polarity -> NPForm -> Polarity -> Agr -> VP -> InfForm -> Str =
        ipol sc pol agr vp0 vi ;

  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = \cl -> cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl ;
  declInvCl    : PrClause -> Str = \cl -> cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questCl      : PrQuestionClause -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questSubordCl : PrQuestionClause -> Str = questCl ;

  that_Compl : Str = "että" ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3.s ! False ; ---- c3

  negAdV :  {s : Str ; p : Polarity} -> Str = \p -> p.s ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = 
       \sta,t,a,pol,o,agr,v -> 
   let 
     ovps = (S.vp2old_vp (S.predV v)).s ! VIFin t ! a ! pol ! agr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
     act = Act 
   in
   <sta ++ ovps.fin, ovps.inf, []> ;

  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str = 
      \sa,a,pol,o,v,vt ->
   let vt = Inf1 ; ----
     ovps = (S.vp2old_vp (S.predV v)).s ! VIInf vt ! a ! pol ! defaultAgr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
   in
   sa ++ ovps.fin ++ ovps.inf ;

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str =
    \s,t,a,p,agr -> tenseV s t a p Act agr (liftV P.olla_V) ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str =
    \s,a,p,vt -> tenseInfV s a p Act (liftV P.olla_V) vt ;

  noObj : Agr => Str = \\_ => [] ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;

  not_Str : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => "inte"} ;

  liftV : S.SVerb1 -> PrVerb = \v -> initPrVerb ** v ;

--- junk

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ;
  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> <[],[]> ;

}