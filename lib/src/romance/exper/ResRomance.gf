--1 Romance auxiliary operations.
--

interface ResRomance = DiffRomance ** open CommonRomance, Prelude in {

flags optimize=all ;
    coding=utf8 ;

--2 Constants uniformly defined in terms of language-dependent constants

oper

  nominative : Case = Nom ;
  accusative : Case = Acc ;

  NounPhrase : Type = {
    s : Case => {c1,c2,comp,ton : Str} ;
    a : Agr ;
    hasClit : Bool ; 
    isPol : Bool ; --- only needed for French complement agr
    isNeg : Bool --- needed for negative NP's such as "personne"
    } ;
  Pronoun : Type = {
    s : Case => {c1,c2,comp,ton : Str} ;
    a : Agr ;
    hasClit : Bool ; 
    isPol : Bool ; --- only needed for French complement agr
    poss : Number => Gender => Str ---- also: substantival
    } ;

  heavyNP    : {s : Case => Str ; a : Agr} -> NounPhrase = heavyNPpol False ;

  heavyNPpol : Bool -> {s : Case => Str ; a : Agr} -> NounPhrase = \isNeg,np -> {
    s = \\c => {comp,ton = np.s ! c ; c1,c2 = []} ;
    a = np.a ;
    hasClit = False ;
    isPol = False ;
    isNeg = isNeg
    } ;

  Compl : Type = {s : Str ; c : Case ; isDir : Bool} ;

  complAcc : Compl = {s = [] ; c = accusative ; isDir = True} ;
  complGen : Compl = {s = [] ; c = genitive ; isDir = False} ;
  complDat : Compl = {s = [] ; c = dative ; isDir = True} ;
  complNom : Compl = {s = [] ; c = Nom ; isDir = False} ;

  pn2np : {s : Str ; g : Gender} -> NounPhrase = pn2npPol False ;
  pn2npNeg : {s : Str ; g : Gender} -> NounPhrase = pn2npPol True ;

  pn2npPol : Bool -> {s : Str ; g : Gender} -> NounPhrase = \isNeg, pn -> heavyNPpol isNeg {
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
      s      = verb ;
      agr    = partAgr typ ;
      neg    = negation ;
      clit1  = [] ;
      clit2  = [] ;
      clit3  = {s,imp = [] ; hasClit = False} ;  --- refl is treated elsewhere
      isNeg  = False ; 
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
      clit3 = addClit3 np.hasClit [] (imperClit np.a obj.c1 obj.c2) vp.clit3 ;
      isNeg = orB vp.isNeg np.isNeg ;
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
    isNeg = vp.isNeg ; --- can be in compl as well
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
    isNeg = vp.isNeg ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertRefl : VP -> VP = \vp -> { 
    s     = vp.s ** {vtyp = vRefl vp.s.vtyp} ;
    agr   = VPAgrSubj ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ; 
    isNeg = vp.isNeg ; 
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
    isNeg = vp.isNeg ; --- adv could be neg 
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
    isNeg = vp.isNeg ;  
    neg   = \\b => let vpn = vp.neg ! b in {p1 = vpn.p1 ; p2 = vpn.p2 ++ co} ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertClit3 : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = addClit3 True co vp.clit3.imp vp.clit3 ;
    isNeg = vp.isNeg ;  
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = vp.ext ;
    } ;

  insertExtrapos : (RPolarity => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clit2 = vp.clit2 ; 
    clit3 = vp.clit3 ;
    isNeg = vp.isNeg ;  
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = \\p => vp.ext ! p ++ co ! p ;
    } ;

  mkVPSlash : Compl -> VP -> VP ** {c2 : Compl} = \c,vp -> vp ** {c2 = c} ;

  mkClause : Str -> Bool -> Bool -> Agr -> VP -> 
      {s : Direct => RTense => Anteriority => RPolarity => Mood => Str} =
    mkClausePol False ;

  -- isNeg = True if subject NP is a negative element, e.g. "personne"
  mkClausePol : Bool -> Str -> Bool -> Bool -> Agr -> VP -> 
      {s : Direct => RTense => Anteriority => RPolarity => Mood => Str} =
    \isNeg, subj, hasClit, isPol, agr, vp -> {
      s = \\d,te,a,b,m => 
        let

          pol : RPolarity = case <isNeg, vp.isNeg, b, d> of {
            <_,True,RPos,_>    => RNeg True ; 
            <True,_,RPos,DInv> => RNeg True ; 
            <True,_,RPos,_>    => polNegDirSubj ;
            _ => b
            } ;

          neg = vp.neg ! pol ;

          gen = agr.g ;
          num = agr.n ;
          per = agr.p ;

          particle = vp.s.p ;

          compl = particle ++ case isPol of {
            True => vp.comp ! {g = gen ; n = Sg ; p = per} ;
            _ => vp.comp ! agr
            } ;
          ext = vp.ext ! b ;

          vtyp  = vp.s.vtyp ;
          refl  = case isVRefl vtyp of {
            True => reflPron num per Acc ; ---- case ?
            _ => [] 
            } ;
          clit = refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3.s ; ---- refl first?

          verb = vp.s.s ;
          vaux = auxVerb vp.s.vtyp ;

          part = case vp.agr of {
            VPAgrSubj     => verb ! VPart agr.g agr.n ;
            VPAgrClit g n => verb ! VPart g n  
            } ;

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
            subj ++ neg.p1 ++ clit ++ fin ++ neg.p2 ++ inf ++ compl ++ ext ;
          DInv => 
            invertedClause vp.s.vtyp <te, a, num, per> hasClit neg clit fin inf compl subj ext
          }
    } ;

--- in French, pronouns should 
--- have a "-" with possibly a special verb form with "t":
--- "comment fera-t-il" vs. "comment fera Pierre"

  infVP : VP -> Agr -> Str = nominalVP VInfin ;

  gerVP : VP -> Agr -> Str = nominalVP (\_ -> VGer) ;

  nominalVP : (Bool -> VF) -> VP -> Agr -> Str = \vf,vp,agr ->
      let
        iform = orB vp.clit3.hasClit (isVRefl vp.s.vtyp) ;
        inf   = vp.s.s ! vf iform ;
        neg   = vp.neg ! RPos ;             --- Neg not in API
        obj   = vp.s.p ++ vp.comp ! agr ++ vp.ext ! RPos ; ---- pol
        refl  = case isVRefl vp.s.vtyp of {
            True => reflPron agr.n agr.p Acc ; ---- case ?
            _ => [] 
            } ;
      in
      neg.p1 ++ neg.p2 ++ clitInf iform (refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3.s) inf ++ obj ; -- ne pas dormant

----- new stuff 28/11/2014 -------------
----- discontinuous clauses ------------

  Clause      : Type = {np : NounPhrase ; vp : VP} ;
  SlashClause : Type = Clause ** {c2 : Compl} ;
  QuestClause : Type = Clause ** {ip : Str ; isSent : Bool} ;        -- if IP is subject then it is np, and ip is empty
  RelClause   : Type = Clause ** {rp : AAgr => Str  ; c : Case} ;    -- if RP is subject then it is np, and rp is empty 

  mknClause : NounPhrase -> VP -> Clause = \np, vp -> {np = np ; vp = vp} ;
  mknpClause : Str -> VP -> Clause = \s, vp -> mknClause (heavyNP {s = \\_ => s ; a = agrP3 Masc Sg}) vp ;

  RelPron : Type = {s : Bool => AAgr => Case => Str ; a : AAgr ; hasAgr : Bool} ;

  OldClause      : Type = {s : Direct => RTense => Anteriority => RPolarity => Mood => Str} ;
  OldQuestClause : Type = {s : QForm  => RTense => Anteriority => RPolarity => Mood => Str} ;
  OldRelClause   : Type = {s : Agr    => RTense => Anteriority => RPolarity => Mood => Str ; c : Case} ;

  mkSentence : Direct -> RTense -> Anteriority -> RPolarity -> Mood -> Clause -> Str = \d,te,a,b,m,cl -> 
        let
          np = cl.np ;
          isNeg = np.isNeg ;
          subj = (cl.np.s ! Nom).comp ;
          hasClit = np.hasClit ;
          isPol = np.isPol ;
          agr = np.a ;
          vp = cl.vp ;

          pol : RPolarity = case <isNeg, vp.isNeg, b, d> of {
            <_,True,RPos,_>    => RNeg True ; 
            <True,_,RPos,DInv> => RNeg True ; 
            <True,_,RPos,_>    => polNegDirSubj ;
            _ => b
            } ;

          neg = vp.neg ! pol ;

          gen = agr.g ;
          num = agr.n ;
          per = agr.p ;

          particle = vp.s.p ;

          compl = particle ++ case isPol of {
            True => vp.comp ! {g = gen ; n = Sg ; p = per} ;
            _ => vp.comp ! agr
            } ;
          ext = vp.ext ! b ;

          vtyp  = vp.s.vtyp ;
          refl  = case isVRefl vtyp of {
            True => reflPron num per Acc ; ---- case ?
            _ => [] 
            } ;
          clit = refl ++ vp.clit1 ++ vp.clit2 ++ vp.clit3.s ; ---- refl first?

          verb = vp.s.s ;
          vaux = auxVerb vp.s.vtyp ;

          part = case vp.agr of {
            VPAgrSubj     => verb ! VPart agr.g agr.n ;
            VPAgrClit g n => verb ! VPart g n  
            } ;

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
            subj ++ neg.p1 ++ clit ++ fin ++ neg.p2 ++ inf ++ compl ++ ext ;
          DInv => 
            invertedClause vp.s.vtyp <te, a, num, per> hasClit neg clit fin inf compl subj ext
          }
     ;





  oldClause : Clause -> OldClause = \cl -> 
    let np = cl.np in
    mkClausePol np.isNeg (np.s ! Nom).comp np.hasClit np.isPol np.a cl.vp ; 

  oldQuestClause : QuestClause -> OldQuestClause = \qcl -> 
    let 
      np = qcl.np ;
      cl = mkClause (np.s ! Nom).comp False False np.a qcl.vp ; 
    in {
      s = table {
        QDir   => \\t,a,r,m =>                                                  qcl.ip ++ cl.s ! DInv ! t ! a ! r ! m ;
        QIndir => \\t,a,r,m => case qcl.isSent of {True => subjIf ; _ => []} ++ qcl.ip ++ cl.s ! DDir ! t ! a ! r ! m 
        }
      } ;

  oldRelClause : RelClause -> OldRelClause = \rcl -> 
    let 
      np = rcl.np ;
      cl = mkClause (np.s ! Nom).comp False False np.a rcl.vp ; ---- Ag rp.a.g rp.a.n P3
    in {
      s = \\agr => cl.s ! DDir ;
      c = rcl.c
      } ; --3456000 (16800,3360)

---------------------------------------
-- compiling LangFre
-- v0:  646666 msec (old LangFre) 
-- v02: 317625 msec (old with VBool)
-- v1:  258153 msec 
-- v2:  175677 msec  UseCl 345600 (5040,5040)  UseQCl 691200 (6720,6720)  UseRCl 1728000 (16800,3360)  
-- v3:  169949 msec   
-- v4:   85209 msec  (with VBool)               

{-
v0
  7167263 french/SentenceFre.gfo
   208919 french/QuestionFre.gfo
   876960 french/RelativeFre.gfo
  8253142 total

v0.2
 7032583 french/SentenceFre.gfo
  205086 french/QuestionFre.gfo
  876660 french/RelativeFre.gfo
 8114329 total

v03 195227 msec (old with VPAgr changed to Str; not yet correct)
 5084845 french/SentenceFre.gfo
  131929 french/QuestionFre.gfo
  333884 french/RelativeFre.gfo
 5550658 total
v04 242696 msec (this correct, Str * Bool)
 6091544 french/SentenceFre.gfo
  156000 french/QuestionFre.gfo
  511900 french/RelativeFre.gfo
 6759444 total

v2
 23476139 french/SentenceFre.gfo
  1150969 french/QuestionFre.gfo
  1282029 french/RelativeFre.gfo
 25909137 total
v3
 23475961 french/SentenceFre.gfo
  1150969 french/QuestionFre.gfo
  1282029 french/RelativeFre.gfo
 25908959 total
v4
 12652021 french/SentenceFre.gfo
   567152 french/QuestionFre.gfo
   628749 french/RelativeFre.gfo
 13847922 total

Ita
324019 msec
 2671533 italian/SentenceIta.gfo
  130526 italian/QuestionIta.gfo
  606895 italian/RelativeIta.gfo
 3408954 total

Ita v03:
253879 msec
 2169173 italian/SentenceIta.gfo
   95021 italian/QuestionIta.gfo
  347063 italian/RelativeIta.gfo
 2611257 total

Spa
112362 msec
 1541743 spanish/SentenceSpa.gfo
   89561 spanish/QuestionSpa.gfo
  430675 spanish/RelativeSpa.gfo
 2061979 total

Spa v03:
91598 msec
 1086758 spanish/SentenceSpa.gfo
   66345 spanish/QuestionSpa.gfo
  250267 spanish/RelativeSpa.gfo
 1403370 total

Cat v03
83132 msec
 1078970 catalan/SentenceCat.gfo
   66225 catalan/QuestionCat.gfo
  249211 catalan/RelativeCat.gfo
 1394406 total



    VType = VTyp VAux Bool

    VPAgr = 
       VPAgrSubj                    -- elle est partie, elle s'est vue
     | VPAgrClit Gender Number ;    -- elle a dormi; elle les a vues

    partAgr : VType -> VPAgr
    vpAgrClit : Agr -> VPAgr
    pronArg : Number -> Person -> CAgr -> CAgr -> Str * Str * Bool
    vRefl   : VType -> VType
    isVRefl : VType -> Bool
    getVTypT : VType -> Bool = \t -> case t of {VTyp _ b => b} ; -- only in Fre

-}

      
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
