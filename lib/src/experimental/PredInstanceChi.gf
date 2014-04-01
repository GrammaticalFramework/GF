instance PredInstanceChi of 
  PredInterface - [PrVerb,initPrVerb,NounPhrase,appSubjCase,appObjCase,PrAdverb,linrefPrAdv] = 

   open ResChi, (P = ParadigmsChi), (X = ParamX), (S = SyntaxChi), Prelude in {

-- overrides

oper
  PrVerb = {
    s    : ResChi.Verb ;
    p    : Str ;                 -- verb particle             
    c1   : ComplCase ; 
    c2   : ComplCase ;
    hasPrep : Bool ;

    isSubjectControl : Bool ;   --- junk in Chi
    vtype : VType ;  
    vvtype : VVType ;

    } ; 

  NounPhrase = {s : Str} ;
  appSubjCase : NounPhrase -> Str = \np -> np.s ;
  appObjCase : NounPhrase -> Str = \np -> np.s ;

  PrAdverb = Preposition ;

  linrefPrAdv : PrAdverb -> Str = \adv -> adv.prepPre ++ adv.prepPost ;

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

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> appPrep p np.s ; ---- advType
  noComplCase   : ComplCase = P.mkPrep [] ;
  strComplCase  : ComplCase -> Str = \c -> c.prepPre ++ c.prepPost ;

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

  agr2nagr : Agr -> NAgr = \a -> a ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \a -> a ;

  ipagr2vagr : IPAgr -> VAgr = \n -> n ;

  rpagr2agr : RPAgr -> Agr -> Agr = \ra,a -> a ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> defaultAgr ;

  vPastPart : PrVerb -> AAgr -> Str = \v,a -> v.s.s ; ----
  vPresPart : PrVerb -> AAgr -> Str = \v,a -> v.s.s ; ----

  vvInfinitive : VVType = UUnit ; ----

  isRefl : PrVerb -> Bool = \v -> False ; ----


------------------
--- opers --------
------------------

oper 
  reflPron : Agr -> Str = \a -> (ResChi.mkNP ResChi.reflPron).s ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    vp.adV ++ vp.adv ++  ---- adv order
    vp.inf ! UUnit ++ 
    vp.adj ! a ++ appPrep vp.c1 (vp.obj1.p1 ! a) ++ appPrep vp.c2 (vp.obj2.p1 ! a) ++ vp.ext ;

  impVP : Number -> PrVerbPhrase -> Str = \n,vp ->
    infVP UUnit UUnit vp ;


  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1 ++ cl.adV ++ cl.adv ++ cl.v.p2 ++ restCl cl ;
  declSubordCl : PrClause -> Str = declCl ;
  declInvCl    : PrClause -> Str = declCl ;

  questCl      : PrQuestionClause -> Str = \cl -> 
    cl.foc ++ cl.v.p1 ++ cl.subj ++ cl.adV ++ cl.adv ++ cl.v.p2 ++ restCl cl ++ question_s ; ---- plus redupl

  questSubordCl : PrQuestionClause -> Str = questCl ;

  that_Compl : Str = say_s ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.ext ; ---- c3

  negAdV :  {s : Str ; p : Polarity} -> Str = \p -> p.s ; ---- not used in negation formation   ++ not_Str p.p ;

  not_Str = \p -> case p of {Pos => [] ; Neg => neg_s} ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = 
       \sta,t,a,p,o,_,v -> 
       let
          bu_neg = not_Str p ;
          vneg   = case p of {Pos => [] ; Neg => v.s.neg} ;
          pass   = case o of {CAct => [] ; CPass => passive_s}
       in case <t,a> of {
          <X.Past,_>  => <sta ++ pass,  bu_neg,  v.s.s ++ v.s.pp> ;
          <_,X.Anter> => <sta ++ pass,  bu_neg,  v.s.s ++ v.s.pp> ;
          _           => <sta ++ pass,  vneg,    v.s.s> 
          } ;   ---- other aspects



  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str = \sa,a,p,o,v,_ -> ---- vvtype
       let tv = tenseV sa X.Pres a p o UUnit v 
       in tv.p1 ++ tv.p2 ++ tv.p3 ;
 
  imperativeV : Str -> Polarity -> ImpType -> PrVerb -> Str = \s,p,it,v -> 
    tenseInfV s X.Simul p CAct v UUnit ;

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str =
    \s,t,a,p,agr -> tenseV s t a p CAct agr (liftV copula) ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str =
    \s,a,p,vt -> tenseInfV s a p CAct (liftV copula) vt ;
  tenseImpCopula : Str -> Polarity -> ImpType -> Str =
    \s,p,n -> imperativeV s p n (liftV copula) ;

  noObj : Agr => Str = \\_ => [] ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;

  liftV : Verb -> PrVerb = \v ->
    {s = v ; p = [] ; c1,c2 = P.mkPrep [] ; isSubjectControl = False ; vtype = UUnit ; vvtype = UUnit ; hasPrep = False} ; 

--- junk

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
    \sta,t,a,p,agr,v -> <[],[]> ;
  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> <[],[]> ;


}