--1 Romance auxiliary operations.
--

interface ResRomance = DiffRomance ** open CommonRomance, Prelude in {


--2 Constants uniformly defined in terms of language-dependent constants

oper

  nominative : Case = Nom ;
  accusative : Case = Acc ;

  Pronoun = {s : NPForm => Str ; a : Agr ; hasClit : Bool} ;

  Compl : Type = {s : Str ; c : Case ; isDir : Bool} ;

  complAcc : Compl = {s = [] ; c = accusative ; isDir = True} ;
  complGen : Compl = {s = [] ; c = genitive ; isDir = False} ;
  complDat : Compl = {s = [] ; c = dative ; isDir = True} ;

  pn2np : {s : Str ; g : Gender} -> Pronoun = \pn -> {
      s = \\c => prepCase (npform2case c) ++ pn.s ; 
      a = agrP3 pn.g Sg ;
      hasClit = False
      } ;

  npform2case : NPForm -> Case = \p -> case p of {
    Ton  x => x ;
    Poss _ => genitive ;
    Aton x => x ;
    _      => dative ---- Ita PreClit
    } ;

  case2npform : Case -> NPForm = \c -> case c of {
    Nom => Ton Nom ;
    Acc => Ton Acc ;
    _   => Ton c
    } ;


  VP : Type = {
      s : VPForm => {
        fin : Agr  => Str ;              -- ai  
        inf : AAgr => Str                -- dit 
        } ;
      agr    : VPAgr ;                   -- dit/dite dep. on verb, subj, and clitic
      neg    : Polarity => (Str * Str) ; -- ne-pas
      clit1  : Agr => Str ;              -- se lui
      clInfo : Case * Number * Person ;  -- whether and what fills clit1 (Nom = none)
      clit2  : Str ;                     -- y en
      comp   : Agr => Str ;              -- content(e) ; à ma mère ; hier
      ext    : Polarity => Str ;         -- que je dors / que je dorme
      } ;

  appCompl : Compl -> (NPForm => Str) -> Str = \comp,np ->
    comp.s ++ np ! Ton comp.c ;

  predV : Verb -> VP = \verb -> 
    let
      vfin  : TMood -> Agr -> Str = \tm,a -> verb.s ! VFin tm a.n a.p ;
      vpart : AAgr -> Str = \a -> verb.s ! VPart a.g a.n ;
      vinf  = verb.s ! VInfin ;

      typ = verb.vtyp ;
      aux = auxVerb typ ;

      habet  : TMood -> Agr -> Str = \tm,a -> aux ! VFin tm a.n a.p ;
      habere : Str = aux ! VInfin ;

      vf : (Agr -> Str) -> (AAgr -> Str) -> {
          fin : Agr => Str ; 
          inf : AAgr => Str
        } = 
        \fin,inf -> {
          fin = \\a => fin a ; 
          inf = \\a => inf a
        } ;

      cli : (Agr => Str) * (Case * Number * Person) = case isVRefl typ of {
          True => <\\a => reflPron ! a.n ! a.p ! Acc,<Acc,Sg,P3>> ; --- n,p
          _    => <\\_ => [],                        <Nom,Sg,P1>> -- not care
          } ;

    in {
    s = table {
      VPFinite t Simul => vf (vfin t) (\_ -> []) ;
      VPFinite t Anter => vf (habet t) vpart ; 
      VPImperat        => vf (\_ -> verb.s ! VImper SgP2) (\_ -> []) ; ----
      VPInfinit Simul  => vf (\_ -> []) (\_ -> vinf) ;
      VPInfinit Anter  => vf (\_ -> []) (\a -> habere ++ vpart a)
      } ;
    agr    = partAgr typ ;
    neg    = negation ;
    clit1  = cli.p1 ;
    clInfo = cli.p2 ;
    clit2  = [] ;
    comp   = \\a => [] ;
    ext    = \\p => []
    } ;

  insertObject : Compl -> Pronoun -> VP -> VP = \c,np,vp -> 
    let
      cc : Bool * Str * VPAgr = case <c.isDir, c.c, np.hasClit> of {
        <False,_,_> | 
        <_,_,False>  => <False, c.s ++ np.s ! Ton c.c, vp.agr> ; 
        <_,Acc,_>    => <True,  [], vpAgrClit np.a> ;
        _            => <True,  [], vp.agr>
        } ;
    in {
      s     = vp.s ;
      agr   = cc.p3 ;
      clit1 = \\a => placeNewClitic vp.clInfo c.c np cc.p1 (vp.clit1 ! a) ;
      clInfo = case cc.p1 of {
        False => vp.clInfo ; -- no new clitic
        _ => <c.c, np.a.n, np.a.p>
        } ; 
      clit2 = vp.clit2 ;
      neg   = vp.neg ;
      comp  = \\a => vp.comp ! a ++ cc.p2 ;
      ext   = vp.ext ;
    } ;

  insertComplement : (Agr => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clInfo = vp.clInfo ; 
    clit2 = vp.clit2 ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ co ! a ;
    ext   = vp.ext ;
    } ;
  insertAdv : Str -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clInfo = vp.clInfo ; 
    clit2 = vp.clit2 ; 
    neg   = vp.neg ;
    comp  = \\a => vp.comp ! a ++ co ;
    ext   = vp.ext ;
    } ;
  insertExtrapos : (Polarity => Str) -> VP -> VP = \co,vp -> { 
    s     = vp.s ;
    agr   = vp.agr ;
    clit1 = vp.clit1 ; 
    clInfo = vp.clInfo ; 
    clit2 = vp.clit2 ; 
    neg   = vp.neg ;
    comp  = vp.comp ;
    ext   = \\p => vp.ext ! p ++ co ! p ;
    } ;

  mkClause : Str -> Agr -> VP -> 
    {s : Tense => Anteriority => Polarity => Mood => Str} =
    \subj,agr,vp -> {
      s = \\t,a,b,m => 
        let 
          tm = case t of {
            Pres => VPres m ;
            Past => VImperf m ;
            Fut  => VFut ;
            Cond => VCondit
            } ;
          vps   = vp.s ! VPFinite tm a ;
          verb  = vps.fin ! agr ;
          inf   = vps.inf ! (appVPAgr vp.agr (aagr agr.g agr.n)) ; --- subtype bug
          neg   = vp.neg ! b ;
          clit  = vp.clit1 ! agr ++ vp.clit2 ;
          compl = vp.comp ! agr ++ vp.ext ! b
        in
        subj ++ neg.p1 ++ clit ++ verb ++ neg.p2 ++ inf ++ compl
    } ;

  infVP : VP -> Agr -> Str = \vp,agr ->
      let
        inf = (vp.s ! VPInfinit Simul).inf ! (aagr agr.g agr.n) ;
        neg = vp.neg ! Pos ; --- Neg not in API
        cli = vp.clit1 ! agr ++ vp.clit2 ;
        obj = vp.comp ! agr
      in
      clitInf cli inf ++ obj ;

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
