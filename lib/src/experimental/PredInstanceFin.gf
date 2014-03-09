instance PredInstanceFin of 
  PredInterface - [
    NounPhrase, 
    PrVerb, initPrVerb,
    PrVerbPhrase, initPrVerbPhrase, initPrVerbPhraseV, useCopula, linrefPrVP, qformsVP, applyVerb, addObj2VP,
    initBasePrVerbPhrase, initBasePrVerbPhraseV, 
    PrClause, initPrClause
  ] = 
      open ResFin, (P = ParadigmsFin), (S = StemFin), (X = ParamX), Prelude in {

-- overrides

oper
  NounPhrase = ResFin.NP ;

  PrVerb = StemFin.SVerb1 ** {
    c1 : ComplCase ; 
    c2 : ComplCase ;
    vvtype : ResFin.VVType ;
    } ; 

  initPrVerb : PrVerb = {
    s = \\_ => [] ;
    sc = SCNom ;
    h = Back ;
    p = [] ; 
    c1,c2 = noComplCase ; isSubjectControl = True ; vtype = Act ; vvtype = VVInf ;
    } ; 

  PrVerbPhrase = {
    v   : Agr => {fin,inf : Str} ;
    inf : VPIType => Str ;
    imp : ImpType => Str ;
    adj : Agr => Str ;
    obj1 : Agr => Str ;             -- Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    obj2 : Agr => Str ;             -- Bool => Polarity => Agr => Str ; -- talo/talon/taloa
    adv : Str ;                     -- Polarity => Str ;        -- ainakin/ainakaan
    adV : Str ;                     -- Polarity => Str ;        -- ainakin/ainakaan
    ext : Str ;
    isNeg : Bool ;  -- True if some complement is negative
    isPass : Bool ; -- True if the verb is rendered in the passive
    vvtype : ResFin.VVType ;
    sc : SubjCase ;
    h  : Harmony ;
    c1 : Compl ;
    c2 : Compl ;
    qforms : VAgr => Str * Str ;
    } ;

  initPrVerbPhrase : PrVerbPhrase = {
    v : Agr => {fin,inf : Str} = \\_ => {fin,inf = []} ;
    inf : VPIType => Str = \\vtt => [] ;
    imp : ImpType => Str = \\_ => [] ;
    adj : Agr => Str = \\_ => [] ;
    obj1 : Agr => Str = \\_ => [] ;
    obj2 : Agr => Str = \\_ => [] ;
    adv : Str = [] ;
    adV : Str = [] ;
    ext : Str = [] ;
    isNeg : Bool = True ;
    isPass : Bool = False ;
    c1 : Compl = noComplCase ;
    c2 : Compl = noComplCase ;
    vvtype = VVInf ;
    sc = SCNom ;
    h = Back ;
    qforms : VAgr => Str * Str = \\_ => <[],[]>    -- special Eng for introducing "do" in questions
    } ;

  initPrVerbPhraseV : 
       {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerb -> PrVerbPhrase = 
  \a,t,p,verb -> 
  initPrVerbPhrase ** {
    v : Agr => {fin,inf : Str} = case verb.sc of {
       SCNom => \\agr => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Act agr        (lin PrV verb) ;
       _     => \\_   => finV (a.s ++ t.s ++ p.s) t.t a.a p.p Act defaultAgr (lin PrV verb)
       } ;
    inf : VPIType => Str = \\vtt => tenseInfV (a.s ++ p.s) a.a p.p Act (lin PrV verb) vtt ;
    imp : ImpType => Str = \\it => imperativeV p.s p.p it (lin PrV verb) ;
    adj : Agr => Str = \\_ => [] ;
    obj1 : Agr => Str = \\_ => [] ;
    obj2 : Agr => Str = \\_ => [] ;
    adv : Str = [] ;
    adV : Str = [] ;
    ext : Str = [] ;
    isNeg : Bool = False ;
    isPass : Bool = False ;
    c1 : Compl = verb.c1 ;
    c2 : Compl = verb.c2 ;
    vvtype = verb.vvtype ;
    sc = verb.sc ;
    h = case a.a of {Anter => Back ; _ => verb.h} ;
    } ;

  useCopula : {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerbPhrase =
    \a,t,p -> initPrVerbPhraseV a t p (liftV P.olla_V) ;

  linrefPrVP : PrVerbPhrase -> Str = \_ -> "verbphrase" ; ----

  PrClause = {
    subj : Str ;
    verb : {fin,inf : Str} ;
    adj  : Str ;
    obj1 : Str ; 
    obj2 : Str ; 
    adv  : Str ;
    adV  : Str ;
    ext  : Str ; 
    h    : Harmony ;
    c3   : Compl ;
    } ;
  initPrClause : PrClause = {
    subj : Str = [] ;
    verb : {fin,inf : Str} = {fin,inf = []} ;
    adj  : Str = [] ; 
    obj1 : Str = [] ; 
    obj2 : Str = [] ; 
    adv  : Str = [] ;
    adV  : Str = [] ;
    ext  : Str = [] ; 
    h    : Harmony = Back ;
    c3   : Compl = noComplCase ;
    } ;

---------------------
-- parameters -------
---------------------

oper
  Agr    = ResFin.Agr ;
  Case   = ResFin.Case ;
  NPCase = ResFin.NPForm ;
  VForm  = S.SVForm ;
  VVType = VPIType ;
  VType  = Voice ; ----
  Gender = Unit ; ----

  VAgr   = Agr ;

  SVoice = Voice ;

oper
  active = Act ;
  passive = Pass ;

  defaultVType = Act ;
  defaultVVType = vvInfinitive ;

  subjCase : NPCase = ResFin.NPCase Nom ;
  objCase  : NPCase = NPAcc ;

  ComplCase = ResFin.Compl ; -- preposition
  agentCase : ComplCase = P.postGenPrep "toimesta" ;
  strComplCase : ComplCase -> Str = \c -> c.s.p1 ++ c.s.p2 ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> appCompl True Pos p np ;
  noComplCase   : ComplCase = P.accPrep ; ----

  noObj : Agr => Str = \\_ => [] ;

  RPCase = NPCase ; 
  subjRPCase : Agr -> RPCase = \a -> subjCase ;

  NAgr = Number ; 
  IPAgr = Number ; --- two separate fields in RGL
  RPAgr = ResFin.RAgr ;
  ICAgr = Agr ;

  defaultAgr : Agr = Ag Sg P3 ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> a ;

  agr2aagr : Agr -> AAgr = \a -> a ;

  agr2nagr : Agr -> NAgr = \a -> case a of {Ag n _ => n ; AgPol => Sg} ; -- minä olen pomo / te olette pomoja / te olette pomo

  agr2icagr : Agr -> ICAgr = \a -> a ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> Ag a P3 ;

  ipagr2vagr : IPAgr -> VAgr = \n -> Ag n P3 ;

  rpagr2agr : RPAgr -> Agr -> Agr = \ra,a -> case ra of {
    RAg ag => ag ;
    RNoAg => a
    } ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> a ;

  vPastPart : PrVerb -> AAgr -> Str = \v,a -> (S.sverb2verbSep v).s ! PastPartPass (aForm a) ;
  vPresPart : PrVerb -> AAgr -> Str = \v,a -> (S.sverb2verbSep v).s ! PresPartAct (aForm a) ;

-- predicative adjective form
  aForm : AAgr -> AForm = \a -> case a of {
    Ag Pl _ => AN (NCase Pl Part) ;
    _       => AN (NCase Sg Nom)
    } ;
---- TODO: case system of PrAP

  vvInfinitive : VVType = VPIVV VVInf ;

  isRefl : PrVerb -> Bool = \_ -> False ; ----

-- the forms outside VPIVV to be used in adverbials such as "tekemällä" 
param
  VPIType = VPIVV (ResFin.VVType) 
          | VPIInf3Adess | VPIInf3Abess | VPIInf2Iness | VPIInf1Long {- | VPIPastPartPassPart -} | VPIInf4Part ;
         -- tekemällä, tekemättä, tehdessä, tehdäkseen, tehtyään, tekemistä

------------------
--- opers --------
------------------

oper 
  reflPron : Agr -> Str = \a -> (ResFin.reflPron a).s ! NPAcc ; ---- case

  finV : Str -> STense -> Anteriority -> Polarity -> SVoice -> Agr -> PrVerb -> {fin,inf : Str} =
       \sta,t,a,pol,o,agr,v -> 
    let 
      vit = case o of {Act => VIFin t ; Pass => VIPass t} ;
      ovps = (S.vp2old_vp (S.predV v)).s ! vit ! a ! pol ! agr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
    in
    {fin = sta ++ ovps.fin ; inf = ovps.inf} ;

  infV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VPIType -> Str = 
      \sa,a,pol,o,v,vvt ->
   let 
     vt = case vvt of {
       VPIVV vi => VIInf (vvtype2infform vi) ;
       VPIInf3Adess => VIInf Inf3Adess ;
       VPIInf3Abess => VIInf Inf3Abess ;
       VPIInf2Iness => VIInf Inf2Iness ;
       VPIInf1Long  => VIInf Inf1Long ;
----       VPIPastPartPassPart => PastPartPass (AN (NCase Sg Part)) ; 
       VPIInf4Part => VIInf Inf4Part 
       } ;
     ovps = (S.vp2old_vp (S.predV v)).s ! vt ! a ! pol ! defaultAgr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
   in
   sa ++ ovps.fin ++ ovps.inf ;

  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str = infV ;
{-
      \sa,a,pol,o,v,vt ->
   let vt = Inf1 ; ----
     ovps = (S.vp2old_vp (S.predV v)).s ! VIInf vt ! a ! pol ! defaultAgr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
   in
   sa ++ ovps.fin ++ ovps.inf ;
-}

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vvt,agr,vp ->
    vp.inf ! vvt ++ vp.adV ++ vp.adj ! agr ++ vp.obj1 ! agr ++ vp.obj2 ! agr ++ vp.adv ++ vp.ext ;

  impVP : Number -> PrVerbPhrase -> Str = \n,vp ->
    let agr = Ag n P2 in
    vp.imp ! n ++ vp.adV ++ vp.adj ! agr ++ vp.obj1 ! agr ++ vp.obj2 ! agr ++ vp.adv ++ vp.ext ;

  declCl : PrClause -> Str = \cl ->
    cl.subj ++ cl.verb.fin ++ cl.adV ++ cl.verb.inf ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;

  declSubordCl : PrClause -> Str = declCl ;
  declInvCl    : PrClause -> Str = declCl ; ---

  questCl : PrQuestionClause -> Str = \cl ->
    let 
      ko = case cl.h of {Back => "ko" ; Front => "kö"} 
    in
    case cl.focType of { 
      NoFoc => cl.verb.fin ++ Predef.BIND ++ ko ++ 
               cl.subj ++ cl.adV ++ cl.verb.inf ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;
      _     => cl.foc ++ cl.subj ++ cl.verb.fin ++ 
               cl.adV ++ cl.verb.inf ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext
      } ;

  questSubordCl : PrQuestionClause -> Str = questCl ;

  that_Compl : Str = "että" ;

  -- this part is usually the same in all reconfigurations
---  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ++ cl.c3.s.p1 ++ cl.c3.s.p2 ; ---- c3

  negAdV :  {s : Str ; p : Polarity} -> Str = \p -> p.s ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = 
       \sta,t,a,pol,o,agr,v -> 
   let 
      vit = case o of {Act => VIFin t ; Pass => VIPass t} ;
      ovps = (S.vp2old_vp (S.predV v)).s ! vit ! a ! pol ! agr ; -- VIForm => Anteriority => Polarity => Agr => {fin, inf : Str} ;
   in
   <sta ++ ovps.fin, ovps.inf, []> ;

  imperativeV : Str -> Polarity -> ImpType -> PrVerb -> Str = \s,p,it,v ->    
    let 
        ovps = (S.vp2old_vp (S.predV v)).s ! VIImper ! Simul ! p ! Ag it P2 ; 
    in
    s ++ ovps.fin ++ ovps.inf ;

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str =
    \s,t,a,p,agr -> tenseV s t a p Act agr (liftV P.olla_V) ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str =
    \s,a,p,vt -> tenseInfV s a p Act (liftV P.olla_V) vt ;
  tenseImpCopula : Str -> Polarity -> ImpType -> Str =
    \s,p,it -> imperativeV s p it (liftV P.olla_V) ;

  noObj : Agr => Str = \\_ => [] ;

  applyVerb : PrVerbPhrase -> VAgr -> {inf,fin : Str}
    = \vp,agr -> vp.v ! agr ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = \\a => vp.obj2 ! a ++ obj ! a ;
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

  qformsVP : PrVerbPhrase -> VAgr -> Str * Str 
   = \vp,vagr -> <[],[]> ;


}