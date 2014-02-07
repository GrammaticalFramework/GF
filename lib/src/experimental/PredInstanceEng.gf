instance PredInstanceEng of PredInterface = open ResEng, (X = ParamX), Prelude in {

---------------------
-- parameters -------
---------------------

oper
  Gender = ResEng.Gender ;
  Agr    = ResEng.Agr ;
  Case   = ResEng.Case ;
  NPCase = ResEng.NPCase ;
  VForm  = ResEng.VForm ;
  VVType = ResEng.VVType ;

--oper STense = ResEng.Tense ;

param
  VAgr     = VASgP1 | VASgP3 | VAPl ;
  VType    = VTAct | VTRefl | VTAux ;

oper
  subjCase : NPCase = NCase Nom ;
  objCase  : NPCase = NPAcc ;

  agentCase : ComplCase = "by" ;

  ComplCase = Str ; -- preposition

  NounPhrase = {s : NPCase => Str ; a : Agr} ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> p ++ np.s ! objCase ;
  noComplCase   : ComplCase = [] ;

  noObj : Agr => Str = \\_ => [] ;

  NAgr = Number ;
  IPAgr = Number ;

  defaultAgr : Agr = AgP3Sg Neutr ;

-- omitting rich Agr information
  agr2vagr : Agr -> VAgr = \a -> case a of {
    AgP1 Sg  => VASgP1 ;
    AgP3Sg _ => VASgP3 ;
    _        => VAPl
    } ;

  agr2aagr : Agr -> AAgr = \a -> a ;

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

  vPastPart : PrVerb -> AAgr -> Str = \v,_ -> v.s ! VPPart ;
  vPresPart : PrVerb -> AAgr -> Str = \v,_ -> v.s ! VPresPart ;

  vvInfinitive : VVType = VVInf ;

-----------------------
-- concrete opers
-----------------------

oper
  reflPron : Agr -> Str = \a -> ResEng.reflPron ! a ;

  infVP : VVType -> Agr -> PrVerbPhrase -> Str = \vt, a,vp -> 
    let 
      a2 = case vp.obj2.p2 of {True => a ; False => vp.obj1.p2} ;
    in
      vp.adV ++ vp.inf ! vt ++ vp.part ++
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a2 ++ vp.adv ++ vp.ext ;

  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str = 
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

  tenseV : Str -> STense -> Anteriority -> Polarity -> Voice -> VAgr -> PrVerb -> Str * Str * Str = 
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

  tenseActV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
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

  tenseActVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
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

  tensePassV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxL sta t a p agr ;
      done = v.s ! VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;
  tensePassVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxC sta t a p agr ;
      done = v.s ! VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;

  tenseInfV : Str -> Anteriority -> Polarity -> Voice -> PrVerb -> VVType => Str = \sa,a,p,o,v -> \\vt => 
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

  questCl : PrQuestionClause -> Str = \cl -> case cl.focType of {
    NoFoc   => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- does she sleep
    FocObj  => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- who does she love
    FocSubj => cl.foc ++ cl.v.p1      ++ cl.subj ++ cl.adV ++ cl.v.p2      ++ restCl cl    -- who loves her
    } ;

  questSubordCl : PrQuestionClause -> Str = \cl -> 
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
  be_V : PrVerb = {
    s = table {
      VInf => "be" ;
      VPres => "is" ;
      VPast => "was" ;
      VPPart => "been" ;
      VPresPart => "being"
      } ;
    p,c1,c2 = [] ; vtype = VTAux ; vvtype = VVInf ; isSubjectControl = False
    } ;

  negAdV : {s : Str ; p : Polarity} -> Str = \p -> p.s ;




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