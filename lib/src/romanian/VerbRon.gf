incomplete concrete VerbRon of Verb = 
  CatRon ** open Prelude, ResRon in {

  flags optimize=all_subs ;

  lin
    UseV = \verb -> 
    {
    s = verb.s ; 
    isRefl = verb.isRefl;
    nrClit = verb.nrClit;
    isFemSg = False ;
    neg    = table {Pos => ""; Neg => "nu"} ;
    clAcc  = RNoAg ;  nrClit = verb.nrClit; 
    clDat  = RNoAg ; 
    comp   = \\a => [] ;
    ext    = \\p => [] ; 
    } ;

    ComplVV v vp =insertSimpObj (\\a => "sã"  ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++vp.comp ! a ++ vp.ext ! Pos) (UseV v) ;


    ComplVS v s  = insertExtrapos (\\b => conjThat ++ s.s ! (v.m ! b)) (predV v) ;
    ComplVQ v q  = insertExtrapos (\\_ => q.s ! QIndir) (predV v) ;
 

    ComplVA v ap = 
    insertSimpObj (\\a => ap.s ! AF a.g a.n Indef ANomAcc) (UseV v) ;


    SlashV2a verb = {s = verb.s ; isRefl = verb.isRefl; nrClit = verb.nrClit;
                     isFemSg = False ; 
                     neg = table {Pos => ""; Neg => "nu"} ;
                     clAcc  = RNoAg ; 
                     clDat  = RNoAg ; 
                     comp   = \\a => [] ;
                     ext    = \\p => [] ;
                     c2 = verb.c2 ; needAgr = False ; lock_VP = <>};
  



    Slash2V3 v np = let  s1 = v.c2.s ++(np.s ! (v.c2.c)).comp ;
                         ss = if_then_Str np.hasRef (v.c2.prepDir ++ s1) s1; 
                         sir = if_then_Str np.isPronoun "" ss ;
                         vcDa = if_then_else VClit np.hasRef (nextClit v.nrClit PDat) v.nrClit;
                         vcAc = if_then_else VClit np.hasRef (nextClit v.nrClit PAcc) v.nrClit   
                         in
                               case v.c2.isDir of
                                  {Dir PAcc => (insertObje (\\_ => sir) (clitFromNoun np Ac) RNoAg (isAgrFSg np.a) vcAc (UseV v)) ** {needAgr = False ; c2 = v.c3} ;
                                   Dir PDat => (insertObje (\\_ => sir) RNoAg (clitFromNoun np Da) False vcDa (UseV v)) ** {needAgr = False ; c2 = v.c3};
                                    _ => (insertSimpObj (\\_ => ss) (UseV v)) ** {needAgr = False ; c2 = v.c3}
                                    };
    
    Slash3V3 v np = let s1 = v.c3.s ++ (np.s ! (v.c3.c)).comp ;
                        ss = if_then_Str np.hasRef (v.c3.prepDir ++ s1) s1 ;
                        sir = if_then_Str np.isPronoun "" ss ;
                        vcDa = if_then_else VClit np.hasRef (nextClit v.nrClit PDat) v.nrClit;
                        vcAc = if_then_else VClit np.hasRef (nextClit v.nrClit PAcc) v.nrClit  
                            in
                           case v.c3.isDir of
                            {Dir PAcc => (insertObje (\\_ => sir) (clitFromNoun np Ac) RNoAg (isAgrFSg np.a) vcAc (UseV v)) ** {needAgr = False ; c2 = v.c2}  ;
                             Dir PDat => (insertObje (\\_ => sir) RNoAg (clitFromNoun np Da) False vcDa (UseV v)) ** {needAgr = False ; c2 = v.c2}  ;
                            _ => (insertSimpObj (\\_ => ss) (UseV v)) ** {needAgr = False ; c2 = v.c2}
                             };

-- needs fixing - agreement for the added verb must be made accordingly to what we add in ComplSlash !!! 
-- fixed with extra parameter !

    SlashV2V v vp =  (insertSimpObj (\\a =>  "sã" ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++ vp.comp ! a ++ vp.ext ! Pos) (UseV v)) ** {needAgr = True ;c2 = v.c2} ; 


    SlashV2S v s = (insertExtrapos (\\b => conjThat ++ s.s ! Indic) (UseV v)) ** {needAgr = False; c2 = v.c2}; 

    SlashV2Q v q = (insertExtrapos (\\_ => q.s ! QIndir) (UseV v)) ** {needAgr = False ; c2 = v.c2 } ; 

   

 -- more usually the adverbial form is used, hence no agreement
 
   SlashV2A v ap =  
     (insertSimpObj  (\\a => v.c3.s ++ ap.s ! (AF Masc Sg Indef (convCase v.c3.c)))  
(UseV v)) ** {needAgr = False ;c2 = v.c2} ;

    ComplSlash vp np =  let  s1 = vp.c2.s ++(np.s ! (vp.c2.c)).comp ;
                             ss = if_then_Str np.hasRef (vp.c2.prepDir ++ s1) s1 ; 
                             sir = if_then_Str np.isPronoun "" ss  ;
                             vcDa = if_then_else VClit np.hasRef (nextClit vp.nrClit PDat) vp.nrClit;
                             vcAc = if_then_else VClit np.hasRef (nextClit vp.nrClit PAcc) vp.nrClit;  
                             vpp =  case vp.c2.isDir of
                          {Dir PAcc => insertObje (\\_ => sir) (clitFromNoun np Ac) RNoAg (isAgrFSg np.a) vcAc vp  ;
                           Dir PDat => insertObje (\\_ => sir) RNoAg (clitFromNoun np Da) False vcDa vp;
                           _ => insertSimpObj (\\_ => ss) vp 
                             }
                            in 
                         {isRefl = vpp.isRefl;
                          s = vpp.s ; isFemSg = vpp.isFemSg ;
                          nrClit = vpp.nrClit; clAcc = vpp.clAcc ; 
                          clDat = vpp.clDat ; neg   = vpp.neg ;
                          comp  = case vp.needAgr of 
                                     {True => \\a => vpp.comp ! (np.a);
                                      _    => \\a => vpp.comp ! a 
                                      };
                          ext   = vpp.ext ;
                          lock_VP = <> };

 


--add reflexive clitics 
    ReflVP v = {isRefl = case v.c2.c of
                           {Da => \\a => dRefl a;
                            _  => \\a => aRefl a
                            };
                s     = v.s ; isFemSg = v.isFemSg ;
                nrClit = case v.nrClit of 
                            {VNone => VRefl;
                             _     => VMany };
                clAcc = v.clAcc ; 
                clDat = v.clDat ; 
                neg   = v.neg ;
                comp  = v.comp ;
                ext   = v.ext ;
                lock_VP = <> 
                };
      

    SlashVV v vp = 
              insertObjc (\\a => "sã" ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp a ++ vp.comp ! a ++ vp.ext ! Pos) ((UseV v) **{c2=vp.c2; needAgr= vp.needAgr ; lock_VPSlash = <>}) ;
{-
    SlashV2VNP v np vp = let  s1 = v.c2.s ++(np.s ! (v.c2.c)).comp ;
                              ss = if_then_Str np.hasRef (v.c2.prepDir ++ s1) s1; 
                              sir = if_then_Str np.isPronoun "" ss ;
                              vcDa = if_then_else VClit np.hasRef (nextClit v.nrClit PDat) v.nrClit;
                              vcAc = if_then_else VClit np.hasRef (nextClit v.nrClit PAcc) v.nrClit ;  
                              vcomp = (getConjComp vp np.a).s
                           in   
                              case v.c2.isDir  of
                                {Dir PAcc => (insertObje (\\a => sir ++ vcomp ! a) (clitFromNoun np Ac) RNoAg (isAgrFSg np.a) vcAc (UseV v)) ** {needAgr = vp.needAgr ; c2 = vp.c2} ;
                                
                                 Dir PDat =>  (insertObje (\\a => sir ++ vcomp ! a) RNoAg (clitFromNoun np Da) False vcDa (UseV v)) ** {needAgr = vp.needAgr ; c2 = vp.c2};
                                 
                                 _        => (insertSimpObj (\\a => ss ++ vcomp ! a) (UseV v)) ** {needAgr = vp.needAgr ; c2 = vp.c2}  
                                };

-}
    UseComp comp = insertSimpObj comp.s (UseV copula) ;

    CompAP ap = {s = \\ag => ap.s ! AF ag.g ag.n Indef ANomAcc} ;
    CompNP np = {s = \\_  => (np.s ! No).comp} ;
    CompAdv a = {s = \\_  => a.s} ;


    AdvVP vp adv = insertAdv adv.s vp ;
    AdVVP adv vp = insertAdv adv.s vp ;

    PassV2 v = insertSimpObj (\\a => v.s ! PPasse a.g a.n Indef ANomAcc) (UseV auxPassive) ;




oper conjVP : VP -> Agr -> Str = \vp,agr ->
      let
        inf  = vp.s ! Subjo SPres agr.n agr.p ;
        neg  = vp.neg ! Pos ; 
      in
       neg ++ inf ;

insertAdv : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    isRefl = vp.isRefl;
    isFemSg = vp.isFemSg ;
    clAcc = vp.clAcc ; nrClit = vp.nrClit ;
    clDat = vp.clDat ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ co ;
    ext   = vp.ext ;
    lock_VP = <>
    } ;

 oper copula    : V = 
    let t = table {Inf => "fi" ;
                Indi Presn Sg P1 => "sunt" ; Indi Presn Sg P2 => "eºti" ; Indi Presn Sg P3 => "este" ;
                Indi Presn Pl P1 => "suntem" ; Indi Presn Pl P2 => "sunteþi" ; Indi Presn Pl P3 => "sunt" ;
                Indi PSimple Sg P1 => "fusei" ; Indi PSimple Sg P2 => "fuseºi" ; Indi PSimple Sg P3 => "fuse" ;
                Indi PSimple Pl P1 => "fuserãm" ; Indi PSimple Pl P2 => "fuserãþi" ; Indi PSimple Pl P3 => "fuserã" ;
                Indi Imparf Sg P1 => "eram" ; Indi Imparf Sg P2 => "erai" ; Indi Imparf Sg P3 => "era" ;
                Indi Imparf Pl P1 => "eram" ; Indi Imparf Pl P2 => "eraþi" ; Indi Imparf Pl P3 => "erau" ;
                Indi PPerfect Sg P1 => "fusesem" ; Indi PPerfect Sg P2 => "fuseseºi" ; Indi PPerfect Sg P3 => "fusese" ;
                Indi PPerfect Pl P1 => "fusesem" ; Indi PPerfect Pl P2 => "fuseseþi" ; Indi PPerfect Pl P3 => "fuseserã" ;
                Subjo SPres Sg P1 => "fiu" ; Subjo SPres Sg P2 => "fii" ; Subjo SPres Sg P3 => "fie" ;
                Subjo SPres Pl P1 => "fim" ; Subjo SPres Pl P2 => "fiþi" ; Subjo SPres Pl P3 => "fie" ;
                Imper SgP2 => "fii" ; Imper PlP2 => "fiþi" ; Imper PlP1 => "fim" ;
                Ger => "fiind"; 
                PPasse g n a d => (mkAdjReg "fost"). s ! (AF g  n  a  d)   
                } in
  {s = t; isRefl = \\_ => RNoAg; nrClit = VNone ; lock_V = <>} ;

predV : V -> VP = \verb -> 
    {
    s = verb.s ; 
    isRefl = verb.isRefl;
    isFemSg = False ;
    nrClit = verb.nrClit ;
    neg    = table {Pos => ""; Neg => "nu"} ;
    clAcc  = RNoAg ; 
    clDat  = RNoAg ; 
    comp   = \\a => [] ;
    ext    = \\p => [] ; lock_VP = <>
    } ;

useVP : VP -> VPC = \vp -> 
    let
      verb = vp.s ;
      vinf  : Bool -> Str = \b -> verb ! Inf ;
      vger  = verb ! Ger ;

      vimp : Agr -> Str = \a -> case <a.n,a.p> of 
       {<Sg,P2>  => verb ! Imper SgP2 ;
        <Pl,P2>  => verb ! Imper PlP2 ;
        _        => verb ! Subjo SPres a.n a.p           
       } ;
      vf : Str -> (Agr -> Str) -> {
                      sa : Str ;                    
                      sv : Agr => Str 
                                  } = 
                           \fin,inf -> {
                               sa = fin ; 
                               sv = \\a => inf a
                                       } ;
   

    in {
    s = table {
      VPFinite tm Simul => case tm of 
                             {VPres Indic => vf "" (\a -> verb ! Indi Presn a.n a.p) ;
                              VPres Conjunct => vf "sã" (\a -> verb ! Subjo SPres a.n a.p) ;
                              VImperff  => vf "" (\a -> verb ! Indi Imparf a.n a.p)  ;
                              VPasse  Indic => vf "" (\a -> pComp ! a.n ! a.p ++ verb ! PPasse Masc Sg Indef ANomAcc) ; 
                              VPasse  Conjunct => vf "sã" (\a -> copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;
                              VFut => vf "" (\a -> pFut ! a.n ! a.p ++ verb ! Inf) ;
                              VCondit => vf "" (\a -> pCond ! a.n ! a.p ++ verb ! Inf) 
                              } ;  
      VPFinite tm Anter => case tm of 
                              {VPres Indic => vf "" (\a -> pComp ! a.n ! a.p ++ verb ! PPasse Masc Sg Indef ANomAcc) ; 
                              (VPres Conjunct | VPasse Conjunct) => vf "sã" (\a -> copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;
                              VFut => vf "" (\a -> pFut !a.n ! a.p ++ copula.s! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc) ;   
                              VCondit => vf "" (\a -> pCond ! a.n ! a.p ++ copula.s ! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc);
                              _       => vf "" (\a -> verb ! Indi PPerfect a.n a.p) 
                              }; 
      VPInfinit Anter b=> vf "a" (\a -> copula.s ! Inf ++ verb ! PPasse Masc Sg Indef ANomAcc);  
      VPImperat        => vf "sã" (\a -> verb ! Subjo SPres a.n a.p) ; -- fix it later !
      VPGerund         => vf "" (\a -> vger) ;
      VPInfinit Simul b => vf "a" (\a -> verb ! Inf) 
      } ;
    agr    = vp.agr ; 
    neg    = vp.neg ; 
    clitAc  = vp.clAcc ; 
    clitDa  = vp.clDat ; 
    clitRe = RNoAg ; 
    nrClit = vp.nrClit ;
    comp   = vp.comp ; 
    ext    = vp.ext 
    } ;

mkClause : Str -> Bool -> Agr -> VP -> 
    {s : Direct => RTense => Anteriority => Polarity => Mood => Str} =
    \subj,hasClit,agr,vpr -> {
      s = \\d,t,a,b,m => 
        let 
          tm = case t of {
            RPast  => VPasse m ;   
            RFut   => VFut ;        
            RCond  => VCondit ;        
            RPres  => VPres m
            } ;
          cmp = case <t,a,m> of 
           {<RPast,Simul,Indic> | <RPres, Anter,Indic> => True ;
            <RCond, _, _> => True;
            _             => False
            } ;
          vp    = useVP vpr ;
          vps   = (vp.s ! VPFinite tm a).sv ;
          sa    = (vp.s ! VPFinite tm a ).sa ; 
          verb  = vps ! agr ; 
          neg   = vp.neg ! b ;
          clpr  = flattenClitics vpr.nrClit vpr.clAcc vpr.clDat (vpr.isRefl ! agr) (andB vpr.isFemSg cmp) cmp; 
          compl = vp.comp ! agr ++ vp.ext ! b
        in
        case d of {
          DDir => 
            subj ++ sa ++ neg ++ clpr.s1 ++ verb ++ clpr.s2;
          DInv => 
            sa ++ neg ++ clpr.s1 ++verb ++ clpr.s2 ++subj 
          }
        ++ compl
    } ;






oper auxPassive = copula ; 

mkVPSlash : Compl -> VP -> VP ** {c2 : Compl} = \c,vp -> vp ** {c2 = c; needAgr = False} ;


insertObje : (Agr => Str) -> RAgr -> RAgr -> Bool -> VClit -> VP -> VP = \obj,clA, clD, agg, vc, vp -> {
   s = vp.s ; isRefl = vp.isRefl;
   isFemSg= orB agg vp.isFemSg ; 
   nrClit = vc;
   neg    = table {Pos => ""; Neg => "nu"} ;
   clAcc  = {s = \\cs => vp.clAcc.s ! cs ++ clA.s ! cs };
   clDat  = {s = \\cs => vp.clDat.s ! cs ++ clD.s ! cs };
   comp = \\a => vp.comp ! a ++ obj ! a ;
   ext = vp.ext ; lock_VP = <>
    };

insertSimpObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
 s = vp.s ; isRefl = vp.isRefl; isFemSg = vp.isFemSg ; neg = vp.neg ;
 clAcc = vp.clAcc ; clDat = vp.clDat ;
 nrClit = vp.nrClit ;
 comp = \\a => vp.comp ! a ++ obj ! a ;
 ext = vp.ext ; lock_VP = <>
};


insertObjc : (Agr => Str) -> VPSlash -> VPSlash = \obj,vp -> 
    insertSimpObj obj vp ** {c2 = vp.c2; needAgr = False ; lock_VPSlash = <>} ;

insertExtrapos : (Polarity => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    isFemSg = vp.isFemSg ;
    clAcc = vp.clAcc ; isRefl = vp.isRefl;
    clDat = vp.clDat ; 
    neg   = vp.neg ;
    comp  = vp.comp ; nrClit = vp.nrClit ;
    ext   = \\p => vp.ext ! p ++ co ! p ;
    lock_VP =<>
    } ;

clitFromNoun : NP -> NCase -> RAgr = \np,nc ->
{s = (np.s ! nc).clit; hasClit = True};

isAgrFSg : Agr -> Bool = \ag ->
case <ag.n,ag.g,ag.p> of
{<Sg,Fem,P3> => True ;
 _           => False
};


getConjComp : VP -> Agr -> {s: Agr => Str} = \vp,ag ->
 {s  = \\a => "sã" ++ (flattenSimpleClitics vp.nrClit vp.clAcc vp.clDat (vp.isRefl ! a)) ++ conjVP vp ag ++ vp.comp ! a ++ vp.ext ! Pos};

oper nextClit : VClit -> ParClit ->  VClit = \vc,pc ->
case vc of
  { VNone => VOne pc;
    _     => VMany
   };

-- discuss example 
-- l -table (ComplSlash (Slash3V3 sell_V3 (UsePN john_PN)) (UsePN paris_PN))
-- in English the direct object always comes first, which could lead to incorrect longer examples
-- while in French it always comes last
-- ?!?
};
