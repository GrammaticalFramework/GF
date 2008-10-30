--1 Romance auxiliary operations.
--

interface ResRomance = DiffRomance ** open CommonRomance, Prelude in {

flags optimize=all ;

--2 Constants uniformly defined in terms of language-dependent constants

oper

  nominative : Case = Nom ;
  accusative : Case = Acc ;

--e  Pronoun = {s : NPForm => Str ; a : Agr ; hasClit : Bool} ;
  NounPhrase : Type = {
    s : Case => {c1,c2,comp,ton : Str} ;
    a : Agr ;
    hasClit : Bool
    } ;
  Pronoun : Type = NounPhrase ** {
    poss : Number => Gender => Str ---- also: substantival
    } ;

  heavyNP : {s : Case => Str ; a : Agr} -> NounPhrase = \np -> {
    s = \\c => {comp,ton = np.s ! c ; c1,c2 = []} ;
    a = np.a ;
    hasClit = False
    } ;
--e

  Compl : Type = {s : Str ; c : Case ; isDir : Bool} ;

  complAcc : Compl = {s = [] ; c = accusative ; isDir = True} ;
  complGen : Compl = {s = [] ; c = genitive ; isDir = False} ;
  complDat : Compl = {s = [] ; c = dative ; isDir = True} ;

--e
  pn2np : {s : Str ; g : Gender} -> NounPhrase = \pn -> heavyNP {
    s = \\c => prepCase c ++ pn.s ; 
    a = agrP3 pn.g Sg
    } ;

  npform2case : NPForm -> Case = \p -> case p of {
    Ton  x => x ;
    Poss _ => genitive ;
    Aton x => x
    } ;

  case2npform : Case -> NPForm = \c -> case c of {
    Nom => Ton Nom ;
    Acc => Ton Acc ;
    _   => Ton c
    } ;

-- Pronouns in $NP$ lists are always in stressed forms.

  stressedCase : NPForm -> NPForm = \c -> case c of {
    Aton k => Ton k ;
    _ => c
    } ;

  appCompl : Compl -> NounPhrase -> Str = \comp,np ->
    comp.s ++ (np.s ! comp.c).ton ;
--e  appCompl : Compl -> (NPForm => Str) -> Str = \comp,np ->
--e    comp.s ++ np ! Ton comp.c ;

  oper

  VP : Type = {
    s : Verb ;
    agr    : VPAgr ;                   -- dit/dite dep. on verb, subj, and clitic
    neg    : Polarity => (Str * Str) ; -- ne-pas
    clit1  : Str ;                     -- le/se
    clit2  : Str ;                     -- lui
    clit3  : Str ;                     -- y en
    comp   : Agr => Str ;              -- content(e) ; à ma mère ; hier
    ext    : Polarity => Str ;         -- que je dors / que je dorme
    } ;


  useVP : VP -> VPC = \vp -> 
    let
      verb = vp.s ;
      vfin  : TMood -> Agr -> Str = \tm,a -> verb.s ! VFin tm a.n a.p ;
      vpart : AAgr -> Str = \a -> verb.s ! VPart a.g a.n ;
      vinf  : Bool -> Str = \b -> verb.s ! VInfin b ;
      vger  = verb.s ! VGer ;

      typ = verb.vtyp ;
      aux = auxVerb typ ;

      habet  : TMood -> Agr -> Str = \tm,a -> aux ! VFin tm a.n a.p ;
      habere : Str = aux ! VInfin False ;

      vimp : Agr -> Str = \a -> case <a.n,a.p> of {
        <Pl,P1> => verb.s ! VImper PlP1 ;
        <_, P3> => verb.s ! VFin (VPres Conjunct) a.n P3 ;
        <Sg,_>  => verb.s ! VImper SgP2 ;
        <Pl,_>  => verb.s ! VImper PlP2
        } ;

      vf : (Agr -> Str) -> (AAgr -> Str) -> {
          fin : Agr => Str ; 
          inf : AAgr => Str
        } = 
        \fin,inf -> {
          fin = \\a => fin a ; 
          inf = \\a => inf a
        } ;

    in {
    s = table {
      VPFinite t Simul => vf (vfin t)   (\_ -> []) ;
      VPFinite t Anter => vf (habet t)  vpart ;   --# notpresent
      VPInfinit Anter b=> vf (\_ -> []) (\a -> habere ++ vpart a) ;  --# notpresent
      VPImperat        => vf vimp       (\_ -> []) ;
      VPGerund         => vf (\_ -> []) (\_ -> vger) ;
      VPInfinit Simul b=> vf (\_ -> []) (\_ -> vinf b)
      } ;
    agr    = vp.agr ;
    neg    = vp.neg ;
    clit1  = vp.clit1 ;
    clit2  = vp.clit2 ;
    clit3  = vp.clit3 ;
    comp   = vp.comp ;
    ext    = vp.ext
    } ;

  predV : Verb -> VP = \verb -> 
    let
      typ = verb.vtyp ;
    in {
    s = {s = verb.s ; vtyp = typ} ;
    agr    = partAgr typ ;
    neg    = negation ;
{- ----e
    clAcc  = case isVRefl typ of {
          True => CRefl ;
          _    => CNone
          } ;
-}
    clit1  = [] ;
    clit2  = [] ;
    clit3  = [] ;
    comp   = \\a => [] ;
    ext    = \\p => []
    } ;

  insertObject : Compl -> NounPhrase -> VP -> VP = \c,np,vp -> 
    let
      obj = np.s ! c.c ;

{- ----e
      vpacc = vp.clAcc ; 
      vpdat = vp.clDat ;
      vpagr = vp.agr ;
      npa   = np.a ;
      cpron = CPron npa.g npa.n npa.p ; 
      noNewClit = <vpacc, vpdat, appCompl c np.s, vpagr> ;

      cc : CAgr * CAgr * Str * VPAgr = case <np.hasClit,c.isDir> of {
        <True,True> => case c.c of {
          Acc => <cpron, vpdat, [], vpAgrClit npa> ;
          _   => <vpacc, cpron, [], vpagr> -- must be dat
          } ;
        _   => noNewClit
        } ;
-} ----e

    in {
      s   = vp.s ;
      agr = vp.agr ; ----e
      clit1 = vp.clit1 ++ obj.c1 ;
      clit2 = vp.clit2 ++ obj.c2 ;
      clit3 = vp.clit3 ;
      comp  = \\a => vp.comp ! a ++ c.s ++ obj.comp ;
----e      agr   = cc.p4 ;
----      clAcc = cc.p1 ;
----      clDat = cc.p2 ;
----e      comp  = \\a => cc.p3 ++ vp.comp ! a ;
      neg   = vp.neg ;
      ext   = vp.ext ;
    } ;

  insertComplement : (Agr => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ co ! a ;
    ext   = vp.ext ;
    } ;


-- Agreement with preceding relative or interrogative: 
-- "les femmes que j'ai aimées"

  insertAgr : AAgr -> VP -> VP = \ag,vp -> { 
    s     = vp.s ;
    agr   = vpAgrClit (agrP3 ag.g ag.n) ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

----e
  insertRefl : VP -> VP = \vp -> { 
    s     = {s = vp.s.s ; vtyp = vRefl} ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertAdv : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ co ;
    ext   = vp.ext ;
    } ;

  insertAdV : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = \\b => let vpn = vp.neg ! b in {p1 = vpn.p1 ; p2 = vpn.p2 ++ co} ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertClit3 : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ++ co ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertExtrapos : (Polarity => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = \\p => vp.ext ! p ++ co ! p ;
    } ;

  mkVPSlash : Compl -> VP -> VP ** {c2 : Compl} = \c,vp -> vp ** {c2 = c} ;

  mkClause : Str -> Bool -> Agr -> VP -> 
    {s : Direct => RTense => Anteriority => Polarity => Mood => Str} =
    \subj,hasClit,agr,vpr -> {
      s = \\d,t,a,b,m => 
        let 
          tm = case t of {
            RPast  => VImperf m ;   --# notpresent
            RFut   => VFut ;        --# notpresent
            RCond  => VCondit ;     --# notpresent
            RPasse => VPasse ;      --# notpresent
            RPres  => VPres m
            } ;
          vp    = useVP vpr ;
          vps   = vp.s ! VPFinite tm a ;
          verb  = vps.fin ! agr ;
          inf   = vps.inf ! (appVPAgr vp.agr (aagr agr.g agr.n)) ; --- subtype bug
          neg   = vp.neg ! b ;
--e          clpr  = pronArg agr.n agr.p vp.clAcc vp.clDat ;
--e          compl = clpr.p2 ++ vp.comp ! agr ++ vp.ext ! b
          clit  = vp.clit1 ++ vp.clit2 ++ vp.clit3 ;
          compl = vp.comp ! agr ++ vp.ext ! b
        in
        case d of {
          DDir => 
            subj ++ neg.p1 ++ clit ++ verb ++ neg.p2 ++ inf ;
          DInv => 
            neg.p1 ++ clit ++ verb ++ preOrPost hasClit subj (neg.p2 ++ inf)
          }
        ++ compl
    } ;
--- in French, pronouns should 
--- have a "-" with possibly a special verb form with "t":
--- "comment fera-t-il" vs. "comment fera Pierre"

  infVP : VP -> Agr -> Str = \vpr,agr ->
      let
        vp   = useVP vpr ;
----e        clpr = pronArg agr.n agr.p vp.clAcc vp.clDat ;
--        iform = infForm agr.n agr.p vp.clAcc vp.clDat ;
        iform = False ;
        inf  = (vp.s ! VPInfinit Simul iform).inf ! (aagr agr.g agr.n) ;
--        neg  = vp.neg ! Pos ; --- Neg not in API
--        obj  = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
      in
----e clitInf clpr.p3 (clpr.p1 ++ vp.clit2) inf ++ obj ;
      inf ; 
}

-- insertObject:
-- p -cat=Cl -tr "la femme te l' envoie"
-- PredVP (DetCN (DetSg DefSg NoOrd) (UseN woman_N)) 
--  (ComplV3 send_V3 (UsePron he_Pron) (UsePron thou_Pron))
-- la femme te l' a envoyé
--
-- p -cat=Cl -tr "la femme te lui envoie"
-- PredVP (DetCN (DetSg DefSg NoOrd) (UseN woman_N)) 
--   (ComplV3 send_V3 (UsePron thou_Pron) (UsePron he_Pron))
-- la femme te lui a envoyée
