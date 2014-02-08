instance PredInstanceFin of PredInterface - [NounPhrase,PrVerb] = 
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

---------------------
-- parameters -------
---------------------

oper
  Agr    = ResFin.Agr ;
  Case   = ResFin.Case ;
  NPCase = ResFin.NPForm ;
  VForm  = S.SVForm ;
  VVType = ResFin.InfForm ;
  VType  = Unit ; ----
  Gender = Unit ; ----

  VAgr   = Agr ;

  SVoice = Voice ;

oper
  active = Act ;
  passive = Pass ;

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

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    let 
      a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} 
    in
      vp.adV ++ vp.inf ! vt ++ 
      vp.adj ! a ++ vp.obj1.p1 ! a ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ; ----- not needed in Finnish
 

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
   let 
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

  liftV : S.SVerb1 -> PrVerb = \v -> 
    v ** {c1,c2 = noComplCase ; isSubjectControl = False ; vtype = UUnit ; vvtype = vvInfinitive} ; 

--- junk

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ;
  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> <[],[]> ;


}