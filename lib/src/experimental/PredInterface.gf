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
param
  VAgr ;    -- agr features that a verb form depends on
  VType ;   -- reflexive, auxiliary, deponent,...

oper
  subjCase : NPCase ;
  objCase  : NPCase ;

  ComplCase : Type ; -- e.g. preposition
  agentCase : ComplCase ;


  NounPhrase : Type = {s : NPCase => Str ; a : Agr} ;

  appComplCase  : ComplCase -> NounPhrase -> Str ;
  noComplCase   : ComplCase ;

  noObj : Agr => Str = \\_ => [] ;

  NAgr : PType ;
  AAgr = Agr ;  -- because of reflexives: "happy with itself"
  IPAgr : PType ;

  defaultAgr : Agr ;

-- omitting parts of Agr information

  agr2vagr : Agr -> VAgr ;
  agr2aagr : Agr -> AAgr ;
  agr2nagr : Agr -> NAgr ;

-- restoring full Agr
  ipagr2agr  : IPAgr -> Agr ;
  ipagr2vagr : IPAgr -> VAgr ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr ;

-- participles as adjectives
  vPastPart : PrVerb -> AAgr -> Str ;
  vPresPart : PrVerb -> AAgr -> Str ;

  vvInfinitive : VVType ;

-------------------------------
--- type synonyms
-------------------------------

oper
  PrVerb = {
    s  : VForm => Str ;
    p  : Str ;                 -- verb particle             
    c1 : ComplCase ; 
    c2 : ComplCase ;
    isSubjectControl : Bool ;
    vtype : VType ;  
    vvtype : VVType ;
    } ; 

  PrVerbPhrase = {
    v : VAgr => Str * Str * Str ;  -- would,have,slept
    inf : VVType => Str ;          -- (not) ((to)(sleep|have slept) | (sleeping|having slept)
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

  PrQuestionClause = PrClause ** {
    foc : Str ;                   -- the focal position at the beginning: *who* does she love
    focType : FocusType ;         --- if already filled, then use other place: who loves *who*
    } ; 

---------------------------
---- concrete syntax opers
---------------------------

oper
  reflPron : Agr -> Str ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> Voice -> VAgr -> PrVerb -> Str * Str * Str ;

  tenseInfV : Str -> Anteriority -> Polarity -> Voice -> PrVerb -> VVType => Str ;

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
