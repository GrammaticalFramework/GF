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
      vfin  : Agr -> TMood -> Str = \a,tm -> verb.s ! VFin tm a.n a.p ;
      vpart : Agr -> Str = \a -> verb.s ! VPart a.g a.n ; ----  
      vinf  = verb.s ! VInfin ;

      aux   = auxVerb verb.vtyp ;

      habet  : Agr -> TMood -> Str = \a,tm -> aux ! VFin tm a.n a.p ;
      habere : Str = aux ! VInfin ;

      vf : Str -> Str -> {fin,inf : Str} = \fin,inf -> {
        fin = fin ; inf = inf
        } ;

    in {
    s = \\a => table {
      VPFinite t Simul => vf (vfin a t) [] ;
      VPFinite t Anter => vf (habet a t) (vpart a) ; 
      VPImperat        => vf (verb.s ! VImper SgP2) [] ; ----
      VPInfinit Simul  => vf [] vinf ;
      VPInfinit Anter  => vf [] (habere ++ vpart a)
      } ;
    a1  = negation ;
    c1,c2 = [] ; ----
    n2  = \\a => [] ;
    a2  : Str = [] ;
    ext : Str = [] ;
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
          verb  = vp.s  ! agr ! VPFinite tm a ;
          neg   = vp.a1 ! b ;
          clit  = vp.c1 ++ vp.c2 ;
          compl = vp.n2 ! agr ++ vp.a2 ++ vp.ext
        in
        subj ++ neg.p1 ++ clit ++ verb.fin ++ neg.p2 ++ verb.inf ++ compl
    } ;

}

