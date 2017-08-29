--# -path=.:../common:../abstract

concrete ExtendEst of Extend =
  CatEst ** ExtendFunctor -
  [
    VPS, ListVPS, VPI, ListVPI, VPS2, ListVPS2, VPI2, ListVPI2, RNP, RNPList, 
    AdAdV, AdjAsCN, AdjAsNP, ApposNP,
    BaseVPS, ConsVPS, BaseVPI, ConsVPI, BaseVPS2, ConsVPS2, BaseVPI2, ConsVPI2,
    MkVPS, ConjVPS, PredVPS, MkVPI, ConjVPI, ComplVPIVV,
    MkVPS2, ConjVPS2, ComplVPS2, MkVPI2, ConjVPI2, ComplVPI2,
    Base_nr_RNP, Base_rn_RNP, Base_rr_RNP, ByVP, CompBareCN,
    CompIQuant, CompQS, CompS, CompVP, ComplBareVS, ComplGenVV, ComplSlashPartLast, ComplVPSVV, CompoundAP,
    CompoundN, ConjRNP, ConjVPS, ConsVPS, Cons_nr_RNP, Cons_rr_RNP, DetNPFem, EmbedPresPart, 
    ExistsNP, FocusAP, FocusAdV, FocusAdv, FocusObj, FrontExtPredVP, GenIP, GenModIP, GenModNP, GenNP, GenRP,
    GerundAdv, GerundCN, GerundNP, IAdvAdv, ICompAP, InOrderToVP, InvFrontExtPredVP, MkVPS, NominalizeVPSlashNP,
    PassAgentVPSlash, PassVPSlash, PastPartAP, PastPartAgentAP, PositAdVAdj, PredVPS, PredVPSVV, PredetRNP, PrepCN,
    PresPartAP, PurposeVP, ReflPoss, ReflPron, ReflRNP, SlashBareV2S, SlashV2V, 
    UncontractedNeg, UttAccIP, UttAccNP, UttAdV, UttDatIP, UttDatNP, UttVPShort, WithoutVP, BaseVPS2, ConsVPS2, ConjVPS2, ComplVPS2, MkVPS2
   ]
  with
    (Grammar = GrammarEst) **

  open
    GrammarEst,
    ResEst,
    (R=ResEst),
    IdiomEst,
    Coordination,
    Prelude,
    MorphoEst,
    ParadigmsEst in {

  lin
  -- : NP -> Quant ;       -- this man's
  GenNP np = {
      s,sp = \\_,_ => np.s ! NPCase Gen ;
      isNum  = False ;
      isDef  = True ;
      isNeg = False 
  } ;

  -- : IP -> IQuant ;      -- whose
  GenIP ip = { s = \\_,_ => ip.s ! NPCase Gen } ;

  -- : Num -> CN -> RP ;   -- whose car
  GenRP num cn = {
    s = \\n,c => let k = npform2case num.n c in relPron ! n ! Gen ++ cn.s ! NCase num.n k ; 
    a = RNoAg 
  } ;

-- In case the first two are not available, the following applications should in any case be.

  -- : Num -> NP -> CN -> NP ; -- this man's car(s)
  GenModNP num np cn = DetCN (DetQuant (GenNP (lin NP np)) num) cn ;

  -- : Num -> IP -> CN -> IP ; -- whose car(s)    
  GenModIP num ip cn = IdetCN (IdetQuant (GenIP (lin IP ip)) num) cn ;

{-



  lincat
    VPS   = {s : Agr => Str} ;
    [VPS] = {s1,s2 : Agr => Str} ; 
    VPI   = {s : VVType => Agr => Str} ;
    [VPI] = {s1,s2 : VVType => Agr => Str} ;

  lin
    BaseVPS = twoTable Agr ;
    ConsVPS = consrTable Agr comma ;
    
    BaseVPI = twoTable2 VVType Agr ;
    ConsVPI = consrTable2 VVType Agr comma ;

    MkVPS t p vp = mkVPS (lin Temp t) (lin Pol p) (lin VP vp) ;
    ConjVPS c xs = conjunctDistrTable Agr c xs ;
    PredVPS np vps = {s = np.s ! npNom ++ vps.s ! np.a} ;

    
    MkVPI vp = mkVPI (lin VP vp) ;
    ConjVPI c xs = conjunctDistrTable2 VVType Agr c xs ;
    ComplVPIVV vv vpi = insertObj (\\a => vpi.s ! vv.typ ! a) (predVV vv) ;


-------- two-place verb conjunction

  lincat
    VPS2   = {s : Agr => Str ; c2 : Str} ; 
    [VPS2] = {s1,s2 : Agr => Str ; c2 : Str} ; 
    VPI2   = {s : VVType => Agr => Str ; c2 : Str} ;
    [VPI2] = {s1,s2 : VVType => Agr => Str ; c2 : Str} ;

  lin
    MkVPS2 t p vpsl = mkVPS (lin Temp t) (lin Pol p) (lin VP vpsl) ** {c2 = vpsl.c2} ;
    MkVPI2 vpsl = mkVPI (lin VP vpsl) ** {c2 = vpsl.c2} ;

    BaseVPS2 x y = twoTable Agr x y ** {c2 = y.c2} ; ---- just remembering the prep of the latter verb
    ConsVPS2 x xs = consrTable Agr comma x xs ** {c2 = xs.c2} ;
	
    BaseVPI2 x y = twoTable2 VVType Agr x y ** {c2 = y.c2} ; ---- just remembering the prep of the latter verb
    ConsVPI2 x xs = consrTable2 VVType Agr comma x xs ** {c2 = xs.c2} ;


    ConjVPS2 c xs = conjunctDistrTable Agr c xs ** {c2 = xs.c2} ;
    ConjVPI2 c xs = conjunctDistrTable2 VVType Agr c xs ** {c2 = xs.c2} ;


    ComplVPS2 vps2 np = {} ;
    ComplVPI2 vpi2 np = {} ;

  oper 
    mkVPS : Temp -> Pol -> VP -> VPS = \t,p,vp -> lin VPS {} ;
      
    mkVPI : VP -> VPI = \vp -> lin VPI {} ;

-----

  lin
    ICompAP ap = {} ; ---- IComp should have agr!

    IAdvAdv adv = {} ;
-}

    -- : VP -> AP ;   -- (the man) looking at Mary / filme vaatav (mees)
  PresPartAP vp = {
    s = \\_,_ => vp2adv vp True VIPresPart ;
    infl = Invariable 
  } ;

{- TODO: need to change VP to get this to work properly:
   1) Add "mine" form into VP (or switch to a BIND solution and just add a stem)
   2) Change s2 in VP so that we can manipulate the complement to be in genitive!
  -- : VP -> SC ;   -- looking at Mary (is fun) / filmide vaatamine (on tore)
  EmbedPresPart vp = 
    let vpGen = vp ; --** { s2 = \\_,_,_ => vp.s2 ! True ! Pos ! }
      {s = vp2adv vp True VI } ; 
-}

  -- : VPSlash -> AP ;    -- täna leitud 
  PastPartAP vp = {
    s = \\_,_ => vp2adv vp True (VIPass Past) ;
    infl = Invariable } ;

  -- : VPSlash -> NP -> AP    -- hobisukeldujate poolt leitud (süvaveepomm)
  PastPartAgentAP vp np = { 
    s = \\_,_ => np.s ! NPCase Gen ++ "poolt" 
              ++ vp2adv vp True (VIPass Past) ; 
    infl = Invariable } ;
{-
   -- : VP -> CN    -- publishing of the document (can get a determiner)
   GerundCN vp = {} ;

   -- : VP -> NP    -- publishing the document (by nature definite)
   GerundNP vp = {} ;
-}
  -- : VP -> Adv
  GerundAdv vp = 
    { s = vp2adv vp True (VIInf InfDes) } ; 

  WithoutVP vp = -- ilma raamatut nägemata
    { s = "ilma" ++ vp2adv vp False (VIInf InfMata) } ;

  InOrderToVP vp = -- et raamatut paremini näha
    { s = "et" ++ vp2adv vp True (VIInf InfDa) } ;
 
  ByVP vp = 
    { s = vp2adv vp True (VIInf InfDes) } ; 

oper 
  vp2adv : R.VP -> Bool -> VIForm -> Str = \vp,sentIsPos,vif ->
    vp.s2 ! sentIsPos ! Pos ! agrP3 Sg   -- raamatut
    ++ vp.adv                     -- paremini
    ++ vp.p                       -- ära 
    ++ (vp.s ! vif ! Simul ! Pos ! agrP3 Sg).fin -- tunda/tundes/tundmata/...
    ++ vp.ext ;

lin
{-

   NominalizeVPSlashNP vpslash np = {} ;  
    PassVPSlash vps = passVPSlash (lin VPS vps) [] ;
    PassAgentVPSlash vps np = passVPSlash (lin VPS vps) ("by" ++ np.s ! NPAcc) ;

   --- AR 7/3/2013
   ComplSlashPartLast vps np = {} ;
-}
   -- : NP -> Cl ;  -- there exists a number / there exist numbers
   ExistsNP = IdiomEst.ExistNP ;

{-
   ComplBareVS  v s = insertExtra s.s (predV v) ;
   SlashBareV2S v s = insertExtrac s.s (predVc v) ;
-}
  -- : N -> N  -> N ;      -- control system / controls system / control-system
  CompoundN noun cn = lin N {
    s = \\nf => noun.s ! NCase Sg Gen ++ BIND ++ cn.s ! nf ---- AR genitive best?
    } ;
{-  
  CompoundAP noun adj = {} ;

  FrontExtPredVP np vp = {} ;

  InvFrontExtPredVP np vp = {} ;




  lin
-}
  -- : AP -> CN ;   -- a green one ; en grön (Swe)
  AdjAsCN ap = { s = ap.s ! True } ; -- True = it's a modifier, not a predicate

  AdjAsNP ap = {
    s = table { NPCase c => ap.s ! True ! NCase Sg c ;
                NPAcc    => ap.s ! True ! NCase Sg Gen } ;
    a = agrP3 Sg ;
    isPron = False
    } ;
{-
  lincat
    RNP     = {s : Agr => Str} ;
    RNPList = {s1,s2 : Agr => Str} ;

  lin 
    ReflRNP vps rnp = insertObjPre (\\a => vps.c2 ++ rnp.s ! a) vps ;
    ReflPron = {s = reflPron} ;
    ReflPoss num cn = {s = \\a => possPron ! a ++ num.s ! Nom ++ cn.s ! num.n ! Nom} ;
    PredetRNP predet rnp = {s = \\a => predet.s ++ rnp.s ! a} ;

    ConjRNP conj rpns = conjunctDistrTable Agr conj rpns ;

    Base_rr_RNP x y = twoTable Agr x y ;
    Base_nr_RNP x y = twoTable Agr {s = \\a => x.s ! NPAcc} y ;
    Base_rn_RNP x y = twoTable Agr x {s = \\a => y.s ! NPAcc} ;
    Cons_rr_RNP x xs = consrTable Agr comma x xs ;
    Cons_nr_RNP x xs = consrTable Agr comma {s = \\a => x.s ! NPAcc} xs ;

    
---- TODO: RNPList construction

    ComplGenVV v a p vp = insertObj (\\agr => a.s ++ p.s ++ 
                                         infVP v.typ vp a.a p.p agr)
                               (predVV v) ;
-}                               
  -- : S -> Comp ;                   -- (the fact is) that she sleeps
  CompS s = {s = \\_ => "et" ++ s.s} ;

  -- : QS -> Comp ;                  -- (the question is) who sleeps
  CompQS qs = {s = \\_ => qs.s } ;

  -- : Ant -> Pol -> VP -> Comp ;    -- (she is) to go
  CompVP ant pol vp = {s = \\a => infVPAnt ant.a (NPCase Nom) pol.p a vp InfDa } ;

-- English-specific
  -- : Pol 
  UncontractedNeg = { s = [] ; p = Neg } ; 

  -- : VP -> Utt ;  -- There's no "short form", so just using InfMa instead of InfDa 
  UttVPShort vp = {s = infVP (NPCase Nom) Pos (agrP3 Sg) vp InfMa} ;
  --TODO: maybe InfMa should be default in PhraseEst and InfDa here?



}