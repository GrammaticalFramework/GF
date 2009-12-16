--1 Romance auxiliary operations.
--

interface ResRomance = DiffRomance ** open CommonRomance, Prelude in {

flags optimize=all ;

--2 Constants uniformly defined in terms of language-dependent constants

oper

  nominative : Case = Nom ;
  accusative : Case = Acc ;

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

  Compl : Type = {s : Str ; c : Case ; isDir : Bool} ;

  complAcc : Compl = {s = [] ; c = accusative ; isDir = True} ;
  complGen : Compl = {s = [] ; c = genitive ; isDir = False} ;
  complDat : Compl = {s = [] ; c = dative ; isDir = True} ;

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

  oper


  predV : Verb -> VP = \verb -> 
    let
      typ = verb.vtyp ;
    in {
      s = {s = verb.s ; vtyp = typ} ;
      agr    = partAgr typ ;
      neg    = negation ;
      clit1  = [] ;
      clit2  = [] ;
      clit3  = [] ;
      comp   = \\a => [] ;
      ext    = \\p => []
      } ;

  insertObject : Compl -> NounPhrase -> VP -> VP = \c,np,vp -> 
    let
      obj = np.s ! c.c ;
    in {
      s   = vp.s ;
      agr = case <np.hasClit, c.isDir, c.c> of {
        <True,True,Acc> => vpAgrClit np.a ;
        _   => vp.agr -- must be dat
        } ;
      clit1 = vp.clit1 ++ obj.c1 ;
      clit2 = vp.clit2 ++ obj.c2 ;
      clit3 = vp.clit3 ;
      comp  = \\a => c.s ++ obj.comp ++ vp.comp ! a ;
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

  insertRefl : VP -> VP = \vp -> { 
    s     = {s = vp.s.s ; vtyp = vRefl} ;
    agr   = VPAgrSubj ;
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

  tmpVP : Type = {
    s      : Verb ;
    agr    : VPAgr ;                   -- dit/dite dep. on verb, subj, and clitic
    neg    : Polarity => (Str * Str) ; -- ne-pas
    clit1  : Str ;                     -- le/se
    clit2  : Str ;                     -- lui
    clit3  : Str ;                     -- y en
    comp   : Agr => Str ;              -- content(e) ; à ma mère ; hier
    ext    : Polarity => Str ;         -- que je dors / que je dorme
    } ;

  mkClause : Str -> Bool -> Agr -> VP -> 
      {s : Direct => RTense => Anteriority => Polarity => Mood => Str} =
    \subj, hasClit, agr, vp -> {
      s = \\d,te,a,b,m => 
        let
          neg   = vp.neg ! b ;
          compl = vp.comp ! agr ++ vp.ext ! b ;

          gen = agr.g ;
          num = agr.n ;
          per = agr.p ;

          vtyp  = vp.s.vtyp ;
          refl  = case vtyp of {
            VRefl => reflPron num per Acc ; ---- case ?
            _ => [] 
            } ;
          clit  = refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3 ; ---- refl first?

          verb = vp.s.s ;
          vaux = auxVerb vp.s.vtyp ;

          vagr = appVPAgr vp.agr (aagr gen num) ; --- subtype bug
          part = verb ! VPart vagr.g vagr.n ;

          vps : Str * Str = case <te,a> of {
            <RPast,Simul> => <verb ! VFin (VImperf m) num per, []> ; --# notpresent
            <RPast,Anter> => <vaux ! VFin (VImperf m) num per, part> ; --# notpresent
            <RFut,Simul>  => <verb ! VFin (VFut) num per, []> ; --# notpresent
            <RFut,Anter>  => <vaux ! VFin (VFut) num per, part> ; --# notpresent
            <RCond,Simul> => <verb ! VFin (VCondit) num per, []> ; --# notpresent
            <RCond,Anter> => <vaux ! VFin (VCondit) num per, part> ; --# notpresent
            <RPasse,Simul> => <verb ! VFin (VPasse) num per, []> ; --# notpresent
            <RPasse,Anter> => <vaux ! VFin (VPasse) num per, part> ; --# notpresent
            <RPres,Anter> => <vaux ! VFin (VPres m) num per, part> ; --# notpresent
            <RPres,Simul> => <verb ! VFin (VPres m) num per, []> 
            } ;

          fin = vps.p1 ;
          inf = vps.p2 ;
        in
        case d of {
          DDir => 
            subj ++ neg.p1 ++ clit ++ fin ++ neg.p2 ++ inf ;
          DInv => 
            neg.p1 ++ clit ++ fin ++ preOrPost hasClit subj (neg.p2 ++ inf)
          }
        ++ compl
    } ;

--- in French, pronouns should 
--- have a "-" with possibly a special verb form with "t":
--- "comment fera-t-il" vs. "comment fera Pierre"

  infVP : VP -> Agr -> Str = \vp,agr ->
      let
----e        clpr = pronArg agr.n agr.p vp.clAcc vp.clDat ;
----e        iform = infForm agr.n agr.p vp.clAcc vp.clDat ;
        clpr = <vp.clit1,vp.clit2, False> ; ----e
        iform = False ; ----e
        inf  = vp.s.s ! VInfin False ; ---- ! (aagr agr.g agr.n) ;
        neg  = vp.neg ! Pos ; --- Neg not in API
        obj  = neg.p2 ++ clpr.p2 ++ vp.comp ! agr ++ vp.ext ! Pos ---- pol
      in
      clitInf clpr.p3 (clpr.p1 ++ vp.clit3) inf ++ obj ;
      
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
