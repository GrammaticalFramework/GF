instance PredInstanceSwe of PredInterface = open CommonScand, ResSwe, (P = ParadigmsSwe), (X = ParamX), Prelude in {

---------------------
-- parameters -------
---------------------

oper
  Gender = CommonScand.Gender ;
  Agr    = CommonScand.Agr ;
  Case   = CommonScand.Case ;
  NPCase = CommonScand.NPForm ;
  VForm  = CommonScand.VForm ;
  VVType = Unit ; -----
  VType  = CommonScand.VType ;

  VAgr   = Unit ;

  SVoice = CommonScand.Voice ;

oper
  active = CommonScand.Act ;
  passive = CommonScand.Pass ;

  defaultVType = VAct ;

  subjCase : NPCase = NPNom ;
  objCase  : NPCase = NPAcc ;

  agentCase : ComplCase = "av" ;

  ComplCase = Str ; -- preposition

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> p ++ np.s ! objCase ;
  noComplCase   : ComplCase = [] ;
  strComplCase  : ComplCase -> Str = \c -> c ;

  noObj : Agr => Str = \\_ => [] ;

  RPCase = CommonScand.RCase ; 
  subjRPCase : Agr -> RPCase = \a -> RNom ;

  NAgr = Number ; --- only Indef Nom forms are needed here
  IPAgr = Number ; ----{g : Gender ; n : Number} ; --- two separate fields in RGL
  RPAgr = RAgr ;
  ICAgr = AFormPos ;

  defaultAgr : Agr = {g = Utr ; n = Sg ; p = P3} ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> UUnit ;

  agr2aagr : Agr -> AAgr = \a -> a ;

  agr2icagr : Agr -> ICAgr = agr2aformpos ;

--- could use this?
  agr2aformpos : Agr -> AFormPos = \a ->
    case a.n of {
      Sg => Strong (GSg a.g) ;
      Pl => Strong GPl
      } ;

  agr2nagr : Agr -> NAgr = \a -> a.n ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> {g = Utr ; n = a ; p = P3} ; ----

  ipagr2vagr : IPAgr -> VAgr = \n -> UUnit ;

  rpagr2agr : RPAgr -> Agr -> Agr = \ra,a -> case ra of {
    RAg g n p => {g = g ; n = n ; p = p} ;
    RNoAg => a
    } ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> defaultAgr ;

  vPastPart : PrVerb -> AAgr -> Str = \v,a -> v.s ! VI (VPtPret (agr2aformpos a) Nom) ;
  vPresPart : PrVerb -> AAgr -> Str = \v,a -> v.s ! VI (VPtPres Sg Indef Nom) ; 

  vvInfinitive : VVType = UUnit ; ----

  isRefl : PrVerb -> Bool = \v -> case v.vtype of {VRefl => True ; _ => False} ;


------------------
--- opers --------
------------------

oper 
  reflPron : Agr -> Str = ResSwe.reflPron ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    let 
      a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} 
    in
      vp.adV ++ vp.inf ! UUnit ++ 
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  impVP : Number -> PrVerbPhrase -> Str = \n,vp ->
    let
      a = {g = Utr ; n = n ; p = P2}
    in 
      vp.imp ! n ++ vp.part ++  ---- AdV contains inte
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a ++ vp.adv ++ vp.ext ;


  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = \cl -> cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl ;
  declInvCl    : PrClause -> Str = \cl -> cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questCl      : PrQuestionClause -> Str = \cl -> cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.v.p2 ++ restCl cl ;

  questSubordCl : PrQuestionClause -> Str = \cl -> 
    let 
      rest = cl.subj ++ cl.adV ++ cl.v.p1 ++ (cl.v.p2 | []) ++ restCl cl 
    in case cl.focType of {
      NoFoc   => "om" ++ cl.foc          ++ rest ;  -- om hon sover
      FocObj  =>         cl.foc          ++ rest ;  -- vem älskar hon / varför hon sover
      FocSubj =>         cl.foc ++ "som" ++ rest    -- vem som älskar henne
      } ;

  that_Compl : Str = "att" | [] ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;

  negAdV :  {s : Str ; p : Polarity} -> Str = \p -> p.s ++ case p.p of {Pos => [] ; Neg => inte_Str} ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = --- Polarity, VAgr not needed in Swe
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
    {s = v.s ; p = v.part ; c1,c2 = [] ; isSubjectControl = True ; vtype = v.vtype ; vvtype = vvInfinitive} ; ---- vvtype



}