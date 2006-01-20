--1 Romance auxiliary operations.
--

interface ResRomance = DiffRomance ** open CommonRomance, Prelude in {


--2 Constants uniformly defined in terms of language-dependent constants

param

  NPForm = Ton Case | Aton Case | Poss {g : Gender ; n : Number} ; --- AAgr

  RelForm = RSimple Case | RComplex Gender Number Case ;


oper

  nominative : Case = Nom ;
  accusative : Case = Acc ;

  Compl : Type = {s : Str ; c : Case} ;

  complAcc : Compl = {s = [] ; c = accusative} ;
  complGen : Compl = {s = [] ; c = genitive} ;
  complDat : Compl = {s = [] ; c = dative} ;

  npform2case : NPForm -> Case = \p -> case p of {
    Ton  x => x ;
    Aton x => x ;
    Poss _ => genitive
    } ;

  case2npform : Case -> NPForm = \c -> case c of {
    Nom => Aton Nom ;
    Acc => Aton Acc ;
    _   => Ton c
    } ;

  npRelForm : NPForm -> RelForm = \np -> case np of {
    Ton  c => RSimple c ;
    Aton c => RSimple c ;
    Poss _ => RSimple genitive
    } ;

  appCompl : Compl -> (NPForm => Str) -> Str = \comp,np ->
    comp.s ++ np ! Ton comp.c ;

  predV : Verb -> VP = \verb -> 
    let
      vfin  : TMood -> Agr -> Str = \tm,a -> verb.s ! VFin tm a.n a.p ;
      vpart : AAgr -> Str = \a -> verb.s ! VPart a.g a.n ;
      vinf  = verb.s ! VInfin ;

      aux   = auxVerb verb.vtyp ;

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

    in {
    s = table {
      VPFinite t Simul => vf (vfin t) (\_ -> []) ;
      VPFinite t Anter => vf (habet t) vpart ; 
      VPImperat        => vf (\_ -> verb.s ! VImper SgP2) (\_ -> []) ; ----
      VPInfinit Simul  => vf (\_ -> []) (\_ -> vinf) ;
      VPInfinit Anter  => vf (\_ -> []) (\a -> habere ++ vpart a)
      } ;
    agr   = partAgr verb.vtyp ;
    neg   = negation ;
    clit1 = \\a => [] ; ----
    clit2 = [] ;
    comp  = \\a => [] ;
    adv   = [] ;
    ext   = [] ;
    } ;
{-
  insertObj : (Agr => Str) -> VP -> VP = \obj,vp -> {
    s = vp.s ;
    agr =
    
    a1 = vp.a1 ;
    n2 = \\a => vp.n2 ! a ++ obj ! a ;
    a2 = vp.a2 ;
    ext = vp.ext ;
    en2 = True ;
    ea2 = vp.ea2 ;
    eext = vp.eext
    } ;
-}
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
          compl = vp.comp ! agr ++ vp.adv ++ vp.ext
        in
        subj ++ neg.p1 ++ clit ++ verb ++ neg.p2 ++ inf ++ compl
    } ;


}

