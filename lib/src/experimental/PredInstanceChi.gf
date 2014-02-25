instance PredInstanceChi of PredInterface = open ResChi, (P = ParadigmsChi), (X = ParamX), (S = SyntaxChi), Prelude in {

---------------------
-- parameters -------
---------------------

oper
  Gender = Unit ;
  Agr    = Unit ;
  Case   = Unit ;
  NPCase = Unit ;
  VForm  = Unit ; ----
  VVType = Unit ; ----
  VType  = Unit ; ----

  VAgr   = Unit ;

  SVoice = CVoice ;

param CVoice = CAct | CPass ;

oper
  active = CAct ;
  passive = CPass ;

  defaultVType = UUnit ; ----

  subjCase = UUnit ;
  objCase = UUnit ;

  agentCase : ComplCase = S.by8agent_Prep ;

  ComplCase = Preposition ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> ss (appPrep p np.s ; ---- advType
  noComplCase   : ComplCase = P.mkPrep [] ;
  strComplCase  : ComplCase -> Str = \c -> P.mkPrep c ;

  noObj : Agr => Str = \\_ => [] ;

  RPCase = Unit ; 
  subjRPCase : Agr -> RPCase = \a -> UUnit ;

  NAgr = Unit ; 
  IPAgr = Unit ;
  RPAgr = Unit ;
  ICAgr = Unit ;

  defaultAgr : Agr = UUnit ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> a ;

  agr2aagr : Agr -> AAgr = \a -> a ;

  agr2icagr : Agr -> ICAgr = \a -> a ;

--- could use this?
  agr2aformpos : Agr -> AFormPos = \a -> a ;

  agr2nagr : Agr -> NAgr = \a -> a ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> a ;

  ipagr2vagr : IPAgr -> VAgr = \n -> n ;

  rpagr2agr : RPAgr -> Agr -> Agr = \ra,a -> a ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> defaultAgr ;

  vPastPart : PrVerb -> AAgr -> Str = \v,a -> v.s ; ----
  vPresPart : PrVerb -> AAgr -> Str = \v,a -> v.s ; ----

  vvInfinitive : VVType = UUnit ; ----

  isRefl : PrVerb -> Bool = \v -> False ; ----


------------------
--- opers --------
------------------

oper 
  reflPron : Agr -> Str = \a -> ResChi.mkNP ResChi.reflPron ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    vp.adV ++ vp.adv ++  ---- adv order
    vp.inf ! UUnit ++ 
    vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.ext ;

  impVP : Number -> PrVerbPhrase -> Str = \n,vp ->
    infVP UUnit UUnit vp ;

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ; ----- not needed in Chinese
 

  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl,adv ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = declCl ;
  declInvCl    : PrClause -> Str = declInvCl ;

  questCl      : PrQuestionClause -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.adv ++ cl.v.p2 ++ restCl cl ;

  questSubordCl : PrQuestionClause -> Str = \cl -> questCl ;

  that_Compl : Str = say_s ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.ext ++ cl.c3 ;

  negAdV :  {s : Str ; p : Polarity} -> Str = \p -> p.s ++ case p.p of {Pos => [] ; Neg => neg_s} ;







  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = --- Polarity, VAgr not needed in Chi
       \sta,t,a,_,o,_,v -> 
   let act = CommonScand.Act in
   case <t,a> of {  --- sta dummy s field of Ant and Tense
    <Pres,Simul> => <sta ++ v.s ! VF (VPres o),   [],                          []> ;
    <Past,Simul> => <sta ++ v.s ! VF (VPret o),   [],                          []> ;
    <Fut, Simul> => <skola_V.s  ! VF (VPres act), [],                          sta ++ v.s ! VI (VInfin o)> ;
    <Cond,Simul> => <skola_V.s  ! VF (VPret act), [],                          sta ++ v.s ! VI (VInfin o)> ;
    <Pres,Anter> => <hava_V.s   ! VF (VPres act), [],                          sta ++ v.s ! VI (VSupin o)> ;
    <Past,Anter> => <hava_V.s   ! VF (VPret act), [],                          sta ++ v.s ! VI (VSupin o)> ;
    <Fut, Anter> => <skola_V.s  ! VF (VPres act), hava_V.s ! VI (VInfin act),  sta ++ v.s ! VI (VSupin o)> ;
    <Cond,Anter> => <skola_V.s  ! VF (VPret act), hava_V.s ! VI (VInfin act),  sta ++ v.s ! VI (VSupin o)> 
    } ;

  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str = \sa,a,_,o,v,_ -> ---- vvtype
    case a of {
      Simul =>                                           sa ++ v.s ! VI (VInfin o) ;  -- hon vill sova
      Anter => hava_V.s ! VI (VInfin CommonScand.Act) ++ sa ++ v.s ! VI (VSupin o)    -- hon vill (ha) sovit ---- discont?
      } ;

  imperativeV : Str -> Polarity -> ImpType -> PrVerb -> Str = \s,p,it,v -> 
    s ++ case p of {
      Pos => v.s ! VF (VImper CommonScand.Act) ;   ---- deponents
      Neg => v.s ! VF (VImper CommonScand.Act) ++ inte_Str
      } ;

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str =
    \s,t,a,p,_ -> tenseV s t a p CommonScand.Act UUnit (liftV be_V) ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str =
    \s,a,p,vt -> tenseInfV s a p CommonScand.Act (liftV be_V) vt ;
  tenseImpCopula : Str -> Polarity -> ImpType -> Str =
    \s,p,n -> imperativeV s p n (liftV be_V) ;

  hava_V : Verb = P.mkV "ha" "har" "ha" "hade" "haft" "havd" ; -- havd not used
  be_V : Verb = P.mkV "vara" "är" "var" "var" "varit" "varen" ; -- varen not used
  skola_V : Verb = P.mkV "skola" ("ska" | "skall") "ska" "skulle" "skolat" "skolad" ; ---- not used but ska and skulle

  noObj : Agr => Str = \\_ => [] ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;

  not_Str : Polarity -> Str = \p -> case p of {Pos => [] ; Neg => inte_Str} ;

  inte_Str = "inte" | "icke" | "ej" ;

  liftV : Verb -> PrVerb = \v ->
    {s = v.s ; p = v.part ; c1,c2 = [] ; isSubjectControl = False ; vtype = v.vtype ; vvtype = vvInfinitive} ; ---- vvtype

--- junk

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ;
  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> <[],[]> ;


}