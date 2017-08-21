instance PredInstanceEng of PredInterface - [
   PrVerbPhrase, PrClause,
   initPrVerbPhrase, initPrVerbPhraseV, initPrClause, 
   useCopula, questCl, linrefPrQCl
   ] = 

  open ResEng, (X = ParamX), Prelude in {

----- overrides ----------------

oper

-- add contracted verb forms and forms for question

  PrVerbPhrase = BasePrVerbPhrase ** {vc : VAgr => Str * Str * Str ; qforms : VAgr => Str * Str} ;
  PrClause = BasePrClause ** {vc : Str * Str * Str ; qforms : Str * Str} ;

  initPrVerbPhrase : PrVerbPhrase = initBasePrVerbPhrase ** {
    vc : VAgr => Str * Str * Str  = \\_ => <[],[],[]> ;
    qforms = \\agr => <[],[]> ;
    } ;

  initPrVerbPhraseV : 
       {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> PrVerb -> PrVerbPhrase = 
    \a,t,p,v -> initBasePrVerbPhraseV a t p v ** {
    vc   = \\agr => tenseVContracted (a.s ++ t.s ++ p.s) t.t a.a p.p active agr v ;
    qforms = \\agr => qformsV (a.s ++ t.s ++ p.s) t.t a.a p.p agr v
    } ;
 
  initPrClause : PrClause = initBasePrClause ** {
    vc = <[],[],[]> ; 
    qforms = <[],[]> ;
    } ; 

  useCopula : {s : Str ; a : Anteriority} -> {s : Str ; t : STense} -> {s : Str ; p : Polarity} -> 
                 PrVerbPhrase =
    \a,t,p -> initPrVerbPhrase ** {
    v   = \\agr => tenseCopula (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    vc  = \\agr => tenseCopulaC (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    inf = \\vt => tenseInfCopula a.s a.a p.p vt ;
    imp = \\n => tenseImpCopula p.s p.p n ;
    adV = negAdV p ;
    qforms = \\agr => qformsCopula (a.s ++ t.s ++ p.s) t.t a.a p.p agr ;
    } ;

  questCl : PrQuestionClause -> Str = \cl -> case cl.focType of {
    NoFoc   => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- does she sleep
    FocObj  => cl.foc ++ cl.qforms.p1 ++ cl.subj ++ cl.adV ++ cl.qforms.p2 ++ restCl cl ;  -- who does she love
    FocSubj => cl.foc ++ cl.v.p1      ++ cl.subj ++ cl.adV ++ cl.v.p2      ++ restCl cl    -- who loves her
    } ;

  linrefPrQCl : PrQuestionClause -> Str = \qcl -> questCl qcl ;

---------------------
-- parameters -------
---------------------

oper
  Gender = ResEng.Gender ;
  Agr    = ResEng.Agr ;
  Case   = ResEng.Case ;
  NPCase = ResEng.NPCase ;
  VForm  = ResEng.VVForm ;  ---- VVForm to get contracted aux verbs
  VVType = ResEng.VVType ; 
  SVoice = Voice ;
  
  VAgr = EVAgr ;
  VType = EVType ; 

param  --- have to do this clumsy way because param P and oper P : PType don't unify
  EVAgr  = VASgP1 | VASgP3 | VAPl ;
  EVType = VTAct | VTRefl | VTAux ;

oper
  active : SVoice = Act ;
  passive : SVoice = Pass ;

  defaultVType : VType = VTAct ;

  subjCase : NPCase = NCase Nom ;
  objCase  : NPCase = NPAcc ;

  agentCase : ComplCase = "by" ;

  ComplCase = Str ; -- preposition

  NounPhrase = {s : NPCase => Str ; a : Agr} ;

  appComplCase  : ComplCase -> NounPhrase -> Str = \p,np -> p ++ np.s ! objCase ;
  noComplCase   : ComplCase = [] ;
  strComplCase  : ComplCase -> Str = \c -> c ;

  noObj : Agr => Str = \\_ => [] ;

  RPCase = ResEng.RCase ; 
  subjRPCase : Agr -> RPCase = \a -> RC (fromAgr a).g npNom ;

  NAgr = Number ;
  IPAgr = Number ;
  RPAgr = ResEng.RAgr ;
  ICAgr = Unit ;

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
    AgP3Pl _ => Pl
    } ;

  agr2icagr : Agr -> ICAgr = \a -> UUnit ;

-- restoring full Agr
  ipagr2agr : IPAgr -> Agr = \n -> case n of {
    Sg => AgP3Sg Neutr ; ---- gender
    Pl => AgP3Pl Neutr
    } ;

  ipagr2vagr : IPAgr -> VAgr = \n -> case n of {
    Sg => VASgP3 ;
    Pl => VAPl
    } ;

  rpagr2agr : RPAgr -> Agr -> Agr = \ra,a -> case ra of {
    RAg ag => ag ;
    RNoAg => a
    } ;

--- this is only needed in VPC formation
  vagr2agr : VAgr -> Agr = \a -> case a of {
    VASgP1 => AgP1 Sg ;
    VASgP3 => AgP3Sg Neutr ;
    VAPl   => AgP3Pl Neutr
    } ;

  vPastPart : PrVerb -> AAgr -> Str = \v,_ -> v.s ! VVF VPPart ;
  vPresPart : PrVerb -> AAgr -> Str = \v,_ -> v.s ! VVF VPresPart ;

  vvInfinitive : VVType = VVInf ;

  isRefl : PrVerb -> Bool = \v -> case v.vtype of {VTRefl => True ; _ => False} ;

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

  impVP : Number -> PrVerbPhrase -> Str = \n,vp ->
    let
      a = AgP2 n
    in 
      vp.adV ++ vp.imp ! n ++ vp.part ++
      vp.adj ! a ++ vp.c1 ++ vp.obj1.p1 ! a ++ vp.c2 ++ vp.obj2.p1 ! a ++ vp.adv ++ vp.ext ;

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

  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str = 
    \sta,t,a,p,agr -> 
    let verb = be_AuxL sta t a p agr
    in <verb.p1, verb.p2> ;                     -- is , not  ---- TODO isn't , 

  tenseCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \s,t,a,p,agr ->
    be_AuxL s t a p agr ;
  tenseCopulaC : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \s,t,a,p,agr ->
    be_AuxC s t a p agr ;
  tenseInfCopula : Str -> Anteriority -> Polarity -> VVType -> Str = \s,a,p,vt ->
    tenseInfV s a p Act be_V vt ;
  tenseImpCopula : Str -> Polarity -> ImpType -> Str = \s,p,n ->
    imperativeV s p n be_V ;

  tenseV : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = 
    \sta,t,a,p,o,agr,v -> 
    case o of {  
      Act  => tenseActV sta t a p agr v ;
      Pass => tensePassV sta t a p agr v 
      } ;
       
           ---- leaving out these variants makes compilation time go down from 900ms to 300ms. 
           ---- parsing time of "she sleeps" goes down from 300ms to 60ms. 4/2/2014 

  tenseVContracted : Str -> STense -> Anteriority -> Polarity -> SVoice -> VAgr -> PrVerb -> Str * Str * Str = 
    \sta,t,a,p,o,agr,v -> 
    case o of {  
      Act  => tenseActVContracted sta t a p agr v ;
      Pass => tensePassVContracted sta t a p agr v
      } ;

  tenseActV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let vt : ResEng.VForm = case <t,agr> of {
        <Pres,VASgP3>  => VPres ; 
        <Past|Cond,_ > => VPast ; 
        _              => VInf
        } ; 
    in 
    case <t,a> of {  
    <Pres|Past, Simul> =>
      case v.vtype of {
        VTAux  => case t of {
          Pres         => <sta ++ v.s ! VVF VPres,   not_Str p,                   []> ;  -- can I/she/we
          _            => <sta ++ v.s ! VVF vt,      not_Str p,                   []>    -- could ...
          } ;
        _              => case p of {
          Pos          => <[],                   sta ++ v.s ! VVF vt,             []> ;                 -- this is the deviating case
          Neg          => <do_Aux       vt Pos,  not_Str p,                       sta ++ v.s ! VVF VInf>
          }
       } ;

    <Pres|Past, Anter> => <have_Aux     vt Pos,  not_Str p,                       sta ++ v.s ! VVF VPPart> ;
    <Fut|Cond,  Simul> => <will_Aux     vt Pos,  not_Str p,                       sta ++ v.s ! VVF VInf> ;
    <Fut|Cond,  Anter> => <will_Aux     vt Pos,  not_Str p ++ have_Aux VInf Pos,  sta ++ v.s ! VVF VPPart>
    } ;

  tenseActVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let vt : ResEng.VForm * VVForm = case <t,agr> of {
        <Pres,VASgP3>  => <VPres, VVPresNeg> ; 
        <Past|Cond,_ > => <VPast, VVPastNeg> ; 
        _              => <VInf,  VVF VInf>
        } ; 
    in 

    case <t,a> of {  
    <Pres|Past, Simul> =>
      case v.vtype of {
        VTAux  => case p of {
          Pos          => <sta ++ v.s ! VVF vt.p1,  [],                              []> ;
          Neg          => <sta ++ v.s ! vt.p2,      [],                              []>
          } ;
        _ => case p of {
          Pos          => <[],                     sta ++ v.s ! VVF vt.p1,           []> ;                 -- this is the deviating case
          Neg          => <do_Aux       vt.p1 p,    [],                              sta ++ v.s ! VVF VInf>
          }
       } ;
    <Pres|Past, Anter> => <have_AuxC    vt.p1 p,    [],                              sta ++ v.s ! VVF VPPart> ;
----                        | <have_AuxC    vt.p1 Pos,  not_Str p,                       sta ++ v.s ! VVF VPPart> ; 
    <Fut|Cond,  Simul> => <will_AuxC    vt.p1 p,    [],                              sta ++ v.s ! VVF VInf> ;
----                        | <will_AuxC    vt.p1 Pos,  not_Str p,                       sta ++ v.s ! VVF VInf> ; 
    <Fut|Cond,  Anter> => <will_AuxC    vt.p1 p,    have_Aux VInf Pos,               sta ++ v.s ! VVF VPPart>
----                        | <will_AuxC    vt.p1 Pos,  not_Str p ++ have_Aux VInf Pos,  sta ++ v.s ! VVF VPPart> 
    } ;

  tensePassV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxL sta t a p agr ;
      done = v.s ! VVF VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;
  tensePassVContracted : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str * Str = \sta,t,a,p,agr,v -> 
    let 
      be   = be_AuxC sta t a p agr ;
      done = v.s ! VVF VPPart
    in 
    <be.p1, be.p2, be.p3 ++ done> ;

  tenseInfV : Str -> Anteriority -> Polarity -> SVoice -> PrVerb -> VVType -> Str = \sa,a,p,o,v,vt -> 
    let 
      not = case p of {Pos => [] ; Neg => "not"} ;
    in
    case vt of {
      VVInf => 
        case a of {
          Simul => not ++ "to" ++                      sa ++ v.s ! VVF VInf ;       -- (she wants) (not) to sleep
          Anter => not ++ "to" ++ have_Aux VInf Pos ++ sa ++ v.s ! VVF VPPart       -- (she wants) (not) to have slept
          } ;
      VVAux =>
        case a of {
          Simul => not ++                              sa ++ v.s ! VVF VInf ;       -- (she must) (not) sleep
          Anter => not ++         have_Aux VInf Pos ++ sa ++ v.s ! VVF VPPart       -- (she must) (not) have slept
          } ;
     VVPresPart =>
        case a of {
          Simul => not ++                              sa ++ v.s ! VVF VPresPart ;  -- (she starts) (not) sleeping
          Anter => not ++         "having"          ++ sa ++ v.s ! VVF VPPart       -- (she starts) (not) having slept
          }
     } ;

  imperativeV : Str -> Polarity -> ImpType -> PrVerb -> Str = \s,p,it,v -> 
    s ++ case p of {
      Pos => v.s ! VVF VInf ;
      Neg => ("do not" | "don't") ++ v.s ! VVF VInf
      } ;


----- dangerous variants for PMCFG generation - keep apart as long as possible
  be_Aux : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str * Str = \sta,t,a,p,agr -> 
    be_AuxL sta t a p agr ;

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
      <Pres,Simul,Neg,VASgP3> => ---- <Predef.BIND ++ "'s" ++ sta,  "not", []>
                                 <"isn't" ++ sta,              [],    []> ;
      <Pres,Simul,Neg,VASgP1> => <Predef.BIND ++ "'m" ++ sta,  "not", []> ;
      <Pres,Simul,Neg,VAPl>   => ---- <Predef.BIND ++ "'re" ++ sta, "not", []>
                                 <"aren't" ++ sta,             [],    []> ;
      <Past,Simul,Pos,VAPl>   => <"were" ++ sta,               [],    []> ; 
      <Past,Simul,Neg,VAPl>   => <"weren't" ++ sta,            [],    []> ;
      <Past,Simul,Neg,_>      => <"wasn't" ++ sta,            [],    []> ;
      _ => beV
      } ;

  declCl       : PrClause -> Str = \cl -> cl.subj ++ cl.v.p1  ++ cl.adV ++ cl.v.p2  ++ restCl cl ;
  declSubordCl : PrClause -> Str = declCl ;
  declInvCl    : PrClause -> Str = declCl ;

  declClContracted : PrClause -> Str = \cl -> cl.subj ++ cl.vc.p1 ++ cl.adV ++ cl.vc.p2 ++ restCl cl ; -- contracted forms

  questSubordCl : PrQuestionClause -> Str = \cl -> 
    let 
      rest = cl.subj ++ cl.adV ++ cl.v.p1 ++ cl.v.p2 ++ restCl cl 
    in case cl.focType of {
      NoFoc   => "if" ++ cl.foc ++ rest ;  -- if she sleeps
      FocObj  =>         cl.foc ++ rest ;  -- who she loves / why she sleeps
      FocSubj =>         cl.foc ++ rest    -- who loves her
      } ;


--- only needed in Eng because of do questions
  qformsV : Str -> STense -> Anteriority -> Polarity -> VAgr -> PrVerb -> Str * Str ;
  qformsCopula : Str -> STense -> Anteriority -> Polarity -> VAgr -> Str * Str ;

  qformsVP : PrVerbPhrase -> VAgr -> Str * Str 
   = \vp,vagr -> vp.qforms ! vagr ;


  that_Compl : Str = "that" | [] ;

  -- this part is usually the same in all reconfigurations
  restCl : PrClause -> Str = \cl -> cl.v.p3 ++ cl.adj ++ cl.obj1 ++ cl.obj2 ++ cl.adv ++ cl.ext ;


  addObj2VP : PrVerbPhrase -> (Agr => Str) -> PrVerbPhrase = \vp,obj -> vp ** {
    obj2 = <\\a => vp.obj2.p1 ! a ++ obj ! a, vp.obj2.p2> ;
    } ;

  addExtVP : PrVerbPhrase -> Str -> PrVerbPhrase = \vp,ext -> vp ** {
    ext = ext ;
    } ;

oper
  be_V : PrVerb = {
    s = table {
      VVF VInf => "be" ;
      VVF VPres => "is" ;
      VVF VPast => "was" ;
      VVF VPPart => "been" ;
      VVF VPresPart => "being" ;
      VVPresNeg => "isn't" ;
      VVPastNeg => "wasn't"
      } ;
    p,c1,c2 = [] ; vtype = VTAux ; vvtype = VVInf ; isSubjectControl = False
    } ;

  negAdV : {s : Str ; p : Polarity} -> Str = \p -> p.s ;




oper
---- have to split the tables to two to get reasonable PMCFG generation
  will_Aux : ResEng.VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf|VPres, Pos> => varAux "will" "ll" ;
    <VInf|VPres, Neg> => "won't" ;
    <VPast|_   , Pos> => varAux "would" "d" ; 
    <VPast|_   , Neg> => "wouldn't"
    } ; 
  will_AuxC : ResEng.VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf|VPres, Pos> => varAuxC "will" "ll" ;
    <VInf|VPres, Neg> => "won't" ;
    <VPast|_   , Pos> => varAuxC "would" "d" ; 
    <VPast|_   , Neg> => "wouldn't"
    } ; 

  have_Aux : ResEng.VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf,     Pos> => varAux "have" "ve" ;  --- slightly overgenerating if used in infinitive
    <VInf,     Neg> => "haven't" ;
    <VPres,    Pos> => varAux "has" "s" ;
    <VPres,    Neg> => "hasn't" ;
    <VPast|_ , Pos> => varAux "had" "d" ; 
    <VPast|_ , Neg> => "hadn't"
    } ; 
  have_AuxC : ResEng.VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
    <VInf,     Pos> => varAuxC "have" "ve" ;  --- slightly overgenerating if used in infinitive
    <VInf,     Neg> => "haven't" ;
    <VPres,    Pos> => varAuxC "has" "s" ;
    <VPres,    Neg> => "hasn't" ;
    <VPast|_ , Pos> => varAuxC "had" "d" ; 
    <VPast|_ , Neg> => "hadn't"
    } ; 

  do_Aux : ResEng.VForm -> Polarity -> Str = \vf,p -> case <vf,p> of {
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