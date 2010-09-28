--# -path=.:alltenses

concrete FreReal of Fre = IrregFre ** open (R = CommonRomance), Prelude in {

lincat 
  Display = Str ;
  Word = R.VF => Str ;
  Form = {s : Str ; v : R.VF} ;
  TMood = {s : Str ; v : R.TMood} ;
  Number = {s : Str ; v : R.Number} ;
  Person = {s : Str ; v : R.Person} ;
  NumPersI = {s : Str ; v : R.NumPersI} ;
  Gender = {s : Str ; v : R.Gender} ;
  Mood = {s : Str ; v : R.Mood} ;

lin
  -- display the same subset of forms as Petit Robert

{-
  DAll w = 
    w ! R.VInfin True ++
    w ! R.VFin (R.VPres R.Indic) R.Sg R.P1 ++ 
    w ! R.VFin (R.VPres R.Indic) R.Sg R.P3 ++ 
    w ! R.VFin (R.VPres R.Indic) R.Pl R.P1 ++ 
    w ! R.VFin (R.VPres R.Indic) R.Pl R.P3 ++ 
    w ! R.VFin (R.VImperf R.Indic) R.Sg R.P1 ++ 
    w ! R.VFin (R.VImperf R.Indic) R.Pl R.P1 ++ 
    w ! R.VFin R.VPasse R.Sg R.P1 ++ 
    w ! R.VFin R.VPasse R.Pl R.P1 ++ 
    w ! R.VFin R.VFut R.Sg R.P1 ++ 
    w ! R.VFin R.VCondit R.Sg R.P1 ++ 
    w ! R.VFin (R.VPres R.Conjunct) R.Sg R.P1 ++ 
    w ! R.VImper R.SgP2 ++
    w ! R.VImper R.PlP1 ++
    w ! R.VGer ++
    w ! R.VPart R.Masc R.Sg ; 
-}
  DForm w f = w ! f.v ++ f.s ; ---

  VInfin = {s = [] ; v = R.VInfin True} ;
  VFin m n p = {s = m.s ++ n.s ++ p.s ; v = R.VFin m.v n.v p.v} ;

  VImper np = {s = np.s ; v = R.VImper np.v} ;
  VPart g n = {s = g.s ++ n.s ; v = R.VPart g.v n.v} ;
  VGer = {s = [] ; v = R.VGer} ;

  VPres m = {s = m.s ; v = R.VPres m.v} ;
  VImperf m = {s = m.s ; v = R.VImperf m.v} ;
  VPasse = {s = [] ; v = R.VPasse} ;
  VFut = {s = [] ; v = R.VFut} ;
  VCondit = {s = [] ; v = R.VCondit} ;

  SgP2 = {s = [] ; v = R.SgP2} ;
  PlP1 = {s = [] ; v = R.PlP1} ;
  PlP2 = {s = [] ; v = R.PlP2} ;
  Sg = {s = [] ; v = R.Sg} ;
  Pl = {s = [] ; v = R.Pl} ;
  P1 = {s = [] ; v = R.P1} ;
  P2 = {s = [] ; v = R.P2} ;
  P3 = {s = [] ; v = R.P3} ;
  Masc = {s = [] ; v = R.Masc} ;
  Fem = {s = [] ; v = R.Fem} ;
  Indic = {s = [] ; v = R.Indic} ;
  Conjunct = {s = [] ; v = R.Conjunct} ;

  WVerb v = v.s ;
  WVerb2 v = v.s ;

oper
  vf : R.VF -> {s : Str ; v : R.VF} = \f -> {s = [] ; v = f} ; ---

}
