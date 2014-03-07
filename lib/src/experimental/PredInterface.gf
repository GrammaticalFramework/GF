interface PredInterface = open Prelude, (X = ParamX) in {

---------------------
-- parameters -------
---------------------

-- standard usually general
oper
  Number : PType = X.Number ;
  Person : PType = X.Person ;
  Anteriority : PType = X.Anteriority ;
  Polarity : PType = X.Polarity ;
  STense : PType = X.Tense ;
  SVoice : PType ;

  ImpType : PType = Number ;

param
  Voice = Act | Pass ;  --- should be in ParamX
  Unit = UUnit ;        --- should be in Prelude

-- this works for typical "wh movement" languages

  FocusType = NoFoc | FocSubj | FocObj ; -- sover hon/om hon sover, vem älskar hon/vem hon älskar, vem sover/vem som sover 

-- language-dependent

oper
  Gender : PType ;
  Agr : PType ;       -- full agreement, inherent in NP
  Case : PType ;      -- case of CN     
  NPCase : PType ;    -- full case of NP
  VForm : PType ;     -- inflection form of V
  VVType : PType ;    -- infinitive form required by VV


-- language dependent

  VAgr : PType ;      -- agr features that a verb form depends on
  VType : PType ;     -- reflexive, auxiliary, deponent,...

oper
  active : SVoice ;
  passive : SVoice ;

  defaultVType : VType ;

  subjCase : NPCase ;
  objCase  : NPCase ;

  ComplCase : Type ; -- e.g. preposition
  agentCase : ComplCase ;
  strComplCase : ComplCase -> Str ;

  NounPhrase : Type = {s : NPCase => Str ; a : Agr} ;

  appComplCase  : ComplCase -> NounPhrase -> Str ;
  noComplCase   : ComplCase ;

  appSubjCase : NounPhrase -> Str = \np -> np.s ! subjCase ;
  appObjCase  : NounPhrase -> Str = \np -> np.s ! objCase ;

  noObj : Agr => Str = \\_ => [] ;

  RPCase : PType ;
  subjRPCase : Agr -> RPCase ;

  NAgr : PType ;
  AAgr = Agr ;  -- because of reflexives: "happy with itself"
  IPAgr : PType ; -- agreement of IP
  RPAgr : PType ; -- agreement of RP
  ICAgr : PType ; -- agreement to IComp

  defaultAgr : Agr ;

-- omitting parts of Agr information

  agr2vagr  : Agr -> VAgr ;
  agr2aagr  : Agr -> AAgr ;
  agr2nagr  : Agr -> NAgr ;
  agr2icagr : Agr -> ICAgr ;

-- restoring full Agr
  ipagr2agr  : IPAgr -> Agr ;
  ipagr2vagr : IPAgr -> VAgr ;
  rpagr2agr  : RPAgr -> Agr -> Agr ; -- the agr can come from the RP itself or from above

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr ;

-- participles as adjectives
  vPastPart : PrVerb -> AAgr -> Str ;
  vPresPart : PrVerb -> AAgr -> Str ;

  vvInfinitive : VVType ;

  isRefl : PrVerb -> Bool ;

  applyVerb : PrVerbPhrase -> VAgr -> Str * Str * Str 
    = \vp,a -> vp.v ! a ;

-------------------------------
--- type synonyms
-------------------------------

oper
  PrVerb = BasePrVerb ;
  PrVerbPhrase = BasePrVerbPhrase ;
  PrClause = BasePrClause ;
  PrQuestionClause = BasePrQuestionClause ;

  initPrVerb = initBasePrVerb ;
  initPrVerbPhrase = initBasePrVerbPhrase ;
  initPrVerbPhraseV = initBasePrVerbPhraseV ;
  initPrClause = initBasePrClause ;



  BasePrVerb = {
    s  : VForm => Str ;
    p  : Str ;                 -- verb particle             
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    vtype : VType ;  
    vvtype : VVType ;
    } ; 

  initBasePrVerb : BasePrVerb = {
    s = \\_ => [] ;
    p = [] ;
    c1 = noComplCase ;
    c2 = noComplCase ;
    isSubjectControl = True ;
    vtype = defaultVType ;
    vvtype = vvInfinitive ;
    } ;

  BasePrVerbPhrase = {
    v : VAgr => Str * Str * Str ;  -- would,have,slept
    inf : VVType => Str ;          -- (not) ((to)(sleep|have slept) | (sleeping|having slept)
    imp : ImpType => Str ;
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
    } ;

  initBasePrVerbPhrase : BasePrVerbPhrase = {
    v : VAgr => Str * Str * Str  = \\_ => <[],[],[]> ;
    inf : VVType => Str = \\_ => [] ;
    imp : ImpType => Str = \\_ => [] ;
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
    } ;

  initBasePrVerbPhraseV : 
       {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerb -> BasePrVerbPhrase = 
  \a,t,p,v -> initBasePrVerbPhrase ** {
    v   = \\agr => tenseV (a.s ++ t.s ++ p.s) t.t a.a p.p active agr v ;
    inf = \\vt => tenseInfV a.s a.a p.p active v vt ;
    imp = \\it => imperativeV p.s p.p it v ;
    c1  = v.c1 ;
    c2  = v.c2 ;
    part = v.p ;
    obj1 = <case isRefl v of {True => \\a => reflPron a ; _ => \\_ => []}, defaultAgr> ; ---- not used, just default value
    obj2 = <noObj, v.isSubjectControl> ;
    vvtype = v.vvtype ;
    adV = negAdV p ; --- just p.s in Eng
    } ;
 
  BasePrClause = {
    v : Str * Str * Str ; 
    adj,obj1,obj2 : Str ; 
    adv : Str ; 
    adV : Str ;
    ext : Str ; 
    subj : Str ; 
    c3  : ComplCase ;              -- for a slashed adjunct, not belonging to the verb valency
    } ; 

  initBasePrClause : BasePrClause = {
    v : Str * Str * Str = <[],[],[]> ; 
    adj,obj1,obj2 : Str = [] ; 
    adv,adV,ext : Str = [] ; 
    subj : Str = [] ; 
    c3  : ComplCase = noComplCase ;              -- for a slashed adjunct, not belonging to the verb valency
    } ; 

  BasePrQuestionClause = PrClause ** {
    foc : Str ;                   -- the focal position at the beginning: *who* does she love
    focType : FocusType ;         --- if already filled, then use other place: who loves *who*
    } ; 

  PrAdverb = {s : Str ; isAdV : Bool ; c1 : ComplCase} ;


  useCopula : {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> 
                 PrVerbPhrase =
    \a,t,p -> initPrVerbPhrase ** {
    v   = \\agr => tenseCopula (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    inf = \\vt => tenseInfCopula a.s a.a p.p vt ;
    imp = \\n => tenseImpCopula p.s p.p n ;
    adV = negAdV p ;
    } ;


  linrefPrVP : PrVerbPhrase -> Str = \vp  -> 
    let 
      agr  = defaultAgr ;
      vagr = agr2vagr agr ;
      verb = vp.v ! vagr ;
    in
    verb.p1 ++ verb.p2 ++ vp.adV ++ verb.p3 ++ vp.part ++ 
    vp.adj ! agr ++ vp.obj1.p1 ! agr ++ vp.obj2.p1 ! agr ++ vp.adv ++ vp.ext ;
 
  linrefPrCl : PrClause -> Str = \cl  -> declCl cl ;
  linrefPrQCl : PrQuestionClause -> Str = \qcl -> questCl qcl ;
  linrefPrAdv : PrAdverb -> Str = \adv -> strComplCase adv.c1 ++ adv.s ;
----  linrefPrAP  = \ap  -> ap.s ! defaultAgr ++ ap.obj1 ! defaultAgr ;  
----  linrefPrCN  = \cn  -> cn.s ! Sg ++ cn.obj1 ! defaultAgr ; 


---------------------------
---- concrete syntax opers
---------------------------

oper
  reflPron : Agr -> Str ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str ;

  impVP : Number -> PrVerbPhrase -> Str ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str ;

  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str ;

  imperativeV : Str -> Polarity -> ImpType -> PrVerb -> Str ;

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str ;
  tenseImpCopula : Str -> Polarity -> ImpType -> Str ;

  declCl       : PrClause -> Str ;
  declSubordCl : PrClause -> Str ;
  declInvCl    : PrClause -> Str ;

  questCl : PrQuestionClause -> Str ;
  questSubordCl : PrQuestionClause -> Str ;

  that_Compl : Str ;

  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;

  not_Str : Polarity -> Str ;

}
